#!/usr/bin/env python3
import http.server
import socketserver
import os
import sys

PORT = int(sys.argv[1]) if len(sys.argv) > 1 else 3019
DIRECTORY = os.path.dirname(os.path.abspath(__file__))

class Handler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=DIRECTORY, **kwargs)

    def end_headers(self):
        self.send_header('Cache-Control', 'no-store, no-cache, must-revalidate')
        self.send_header('Access-Control-Allow-Origin', '*')
        super().end_headers()

def run():
    socketserver.TCPServer.allow_reuse_address = True
    try:
        with socketserver.TCPServer(("", PORT), Handler) as httpd:
            print(f"=====================================================")
            print(f" PKN Mobile v3 - Tips Praktis & P3K Krisis Server    ")
            print(f"=====================================================")
            print(f" Local URL:   http://localhost:{PORT}")
            print(f" Network URL: http://0.0.0.0:{PORT}")
            print(f" Directory:   {DIRECTORY}")
            print(f"=====================================================")
            print(f" Tekan Ctrl+C untuk menghentikan server.")
            httpd.serve_forever()
    except OSError as e:
        if e.errno == 98: # Address already in use
            alt_port = PORT + 1
            print(f"Port {PORT} sedang dipakai, mencoba port {alt_port}...")
            with socketserver.TCPServer(("", alt_port), Handler) as httpd:
                print(f" Server berjalan di: http://localhost:{alt_port}")
                httpd.serve_forever()
        else:
            raise

if __name__ == '__main__':
    run()
