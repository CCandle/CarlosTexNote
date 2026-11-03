#!/usr/bin/env bash
# Install CarlosTexNote.cls into TEXMFHOME so any project can use it.
set -euo pipefail

here="$(cd "$(dirname "$0")/.." && pwd)"
texmf="${TEXMFHOME:-$(kpsewhich -var-value=TEXMFHOME 2>/dev/null || true)}"
if [ -z "${texmf}" ]; then
  texmf="$HOME/Library/texmf"
fi
target="$texmf/tex/latex/carlostexnote"
mkdir -p "$target"
cp "$here/CarlosTexNote.cls" "$target/CarlosTexNote.cls"
echo "installed: $target/CarlosTexNote.cls"
