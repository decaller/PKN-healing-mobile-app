#!/usr/bin/env python3
import http.server
import mimetypes
import os
import socketserver
import sys
import threading

PORTS_CONFIG = [
    {
        "port": 3011,
        "name": "Stitch Variant A - Nordic Mist Sanctuary",
        "file": os.path.abspath(os.path.join(os.path.dirname(__file__), "stitch_flutter_derived_variants/variant_a_nordic_mist.html"))
    },
    {
        "port": 3012,
        "name": "Stitch Variant B - Earthy Forest Monastic",
        "file": os.path.abspath(os.path.join(os.path.dirname(__file__), "stitch_flutter_derived_variants/variant_b_earthy_forest.html"))
    },
    {
        "port": 3013,
        "name": "Stitch Variant C - Zen Minimalist Paper",
        "file": os.path.abspath(os.path.join(os.path.dirname(__file__), "stitch_flutter_derived_variants/variant_c_zen_minimalist_paper.html"))
    },
    {
        "port": 3014,
        "name": "Tree Clock Minimal 1 - Sanctuary Canopy",
        "file": os.path.abspath(os.path.join(os.path.dirname(__file__), "stitch_home_tree_clock_minimal/1_sanctuary_canopy.html"))
    },
    {
        "port": 3015,
        "name": "Tree Clock Minimal 2 - Nordic Mist",
        "file": os.path.abspath(os.path.join(os.path.dirname(__file__), "stitch_home_tree_clock_minimal/2_nordic_mist.html"))
    },
    {
        "port": 3016,
        "name": "Tree Clock Minimal 3 - Zen Monastic",
        "file": os.path.abspath(os.path.join(os.path.dirname(__file__), "stitch_home_tree_clock_minimal/3_zen_monastic.html"))
    },
    {
        "port": 3017,
        "name": "Legacy Prototype V1/V2",
        "file": os.path.abspath(os.path.join(os.path.dirname(__file__), "prototype.html"))
    },
    {
        "port": 3018,
        "name": "Preview V2 - P3K & Curhat AI Bersandingan (Interactive Demo + Voice PTT)",
        "file": os.path.abspath(os.path.join(os.path.dirname(__file__), "../prototype/preview-v2/index.html"))
    },
    {
        "port": 3020,
        "name": "Design Showcase Hub (All Versions Directory)",
        "file": os.path.abspath(os.path.join(os.path.dirname(__file__), "hub_index.html"))
    }
]

def make_handler(target_file):
    class SingleFileHandler(http.server.BaseHTTPRequestHandler):
        def end_headers(self):
            self.send_header("Access-Control-Allow-Origin", "*")
            self.send_header("Access-Control-Allow-Methods", "GET, POST, OPTIONS, HEAD")
            self.send_header("Cache-Control", "no-cache, no-store, must-revalidate")
            super().end_headers()

        def do_OPTIONS(self):
            self.send_response(200, "ok")
            self.end_headers()

        def do_HEAD(self):
            self.send_response(200)
            self.send_header("Content-Type", "text/html; charset=utf-8")
            self.end_headers()

        def do_GET(self):
            req_path = self.path.split("?")[0].lstrip("/")
            file_dir = os.path.dirname(target_file)
            candidate = os.path.join(file_dir, req_path)

            # If user asks for / or /index.html or non-existing path, serve main target_file
            if not req_path or req_path == "index.html" or not os.path.exists(candidate):
                serve_path = target_file
            else:
                serve_path = candidate

            try:
                with open(serve_path, "rb") as f:
                    content = f.read()

                content_type, _ = mimetypes.guess_type(serve_path)
                if not content_type:
                    content_type = "text/html; charset=utf-8"
                elif content_type.startswith("text/"):
                    content_type += "; charset=utf-8"

                self.send_response(200)
                self.send_header("Content-Type", content_type)
                self.send_header("Content-Length", str(len(content)))
                self.end_headers()
                self.wfile.write(content)
            except Exception as e:
                self.send_response(500)
                self.end_headers()
                self.wfile.write(f"500 Internal Error: {e}".encode("utf-8"))

        def log_message(self, format, *args):
            # Keep logs clean and silent
            pass

    return SingleFileHandler

def run_port_server(cfg):
    port = cfg["port"]
    name = cfg["name"]
    target_file = cfg["file"]

    handler_class = make_handler(target_file)
    socketserver.TCPServer.allow_reuse_address = True
    try:
        with socketserver.TCPServer(("0.0.0.0", port), handler_class) as httpd:
            print(f"[PORT {port}] Serving {name} -> {target_file}")
            sys.stdout.flush()
            httpd.serve_forever()
    except Exception as e:
        print(f"[PORT {port}] Error starting server: {e}", file=sys.stderr)

def main():
    print("=" * 65)
    print("  PKN HEALING - MULTI-PORT DESIGN VERSIONS DAEMON")
    print("=" * 65)
    print("Available Tailscale IPv4: 100.118.34.69")
    print("Listening on 0.0.0.0 across all configured ports:")
    print("  • Port 3010: (Running) Live Flutter Web App")
    for cfg in PORTS_CONFIG:
        print(f"  • Port {cfg['port']}: {cfg['name']}")
    print("=" * 65)
    sys.stdout.flush()

    threads = []
    for cfg in PORTS_CONFIG:
        t = threading.Thread(target=run_port_server, args=(cfg,), daemon=True)
        t.start()
        threads.append(t)

    try:
        for t in threads:
            t.join()
    except KeyboardInterrupt:
        print("\nShutting down multi-port server...")

if __name__ == "__main__":
    main()
