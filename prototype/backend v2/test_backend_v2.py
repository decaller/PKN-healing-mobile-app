#!/usr/bin/env python3
"""Black-box acceptance suite: python test_backend_v2.py -v [--live-wordpress]."""
import asyncio
from contextlib import closing
import hashlib
import io
import json
from pathlib import Path
import socket
import sqlite3
import subprocess
import sys
import tempfile
import threading
import time
import unittest
import urllib.error
import urllib.parse
import urllib.request
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
import numpy as np

ROOT = Path(__file__).resolve().parent
LIVE = '--live-wordpress' in sys.argv
if LIVE:
    sys.argv.remove('--live-wordpress')
DOA = "Doa gelisah: اللَّهُمَّ tenangkan hati dengan thuma'ninah."
SCENARIO = 'Maghrib: ayah mendengar anak, lalu memilih dialog adab.'


def read_json(path):
    return json.loads(path.read_text(encoding='utf-8'))


def save_json(path, value):
    path.write_text(json.dumps(value, ensure_ascii=False), encoding='utf-8')


def free_port():
    with socket.socket() as sock:
        sock.bind(('127.0.0.1', 0))
        return sock.getsockname()[1]


class WordPressFixture:
    def __init__(self):
        self.changed = False
        self.fail = False
        self.fail_detail = False
        self.fail_public = False
        self.requests = []
        self.records = []
        fixture = self

        class Handler(BaseHTTPRequestHandler):
            def log_message(self, *args):
                pass

            def do_GET(self):
                parsed = urllib.parse.urlsplit(self.path)
                fixture.requests.append(self.path)
                if fixture.fail:
                    self.send_error(503, 'fixture unavailable')
                    return
                if parsed.path == '/event-public/':
                    if fixture.fail_public:
                        self.send_error(502, 'public page unavailable')
                        return
                    body = ('<!doctype html><html><body><nav>Unrelated navigation</nav>'
                            '<div data-elementor-type="wp-page" data-elementor-id="101">'
                            '<section><h1>Event</h1><div><p>Public majelis thuma\'ninah.</p>'
                            '<p>Tanggal: 12 Oktober 2026</p><p>Lokasi: Bandung</p></div></section></div>'
                            '<footer>Unrelated footer</footer></body></html>').encode()
                    self.send_response(200)
                    self.send_header('Content-Type', 'text/html; charset=utf-8')
                    self.send_header('Content-Length', str(len(body)))
                    self.end_headers()
                    self.wfile.write(body)
                    return
                if parsed.path.endswith('/documents'):
                    payload = {'records': fixture.records}
                elif '/pages/' in parsed.path:
                    identifier = int(parsed.path.rsplit('/', 1)[1])
                    if fixture.fail_detail and identifier == 101:
                        self.send_error(500, 'REST detail unavailable')
                        return
                    details = {
                        101: ('event-thumaninah', "Event Thuma'ninah Revisi" if fixture.changed else "Event Thuma'ninah",
                              "<h1>Event</h1><p>Majelis thuma'ninah bersama keluarga.</p><p>Tanggal: 12 Oktober 2026</p><p>Lokasi: Bandung</p>"),
                        202: ('buku-adab', 'Buku Adab', '<h1>Buku</h1><p>Pustaka adab keluarga.</p>'),
                        303: ('kontak', 'Kontak', '<p>Hubungi kami.</p>'),
                    }
                    slug, title, text = details[identifier]
                    payload = dict(id=identifier, slug=slug, link='https://example.org/' + slug,
                                   modified='2026-01-02T00:00:00' if fixture.changed and identifier == 101 else '2026-01-01T00:00:00',
                                   title={'rendered': title}, content={'rendered': text})
                elif parsed.path.endswith('/pages'):
                    page = int(urllib.parse.parse_qs(parsed.query).get('page', ['1'])[0])
                    if page == 1:
                        title = 'Event Thuma\'ninah Revisi' if fixture.changed else 'Event Thuma\'ninah'
                        payload = [dict(id=101, slug='event-thumaninah', link='http://127.0.0.1:%d/event-public/' % self.server.server_port,
                                        modified='2026-01-02T00:00:00' if fixture.changed else '2026-01-01T00:00:00',
                                        title={'rendered': title}, content={'rendered':
                                        '<h1>Event</h1><p>Majelis thuma\'ninah bersama keluarga.</p><p>Tanggal: 12 Oktober 2026</p><p>Lokasi: Bandung</p>'})]
                    elif page == 2:
                        payload = [dict(id=202, slug='buku-adab', link='https://example.org/book',
                                        modified='2026-01-01T00:00:00', title={'rendered': 'Buku Adab'},
                                        content={'rendered': '<h1>Buku</h1><p>Pustaka adab keluarga.</p>'}),
                                   dict(id=303, slug='kontak', link='https://example.org/contact',
                                        modified='2026-01-01T00:00:00', title={'rendered': 'Kontak'},
                                        content={'rendered': '<p>Hubungi kami.</p>'})]
                    else:
                        self.send_error(400, 'invalid page')
                        return
                    # Realistic list responses require a detail request for content.
                    for record in payload:
                        record.pop('content', None)
                else:
                    self.send_error(404)
                    return
                body = json.dumps(payload).encode()
                self.send_response(200)
                self.send_header('Content-Type', 'application/json')
                self.send_header('X-WP-TotalPages', '2')
                self.send_header('Content-Length', str(len(body)))
                self.end_headers()
                self.wfile.write(body)

        self.http = ThreadingHTTPServer(('127.0.0.1', 0), Handler)
        self.thread = threading.Thread(target=self.http.serve_forever, daemon=True)
        self.thread.start()
        self.base = 'http://127.0.0.1:%s/wp-json/wp/v2' % self.http.server_port

    def close(self):
        self.http.shutdown()
        self.http.server_close()
        self.thread.join(timeout=5)


class BackendAcceptance(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix='pkn-v2-test-')
        self.addCleanup(self.temp.cleanup)
        self.directory = Path(self.temp.name)
        self.wiki = self.directory / 'wiki'
        self.wiki.mkdir()
        (self.wiki / 'fitrah.md').write_text('# Fitrah AI\n\nMateri fitrah keluarga buatan AI.', encoding='utf-8')
        self.curated = self.directory / 'curated.json'
        self.seeds = [dict(key='doa_gelisah', title='Doa Gelisah', category='Doa', body=DOA,
                           content_type='doa', provenance='expert_verified', source_origin='alexandrie',
                           metadata={'takhrij': 'fixture editorial'}),
                      dict(key='skenario_maghrib', title='Skenario Maghrib', category='Cerita',
                           body=SCENARIO, content_type='cerita_rpg', provenance='expert_verified',
                           source_origin='alexandrie', metadata={'usia': '7-10'}),
                      dict(key='ai_doa', title='Doa Gelisah AI', body='Doa gelisah AI tidak boleh terpilih.',
                           content_type='doa', provenance='ai_assisted'),
                      dict(key='ai_scenario', title='Skenario Maghrib AI', body='Maghrib AI tidak boleh terpilih.',
                           content_type='cerita_rpg', provenance='ai_assisted')]
        save_json(self.curated, {'records': self.seeds, 'editorial_owner': 'preserve me'})
        self.fixture = WordPressFixture()
        self.addCleanup(self.fixture.close)
        self.process = None
        self.addCleanup(self.stop_server)

    def cli(self, script, *args, success=True):
        result = subprocess.run([sys.executable, str(ROOT / script), *map(str, args)],
                                cwd=ROOT, capture_output=True, text=True, timeout=90)
        if success:
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        else:
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        return result

    def ingest(self):
        self.cli('ingestion_worker.py', '--wp-api', self.fixture.base, '--output', self.curated)
        return read_json(self.curated)

    def compile(self, version=1, api=None, success=True, embedding_mode='lexical'):
        args = ['--wiki-ai', self.wiki, '--alexandrie-json', self.curated,
                '--db-out', self.directory / 'knowledge_build.db',
                '--zst-out', self.directory / 'knowledge_v1.db.zst',
                '--version-code', version, '--release-tag', 'v%d.0.0' % version,
                '--embedding-mode', embedding_mode]
        if api:
            args += ['--alexandrie-api', api]
        self.cli('build_knowledge_db.py', *args, success=success)
        return read_json(self.directory / 'release_manifest.json')

    def request(self, path, body=None, token=None, status=200, binary=False):
        headers = {}
        if token is not None:
            headers['Authorization'] = 'Bearer ' + token
        data = None
        if body is not None:
            data = json.dumps(body).encode()
            headers['Content-Type'] = 'application/json'
        request = urllib.request.Request(self.base + path, data=data, headers=headers)
        try:
            with urllib.request.urlopen(request, timeout=5) as response:
                actual, raw = response.status, response.read()
        except urllib.error.HTTPError as error:
            with error:
                actual, raw = error.code, error.read()
        self.assertEqual(actual, status, raw.decode(errors='replace'))
        return raw if binary else json.loads(raw)

    def start_server(self):
        auth = self.directory / 'auth.json'
        save_json(auth, {'token-alice': 'alice', 'token-bob': 'bob'})
        port = free_port()
        self.base = 'http://127.0.0.1:%d' % port
        self.server_log = tempfile.TemporaryFile(mode='w+b')
        self.addCleanup(self.server_log.close)
        self.process = subprocess.Popen([sys.executable, str(ROOT / 'server.py'), '--host', '127.0.0.1',
                                         '--port', str(port), '--data-dir', str(self.directory),
                                         '--auth-file', str(auth)], stdout=self.server_log, stderr=self.server_log)
        deadline = time.monotonic() + 15
        while time.monotonic() < deadline:
            if self.process.poll() is not None:
                self.server_log.seek(0)
                self.fail('Server exited: ' + self.server_log.read().decode())
            try:
                with urllib.request.urlopen(self.base + '/health', timeout=.2) as response:
                    if response.status == 200:
                        return
            except (OSError, urllib.error.URLError):
                time.sleep(.05)
        self.fail('Server did not become ready')

    def stop_server(self):
        if self.process is not None:
            self.process.terminate()
            try:
                self.process.wait(timeout=5)
            except subprocess.TimeoutExpired:
                self.process.kill()
                self.process.wait(timeout=5)
            self.process = None

    def test_paginated_ingestion_is_stable_and_transactional(self):
        first = self.ingest()
        self.assertEqual(first['editorial_owner'], 'preserve me')
        self.assertEqual(first['records'][:len(self.seeds)], self.seeds)
        mirrored = [r for r in first['records'] if r['key'].startswith('wordpress:')]
        prefix = 'wordpress:' + hashlib.sha256(self.fixture.base.encode()).hexdigest()[:12]
        self.assertEqual({r['key'] for r in mirrored}, {prefix + ':pages:101', prefix + ':pages:202'})
        self.assertEqual({r['content_type'] for r in mirrored}, {'event', 'book'})
        self.assertTrue(any('page=2' in url for url in self.fixture.requests))
        self.assertEqual(self.ingest(), first)
        self.fixture.changed = True
        changed = self.ingest()
        self.assertEqual({r['key'] for r in changed['records']}, {r['key'] for r in first['records']})
        event = next(r for r in changed['records'] if r['key'].endswith(':101'))
        self.assertEqual(event['title'], "Event Thuma'ninah Revisi")
        self.assertEqual(changed['records'][:len(self.seeds)], self.seeds)
        before = self.curated.read_bytes()
        self.fixture.fail = True
        self.cli('ingestion_worker.py', '--wp-api', self.fixture.base, '--output', self.curated, success=False)
        self.assertEqual(self.curated.read_bytes(), before)

    def test_rest_detail_failure_uses_public_elementor_and_preserves_on_double_failure(self):
        self.fixture.fail_detail = True
        result = self.ingest()
        event = next(record for record in result['records'] if record['key'].endswith(':101'))
        self.assertIn("Public majelis thuma'ninah.", event['body'])
        self.assertNotIn('Unrelated navigation', event['body'])
        self.assertNotIn('Unrelated footer', event['body'])
        self.assertEqual(event['metadata']['ingestion_method'], 'public_html')
        self.assertTrue(any('/pages/101?' in path for path in self.fixture.requests))
        self.assertIn('/event-public/', self.fixture.requests)
        self.assertEqual(result['records'][:len(self.seeds)], self.seeds)
        before = self.curated.read_bytes()
        self.fixture.fail_public = True
        self.cli('ingestion_worker.py', '--wp-api', self.fixture.base, '--output', self.curated, success=False)
        self.assertEqual(self.curated.read_bytes(), before)

    def assert_bundle(self, manifest):
        import zstandard
        db = self.directory / 'knowledge_build.db'
        compressed = (self.directory / manifest['file_name']).read_bytes()
        self.assertEqual(hashlib.sha256(compressed).hexdigest(), manifest['sha256'])
        self.assertEqual(len(compressed), manifest['compressed_bytes'])
        self.assertEqual(db.stat().st_size, manifest['uncompressed_bytes'])
        with zstandard.ZstdDecompressor().stream_reader(io.BytesIO(compressed)) as reader:
            self.assertEqual(reader.read(), db.read_bytes())
        self.assertEqual((self.directory / 'knowledge_v1.db.zst').read_bytes(), compressed)
        self.assertEqual(manifest['embedding_mode'], 'lexical')
        with closing(sqlite3.connect(db)) as conn:
            conn.row_factory = sqlite3.Row
            rows = [dict(row) for row in conn.execute('SELECT * FROM articles')]
            self.assertEqual(len(rows), manifest['total_articles'])
            doa = next(r for r in rows if r['title'] == 'Doa Gelisah')
            self.assertEqual(doa['content'], DOA)
            self.assertEqual(doa['provenance'], 'expert_verified')
            self.assertEqual(json.loads(doa['metadata_json'])['takhrij'], 'fixture editorial')
            ai = next(r for r in rows if r['title'] == 'Fitrah AI')
            self.assertEqual(ai['provenance'], 'ai_assisted')
            self.assertEqual(conn.execute('SELECT count(*) FROM article_chunks WHERE embedding IS NOT NULL').fetchone()[0], 0)
            self.assertGreater(conn.execute("SELECT count(*) FROM articles_fts WHERE articles_fts MATCH ?", ('"thuma" AND "ninah"',)).fetchone()[0], 0)
            self.assertEqual(conn.execute('PRAGMA integrity_check').fetchone()[0], 'ok')
        return rows

    def test_compiler_sql_compression_api_and_failed_publication(self):
        self.ingest()
        manifest = self.compile()
        rows = self.assert_bundle(manifest)
        self.assertEqual(manifest['version_code'], 1)
        self.assertEqual(manifest['release_tag'], 'v1.0.0')
        event = next(r for r in rows if r['content_type'] == 'event')
        self.assertEqual(event['source_origin'], 'wordpress')
        self.assertEqual(json.loads(event['metadata_json'])['wp_id'], 101)
        self.fixture.records = read_json(self.curated)['records'] + [dict(key='api_only', title='API Only', body='API transport content.')]
        api_manifest = self.compile(2, api=self.fixture.base + '/documents')
        with closing(sqlite3.connect(self.directory / 'knowledge_build.db')) as conn:
            self.assertEqual(conn.execute("SELECT content FROM articles WHERE title='API Only'").fetchone()[0], 'API transport content.')
        self.assert_bundle(api_manifest)
        protected = {name: (self.directory / name).read_bytes() for name in
                     ['release_manifest.json', 'knowledge_build.db', 'knowledge_v1.db.zst', api_manifest['file_name']]}
        self.fixture.fail = True
        self.compile(3, api=self.fixture.base + '/documents', success=False)
        for name, payload in protected.items():
            self.assertEqual((self.directory / name).read_bytes(), payload, name)

    async def mcp_results(self, calls):
        from mcp import ClientSession, StdioServerParameters
        from mcp.client.stdio import stdio_client
        parameters = StdioServerParameters(command=sys.executable,
                                           args=[str(ROOT / 'mcp/pkn_knowledge_mcp.py'), '--db',
                                                 str(self.directory / 'knowledge_build.db')])
        async with stdio_client(parameters) as (reader, writer):
            async with ClientSession(reader, writer) as session:
                initialized = await session.initialize()
                self.assertTrue(initialized.serverInfo.name)
                listed = await session.list_tools()
                self.assertEqual({tool.name for tool in listed.tools},
                                 {'search_knowledge', 'get_article', 'get_doa_penenang',
                                  'get_skenario_adab', 'get_agenda_event', 'get_similar_articles'})
                results = []
                for name, arguments in calls:
                    result = await session.call_tool(name, arguments)
                    self.assertFalse(result.isError, result)
                    text = json.loads(next(item.text for item in result.content if item.type == 'text'))
                    if result.structuredContent is not None:
                        self.assertEqual(result.structuredContent, text)
                    results.append(text)
                return results

    def test_mcp_five_tools_and_live_release_cutover(self):
        self.ingest()
        first = self.compile()
        with closing(sqlite3.connect(self.directory / 'knowledge_build.db')) as conn:
            article_id = conn.execute("SELECT id FROM articles WHERE title='Doa Gelisah'").fetchone()[0]
            expected_event = conn.execute("SELECT content FROM articles WHERE content_type='event'").fetchone()[0]
            book_id, book_body = conn.execute("SELECT id, content FROM articles WHERE title='Buku Adab'").fetchone()
        calls = [('search_knowledge', {'query': "thuma'ninah", 'provenance': 'expert_verified'}),
                 ('get_article', {'article_id': article_id}), ('get_doa_penenang', {'topik': 'gelisah'}),
                 ('get_skenario_adab', {'kata_kunci': 'Maghrib'}), ('get_agenda_event', {'limit': 5}),
                 ('search_knowledge', {'query': 'Buku', 'content_type': 'buku', 'provenance': 'expert_verified'}),
                 ('get_article', {'article_id': book_id})]
        search, article, doa, scenario, events, books, book = asyncio.run(self.mcp_results(calls))
        self.assertIn(article_id, {row['id'] for row in search['results']})
        self.assertTrue(all(row['provenance'] == 'expert_verified' for row in search['results']))
        self.assertEqual(article['content'], DOA)
        self.assertEqual(article['metadata']['takhrij'], 'fixture editorial')
        self.assertEqual(article['source_origin'], 'alexandrie')
        self.assertEqual([row['content'] for row in doa['doa_list']], [DOA])
        self.assertEqual([row['content'] for row in scenario['skenario_list']], [SCENARIO])
        for row in doa['doa_list'] + scenario['skenario_list'] + events['events']:
            self.assertEqual(row['provenance'], 'expert_verified')
        self.assertEqual(len(events['events']), 1)
        self.assertEqual(events['events'][0]['metadata']['wp_id'], 101)
        self.assertEqual(events['events'][0]['content'], expected_event)
        self.assertEqual(events['events'][0]['source_origin'], 'wordpress')
        self.assertEqual(scenario['skenario_list'][0]['metadata']['usia'], '7-10')
        self.assertEqual(doa['doa_list'][0]['metadata']['takhrij'], 'fixture editorial')
        self.assertEqual([row['id'] for row in books['results']], [book_id])
        self.assertEqual(books['results'][0]['content_type'], 'buku')
        self.assertEqual(book['content'], book_body)
        self.assertIn('Pustaka adab keluarga.', book['content'])
        self.assertEqual(book['metadata']['wp_id'], 202)
        self.assertEqual(book['source_origin'], 'wordpress')
        self.assertEqual(book['provenance'], 'expert_verified')
        self.start_server()
        self.assertEqual(self.request('/health')['status'], 'ok')
        release = self.request('/api/knowledge/release')
        self.assertEqual(release['version_code'], 1)
        downloaded = self.request(release['download_url'], binary=True)
        self.assertEqual(hashlib.sha256(downloaded).hexdigest(), first['sha256'])
        self.fixture.changed = True
        self.ingest()
        second = self.compile(2)
        updated = self.request('/api/knowledge/release')
        self.assertEqual(updated['version_code'], 2)
        self.assertEqual(updated['release_tag'], 'v2.0.0')
        self.assertNotEqual(second['sha256'], first['sha256'])
        self.assertEqual(hashlib.sha256(self.request(updated['download_url'], binary=True)).hexdigest(), second['sha256'])
        saved_download = self.request(release['download_url'], binary=True)
        self.assertEqual(saved_download, downloaded)
        self.assertEqual(hashlib.sha256(saved_download).hexdigest(), first['sha256'])
        fresh = asyncio.run(self.mcp_results([('get_agenda_event', {'limit': 5})]))[0]
        self.assertEqual(fresh['events'][0]['title'], "Event Thuma'ninah Revisi")
        self.assertEqual((self.directory / first['file_name']).read_bytes(), downloaded)

    def mutation(self, collection, mutation_id, *, deleted=False, content='note one',
                 timestamp='2026-01-01T00:00:00Z', record_id=None):
        value = dict(mutation_id=mutation_id, collection=collection, id=record_id or collection + '-1',
                     article_id='article-fixture', client_updated_at=timestamp, is_deleted=deleted)
        if collection == 'notes':
            value['content'] = content
        return value

    def sync(self, outbox=(), cursor=0, token='token-alice', status=200):
        return self.request('/api/user/sync', {'cursor': cursor, 'outbox': list(outbox)}, token, status)

    def test_sync_lifecycle_conflicts_atomicity_isolation_and_restart(self):
        self.start_server()
        self.sync(token=None, status=401)
        self.sync(token='unknown', status=401)
        initial = [self.mutation(kind, kind + '-create') for kind in ('notes', 'bookmarks')]
        created = self.sync(initial)
        self.assertEqual(created['acknowledged'], ['notes-create', 'bookmarks-create'])
        self.assertEqual(len(created['changes']), 2)
        cursor = created['cursor']
        self.assertGreater(cursor, 0)
        self.assertEqual({r['collection'] for r in created['changes']}, {'notes', 'bookmarks'})
        self.assertTrue(all(not r['is_deleted'] for r in created['changes']))
        self.assertEqual(next(r['content'] for r in created['changes'] if r['collection'] == 'notes'), 'note one')
        retry = self.sync(initial, cursor=cursor)
        self.assertEqual(retry, {'acknowledged': ['notes-create', 'bookmarks-create'], 'changes': [], 'cursor': cursor})
        equal_identical = [self.mutation(kind, kind + '-equal') for kind in ('notes', 'bookmarks')]
        equal = self.sync(equal_identical, cursor=cursor)
        self.assertEqual(equal['changes'], [])
        self.assertEqual(equal['cursor'], cursor)
        for kind in ('notes', 'bookmarks'):
            with self.subTest(collection=kind, conflict='equal'):
                conflict = self.mutation(kind, kind + '-conflict', deleted=True)
                self.sync([conflict], cursor=cursor, status=409)
            with self.subTest(collection=kind, conflict='stale'):
                stale = self.mutation(kind, kind + '-stale', timestamp='2025-12-31T23:59:59Z')
                self.sync([stale], cursor=cursor, status=409)
        collision = dict(initial[0], content='different retry payload')
        self.sync([collision], cursor=cursor, status=409)
        updated = [self.mutation(kind, kind + '-update', content='note two',
                                 timestamp='2026-01-02T00:00:00Z') for kind in ('notes', 'bookmarks')]
        # A bookmark update changes article_id, not note-only content.
        updated[1]['article_id'] = 'article-two'
        response = self.sync(updated, cursor=cursor)
        self.assertEqual(response['acknowledged'], ['notes-update', 'bookmarks-update'])
        self.assertEqual(len(response['changes']), 2)
        self.assertEqual(next(r['content'] for r in response['changes'] if r['collection'] == 'notes'), 'note two')
        self.assertEqual(next(r['article_id'] for r in response['changes'] if r['collection'] == 'bookmarks'), 'article-two')
        self.assertGreater(response['cursor'], cursor)
        cursor = response['cursor']
        invalid = self.mutation('notes', 'invalid', record_id='invalid')
        invalid['is_deleted'] = 'false'
        atomic_valid = self.mutation('notes', 'atomic-valid', record_id='atomic')
        self.sync([atomic_valid, invalid], cursor=cursor, status=400)
        self.assertEqual(self.sync(cursor=cursor)['changes'], [])
        # Reusing the valid ID proves rejection rolled back acknowledgements too.
        accepted = self.sync([atomic_valid], cursor=cursor)
        self.assertEqual(accepted['acknowledged'], ['atomic-valid'])
        self.assertEqual(len(accepted['changes']), 1)
        cursor = accepted['cursor']
        for collection in ('curhat', 'muhasabah', 'child_scores', 'users', 'knowledge_releases'):
            self.sync([dict(self.mutation('bookmarks', 'sensitive-' + collection), collection=collection)],
                      cursor=cursor, status=400)
        self.request('/api/user/sync', {'cursor': cursor, 'outbox': [], 'user_id': 'bob'},
                     'token-alice', status=400)
        self.assertEqual(self.sync(token='token-bob'), {'acknowledged': [], 'changes': [], 'cursor': 0})
        bob = self.sync([self.mutation('notes', 'notes-create', content='private bob')], token='token-bob')
        self.assertEqual(bob['acknowledged'], ['notes-create'])
        self.assertEqual(bob['changes'][0]['content'], 'private bob')
        self.assertEqual(self.sync(cursor=cursor)['changes'], [])
        deleted = [self.mutation(kind, kind + '-delete', deleted=True, content='note two',
                                 timestamp='2026-01-03T00:00:00Z') for kind in ('notes', 'bookmarks')]
        deleted[1]['article_id'] = 'article-two'
        tombstones = self.sync(deleted, cursor=cursor)
        self.assertEqual(tombstones['acknowledged'], ['notes-delete', 'bookmarks-delete'])
        self.assertEqual(len(tombstones['changes']), 2)
        self.assertTrue(all(row['is_deleted'] for row in tombstones['changes']))
        self.assertTrue(all(row['revision'] > cursor for row in tombstones['changes']))
        latest = tombstones['cursor']
        self.assertEqual(self.sync(deleted, cursor=latest)['changes'], [])
        self.stop_server()
        self.start_server()
        pull = self.request('/api/user/sync?cursor=%d' % cursor, token='token-alice')
        self.assertEqual(pull['changes'], tombstones['changes'])
        self.assertEqual(pull['cursor'], latest)
        self.assertEqual(self.sync(deleted, cursor=latest)['acknowledged'], ['notes-delete', 'bookmarks-delete'])
        bob_pull = self.request('/api/user/sync?cursor=0', token='token-bob')
        self.assertEqual([row['content'] for row in bob_pull['changes']], ['private bob'])
        self.assertTrue(all(row['content'] != 'private bob' for row in
                            self.request('/api/user/sync?cursor=0', token='token-alice')['changes']
                            if row['collection'] == 'notes'))

    def test_libsql_vector_embeddings_and_hybrid_search(self):
        self.ingest()
        manifest = self.compile(version=1, embedding_mode='semantic')
        self.assertEqual(manifest['embedding_mode'], 'semantic')
        self.assertEqual(manifest['embedding_dimensions'], 384)

        # 1. Verifikasi SQLite schema & ukuran embedding F32_BLOB(384)
        with closing(sqlite3.connect(self.directory / 'knowledge_build.db')) as conn:
            chunks = conn.execute("SELECT id, article_id, embedding FROM article_chunks").fetchall()
            self.assertTrue(len(chunks) > 0)
            for cid, aid, emb in chunks:
                self.assertIsNotNone(emb, f"Chunk {cid} ({aid}) harus memiliki embedding")
                self.assertEqual(len(emb), 1536, "F32_BLOB(384) harus tepat 1536 bytes")
                vec = np.frombuffer(emb, dtype='<f4')
                self.assertEqual(len(vec), 384)
                norm = float(np.linalg.norm(vec))
                self.assertAlmostEqual(norm, 1.0, places=4)
            doa_id = conn.execute("SELECT id FROM articles WHERE title='Doa Gelisah'").fetchone()[0]

        # 2. Verifikasi MCP tool semantic & hybrid search serta get_similar_articles
        calls = [
            ('search_knowledge', {'query': "thuma'ninah", 'search_mode': 'semantic', 'limit': 3}),
            ('search_knowledge', {'query': "thuma'ninah", 'search_mode': 'hybrid', 'limit': 3}),
            ('get_similar_articles', {'article_id': doa_id, 'limit': 3}),
        ]
        sem_res, hyb_res, sim_res = asyncio.run(self.mcp_results(calls))
        self.assertTrue(len(sem_res['results']) > 0)
        self.assertIn('similarity_score', sem_res['results'][0])
        self.assertTrue(len(hyb_res['results']) > 0)
        self.assertIn('rrf_score', hyb_res['results'][0])
        self.assertTrue(len(sim_res['similar_articles']) > 0)
        self.assertIn('similarity_score', sim_res['similar_articles'][0])
        self.assertNotEqual(sim_res['similar_articles'][0]['id'], doa_id)

    @unittest.skipUnless(LIVE, 'enable real WordPress ingestion with --live-wordpress')
    def test_live_wordpress_has_real_event_and_books(self):
        output = self.directory / 'live-curated.json'
        self.cli('ingestion_worker.py', '--wp-api', 'https://karakternabawiyah.com/wp-json/wp/v2',
                 '--output', output)
        records = read_json(output)['records']
        self.assertTrue(any(row['content_type'] == 'event' for row in records))
        self.assertTrue(any(row['content_type'] == 'book' for row in records))
        self.assertTrue(all(row['key'].startswith('wordpress:') for row in records))


if __name__ == '__main__':
    unittest.main()
