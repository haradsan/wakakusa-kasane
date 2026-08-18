#!/bin/sh
# index.html（骨格なし・Artifact互換）から GitHub Pages 配信用 docs/index.html を生成する
set -e
cd "$(dirname "$0")"
SPLIT=$(grep -n '^</style>$' index.html | head -1 | cut -d: -f1)
{
  echo '<!doctype html>'
  echo '<html lang="ja">'
  echo '<head>'
  echo '<meta charset="utf-8">'
  sed -n "1,${SPLIT}p" index.html
  echo '</head>'
  echo '<body>'
  sed -n "$((SPLIT+1)),\$p" index.html
  echo '</body>'
  echo '</html>'
} > docs/index.html
echo "docs/index.html generated ($(wc -l < docs/index.html) lines)"
