#!/usr/bin/env bash
# Compile the same showcase once for each built-in palette.
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
template="$root/demo/theme-showcase.tex"
outroot="$root/build/theme-showcase"

for theme in classic ocean forest sunset violet; do
  outdir="$outroot/$theme"
  mkdir -p "$outdir"
  sed "s/theme=ocean/theme=$theme/" "$template" > "$outdir/main.tex"
  echo "==> Building theme: $theme"
  (cd "$root" && latexmk -xelatex -synctex=1 -interaction=nonstopmode \
    -halt-on-error -file-line-error -outdir="$outdir" "$outdir/main.tex")
done

echo "Theme PDFs: $outroot/<theme>/main.pdf"
