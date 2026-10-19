#!/usr/bin/env bash
# Assemble Flutter web into public/ and deploy Firebase Hosting (digivoteindia).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
"$ROOT/scripts/assemble_public.sh"
echo "==> firebase deploy hosting"
cd "$ROOT"
export PATH="$ROOT/.tools/node/bin:${PATH:-}"
firebase deploy --only hosting --project digivote-prod
echo "Done."
echo "  Portal:    https://digivoteindia.firebaseapp.com/"
echo "  Marketing: https://digivoteindia.firebaseapp.com/get/"
echo "  Invites:   https://digivoteindia.firebaseapp.com/i/<code>"
