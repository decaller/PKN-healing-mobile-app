#!/usr/bin/env python3
import http.server
import mimetypes
import os
import socketserver
import sys

# Ensure critical WebAssembly and modern web MIME types
mimetypes.add_type("application/wasm", ".wasm")
mimetypes.add_type("application/javascript", ".js")
mimetypes.add_type("application/json", ".json")

PORT = int(os.environ.get("PORT", "3010"))
HOST = os.environ.get("HOST", "0.0.0.0")
WEB_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), "build/web"))

class FlutterHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=WEB_DIR, **kwargs)

    def end_headers(self):
        self.send_header("Access-Control-Allow-Origin", "*")
        self.send_header("Access-Control-Allow-Methods", "GET, POST, OPTIONS, HEAD")
        self.send_header("Access-Control-Allow-Headers", "X-Requested-With, Content-Type, Authorization")
        self.send_header("Cross-Origin-Embedder-Policy", "credentialless")
        self.send_header("Cross-Origin-Opener-Policy", "same-origin")
        self.send_header("Cache-Control", "no-cache, no-store, must-revalidate")
        super().end_headers()

    def do_OPTIONS(self):
        self.send_response(200, "ok")
        self.end_headers()

    def do_GET(self):
        # Support Single Page App (SPA) routing: fallback to index.html if file doesn't exist
        req_path = self.path.split("?")[0]
        local_path = os.path.join(WEB_DIR, req_path.lstrip("/"))
        if not os.path.exists(local_path) and "." not in os.path.basename(req_path):
            self.path = "/index.html"
        return super().do_GET()

if __name__ == "__main__":
    if not os.path.isdir(WEB_DIR):
        print(f"Error: {WEB_DIR} does not exist. Run 'flutter build web --release' first.", file=sys.stderr)
        sys.exit(1)

    socketserver.TCPServer.allow_reuse_address = True
    with socketserver.TCPServer((HOST, PORT), FlutterHandler) as httpd:
        print(f"Flutter Web serving: {WEB_DIR}")
        print(f"Listening on: http://{HOST}:{PORT}")
        sys.stdout.flush()
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\nShutting down server...")
            httpd.server_close()
