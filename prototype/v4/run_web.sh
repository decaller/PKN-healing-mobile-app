#!/usr/bin/env bash
set -euo pipefail

# Port 3001 follows the existing Tailscale Serve proxy used by v1.
PORT="${PORT:-3001}"
HOST="${HOST:-0.0.0.0}"

if ! command -v flutter &> /dev/null; then
  export PATH="/home/abuhafi/flutter/bin:$PATH"
fi

if ! command -v flutter &> /dev/null; then
  echo "Flutter tidak ditemukan. Tambahkan Flutter SDK ke PATH." >&2
  exit 1
fi

echo "Memulai PKN Earth-Tree Web Prototype v4 di $HOST:$PORT..."
echo "Akses lokal: http://localhost:$PORT/"
echo "Tailscale HTTPS (proxy v1 port 3001): https://cachyos-5600gt.tail0faa6b.ts.net/"
if command -v tailscale &> /dev/null; then
  TAILSCALE_IP="$(tailscale ip -4 2>/dev/null || true)"
  if [[ -n "$TAILSCALE_IP" ]]; then
    echo "Akses Tailscale Direct IP: http://$TAILSCALE_IP:$PORT/"
  fi
fi
echo ""

cd "$(dirname "${BASH_SOURCE[0]}")"
exec flutter run -d web-server --web-hostname="$HOST" --web-port="$PORT" "$@"
