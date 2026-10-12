'use strict';

const $ = (id) => document.getElementById(id);
const state = { route: null, previousDirectory: '#directory', controller: null, request: 0, manifest: null, categories: [], categoryCounts: new Map(), debounce: null };
const articleURL = (id) => `#article=${encodeURIComponent(id)}`;
const directoryURL = (q = '', category = '') => {
  const params = new URLSearchParams();
  if (q) params.set('q', q);
  if (category) params.set('category', category);
  return `#directory${params.size ? `&${params}` : ''}`;
};
function element(tag, className, text) {
  const node = document.createElement(tag);
  if (className) node.className = className;
  if (text !== undefined) node.textContent = text;
  return node;
}
function readRoute() {
  const hash = location.hash.slice(1);
  if (hash.startsWith('article=')) return { page: 'article', id: new URLSearchParams(hash).get('article') || '' };
  const params = new URLSearchParams(hash.replace(/^directory&?/, ''));
  return { page: hash.startsWith('directory') ? 'directory' : 'home', q: hash.startsWith('directory') ? params.get('q') || '' : '', category: hash.startsWith('directory') ? params.get('category') || '' : '' };
}
async function api(path, signal) {
  const response = await fetch(path, { signal, headers: { Accept: 'application/json' }, cache: 'no-store' });
  if (!response.ok) {
    if (response.status === 404) throw new Error('Artikel tidak ditemukan. Pilih artikel lain dari direktori.');
    throw new Error('Khazanah belum dapat dimuat. Periksa koneksi dan coba lagi.');
  }
  return response.json();
}
function showState(container, title, description, action) {
  const card = element('div', 'state-card');
  card.append(element('h3', '', title), element('p', '', description));
  if (action) {
    const button = element('button', 'btn', action.label);
    button.type = 'button';
    button.addEventListener('click', action.run);
    card.append(button);
  }
  container.replaceChildren(card);
}
function loading(container, description) {
  showState(container, 'Memuat khazanah', description);
  const spinner = element('div', 'loading-line');
  spinner.setAttribute('aria-hidden', 'true');
  container.firstChild.prepend(spinner);
}
function renderCategories() {
  const chips = [];
  for (const category of ['', ...state.categories]) {
    const button = element('button', 'btn', category || 'Semua');
    button.type = 'button';
    button.dataset.category = category;
    button.setAttribute('aria-pressed', String((state.route.category || '') === category));
    button.addEventListener('click', () => { location.hash = directoryURL($('wiki-search').value.trim(), category); });
    chips.push(button);
  }
  $('categories').replaceChildren(...chips);
  $('category-cards').replaceChildren(...state.categories.map((category) => {
    const link = element('a', 'category-card');
    link.href = directoryURL('', category);
    link.dataset.categoryLink = category;
    const symbol = element('span', 'category-symbol', '♧');
    symbol.setAttribute('aria-hidden', 'true');
    const label = element('span');
    label.append(element('strong', '', category));
    if (state.categoryCounts.has(category)) label.append(element('small', '', `${state.categoryCounts.get(category)} artikel`));
    link.append(symbol, label);
    return link;
  }));
}
function renderArticles(articles, visible = state.route.page === 'home' ? 6 : 24) {
  $('result-count').textContent = `${articles.length.toLocaleString('id-ID')} artikel`;
  $('result-pagination')?.remove();
  if (!articles.length) {
    const filtered = Boolean(state.route.q || state.route.category);
    showState($('results'), filtered ? 'Belum ada hasil yang sesuai' : 'Khazanah belum tersedia', filtered ? 'Coba kata kunci lain atau jelajahi semua kategori.' : 'Sumber belum berisi artikel yang dapat ditampilkan. Muat ulang setelah sinkronisasi selesai.', { label: filtered ? 'Lihat semua artikel' : 'Coba lagi', run: () => filtered ? (location.hash = '#directory') : renderRoute() });
    return;
  }
  $('results').replaceChildren(...articles.slice(0, visible).map((article) => {
    const link = element('a', 'card article-card');
    link.href = articleURL(article.id);
    link.dataset.articleId = article.id;
    link.append(element('span', 'category-label', article.category || 'Khazanah'), element('h3', '', article.title));
    if (article.summary) link.append(element('p', '', article.summary));
    const bottom = element('span', 'card-bottom');
    bottom.append(element('span', '', 'Baca artikel'), element('span', '', '→'));
    link.append(bottom);
    return link;
  }));
  if (articles.length > visible) {
    const controls = element('div');
    controls.id = 'result-pagination';
    controls.style.cssText = 'display:flex;flex-wrap:wrap;align-items:center;justify-content:center;gap:12px;margin-top:20px';
    controls.append(element('span', 'filter-description', `${Math.min(visible, articles.length)} dari ${articles.length.toLocaleString('id-ID')} artikel ditampilkan`));
    if (state.route.page === 'home') {
      const link = element('a', 'btn search-submit', 'Lihat seluruh khazanah');
      link.id = 'view-all-articles';
      link.href = '#directory';
      controls.append(link);
    } else {
      const button = element('button', 'btn search-submit', 'Tampilkan 24 artikel berikutnya');
      button.id = 'load-more-articles';
      button.type = 'button';
      button.addEventListener('click', () => {
        renderArticles(articles, visible + 24);
        const nextArticle = $('results').children[visible];
        nextArticle?.focus({ preventScroll: true });
        nextArticle?.scrollIntoView({ block: 'start', behavior: 'auto' });
      });
      controls.append(button);
    }
    $('results').after(controls);
  }
}
// Rebuild API HTML with an allowlist. No API metadata is inserted as HTML.
function safeArticleHTML(html) {
  const source = new DOMParser().parseFromString(String(html || ''), 'text/html');
  const fragment = document.createDocumentFragment();
  const allowed = new Set(['P','H1','H2','H3','H4','H5','H6','UL','OL','LI','BLOCKQUOTE','STRONG','EM','B','I','DEL','CODE','PRE','BR','HR','A','IMG','TABLE','THEAD','TBODY','TR','TH','TD','SUP','SUB','DL','DT','DD']);
  const discarded = new Set(['SCRIPT','STYLE','IFRAME','OBJECT','EMBED','FORM','INPUT','BUTTON','SVG','MATH','LINK','META']);
  function appendSafe(parent, original) {
    if (original.nodeType === Node.TEXT_NODE) { parent.append(document.createTextNode(original.textContent)); return; }
    if (original.nodeType !== Node.ELEMENT_NODE || discarded.has(original.tagName)) return;
    if (!allowed.has(original.tagName)) { for (const child of original.childNodes) appendSafe(parent, child); return; }
    const node = document.createElement(original.tagName.toLowerCase());
    if (original.getAttribute('dir') === 'rtl') node.dir = 'rtl';
    if (original.tagName === 'IMG') {
      const src = original.getAttribute('src') || '';
      if (!/^https?:\/\//i.test(src) && !/^\/(?!\/)/.test(src)) return;
      node.setAttribute('src', src);
      node.setAttribute('alt', original.getAttribute('alt') || '');
      node.setAttribute('loading', 'lazy');
      node.setAttribute('referrerpolicy', 'no-referrer');
    }
    if (original.tagName === 'A') {
      const href = original.getAttribute('href') || '';
      if (/^#article=/.test(href)) node.setAttribute('href', href);
      else if (/^https?:\/\//i.test(href)) {
        node.setAttribute('href', href);
        node.setAttribute('target', '_blank');
        node.setAttribute('rel', 'noopener noreferrer');
      } else if (/^mailto:/i.test(href)) node.setAttribute('href', href);
    }
    if (original.tagName === 'TH' || original.tagName === 'TD') {
      for (const attr of ['colspan', 'rowspan']) if (/^[1-9]\d?$/.test(original.getAttribute(attr) || '')) node.setAttribute(attr, original.getAttribute(attr));
    }
    for (const child of original.childNodes) appendSafe(node, child);
    parent.append(node);
  }
  for (const node of source.body.childNodes) appendSafe(fragment, node);
  return fragment;
}
function renderArticle(article) {
  $('article-title').textContent = article.title;
  $('article-summary').textContent = article.summary || '';
  $('article-source').textContent = article.sourcePath ? `Sumber khazanah · ${article.sourcePath}` : '';
  $('article-tags').replaceChildren(...[article.category, ...(article.tags || [])].filter(Boolean).map((tag) => element('span', '', tag)));
  $('article-body').replaceChildren(safeArticleHTML(article.html));
  const headings = [...$('article-body').querySelectorAll('h1,h2,h3')];
  $('toc-links').replaceChildren(...headings.map((heading, index) => {
    heading.id = `section-${index + 1}`;
    const link = element('a', '', heading.textContent);
    link.href = `#${heading.id}`;
    link.dataset.level = heading.tagName.slice(1);
    link.addEventListener('click', (event) => {
      event.preventDefault();
      heading.tabIndex = -1;
      heading.focus({ preventScroll: true });
      heading.scrollIntoView({ behavior: 'auto', block: 'start' });
    });
    return link;
  }));
  $('toc').hidden = !headings.length;
  $('article-layout').hidden = false;
  $('article-title').tabIndex = -1;
  $('article-title').focus({ preventScroll: true });
  $('article-state').replaceChildren();
  document.title = `${article.title} — Wiki PKN`;
}
async function renderRoute() {
  clearTimeout(state.debounce);
  state.controller?.abort();
  state.controller = new AbortController();
  const signal = state.controller.signal;
  const request = ++state.request;
  const route = readRoute();
  state.route = route;
  const isArticle = route.page === 'article';
  $('directory-view').hidden = isArticle;
  $('article-view').hidden = !isArticle;
  document.querySelectorAll('[data-nav]').forEach((link) => {
    if (link.dataset.nav === route.page) link.setAttribute('aria-current', 'page');
    else link.removeAttribute('aria-current');
  });
  if (isArticle) {
    $('article-layout').hidden = true;
    loading($('article-state'), 'Menyiapkan artikel dari sumber Wiki PKN.');
    try {
      const data = await api(`/api/wiki/articles/${encodeURIComponent(route.id)}`, signal);
      if (request === state.request) renderArticle(data.article);
    } catch (error) {
      if (error.name !== 'AbortError' && request === state.request) showState($('article-state'), 'Artikel belum dapat dibuka', error.message, { label: 'Coba lagi', run: renderRoute });
    }
    return;
  }
  state.previousDirectory = location.hash || '#home';
  document.title = route.page === 'home' ? 'Wiki PKN — Khazanah Fitrah' : 'Direktori — Wiki PKN';
  $('welcome').hidden = route.page !== 'home';
  $('directory-heading').hidden = route.page === 'home';
  $('category-map').hidden = route.page !== 'home';
  $('wiki-search').value = route.q;
  $('clear-search').hidden = !route.q;
  $('results-title').textContent = route.category || (route.q ? 'Hasil pencarian' : 'Jelajahi artikel');
  $('filter-description').hidden = !route.q;
  $('filter-description').textContent = route.q ? `Pencarian: “${route.q}”` : '';
  $('result-count').textContent = '';
  $('result-pagination')?.remove();
  $('results').setAttribute('aria-busy', 'true');
  renderCategories();
  loading($('results'), 'Memuat artikel dan kategori terbaru.');
  try {
    const params = new URLSearchParams();
    if (route.q) params.set('q', route.q);
    if (route.category) params.set('category', route.category);
    const data = await api(`/api/wiki/articles${params.size ? `?${params}` : ''}`, signal);
    if (request !== state.request) return;
    state.categories = data.categories || [];
    if (!route.q && !route.category) {
      state.categoryCounts.clear();
      for (const article of data.articles) state.categoryCounts.set(article.category, (state.categoryCounts.get(article.category) || 0) + 1);
    }
    renderCategories();
    renderArticles(data.articles);
  } catch (error) {
    if (error.name !== 'AbortError' && request === state.request) showState($('results'), 'Khazanah belum dapat dimuat', error.message, { label: 'Coba lagi', run: renderRoute });
  } finally {
    if (request === state.request) $('results').setAttribute('aria-busy', 'false');
  }
}
async function loadManifest() {
  try {
    const manifest = await api('/api/wiki/manifest');
    const changed = state.manifest && state.manifest.version !== manifest.version;
    state.manifest = manifest;
    const date = manifest.lastSyncedAt ? new Date(manifest.lastSyncedAt) : null;
    const synced = date && !Number.isNaN(date.getTime()) ? new Intl.DateTimeFormat('id-ID', { dateStyle: 'medium', timeStyle: 'short' }).format(date) : 'Belum tersinkron';
    $('sync-title').textContent = `${Number(manifest.articleCount || 0).toLocaleString('id-ID')} artikel · ${manifest.lastError ? 'Sinkronisasi perlu perhatian' : 'Khazanah terhubung'}`;
    const source = typeof manifest.source === 'string' ? manifest.source : [manifest.source?.path, manifest.source?.ref, manifest.source?.commit?.slice(0, 8)].filter(Boolean).join(' · ');
    $('sync-detail').textContent = `Sinkronisasi terakhir: ${synced}. Pemeriksaan setiap ${manifest.intervalSeconds} detik.${source ? ` Sumber: ${source}.` : ''}${manifest.lastError ? ` ${manifest.lastError}` : ''}`;
    document.querySelector('.sync-card').dataset.status = manifest.lastError ? 'error' : 'ok';
    if (changed) renderRoute();
  } catch (error) {
    $('sync-title').textContent = 'Status sinkronisasi tidak tersedia';
    $('sync-detail').textContent = 'Periksa koneksi backend, lalu pilih Muat ulang. Artikel yang sudah terbuka tetap dapat dibaca.';
    document.querySelector('.sync-card').dataset.status = 'error';
  }
}
function navigateSearch() {
  if (state.route.page === 'article') location.hash = '#directory';
  requestAnimationFrame(() => { $('wiki-search').focus(); $('wiki-search').scrollIntoView({ block: 'center' }); });
}
$('search-form').addEventListener('submit', (event) => { event.preventDefault(); clearTimeout(state.debounce); location.hash = directoryURL($('wiki-search').value.trim(), state.route.category || ''); });
$('wiki-search').addEventListener('input', () => {
  $('clear-search').hidden = !$('wiki-search').value;
  clearTimeout(state.debounce);
  state.debounce = setTimeout(() => { location.hash = directoryURL($('wiki-search').value.trim(), state.route.category || ''); }, 350);
});
$('clear-search').addEventListener('click', () => { clearTimeout(state.debounce); $('wiki-search').value = ''; location.hash = directoryURL('', state.route.category || ''); $('wiki-search').focus(); });
$('article-back').addEventListener('click', () => { location.hash = state.previousDirectory; });
$('header-search').addEventListener('click', navigateSearch);
$('nav-search').addEventListener('click', navigateSearch);
$('refresh-button').addEventListener('click', () => { loadManifest(); renderRoute(); });
window.addEventListener('hashchange', () => { renderRoute(); window.scrollTo({ top: 0, behavior: 'auto' }); });
renderRoute();
loadManifest();
setInterval(() => { if (!document.hidden) loadManifest(); }, 30000);
