"""Read-only event mirror for the public PKN website (Python 3.10+, stdlib)."""
import argparse
from datetime import datetime, timedelta, timezone
import hashlib
from html.parser import HTMLParser
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
import json
import logging
import os
from pathlib import Path
import re
import tempfile
import threading
from urllib.parse import unquote, urlencode, urljoin, urlsplit
from urllib.request import HTTPRedirectHandler, Request, build_opener, urlopen

SOURCE_URL = 'https://karakternabawiyah.com/'
LOG = logging.getLogger(__name__)
BLOCKS = {'p', 'li', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'div', 'section', 'br', 'button'}
VOID = {'area', 'base', 'br', 'col', 'embed', 'hr', 'img', 'input', 'link', 'meta', 'param', 'source', 'track', 'wbr'}
IGNORED = {'script', 'style', 'svg', 'noscript', 'nav', 'footer', 'header'}
LABELS = {'pemateri', 'narasumber', 'materi', 'hari tanggal', 'tanggal', 'waktu', 'tempat', 'lokasi', 'fasilitas', 'kontribusi', 'harga', 'rekening'}


class Node:
    def __init__(self, tag='', attrs=None):
        self.tag = tag
        self.attrs = attrs or {}
        self.children = []

    def walk(self):
        yield self
        for child in self.children:
            if isinstance(child, Node):
                yield from child.walk()

    def has_class(self, name):
        return name in self.attrs.get('class', '').split()

    def text(self):
        if self.tag in IGNORED:
            return ''
        parts = []
        for child in self.children:
            if isinstance(child, str):
                parts.append(child)
            else:
                value = child.text()
                if child.tag in BLOCKS:
                    parts.extend(['\n', value, '\n'])
                else:
                    parts.append(value)
        return ''.join(parts)

    def lines(self):
        return [value for line in self.text().splitlines() if (value := clean(line))]


def clean(value):
    return re.sub(r'\s+', ' ', value).strip()


class DocumentParser(HTMLParser):
    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.root = Node()
        self.stack = [self.root]

    def handle_starttag(self, tag, attrs):
        node = Node(tag, dict(attrs))
        self.stack[-1].children.append(node)
        if tag not in VOID:
            self.stack.append(node)

    def handle_startendtag(self, tag, attrs):
        self.handle_starttag(tag, attrs)
        if tag not in VOID:
            self.handle_endtag(tag)

    def handle_endtag(self, tag):
        for index in range(len(self.stack) - 1, 0, -1):
            if self.stack[index].tag == tag:
                del self.stack[index:]
                break

    def handle_data(self, data):
        self.stack[-1].children.append(data)


def parse_html(html):
    parser = DocumentParser()
    parser.feed(html)
    return parser.root


def safe_url(value, base):
    url = urljoin(base, value or '')
    return url if urlsplit(url).scheme in {'https', 'http'} else None


def discover_home_links(root, base):
    links = []
    for node in root.walk():
        if node.tag == 'a' and clean(node.text()).casefold() == 'event terkini':
            url = safe_url(node.attrs.get('href'), base)
            if url and urlsplit(url).netloc == urlsplit(base).netloc and url not in links:
                links.append(url)
    return links


def event_label(root):
    return any(node.tag in {'h1', 'h2', 'h3', 'h4', 'h5', 'h6'} and
               clean(node.text()).casefold() == 'event' for node in root.walk())


def normalize_event(html, source_url, title=None):
    document = parse_html(html)
    # Navigation may embed Elementor wp-page templates before the actual article.
    # Restrict candidates to main/article, then match the WordPress article ID.
    main = next((node for node in document.walk() if node.tag == 'main'), document)
    article = next((node for node in main.walk() if node.tag == 'article'
                    and node.attrs.get('id', '').startswith('post-')), None)
    scope = article or main
    page_id = article.attrs['id'].removeprefix('post-') if article else None
    candidates = [node for node in scope.walk()
                  if node.attrs.get('data-elementor-type') in {'wp-page', 'wp-post'}]
    root = next((node for node in candidates if page_id and
                 node.attrs.get('data-elementor-id') == page_id), None)
    if root is None:
        root = next((node for node in candidates if event_label(node)), scope)
    nodes = list(root.walk())
    lines = root.lines()
    title = clean(parse_html(title).text()) if title else None
    if not title:
        title = next((clean(node.attrs.get('content', '')) for node in document.walk()
                      if node.tag == 'meta' and node.attrs.get('property') == 'og:title'
                      and node.attrs.get('content')), None)
    if not title:
        title = next((clean(node.text()) for node in nodes if node.tag in {'h1', 'h2'} and clean(node.text())), None)
    if not title or not lines:
        raise ValueError(f'Event content/title missing: {source_url}')
    sections = {}
    for node in nodes:
        if node.has_class('wpr-accordion-item-wrap'):
            label = next((clean(child.text()).casefold() for child in node.walk()
                          if child.has_class('wpr-acc-title-text')), '')
            panel = next((child for child in node.walk() if child.has_class('wpr-acc-panel-content')), None)
            if panel:
                sections[label] = panel
    # Preserve explicitly labelled sections in simpler non-Elementor pages too.
    def section_lines(*labels):
        for label in labels:
            if label in sections:
                return sections[label].lines()
        for index, line in enumerate(lines):
            if line.casefold() in labels:
                result = []
                for value in lines[index + 1:]:
                    if value.casefold() in LABELS:
                        break
                    result.append(value)
                return result
        return []

    date_lines = section_lines('hari tanggal', 'tanggal')
    time_lines = section_lines('waktu')
    location_lines = section_lines('tempat', 'lokasi')
    location_lines = [line for line in location_lines if not re.match(r'^(map\s*:|klik disini)', line, re.I)]
    speakers = [clean(node.text()) for node in nodes if node.tag in {'h3', 'h4'} and
                re.match(r'^(Ust(?:adz|adzah)?\.?|Dr\.?|Prof\.?)\s', clean(node.text()), re.I)]
    speaker_panel = sections.get('pemateri') or sections.get('narasumber')
    if speaker_panel:
        speakers = [clean(node.text()) for node in speaker_panel.walk()
                    if node.tag in {'h2', 'h3', 'h4'} and clean(node.text())]
    facilities = section_lines('fasilitas')
    facilities = [re.sub(r'^[✓✔\s]+', '', line) for line in facilities
                  if re.search(r'\w', line) and line.casefold() not in {'fasilitas', 'konsumsi peserta'}]
    price_panel = sections.get('kontribusi') or sections.get('harga')
    prices = []
    if price_panel:
        prices = [clean(node.text()) for node in price_panel.walk() if node.has_class('harga-card')]
    if not prices:
        prices = [line for line in section_lines('kontribusi', 'harga') if re.search(r'\bRp\s*[\d.]', line, re.I)]
    links = [(safe_url(node.attrs.get('href'), source_url), clean(node.text()).casefold())
             for node in nodes if node.tag == 'a' and node.attrs.get('href')]
    registration = next((url for url, label in links if url and
                         urlsplit(url).hostname in {'forms.gle', 'docs.google.com'}), None)
    if not registration:
        registration = next((url for url, label in links if url and re.search(r'daftar|registrasi|register', label)), None)
    map_url = next((url for url, label in links if url and
                    (urlsplit(url).hostname in {'maps.app.goo.gl', 'maps.google.com', 'goo.gl'} or
                     (urlsplit(url).hostname in {'www.google.com', 'google.com'} and '/maps' in urlsplit(url).path))), None)
    image = next((safe_url(node.attrs.get('content'), source_url) for node in document.walk()
                  if node.tag == 'meta' and node.attrs.get('property') == 'og:image'), None)
    if not image:
        image = next((safe_url(node.attrs.get('src'), source_url) for node in nodes
                      if node.tag == 'img' and node.attrs.get('src') and
                      not re.search(r'logo|icon', node.attrs['src'], re.I)), None)
    paragraphs = [clean(node.text()) for node in nodes if node.tag == 'p' and clean(node.text())]
    summary = next((paragraph for paragraph in paragraphs if len(paragraph) > 100), paragraphs[0] if paragraphs else None)
    canonical = source_url.rstrip('/') + '/'
    return {
        'id': hashlib.sha256(canonical.encode()).hexdigest()[:16], 'title': title,
        'summary': summary, 'imageUrl': image, 'sourceUrl': source_url,
        'registrationUrl': registration, 'mapUrl': map_url,
        'dateLabel': ' '.join(date_lines) or None,
        'timeLabel': re.sub(r'^Pukul\s*:\s*', '', ' '.join(time_lines), flags=re.I) or None,
        'location': ' '.join(location_lines) or None, 'category': 'Event' if event_label(root) else None,
        'speakers': list(dict.fromkeys(speakers)), 'facilities': list(dict.fromkeys(facilities)),
        'prices': prices, 'content': lines,
    }


def fetch_url(url, timeout):
    request = Request(url, headers={'User-Agent': 'PKN-Event-Prototype/1.0', 'Accept': 'application/json,text/html'})
    with urlopen(request, timeout=timeout) as response:
        body = response.read(8 * 1024 * 1024 + 1)
        if len(body) > 8 * 1024 * 1024:
            raise ValueError(f'Source response exceeds 8 MiB: {url}')
        return body.decode(response.headers.get_content_charset() or 'utf-8'), dict(response.headers)


class EventBatch(list):
    """Events plus a visible warning when optional discovery is incomplete."""
    def __init__(self, events, discovery_error=None):
        super().__init__(events)
        self.discovery_error = discovery_error


def fetch_events(timeout):
    events = {}
    warnings = []
    home_links = []
    try:
        homepage, _ = fetch_url(SOURCE_URL, timeout)
        home_links = discover_home_links(parse_html(homepage), SOURCE_URL)
        for url in home_links:
            html, _ = fetch_url(url, timeout)
            events[url.rstrip('/')] = normalize_event(html, url)
    except Exception as error:
        warnings.append(f'Homepage discovery: {type(error).__name__}: {error}')
    # WordPress enriches discovery, but must not gate accessible homepage events.
    # Stage its complete scan separately so a failed later page is not published.
    wordpress_events = {}
    try:
        page = 1
        while True:
            query = urlencode({'per_page': 20, 'page': page, '_fields': 'id,link,title,content'})
            body, headers = fetch_url(urljoin(SOURCE_URL, 'wp-json/wp/v2/pages') + '?' + query, timeout)
            records = json.loads(body)
            if not isinstance(records, list):
                raise ValueError('WordPress pages response is not an array')
            for record in records:
                html = record.get('content', {}).get('rendered', '')
                url = record.get('link', '')
                if urlsplit(url).netloc != urlsplit(SOURCE_URL).netloc:
                    continue
                if event_label(parse_html(html)) or url.rstrip('/') in {link.rstrip('/') for link in home_links}:
                    wordpress_events[url.rstrip('/')] = normalize_event(
                        html, url, record.get('title', {}).get('rendered'))
            total_pages = int(next((value for key, value in headers.items()
                                    if key.lower() == 'x-wp-totalpages'), '1'))
            if page >= total_pages:
                break
            page += 1
        events.update(wordpress_events)
    except Exception as error:
        warnings.append(f'WordPress discovery: {type(error).__name__}: {error}')
    if not events:
        raise ValueError('; '.join(warnings) or 'No event-labelled pages or Event Terkini links found')
    ordered = sorted(events.values(), key=lambda event: 0 if event['sourceUrl'].rstrip('/') in
                     {url.rstrip('/') for url in home_links} else 1)
    return EventBatch(ordered, '; '.join(warnings) or None)


def timestamp(value=None):
    return (value or datetime.now(timezone.utc)).isoformat().replace('+00:00', 'Z')


class EventService:
    def __init__(self, cache_path, interval, timeout):
        self.cache_path = Path(cache_path)
        self.interval = interval
        self.timeout = timeout
        self.lock = threading.Lock()
        self.sync_lock = threading.Lock()
        self.stop = threading.Event()
        self.events = []
        self.last_success = None
        self.last_error = None
        self.next_sync = timestamp()
        try:
            cached = json.loads(self.cache_path.read_text(encoding='utf-8'))
            if not isinstance(cached['events'], list) or not cached['events'] or not all(
                    isinstance(event, dict) and event.get('id') and event.get('title') for event in cached['events']):
                raise ValueError('Invalid event cache')
            self.events = cached['events']
            self.last_success = cached['lastSuccessAt']
        except FileNotFoundError:
            pass
        except (OSError, ValueError, KeyError, TypeError) as error:
            self.last_error = f'Cache load failed: {error}'
            LOG.warning(self.last_error)

    def snapshot(self):
        with self.lock:
            return {'events': self.events, 'sync': {
                'lastSuccessAt': self.last_success, 'nextSyncAt': self.next_sync,
                'lastError': self.last_error, 'intervalSeconds': self.interval, 'sourceUrl': SOURCE_URL,
            }}

    def sync(self):
        if not self.sync_lock.acquire(blocking=False):
            return False
        try:
            events = fetch_events(self.timeout)
            if not events:
                raise ValueError('Empty event snapshot rejected')
            discovery_error = getattr(events, 'discovery_error', None)
            if discovery_error:
                # Refresh real fetched events without removing cached events whose
                # discovery source is temporarily unavailable.
                with self.lock:
                    fetched_ids = {event['id'] for event in events}
                    events = list(events) + [event for event in self.events if event['id'] not in fetched_ids]
            success = timestamp()
            self.cache_path.parent.mkdir(parents=True, exist_ok=True)
            temporary = None
            try:
                with tempfile.NamedTemporaryFile(mode='w', encoding='utf-8', dir=self.cache_path.parent,
                                                 prefix=self.cache_path.name + '.', delete=False) as file:
                    temporary = file.name
                    json.dump({'events': events, 'lastSuccessAt': success}, file, ensure_ascii=False)
                    file.flush()
                    os.fsync(file.fileno())
                os.replace(temporary, self.cache_path)
            finally:
                if temporary and os.path.exists(temporary):
                    os.unlink(temporary)
            with self.lock:
                self.events = events
                self.last_success = success
                self.last_error = discovery_error
            LOG.info('Synced %s events', len(events))
            return True
        except Exception as error:
            # A scheduled failure must not kill the worker or publish a partial snapshot.
            with self.lock:
                self.last_error = f'{type(error).__name__}: {error}'
            LOG.warning('Event sync failed: %s', error)
            return False
        finally:
            with self.lock:
                self.next_sync = timestamp(datetime.now(timezone.utc) + timedelta(seconds=self.interval))
            self.sync_lock.release()

    def run(self):
        while not self.stop.is_set():
            self.sync()
            if self.stop.wait(self.interval):
                break


def source_image_url(url):
    parsed = urlsplit(url or '')
    if (parsed.scheme != 'https' or parsed.hostname != urlsplit(SOURCE_URL).hostname
            or parsed.port not in {None, 443} or parsed.username or parsed.password):
        raise ValueError('Poster URL is not on the HTTPS source website')
    return url


class ImageRedirectHandler(HTTPRedirectHandler):
    def redirect_request(self, request, file, code, message, headers, new_url):
        source_image_url(new_url)
        return super().redirect_request(request, file, code, message, headers, new_url)


def fetch_event_image(event, timeout):
    url = source_image_url(event.get('imageUrl'))
    request = Request(url, headers={'User-Agent': 'PKN-Event-Prototype/1.0', 'Accept': 'image/*'})
    with build_opener(ImageRedirectHandler()).open(request, timeout=timeout) as response:
        content_type = response.headers.get_content_type()
        if content_type not in {'image/png', 'image/jpeg', 'image/webp', 'image/gif', 'image/avif'}:
            raise ValueError('Source poster is not a supported raster image')
        body = response.read(8 * 1024 * 1024 + 1)
        if len(body) > 8 * 1024 * 1024:
            raise ValueError('Source poster exceeds 8 MiB')
        return body, content_type


def handler_for(service):
    class Handler(BaseHTTPRequestHandler):
        def send_json(self, status, payload):
            body = json.dumps(payload, ensure_ascii=False).encode('utf-8')
            self.send_response(status)
            self.send_header('Content-Type', 'application/json; charset=utf-8')
            self.send_header('Content-Length', str(len(body)))
            self.send_header('Access-Control-Allow-Origin', '*')
            self.send_header('Access-Control-Allow-Methods', 'GET, OPTIONS')
            self.send_header('Access-Control-Allow-Headers', 'Content-Type')
            self.send_header('Cache-Control', 'no-store')
            self.end_headers()
            self.wfile.write(body)

        def do_OPTIONS(self):
            self.send_json(200, {})

        def do_GET(self):
            path = unquote(urlsplit(self.path).path).rstrip('/')
            snapshot = service.snapshot()
            if path == '/events':
                self.send_json(200, snapshot)
            elif path == '/health':
                self.send_json(200, {'status': 'ok' if snapshot['sync']['lastSuccessAt'] else 'waiting',
                                     'eventCount': len(snapshot['events']), 'sync': snapshot['sync']})
            elif path.startswith('/events/'):
                parts = path[len('/events/'):].split('/')
                event = next((event for event in snapshot['events'] if event['id'] == parts[0]), None)
                if not event:
                    self.send_json(404, {'error': 'Event not found'})
                elif len(parts) == 1:
                    self.send_json(200, {'event': event})
                elif parts[1:] == ['image']:
                    if not event.get('imageUrl'):
                        self.send_json(404, {'error': 'Event poster not available'})
                        return
                    try:
                        body, content_type = fetch_event_image(event, service.timeout)
                    except Exception as error:
                        LOG.warning('Poster fetch failed: %s', error)
                        self.send_json(502, {'error': 'Source poster unavailable'})
                        return
                    self.send_response(200)
                    self.send_header('Content-Type', content_type)
                    self.send_header('Content-Length', str(len(body)))
                    self.send_header('Access-Control-Allow-Origin', '*')
                    self.send_header('X-Content-Type-Options', 'nosniff')
                    self.send_header('Cache-Control', 'public, max-age=3600')
                    self.end_headers()
                    self.wfile.write(body)
                else:
                    self.send_json(404, {'error': 'Not found'})
            else:
                self.send_json(404, {'error': 'Not found'})
    return Handler


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--host', default=os.getenv('HOST', '127.0.0.1'))
    parser.add_argument('--port', type=int, default=os.getenv('PORT', '8081'))
    parser.add_argument('--interval', type=float, default=os.getenv('SYNC_INTERVAL_SECONDS', '3600'))
    parser.add_argument('--timeout', type=float, default=os.getenv('HTTP_TIMEOUT_SECONDS', '20'))
    parser.add_argument('--cache', type=Path, default=os.getenv('EVENT_CACHE_PATH', str(Path(__file__).parent / '.cache/events.json')))
    args = parser.parse_args()
    if args.interval <= 0 or args.timeout <= 0 or not 1 <= args.port <= 65535:
        parser.error('interval/timeout must be positive and port must be 1–65535')
    logging.basicConfig(level=logging.INFO, format='%(asctime)s %(levelname)s %(message)s')
    service = EventService(args.cache, args.interval, args.timeout)
    server = ThreadingHTTPServer((args.host, args.port), handler_for(service))
    worker = threading.Thread(target=service.run, name='event-sync', daemon=True)
    worker.start()
    LOG.info('Event API listening at http://%s:%s', args.host, args.port)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        pass
    finally:
        service.stop.set()
        server.server_close()
        worker.join(timeout=args.timeout + 1)


if __name__ == '__main__':
    main()
