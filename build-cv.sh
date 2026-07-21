#!/usr/bin/env bash
# Regenerate cv.html (styled web CV) and cv.pdf from cv.md — single source of truth.
set -euo pipefail
cd "$(dirname "$0")"

pandoc cv.md \
  --template cv-template.html \
  --from markdown \
  --to html5 \
  --output cv.html

# PDF is rendered from the exact same HTML+CSS, so web and PDF never drift.
python3 -m weasyprint cv.html cv.pdf

echo "✓ Built cv.html and cv.pdf from cv.md"
