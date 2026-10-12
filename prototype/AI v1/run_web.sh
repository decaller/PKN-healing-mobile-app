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
PORT="${PORT:-3012}"
HOST="${HOST:-0.0.0.0}"
OLLAMA_URL="${OLLAMA_URL:-http://localhost:11434}"
printf 'AI v1 Web: http://localhost:%s\nEdge LLM (Ollama): %s\n' "$PORT" "$OLLAMA_URL"
exec flutter run -d web-server --web-hostname "$HOST" --web-port "$PORT" --dart-define="OLLAMA_URL=$OLLAMA_URL" "$@"
