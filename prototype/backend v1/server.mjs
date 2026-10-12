import http from 'node:http';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { readFile, realpath } from 'node:fs/promises';
import { execFile } from 'node:child_process';
import { promisify } from 'node:util';
import { createHash } from 'node:crypto';
import { Marked, Renderer } from 'marked';
import sanitizeHtml from 'sanitize-html';
import { parse as parseYaml } from 'yaml';

const exec = promisify(execFile);
const directory = path.dirname(fileURLToPath(import.meta.url));
const frontend = path.resolve(directory, '../wiki v1');
const sourcePath = path.resolve(process.env.WIKI_SOURCE_PATH || '/home/abuhafi/Project/wiki-pkn');
function integer(value, fallback, maximum, name) {
  const result = value === undefined ? fallback : Number(value);
  if (!Number.isInteger(result) || result < 1 || result > maximum) throw new Error(`${name} must be an integer between 1 and ${maximum}`);
  return result;
}
const intervalSeconds = integer(process.env.WIKI_SYNC_INTERVAL_SECONDS, 300, 86400, 'WIKI_SYNC_INTERVAL_SECONDS');
const port = integer(process.env.PORT, 8787, 65535, 'PORT');
const controller = new AbortController();
let snapshot = null;
let lastError = null;
let syncing = null;
let stopping = false;
const imageTypes = { '.png': 'image/png', '.jpg': 'image/jpeg', '.jpeg': 'image/jpeg', '.webp': 'image/webp', '.gif': 'image/gif', '.avif': 'image/avif' };
const staticTypes = { '.html': 'text/html; charset=utf-8', '.css': 'text/css; charset=utf-8', '.js': 'text/javascript; charset=utf-8', '.svg': 'image/svg+xml', ...imageTypes };
async function git(args, binary = false) {
  const { stdout } = await exec('git', ['-C', sourcePath, ...args], {
    encoding: binary ? 'buffer' : 'utf8', maxBuffer: 32 * 1024 * 1024, timeout: 60000,
    signal: controller.signal, env: { ...process.env, GIT_TERMINAL_PROMPT: '0', GIT_OPTIONAL_LOCKS: '0' },
  });
  return binary ? stdout : stdout.trim();
}
const idFor = value => createHash('sha256').update(value).digest('base64url');
const normalize = value => value.normalize('NFKC').toLocaleLowerCase('id');
const strings = value => (Array.isArray(value) ? value : typeof value === 'string' ? value.split(',') : []).filter(item => typeof item === 'string').map(item => item.trim()).filter(Boolean);
const falseValue = value => value === false || /^(false|no|0)$/i.test(String(value));
const trueValue = value => value === true || /^(true|yes|1)$/i.test(String(value));
function unpublished(data) {
  return trueValue(data.draft) || trueValue(data.private) || trueValue(data.unpublished) ||
    ['published', 'publish', 'public'].some(key => key in data && falseValue(data[key])) ||
    /^(draft|unpublished|private|archived|review|pending)$/i.test(String(data.status || ''));
}
function parseDocument(text, file) {
  let data = {};
  let body = text.replace(/^\uFEFF/, '');
  const frontmatter = body.match(/^---\r?\n([\s\S]*?)\r?\n---(?:\r?\n|$)/);
  if (frontmatter) {
    data = parseYaml(frontmatter[1], { maxAliasCount: 50 }) || {};
    if (typeof data !== 'object' || Array.isArray(data)) throw new Error(`Invalid frontmatter: ${file}`);
    body = body.slice(frontmatter[0].length);
  }
  if (unpublished(data)) return null;
  const title = typeof data.title === 'string' && data.title.trim() ? data.title.trim() : body.match(/^#\s+(.+)$/m)?.[1] || path.posix.basename(file, '.md');
  const plain = body.replace(/!\[\[[^\]]+\]\]/g, '').replace(/\[\[([^\]|]+)(?:\|([^\]]+))?\]\]/g, '$2 $1').replace(/<[^>]*>/g, '').replace(/[#*_`>\[\]]/g, '').replace(/\s+/g, ' ').trim();
  const summary = typeof data.description === 'string' ? data.description : typeof data.summary === 'string' ? data.summary : plain.slice(0, 220);
  const category = typeof data.category === 'string' && data.category.trim() ? data.category.trim() : file.includes('/') ? file.split('/')[0] : 'Umum';
  return { id: idFor(file), title, category, summary, tags: strings(data.tags), sourcePath: `content/${file}`, file, body, aliases: strings(data.aliases), plain };
}
async function loadSnapshot(ref, mode) {
  const commit = await git(['rev-parse', '--verify', `${ref}^{commit}`]);
  const tree = await git(['ls-tree', '-r', '-z', commit, '--', 'content/']);
  const files = new Map();
  for (const entry of tree.split('\0').filter(Boolean)) {
    const match = entry.match(/^(100644|100755) blob ([a-f0-9]+)\tcontent\/(.+)$/s);
    if (match) files.set(match[3], match[2]);
  }
  const articles = [];
  for (const [file, blob] of files) {
    if (!/\.md$/i.test(file)) continue;
    const article = parseDocument((await git(['cat-file', 'blob', blob], true)).toString('utf8'), file);
    if (article) articles.push(article);
  }
  const lookup = new Map();
  const register = (key, article) => {
    key = normalize(key);
    if (!lookup.has(key)) lookup.set(key, article);
    else if (lookup.get(key)?.id !== article.id) lookup.set(key, null);
  };
  for (const article of articles) {
    for (const key of [article.file, article.file.replace(/\.md$/i, ''), path.posix.basename(article.file, '.md'), article.title, ...article.aliases]) register(key, article);
  }
  const media = new Map();
  const resolveFile = (target, article) => {
    const local = path.posix.normalize(path.posix.join(path.posix.dirname(article.file), target));
    return files.has(local) ? local : files.has(target) ? target : null;
  };
  function destination(raw, article, image = false) {
    let target;
    try { target = decodeURIComponent(raw); } catch { return null; }
    if (/^(https?:|mailto:)/i.test(target)) return image ? (/^https?:/i.test(target) ? target : null) : target;
    if (/^[a-z][a-z\d+.-]*:/i.test(target) || target.startsWith('//') || target.includes('\\') || target.includes('\0')) return null;
    if (target.startsWith('#')) return image ? null : target;
    const [name] = target.split('#');
    const resolved = resolveFile(name.replace(/^\/?content\//, ''), article);
    if (image) {
      if (!resolved || !imageTypes[path.posix.extname(resolved).toLowerCase()]) return null;
      const id = idFor(resolved);
      media.set(id, { blob: files.get(resolved), type: imageTypes[path.posix.extname(resolved).toLowerCase()] });
      return `/api/wiki/media/${id}?v=${commit}`;
    }
    const linked = (resolved && lookup.get(normalize(resolved))) || lookup.get(normalize(name)) || lookup.get(normalize(name.replace(/\.md$/i, '')));
    return linked ? `#article=${linked.id}` : null;
  }
  const escape = value => String(value).replace(/[&<>"']/g, char => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' })[char]);
  for (const article of articles) {
    const renderer = new Renderer();
    renderer.html = () => '';
    renderer.link = function ({ href, tokens }) {
      const url = destination(href, article);
      const label = this.parser.parseInline(tokens);
      return url ? `<a href="${escape(url)}"${/^https?:/i.test(url) ? ' target="_blank" rel="noopener noreferrer"' : ''}>${label}</a>` : label;
    };
    renderer.image = ({ href, text }) => {
      const url = destination(href, article, true);
      return url ? `<img src="${escape(url)}" alt="${escape(text)}" loading="lazy">` : escape(text);
    };
    const wikiLinks = {
      name: 'wikiLinks', level: 'inline', start: src => src.search(/!?\[\[/),
      tokenizer(src) {
        const match = /^(!?)\[\[([^\]\n]+)\]\]/.exec(src);
        if (match) return { type: 'wikiLinks', raw: match[0], embed: Boolean(match[1]), target: match[2] };
      },
      renderer(token) {
        const [target, alias] = token.target.split('|');
        const label = alias || target.split('#')[0];
        const url = destination(target, article, token.embed);
        if (!url) return escape(label);
        return token.embed ? `<img src="${escape(url)}" alt="${escape(label)}" loading="lazy">` : `<a href="${escape(url)}">${escape(label)}</a>`;
      },
    };
    // A per-article parser avoids shared renderer state during snapshot replacement.
    const parser = new Marked({ renderer, extensions: [wikiLinks], gfm: true });
    article.html = sanitizeHtml(parser.parse(article.body), {
      allowedTags: [...sanitizeHtml.defaults.allowedTags, 'img'],
      allowedAttributes: { ...sanitizeHtml.defaults.allowedAttributes, a: ['href', 'target', 'rel'], img: ['src', 'alt', 'loading'] },
      allowedSchemes: ['http', 'https', 'mailto'], allowProtocolRelative: false,
      transformTags: { img: (tagName, attributes) => {
        const src = attributes.src || '';
        return { tagName, attribs: /^\/api\/wiki\/media\/[A-Za-z0-9_-]+\?v=[a-f0-9]+$/.test(src) || /^https?:\/\//i.test(src) ? attributes : { alt: attributes.alt || '' } };
      } },
    });
  }
  articles.sort((a, b) => a.title.localeCompare(b.title, 'id'));
  return { version: commit, articles, byId: new Map(articles.map(article => [article.id, article])), media,
    categories: [...new Set(articles.map(article => article.category))].sort((a, b) => a.localeCompare(b, 'id')),
    lastSyncedAt: new Date().toISOString(), source: { path: sourcePath, mode, ref, commit } };
}
async function trackingRef() {
  if (process.env.WIKI_GIT_REF) {
    if (!/^refs\/remotes\/origin\/[\w./-]+$/.test(process.env.WIKI_GIT_REF) || process.env.WIKI_GIT_REF.includes('..')) throw new Error('WIKI_GIT_REF must be an origin remote-tracking ref');
    return process.env.WIKI_GIT_REF;
  }
  try {
    const branch = await git(['symbolic-ref', '--short', 'HEAD']);
    const remote = await git(['config', '--get', `branch.${branch}.remote`]);
    const merge = await git(['config', '--get', `branch.${branch}.merge`]);
    if (remote === 'origin' && merge.startsWith('refs/heads/')) return merge.replace('refs/heads/', 'refs/remotes/origin/');
  } catch { /* Detached or unconfigured branch keeps the HEAD provenance. */ }
  return null;
}
function sync() {
  if (syncing || stopping) return syncing;
  syncing = (async () => {
    try {
      const ref = await trackingRef();
      if (!ref) throw new Error('Current branch has no origin upstream; serving local HEAD. Set WIKI_GIT_REF to select an origin branch.');
      const branch = ref.slice('refs/remotes/origin/'.length);
      await git(['-c', 'core.hooksPath=/dev/null', 'fetch', '--no-tags', '--no-recurse-submodules', 'origin', `+refs/heads/${branch}:${ref}`]);
      const next = await loadSnapshot(ref, 'origin-tracking-ref');
      if (!stopping) { snapshot = next; lastError = null; }
    } catch (error) {
      if (!stopping) { lastError = error.message; console.error(`Wiki synchronization failed: ${error.message}`); }
    }
  })().finally(() => { syncing = null; });
  return syncing;
}
function json(response, status, value) {
  response.writeHead(status, { 'Content-Type': 'application/json; charset=utf-8', 'Cache-Control': 'no-store' });
  response.end(JSON.stringify(value));
}
const summaryOf = ({ id, title, category, summary, tags }) => ({ id, title, category, summary, tags });
function bad(message) { const error = new Error(message); error.status = 400; return error; }
const server = http.createServer(async (request, response) => {
  response.setHeader('X-Content-Type-Options', 'nosniff');
  response.setHeader('Referrer-Policy', 'strict-origin-when-cross-origin');
  try {
    if (request.method !== 'GET' && request.method !== 'HEAD') {
      response.setHeader('Allow', 'GET, HEAD');
      return json(response, 405, { error: 'Method not allowed' });
    }
    const url = new URL(request.url, 'http://localhost');
    const pathname = decodeURIComponent(url.pathname);
    if (pathname.includes('\0') || pathname.includes('\\')) throw bad('Invalid path');
    const current = snapshot;
    if (pathname.startsWith('/api/')) {
      if (!current) return json(response, 503, { error: 'Wiki content unavailable', lastError });
      if (pathname === '/api/wiki/manifest') return json(response, 200, { version: current.version, articleCount: current.articles.length, lastSyncedAt: current.lastSyncedAt, source: current.source, intervalSeconds, lastError });
      if (pathname === '/api/wiki/articles') {
        for (const key of url.searchParams.keys()) if (!['q', 'category'].includes(key) || url.searchParams.getAll(key).length !== 1) throw bad('Only single q and category parameters are supported');
        const q = url.searchParams.get('q') || '';
        const category = url.searchParams.get('category') || '';
        if (q.length > 500 || category.length > 200) throw bad('Search parameter too long');
        const terms = normalize(q).split(/\s+/).filter(Boolean);
        const articles = current.articles.filter(article => (!category || article.category === category) && terms.every(term => normalize(`${article.title} ${article.summary} ${article.tags.join(' ')} ${article.plain}`).includes(term)));
        return json(response, 200, { articles: articles.map(summaryOf), categories: current.categories });
      }
      const detail = /^\/api\/wiki\/articles\/([A-Za-z0-9_-]{43})$/.exec(pathname);
      if (detail) {
        const article = current.byId.get(detail[1]);
        if (!article) return json(response, 404, { error: 'Article not found' });
        return json(response, 200, { article: { ...summaryOf(article), html: article.html, sourcePath: article.sourcePath } });
      }
      const media = /^\/api\/wiki\/media\/([A-Za-z0-9_-]{43})$/.exec(pathname);
      if (media) {
        const asset = current.media.get(media[1]);
        if (!asset || (url.searchParams.has('v') && url.searchParams.get('v') !== current.version)) return json(response, 404, { error: 'Media not found in current snapshot' });
        const bytes = await git(['cat-file', 'blob', asset.blob], true);
        response.writeHead(200, { 'Content-Type': asset.type, 'Cache-Control': 'no-cache' });
        return response.end(request.method === 'HEAD' ? undefined : bytes);
      }
      return json(response, 404, { error: 'API endpoint not found' });
    }
    const relative = pathname === '/' ? 'index.html' : pathname.slice(1);
    if (relative.split('/').some(part => part === '..' || part.startsWith('.'))) throw bad('Invalid path');
    const type = staticTypes[path.extname(relative).toLowerCase()];
    if (!type) return json(response, 404, { error: 'File not found' });
    const root = await realpath(frontend);
    const file = await realpath(path.resolve(root, relative));
    if (!file.startsWith(`${root}${path.sep}`)) throw bad('Invalid path');
    const bytes = await readFile(file);
    response.writeHead(200, { 'Content-Type': type, 'Cache-Control': 'no-cache' });
    response.end(request.method === 'HEAD' ? undefined : bytes);
  } catch (error) {
    const status = error.status || (error instanceof URIError ? 400 : ['ENOENT', 'ENOTDIR'].includes(error.code) ? 404 : 500);
    if (status === 500) console.error(error);
    json(response, status, { error: status === 500 ? 'Internal server error' : status === 404 ? 'File not found' : error.message });
  }
});
try { snapshot = await loadSnapshot('HEAD', 'local-head'); }
catch (error) { lastError = error.message; console.error(`Local wiki initialization failed: ${error.message}`); }
server.listen(port, process.env.HOST || '127.0.0.1', () => console.log(`Wiki PKN: http://${process.env.HOST || '127.0.0.1'}:${port}`));
server.on('error', error => { console.error(error.message); shutdown(); process.exitCode = 1; });
void sync();
const timer = setInterval(sync, intervalSeconds * 1000);
async function shutdown() {
  if (stopping) return;
  stopping = true;
  clearInterval(timer);
  controller.abort();
  server.close();
  server.closeIdleConnections();
  const forceClose = setTimeout(() => server.closeAllConnections(), 5000);
  forceClose.unref();
  await syncing;
}
process.once('SIGINT', shutdown);
process.once('SIGTERM', shutdown);
