#!/usr/bin/env bash
set -euo pipefail

PORT="${PORT:-3003}"
HOST="${HOST:-0.0.0.0}"
if ! command -v flutter >/dev/null 2>&1; then
  export PATH="/home/abuhafi/flutter/bin:$PATH"
fi
cd "$(dirname "${BASH_SOURCE[0]}")"
printf 'PKN v3: http://localhost:%s/\n' "$PORT"
exec flutter run -d web-server --web-hostname="$HOST" --web-port="$PORT" "$@"
