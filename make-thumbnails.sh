#!/usr/bin/env bash
# Convert the first page of each PDF in papers/ into a PNG thumbnail for the site.
#
# Usage:
#   ./make-thumbnails.sh            # process every PDF in ./papers/
#   ./make-thumbnails.sh paper.pdf  # process one file
#
# Output: images/paper-first-pages/<filename>.png
#
# Requires: ImageMagick (`magick` or `convert`) + Ghostscript (`gs`).
#   macOS:  brew install imagemagick ghostscript
#
# The thumbnail keeps the same aspect ratio as a paper page (≈0.76) so it
# fills the .paper-preview box without distortion.

set -euo pipefail

OUT="images/paper-first-pages"
mkdir -p "$OUT"

# Pick the right ImageMagick binary (v7 = `magick`, v6 = `convert`).
if command -v magick >/dev/null 2>&1; then
  CMD="magick"
elif command -v convert >/dev/null 2>&1; then
  CMD="convert"
else
  echo "Error: ImageMagick not found. Install with: brew install imagemagick ghostscript" >&2
  exit 1
fi

if ! command -v gs >/dev/null 2>&1; then
  echo "Error: Ghostscript not found. Install with: brew install ghostscript" >&2
  exit 1
fi

PDFS=("$@")
if [ ${#PDFS[@]} -eq 0 ]; then
  mapfile -t PDFS < <(find papers -maxdepth 1 -type f -name '*.pdf' 2>/dev/null || true)
fi

if [ ${#PDFS[@]} -eq 0 ]; then
  echo "No PDFs found. Put your papers in a ./papers/ folder, or pass paths as arguments." >&2
  exit 0
fi

for pdf in "${PDFS[@]}"; do
  base="$(basename "$pdf" .pdf)"
  # -density 150 gives crisp text; -resize caps the width; [0] = first page only.
  "$CMD" -density 150 "${pdf}[0]" -resize 600x -quality 92 "$OUT/${base}.png"
  echo "✓ $OUT/${base}.png"
done

echo ""
echo "Done. Reference them in index.html as:"
echo "  <img src=\"images/paper-first-pages/<name>.png\" ...>"
