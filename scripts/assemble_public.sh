#!/usr/bin/env bash
# Build Flutter web (prod API) into digivote-web/public without deploying.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
UI="$(cd "$ROOT/../digivote-ui" && pwd)"
PUBLIC="$ROOT/public"
STAGING="$ROOT/.deploy_staging"

echo "==> Flutter web build (prod → digivoteindia portal)"
cd "$UI"
flutter build web --release --base-href / --no-wasm-dry-run \
  --dart-define=DIGIVOTE_FLAVOR=prod \
  --dart-define=API_BASE_URL=https://digivote-api-t4hf2gpiya-el.a.run.app

echo "==> Assemble public/"
rm -rf "$STAGING"
mkdir -p "$STAGING"
for path in get invite.html badges videos digivote-icon.png icon-64.png; do
  if [[ -e "$PUBLIC/$path" ]]; then
    cp -R "$PUBLIC/$path" "$STAGING/$path"
  fi
done
cp -R "$UI/build/web/." "$STAGING/"
for path in get invite.html badges videos digivote-icon.png icon-64.png; do
  if [[ -e "$PUBLIC/$path" ]]; then
    rm -rf "$STAGING/$path"
    cp -R "$PUBLIC/$path" "$STAGING/$path"
  fi
done
rm -rf "$PUBLIC"
mv "$STAGING" "$PUBLIC"
echo "Assembled $PUBLIC"
echo "  Portal stub replaced by Flutter build at /"
echo "  Marketing at /get/"
echo "Deploy: PATH=digivote-web/.tools/node/bin:\$PATH firebase deploy --only hosting --project digivote-prod"
