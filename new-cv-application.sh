#!/usr/bin/env bash
# Scaffold a job-tailored CV copy under applications/ (gitignored — never pushed).
#
# Usage:
#   ./new-cv-application.sh acme-sre-2026-08
#   # edit applications/acme-sre-2026-08/cv.md  (keywords / summary / skills)
#   ./build-cv.sh applications/acme-sre-2026-08
#
# Root cv.md stays the public site CV. Only edit that when you want the live
# /cv.html + /cv.pdf to change.
set -euo pipefail
cd "$(dirname "$0")"

slug="${1:-}"
if [[ -z "$slug" || "$slug" == */* || "$slug" == .* ]]; then
  echo "usage: $0 <slug>" >&2
  echo "  slug: short folder name, e.g. acme-platform-engineer-2026-08" >&2
  exit 1
fi

dir="applications/${slug}"
if [[ -e "${dir}/cv.md" ]]; then
  echo "error: ${dir}/cv.md already exists — pick a new slug or edit in place" >&2
  exit 1
fi

mkdir -p "$dir"
cp cv.md "${dir}/cv.md"

# Optional notes file for the JD / keywords you are targeting (also gitignored).
cat > "${dir}/notes.md" <<EOF
# ${slug}

Target role / company:
Job link:
Keywords to weave in:

EOF

echo "✓ Created ${dir}/cv.md (copy of public CV) and ${dir}/notes.md"
echo "  1. Edit ${dir}/cv.md for this JD"
echo "  2. ./build-cv.sh ${dir}"
echo "  3. Open ${dir}/Prateek-Rajvats-CV.pdf — nothing under applications/ is git-tracked"
