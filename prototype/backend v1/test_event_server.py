"""Deterministic parser and snapshot tests; no network required."""
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

from event_server import EventService, SOURCE_URL, discover_home_links, fetch_event_image, fetch_events, normalize_event, parse_html


DETAIL = '''<div><h3>Event</h3><h2>Seminar Pendidikan</h2>
<p>Penjelasan pendidikan yang bersumber dari halaman acara.</p>
<img src="https://example.com/poster.png">
<div class="wpr-accordion-item-wrap"><span class="wpr-acc-title-text">Pemateri</span>
<div class="wpr-acc-panel-content"><div class="narasumber-card"><h3>Ust. Ahmad</h3></div></div></div>
<div class="wpr-accordion-item-wrap"><span class="wpr-acc-title-text">Hari Tanggal</span><div class="wpr-acc-panel-content"><p>Ahad, 18 Oktober 2026</p></div></div>
<div class="wpr-accordion-item-wrap"><span class="wpr-acc-title-text">Waktu</span><div class="wpr-acc-panel-content"><p>Pukul : 08.00 s/d 16.00 WIB</p></div></div>
<div class="wpr-accordion-item-wrap"><span class="wpr-acc-title-text">Tempat</span><div class="wpr-acc-panel-content"><p>Gedung Pendidikan,<br>Kabupaten Bekasi<br>Map : <a href="https://maps.app.goo.gl/example">Klik disini</a></p></div></div>
<div class="wpr-accordion-item-wrap"><span class="wpr-acc-title-text">Fasilitas</span><div class="wpr-acc-panel-content"><ul><li>✓ Handout</li><li>Snack &amp; Makan</li></ul></div></div>
<div class="wpr-accordion-item-wrap"><span class="wpr-acc-title-text">Kontribusi</span><div class="wpr-acc-panel-content"><div class="harga-card"><div>REGULER</div><div>Rp 250.000</div></div></div></div>
<a href="https://forms.gle/example">Daftar Sekarang</a><style>.hidden {color: red}</style></div>'''


class ParserTests(unittest.TestCase):
    def test_extracts_source_fields_and_ignores_styles(self):
        event = normalize_event(DETAIL, 'https://example.com/event/', 'Seminar Pendidikan')
        self.assertEqual(event['dateLabel'], 'Ahad, 18 Oktober 2026')
        self.assertEqual(event['timeLabel'], '08.00 s/d 16.00 WIB')
        self.assertEqual(event['location'], 'Gedung Pendidikan, Kabupaten Bekasi')
        self.assertEqual(event['speakers'], ['Ust. Ahmad'])
        self.assertEqual(event['facilities'], ['Handout', 'Snack & Makan'])
        self.assertEqual(event['prices'], ['REGULER Rp 250.000'])
        self.assertEqual(event['registrationUrl'], 'https://forms.gle/example')
        self.assertNotIn('.hidden', ' '.join(event['content']))

    def test_full_page_ignores_embedded_navigation_template(self):
        html = ('<html><head><meta property="og:title" content="Seminar Pendidikan"></head>'
                '<body><div data-elementor-type="wp-page"><h2>PEMATERI</h2>'
                '<h3>Ustadz Template</h3></div><main><article id="post-123">'
                '<div data-elementor-type="wp-page" data-elementor-id="123">'
                + DETAIL + '</div></article></main></body></html>')
        event = normalize_event(html, 'https://example.com/event/')
        self.assertEqual(event['title'], 'Seminar Pendidikan')
        self.assertEqual(event['dateLabel'], 'Ahad, 18 Oktober 2026')
        self.assertEqual(event['speakers'], ['Ust. Ahmad'])
        self.assertEqual(event['mapUrl'], 'https://maps.app.goo.gl/example')
        self.assertNotIn('Ustadz Template', event['content'])

    def test_missing_fields_are_not_invented(self):
        event = normalize_event('<h3>Event</h3><h2>Acara</h2>', 'https://example.com/acara/')
        self.assertIsNone(event['dateLabel'])
        self.assertIsNone(event['registrationUrl'])
        self.assertEqual(event['speakers'], [])

    def test_home_discovery_excludes_product_link(self):
        links = discover_home_links(parse_html('<a href="/event/">Event Terkini</a><a href="/product/">Produk Terkini</a>'), 'https://example.com/')
        self.assertEqual(links, ['https://example.com/event/'])


class ImageTests(unittest.TestCase):
    def test_rejects_non_source_image_host(self):
        with self.assertRaises(ValueError):
            fetch_event_image({'imageUrl': 'http://127.0.0.1/private'}, 10)

    def test_missing_image_is_not_fabricated(self):
        with self.assertRaises(ValueError):
            fetch_event_image({'imageUrl': None}, 10)


class DiscoveryTests(unittest.TestCase):
    def test_wordpress_failure_still_fetches_homepage_detail(self):
        def source(url, timeout):
            if url == SOURCE_URL:
                return '<a href="/seminar/">Event Terkini</a>', {}
            if 'wp-json' in url:
                raise OSError('WordPress unavailable')
            if url == SOURCE_URL + 'seminar/':
                return DETAIL, {}
            raise AssertionError(url)
        with patch('event_server.fetch_url', side_effect=source):
            events = fetch_events(10)
        self.assertEqual(len(events), 1)
        self.assertEqual(events[0]['sourceUrl'], SOURCE_URL + 'seminar/')
        self.assertIn('WordPress unavailable', events.discovery_error)

    def test_all_sources_failure_preserves_last_good_cache(self):
        with tempfile.TemporaryDirectory() as directory:
            service = EventService(Path(directory) / 'events.json', 3600, 10)
            event = normalize_event(DETAIL, SOURCE_URL + 'seminar/')
            with patch('event_server.fetch_events', return_value=[event]):
                service.sync()
            def source(url, timeout):
                if url == SOURCE_URL:
                    return '<a href="/seminar/">Event Terkini</a>', {}
                raise OSError('offline')
            with patch('event_server.fetch_url', side_effect=source):
                self.assertFalse(service.sync())
            self.assertEqual(service.snapshot()['events'], [event])


class SnapshotTests(unittest.TestCase):
    def test_failed_sync_preserves_disk_and_memory(self):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / 'events.json'
            service = EventService(path, 3600, 10)
            event = normalize_event(DETAIL, 'https://example.com/event/')
            with patch('event_server.fetch_events', return_value=[event]):
                self.assertTrue(service.sync())
            old_bytes = path.read_bytes()
            with patch('event_server.fetch_events', side_effect=OSError('offline')):
                self.assertFalse(service.sync())
            self.assertEqual(service.snapshot()['events'], [event])
            self.assertEqual(path.read_bytes(), old_bytes)
            self.assertEqual(EventService(path, 3600, 10).snapshot()['events'], [event])
            self.assertIn('offline', service.snapshot()['sync']['lastError'])

    def test_empty_result_does_not_wipe_snapshot(self):
        with tempfile.TemporaryDirectory() as directory:
            service = EventService(Path(directory) / 'cache.json', 3600, 10)
            with patch('event_server.fetch_events', return_value=[]):
                self.assertFalse(service.sync())
            self.assertIsNone(service.snapshot()['sync']['lastSuccessAt'])


if __name__ == '__main__':
    unittest.main()
