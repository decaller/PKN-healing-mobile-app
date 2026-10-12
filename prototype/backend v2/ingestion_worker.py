"""Sinkronisasi konten publik WordPress ke JSON kurasi dan Alexandrie (stdlib)."""
from __future__ import annotations

import argparse
import hashlib
import html
import http.cookiejar
import json
import os
from pathlib import Path
import re
import tempfile
from html.parser import HTMLParser
from urllib.parse import urlencode, urljoin, urlsplit
from urllib.error import HTTPError, URLError
from urllib.request import HTTPCookieProcessor, Request, build_opener, urlopen

DEFAULT_WP_API = "https://karakternabawiyah.com/wp-json/wp/v2"
TIMEOUT = 30
MAX_RESPONSE = 16 * 1024 * 1024
MONTHS = {name: number for number, name in enumerate(
    ("januari", "februari", "maret", "april", "mei", "juni", "juli", "agustus",
     "september", "oktober", "november", "desember"), 1)}


def clean(value: str) -> str:
    return re.sub(r"\s+", " ", html.unescape(value)).strip()


class PublicHTML(HTMLParser):
    """Ambil teks, heading, gambar dan tautan; buang elemen nonkonten."""

    def __init__(self, markup: str):
        super().__init__(convert_charrefs=True)
        self.parts: list[str] = []
        self.headings: list[str] = []
        self.links: list[tuple[str, str]] = []
        self.images: list[str] = []
        self.ignored: list[str] = []
        self.heading: list[str] | None = None
        self.link: tuple[str, list[str]] | None = None
        self.feed(markup)
        self.lines = [clean(line) for line in "".join(self.parts).splitlines() if clean(line)]

    def handle_starttag(self, tag, attrs):
        attrs = dict(attrs)
        if tag in {"script", "style", "svg", "noscript", "nav", "footer", "header"}:
            self.ignored.append(tag)
        if self.ignored:
            return
        if tag in {"p", "li", "div", "section", "br", "h1", "h2", "h3", "h4", "h5", "h6"}:
            self.parts.append("\n")
        if re.fullmatch(r"h[1-6]", tag):
            self.heading = []
        if tag == "a":
            self.link = (attrs.get("href", ""), [])
        if tag == "img" and attrs.get("src"):
            self.images.append(attrs["src"])

    def handle_endtag(self, tag):
        if self.ignored:
            if tag == self.ignored[-1]:
                self.ignored.pop()
            return
        if re.fullmatch(r"h[1-6]", tag) and self.heading is not None:
            self.headings.append(clean(" ".join(self.heading)))
            self.heading = None
        if tag == "a" and self.link is not None:
            self.links.append((self.link[0], clean(" ".join(self.link[1]))))
            self.link = None
        if tag in {"p", "li", "div", "section", "h1", "h2", "h3", "h4", "h5", "h6"}:
            self.parts.append("\n")

    def handle_data(self, data):
        if self.ignored:
            return
        self.parts.append(data)
        if self.heading is not None:
            self.heading.append(data)
        if self.link is not None:
            self.link[1].append(data)


def safe_url(value: str, base: str) -> str | None:
    resolved = urljoin(base, value)
    return resolved if value and urlsplit(resolved).scheme in {"http", "https"} else None


def fetch_json(url: str):
    request = Request(url, headers={"User-Agent": "PKN-Ingestion/2.0", "Accept": "application/json"})
    try:
        with urlopen(request, timeout=TIMEOUT) as response:
            body = response.read(MAX_RESPONSE + 1)
            if len(body) > MAX_RESPONSE:
                raise ValueError(f"Respons melebihi batas: {url}")
            return json.loads(body), dict(response.headers)
    except (HTTPError, URLError, TimeoutError) as error:
        raise OSError(f"WordPress GET {url}: {error}") from error


def fetch_public_content(record: dict, wp_api: str) -> str:
    """Scrape actual article HTML when WordPress cannot render its REST detail."""
    url = safe_url(record.get("link", ""), wp_api)
    if not url or urlsplit(url).netloc != urlsplit(wp_api).netloc:
        raise ValueError("URL halaman publik harus berada pada host WordPress sumber")
    request = Request(url, headers={"User-Agent": "PKN-Ingestion/2.0", "Accept": "text/html"})
    try:
        with urlopen(request, timeout=TIMEOUT) as response:
            body = response.read(MAX_RESPONSE + 1)
            if len(body) > MAX_RESPONSE:
                raise ValueError(f"Respons melebihi batas: {url}")
            markup = body.decode(response.headers.get_content_charset() or "utf-8")
    except (HTTPError, URLError, TimeoutError) as error:
        raise OSError(f"Halaman publik GET {url}: {error}") from error

    class ArticleHTML(HTMLParser):
        def __init__(self):
            super().__init__(convert_charrefs=False)
            self.depth = 0
            self.parts = []

        def handle_starttag(self, tag, attrs):
            attrs = dict(attrs)
            if not self.depth:
                if not (attrs.get("data-elementor-id") == str(record["id"]) and
                        attrs.get("data-elementor-type") in {"wp-page", "wp-post"}):
                    return
                self.depth = 1
            elif tag not in {"area", "base", "br", "col", "embed", "hr", "img", "input", "link", "meta", "param", "source", "track", "wbr"}:
                self.depth += 1
            self.parts.append(self.get_starttag_text())

        def handle_startendtag(self, tag, attrs):
            if self.depth:
                self.parts.append(self.get_starttag_text())

        def handle_endtag(self, tag):
            if self.depth and tag not in {"area", "base", "br", "col", "embed", "hr", "img", "input", "link", "meta", "param", "source", "track", "wbr"}:
                self.parts.append(f"</{tag}>")
                self.depth -= 1

        def handle_data(self, data):
            if self.depth:
                self.parts.append(data)

        def handle_entityref(self, name):
            if self.depth:
                self.parts.append(f"&{name};")

        def handle_charref(self, name):
            if self.depth:
                self.parts.append(f"&#{name};")

    parser = ArticleHTML()
    parser.feed(markup)
    content = "".join(parser.parts)
    if not content or not PublicHTML(content).lines:
        raise ValueError(f"Konten Elementor ID {record['id']} tidak ditemukan: {url}")
    return content


def candidate_page(record: dict) -> bool:
    identity = clean(record.get("title", {}).get("rendered", "")) + " " + record.get("slug", "")
    if re.search(r"\b(formulir|form|template|testimoni|sukses|profil)\b", identity, re.I):
        return False
    # Public event series use abbreviations rather than the word Event.
    return bool(re.search(
        r"\b(buku|book|event|webinar|workshop|daurah|coaching|manajerial|manajarial)\b|"
        r"\b(akg|tc|pis|tdk)[ -]+\d|panduan[ -]+implementasi[ -]+pkn[ -]+batch", identity, re.I))


def wordpress_pages(wp_api: str) -> list[dict]:
    """Stage pagination metadata lalu ambil HTML satu halaman per permintaan.

    Daftar ringan tidak meminta content. Hanya kandidat katalog dan agenda
    publik yang dirender melalui endpoint per-ID; halaman profil, formulir,
    dan konten tak terkait tidak memicu rendering Elementor.
    """
    records = []
    seen = set()
    page = 1
    while True:
        query = urlencode({"per_page": 20, "page": page,
                           "_fields": "id,link,title,slug,modified"})
        batch, headers = fetch_json(f"{wp_api}/pages?{query}")
        if not isinstance(batch, list):
            raise ValueError("Respons WordPress /pages bukan array")
        for record in batch:
            if not isinstance(record, dict) or not isinstance(record.get("id"), int):
                raise ValueError("Record WordPress tidak memiliki ID numerik")
            if record["id"] in seen:
                raise ValueError("ID WordPress berulang; pagination tidak konsisten")
            seen.add(record["id"])
            records.append(record)
        total = next((int(value) for key, value in headers.items()
                      if key.lower() == "x-wp-totalpages"), None)
        if total is not None:
            if total < 0 or (total and page > total):
                raise ValueError("X-WP-TotalPages tidak valid")
            if page >= total:
                break
        elif len(batch) < 20:
            break
        page += 1
    detailed = []
    for record in records:
        if "content" in record:
            detailed.append(record)
            continue
        if not candidate_page(record):
            detailed.append(record)
            continue
        query = urlencode({"_fields": "id,link,title,content,slug,modified"})
        try:
            detail, _ = fetch_json(f"{wp_api}/pages/{record['id']}?{query}")
        except OSError as rest_error:
            # This is an alternate real source representation, not partial success:
            # either source must deliver actual content or the whole sync aborts.
            try:
                content = fetch_public_content(record, wp_api)
            except (OSError, ValueError) as public_error:
                raise OSError(f"{rest_error}; scraping juga gagal: {public_error}") from public_error
            detail = {**record, "content": {"rendered": content}, "ingestion_method": "public_html"}
        if not isinstance(detail, dict) or detail.get("id") != record["id"]:
            raise ValueError("Respons detail WordPress memiliki ID tidak sesuai")
        detailed.append(detail)
    return detailed


def section(lines: list[str], *labels: str) -> str | None:
    boundaries = {"tanggal", "hari tanggal", "hari/tanggal", "waktu", "tempat", "lokasi",
                  "pemateri", "narasumber", "fasilitas", "kontribusi", "harga", "rekening",
                  "sinopsis", "spesifikasi"}
    for index, line in enumerate(lines):
        label = line.casefold().strip(" :")
        if label in labels:
            values = []
            for following in lines[index + 1:]:
                if following.casefold().strip(" :") in boundaries:
                    break
                values.append(following)
            return " ".join(values) or None
        for name in labels:
            match = re.match(re.escape(name) + r"\s*:\s*(.+)", line, re.I)
            if match:
                return match[1]
    return None


def date_iso(text: str | None) -> str | None:
    if not text:
        return None
    match = re.search(r"\b(\d{1,2})\s+(" + "|".join(MONTHS) + r")\s+(\d{4})\b", text, re.I)
    if match:
        from datetime import date
        return date(int(match[3]), MONTHS[match[2].casefold()], int(match[1])).isoformat()
    match = re.search(r"\b\d{4}-\d{2}-\d{2}\b", text)
    if match:
        from datetime import date
        return date.fromisoformat(match[0]).isoformat()
    return None


def normalize_page(record: dict, wp_api: str) -> dict | None:
    title = " ".join(PublicHTML(record.get("title", {}).get("rendered", "")).lines)
    markup = record.get("content", {}).get("rendered", "")
    parsed = PublicHTML(markup)
    identity = title + " " + record.get("slug", "")
    if re.search(r"\b(formulir|form|template|testimoni|sukses)\b", identity, re.I):
        return None
    # A book promoted inside an event body is not a catalogue entry.
    book = bool(re.search(r"\b(buku|book)\b", identity, re.I) or
                any(heading.casefold() in {"buku", "book"} for heading in parsed.headings[:3]))
    event = bool((candidate_page(record) and not book) or
                 any(heading.casefold() == "event" for heading in parsed.headings))
    if not book and not event:
        return None
    if not title or not parsed.lines:
        raise ValueError(f"Konten/judul kosong pada WordPress ID {record['id']}")
    source_url = safe_url(record.get("link", ""), wp_api)
    if not source_url:
        raise ValueError(f"URL sumber tidak valid pada WordPress ID {record['id']}")
    links = [(safe_url(url, source_url), label) for url, label in parsed.links]
    fields = {"source_url": source_url, "image_url": next(
        (safe_url(image, source_url) for image in parsed.images
         if not re.search(r"logo|icon", image, re.I)), None)}
    if book:
        fields.update({"author": next((line for line in parsed.lines if re.match(
            r"^(karya|penulis|oleh)\b", line, re.I)), None),
            "price": next((line for line in parsed.lines if re.search(r"\bRp\s*[\d.]", line)), None),
            "purchase_url": next((url for url, label in links if url and re.search(
                r"pesan|beli|order", label, re.I)), None),
            "specifications": section(parsed.lines, "spesifikasi")})
    else:
        raw_date = section(parsed.lines, "hari tanggal", "hari/tanggal", "tanggal")
        if not raw_date:
            raw_date = next((line for line in parsed.lines if re.search(
                r"\b\d{1,2}\s+(?:" + "|".join(MONTHS) + r")\s+\d{4}\b", line, re.I)), None)
        fields.update({"date_text": raw_date, "date": date_iso(raw_date),
                       "time": section(parsed.lines, "waktu"),
                       "location": section(parsed.lines, "tempat", "lokasi"),
                       "speakers": section(parsed.lines, "pemateri", "narasumber"),
                       "registration_url": next((url for url, label in links if url and (
                           re.search(r"daftar|registrasi|register", label, re.I) or
                           urlsplit(url).hostname in {"forms.gle", "docs.google.com"})), None)})
    origin = hashlib.sha256(wp_api.encode()).hexdigest()[:12]
    metadata = {"source_origin": "wordpress", "wp_api": wp_api, "wp_id": record["id"],
                "wp_resource": "pages", "source_url": source_url,
                "modified": record.get("modified"), "date_text": fields.get("date_text"),
                "ingestion_method": record.get("ingestion_method", "wp_rest")}
    return {"key": f"wordpress:{origin}:pages:{record['id']}", "title": title,
            "category": "Buku" if book else "Event", "content_type": "book" if book else "event",
            "body": "# " + title + "\n\n" + "\n\n".join(parsed.lines),
            "source": source_url, "source_url": source_url, "source_origin": "wordpress",
            "source_type": "expert_verified", "provenance": "expert_verified",
            "fields": fields, "metadata": metadata}


def atomic_json(output: Path, payload) -> None:
    output.parent.mkdir(parents=True, exist_ok=True)
    name = None
    try:
        with tempfile.NamedTemporaryFile(mode="w", encoding="utf-8", dir=output.parent,
                                         prefix=output.name + ".", suffix=".tmp", delete=False) as stream:
            name = stream.name
            json.dump(payload, stream, ensure_ascii=False, indent=2)
            stream.write("\n")
            stream.flush()
            os.fsync(stream.fileno())
        os.replace(name, output)
    finally:
        if name and os.path.exists(name):
            os.unlink(name)


def sync_wordpress(wp_api: str, output: str | Path) -> dict:
    """Upsert atomik; kegagalan unduh/normalisasi tidak mengubah data lama.

    Tidak menghapus record yang hilang dari sumber: kurasi manual tetap disimpan.
    Provenance expert_verified mengikuti konvensi compiler untuk sumber non-AI,
    bukan klaim audit editorial tambahan atas halaman WordPress.
    """
    wp_api = wp_api.rstrip("/")
    if urlsplit(wp_api).scheme not in {"http", "https"} or not urlsplit(wp_api).netloc:
        raise ValueError("--wp-api harus URL HTTP(S)")
    pages = wordpress_pages(wp_api)
    incoming = [normalized for page in pages if (normalized := normalize_page(page, wp_api))]
    output = Path(output)
    payload = json.loads(output.read_text(encoding="utf-8")) if output.exists() else {"records": []}
    existing = payload.get("records") if isinstance(payload, dict) else payload
    if not isinstance(existing, list) or any(not isinstance(item, dict) or not item.get("key") for item in existing):
        raise ValueError("JSON kurasi harus array records dengan key")
    indexed = {item["key"]: index for index, item in enumerate(existing)}
    if len(indexed) != len(existing):
        raise ValueError("Key kurasi berulang")
    stats = {"fetched": len(pages), "events": sum(item["content_type"] == "event" for item in incoming),
             "books": sum(item["content_type"] == "book" for item in incoming),
             "created": 0, "updated": 0, "unchanged": 0}
    merged = list(existing)
    for item in incoming:
        index = indexed.get(item["key"])
        if index is None:
            merged.append(item)
            stats["created"] += 1
        else:
            old = existing[index]
            item = {**old, **item, "fields": {**old.get("fields", {}), **item["fields"]},
                    "metadata": {**old.get("metadata", {}), **item["metadata"]}}
            if item == old:
                stats["unchanged"] += 1
            else:
                merged[index] = item
                stats["updated"] += 1
    stats["total"] = len(merged)
    if stats["created"] or stats["updated"] or not output.exists():
        atomic_json(output, {**payload, "records": merged} if isinstance(payload, dict) else {"records": merged})
    return stats


def publish_alexandrie(api: str, username: str, password: str, records: list[dict]) -> dict:
    """Publish only WordPress documents through the established /api/nodes contract."""
    jar = http.cookiejar.CookieJar()
    client = build_opener(HTTPCookieProcessor(jar))
    api = api.rstrip("/")

    def request(method, path, payload=None, form=False):
        headers = {"Accept": "application/json"}
        if jar:
            headers["Cookie"] = "; ".join(f"{cookie.name}={cookie.value}" for cookie in jar)
        body = None
        if payload is not None:
            body = (urlencode(payload) if form else json.dumps(payload)).encode()
            headers["Content-Type"] = "application/x-www-form-urlencoded" if form else "application/json"
        with client.open(Request(api + path, body, headers, method=method), timeout=TIMEOUT) as response:
            result = json.load(response)
        return result.get("result", result) if isinstance(result, dict) else result

    user = request("POST", "/auth", {"username": username, "password": password}, True)
    user_id = str(user["id"])
    nodes = request("GET", "/nodes/user/" + user_id) or []
    by_key = {node.get("metadata", {}).get("pkn_ingestion_key"): node for node in nodes
              if isinstance(node.get("metadata"), dict)}
    stats = {"created": 0, "updated": 0, "unchanged": 0}
    for record in records:
        if record.get("source_origin") != "wordpress":
            continue
        old = by_key.get(record["key"])
        digest = hashlib.sha256(json.dumps(record, sort_keys=True, ensure_ascii=False).encode()).hexdigest()
        if old and old["metadata"].get("ingestion_sha256") == digest:
            stats["unchanged"] += 1
            continue
        # PUT is replacement, so retrieve and retain all existing node properties.
        node = request("GET", "/nodes/" + str(old["id"]))["node"] if old else {}
        if old and (str(node.get("user_id")) != user_id or node.get("role") != 3):
            raise ValueError("Dokumen Alexandrie bukan milik akun ingestion")
        metadata = {**node.get("metadata", {}), **record.get("metadata", {}),
                    "pkn_ingestion_key": record["key"], "ingestion_sha256": digest,
                    "category": record["category"], "fields": record["fields"],
                    "provenance": record["provenance"], "source_origin": "wordpress"}
        compiled = "<pre>" + html.escape(record["body"]) + "</pre>"
        document = {**node, "name": record["title"], "role": 3, "content": record["body"],
                    "content_compiled": compiled, "metadata": metadata,
                    "tags": "pkn,wordpress," + record["category"]}
        if not old:
            document.update({"accessibility": 1, "access": 0,
                             "description": "Konten publik WordPress PKN; sumber tercantum dalam metadata."})
        request("PUT" if old else "POST", "/nodes/" + str(old["id"]) if old else "/nodes", document)
        stats["updated" if old else "created"] += 1
    return stats


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--wp-api", default=DEFAULT_WP_API)
    parser.add_argument("--output", type=Path, default=Path(__file__).parent / "data/alexandrie_curated.json")
    parser.add_argument("--alexandrie-api", help="Base API, misalnya http://localhost:8201/api")
    parser.add_argument("--alexandrie-username", default=os.environ.get("ALEXANDRIE_USERNAME"))
    args = parser.parse_args()
    if args.alexandrie_api and (not args.alexandrie_username or not os.environ.get("ALEXANDRIE_PASSWORD")):
        parser.error("Publishing memerlukan --alexandrie-username dan env ALEXANDRIE_PASSWORD")
    try:
        stats = sync_wordpress(args.wp_api, args.output)
        if args.alexandrie_api:
            stats["alexandrie"] = publish_alexandrie(args.alexandrie_api, args.alexandrie_username,
                os.environ["ALEXANDRIE_PASSWORD"], json.loads(args.output.read_text(encoding="utf-8"))["records"])
    except (OSError, ValueError, KeyError, TypeError) as error:
        parser.exit(1, f"Ingestion gagal: {error}\n")
    print(json.dumps(stats, ensure_ascii=False))


if __name__ == "__main__":
    main()
