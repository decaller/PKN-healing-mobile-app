#!/usr/bin/env bash
set -euo pipefail

if ! command -v flutter >/dev/null 2>&1; then
  if [[ -x /home/abuhafi/flutter/bin/flutter ]]; then
    export PATH="/home/abuhafi/flutter/bin:$PATH"
  else
    printf 'Flutter tidak ditemukan. Tambahkan Flutter ke PATH.\n' >&2
    exit 1
  fi
fi

cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
PORT="${PORT:-3011}"
HOST="${HOST:-0.0.0.0}"
API_BASE_URL="${API_BASE_URL:-http://localhost:8081}"
printf 'Event v1: http://localhost:%s\nBackend: %s\n' "$PORT" "$API_BASE_URL"
exec flutter run -d web-server --web-hostname "$HOST" --web-port "$PORT" --dart-define="API_BASE_URL=$API_BASE_URL" "$@"
