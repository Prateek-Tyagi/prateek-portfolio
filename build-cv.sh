#!/usr/bin/env bash
# Regenerate a styled web CV + PDF from markdown.
#
# Usage:
#   ./build-cv.sh                         # public site CV → ./cv.html + ./cv.pdf
#                                         # (+ Prateek-Rajvats-CV.pdf copy)
#   ./build-cv.sh applications/acme-sre   # → …/cv.html + …/Prateek-Rajvats-CV.pdf
#
# The public site always builds from root cv.md (deploy.yml). Job-specific
# variants live under applications/ (gitignored) — see ./new-cv-application.sh.
set -euo pipefail
cd "$(dirname "$0")"

PDF_DOWNLOAD_NAME="Prateek-Rajvats-CV.pdf"

if [[ $# -eq 0 ]]; then
  SRC_MD="cv.md"
  OUT_DIR="."
  # Site URL stays /cv.pdf (deploy + analytics). Download attribute renames it.
  PDF_HREF="cv.pdf"
else
  OUT_DIR="${1%/}"
  SRC_MD="${OUT_DIR}/cv.md"
  if [[ ! -f "$SRC_MD" ]]; then
    echo "error: missing ${SRC_MD}" >&2
    echo "hint:  ./new-cv-application.sh <slug>   # scaffolds applications/<slug>/cv.md" >&2
    exit 1
  fi
  mkdir -p "$OUT_DIR"
  # Tailored apps: real filename matches what candidates attach / send.
  PDF_HREF="${PDF_DOWNLOAD_NAME}"
fi

pandoc "$SRC_MD" \
  --template cv-template.html \
  --from markdown \
  --to html5 \
  --output "${OUT_DIR}/cv.html"

# Point the Download PDF button at the file we actually write in this OUT_DIR.
if [[ "$PDF_HREF" != "cv.pdf" ]]; then
  # Portable in-place edit (macOS sed needs '' ; GNU sed accepts it too with -i.bak pattern avoided)
  python3 - "${OUT_DIR}/cv.html" "$PDF_HREF" <<'PY'
import pathlib, sys
html_path, href = pathlib.Path(sys.argv[1]), sys.argv[2]
text = html_path.read_text(encoding="utf-8")
text = text.replace('href="cv.pdf"', f'href="{href}"', 1)
html_path.write_text(text, encoding="utf-8")
PY
fi

PDF_OUT="${OUT_DIR}/${PDF_HREF}"

render_pdf() {
  local html="$1" pdf="$2"
  if python3 -c 'import weasyprint' 2>/dev/null; then
    python3 -m weasyprint "$html" "$pdf"
    return
  fi

  # Fallback: Chrome headless (no browser name/date headers).
  local chrome=""
  if [[ -x "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" ]]; then
    chrome="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
  elif command -v google-chrome >/dev/null 2>&1; then
    chrome="$(command -v google-chrome)"
  elif command -v chromium >/dev/null 2>&1; then
    chrome="$(command -v chromium)"
  else
    echo "error: neither weasyprint nor Chrome/Chromium available to render PDF" >&2
    exit 1
  fi

  local port=8765
  python3 -m http.server "$port" --directory "$OUT_DIR" >/tmp/cv-http.log 2>&1 &
  local pid=$!
  cleanup() { kill "$pid" 2>/dev/null || true; }
  trap cleanup EXIT
  sleep 0.4
  "$chrome" \
    --headless=new --disable-gpu --no-pdf-header-footer \
    --print-to-pdf="$PWD/${pdf}" \
    "http://127.0.0.1:${port}/cv.html" >/tmp/cv-chrome.log 2>&1
  cleanup
  trap - EXIT
}

render_pdf "${OUT_DIR}/cv.html" "$PDF_OUT"

# Site build: also keep the download-named copy next to cv.pdf for local attach.
if [[ "$OUT_DIR" == "." && "$PDF_HREF" == "cv.pdf" ]]; then
  cp -f "$PDF_OUT" "./${PDF_DOWNLOAD_NAME}"
fi

echo "✓ Built ${OUT_DIR}/cv.html and ${PDF_OUT} from ${SRC_MD}"
if [[ "$OUT_DIR" == "." ]]; then
  echo "  (also ./${PDF_DOWNLOAD_NAME})"
fi
