#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd -- "$SCRIPT_DIR"

if ! command -v flutter >/dev/null 2>&1; then
  if [[ -x /home/abuhafi/flutter/bin/flutter ]]; then
    export PATH="/home/abuhafi/flutter/bin:$PATH"
  else
    printf 'Flutter tidak ditemukan. Tambahkan Flutter ke PATH.\n' >&2
    exit 1
  fi
fi

PORT="${PORT:-3010}"
HOST="${HOST:-0.0.0.0}"
OLLAMA_URL="${OLLAMA_URL:-http://localhost:11434}"
API_BASE_URL="${API_BASE_URL:-http://localhost:8081}"

REBUILD=0
DEV_MODE=0

for arg in "$@"; do
  if [[ "$arg" == "--rebuild" ]]; then
    REBUILD=1
  elif [[ "$arg" == "--dev" ]]; then
    DEV_MODE=1
  fi
done

printf '==================================================\n'
printf 'PKN Healing Mobile App (Compiled Modular Prototype)\n'
printf 'Host / Port: http://%s:%s\n' "$HOST" "$PORT"
printf 'Edge LLM   : %s\n' "$OLLAMA_URL"
printf 'API Base   : %s\n' "$API_BASE_URL"
printf '==================================================\n'

if [[ "$DEV_MODE" -eq 1 ]]; then
  printf 'Starting in DEV mode with flutter run...\n'
  exec flutter run -d web-server --web-hostname "$HOST" --web-port "$PORT" \
    --dart-define="OLLAMA_URL=$OLLAMA_URL" \
    --dart-define="API_BASE_URL=$API_BASE_URL" "$@"
fi

if [[ "$REBUILD" -eq 1 || ! -f "build/web/main.dart.js" ]]; then
  printf 'Compiling Flutter Web (Release bundle)...\n'
  flutter build web --release \
    --dart-define="OLLAMA_URL=$OLLAMA_URL" \
    --dart-define="API_BASE_URL=$API_BASE_URL"
fi

printf 'Starting production web server...\n'
export PORT HOST
exec python3 serve_web.py
