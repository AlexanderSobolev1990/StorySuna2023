#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
BUILD_DIR="$ROOT_DIR/build_test_pics"
OUTPUT_DIR="$ROOT_DIR/output"
OUTPUT_PDF="$OUTPUT_DIR/test_pics.pdf"

mkdir -p "$BUILD_DIR" "$OUTPUT_DIR"
ln -sfn "$ROOT_DIR/pictures" "$BUILD_DIR/pictures"
rm -f "$BUILD_DIR"/test_pics_main.{aux,log,out,pdf,xdv}

(
	cd "$BUILD_DIR"
	TEXINPUTS="$ROOT_DIR:${TEXINPUTS:-}" \
	xelatex \
		-interaction=nonstopmode \
		-halt-on-error \
		test_pics_main.tex
)

cp "$BUILD_DIR/test_pics_main.pdf" "$OUTPUT_PDF"
printf 'Picture test PDF written to %s\n' "$OUTPUT_PDF"
