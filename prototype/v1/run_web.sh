#!/usr/bin/env bash
set -e

# Default to port 3001 to align directly with active Tailscale Serve proxy
PORT="${PORT:-3001}"
HOST="${HOST:-0.0.0.0}"

if ! command -v flutter &> /dev/null; then
  export PATH="/home/abuhafi/flutter/bin:$PATH"
fi

echo "🚀 Memulai PKN Microlearning Web Prototype di $HOST:$PORT..."
echo "🔒 Tailscale HTTPS (MagicDNS): https://cachyos-5600gt.tail0faa6b.ts.net/"
echo "🌐 Akses Lokal:                http://localhost:$PORT/"
echo "📶 Akses Tailscale Direct IP:  http://100.118.34.69:$PORT/"
echo ""

cd "$(dirname "$0")"
exec flutter run -d web-server --web-hostname="$HOST" --web-port="$PORT"
