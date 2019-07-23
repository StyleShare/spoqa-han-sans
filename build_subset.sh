#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pip install fonttools brotli
rm -rf ./subset
mkdir -p $DIR/subset
for ext in ttf woff woff2; do
  for p in $DIR/original/*.ttf; do
    filename=$(basename "$p")
    title="${filename%.*}"
    printf "Making \e[1m\e[34m$title.$ext\e[0m..."
    if [ $ext != ttf ]; then
        flavor=$ext
    fi
    pyftsubset "$p" \
      --flavor=$flavor \
      --output-file="./subset/$title.$ext" \
      --text-file="glyphs.txt" \
      --layout-features='*' \
      --glyph-names \
      --symbol-cmap \
      --legacy-cmap \
      --notdef-glyph \
      --notdef-outline \
      --recommended-glyphs \
      --name-IDs='*' \
      --name-legacy \
      --name-languages='*' \
      --drop-tables= 
  done
done
cp ./css/SpoqaHanSans.css ./subset