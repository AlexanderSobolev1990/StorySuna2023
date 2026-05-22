#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
BUILD_DIR="$ROOT_DIR/build_screen"
OUTPUT_DIR="$ROOT_DIR/output"
OUTPUT_PDF="$OUTPUT_DIR/StorySuna2023_Sobolev.pdf"

mkdir -p "$BUILD_DIR" "$OUTPUT_DIR"
ln -sfn "$ROOT_DIR/pictures" "$BUILD_DIR/pictures"
rm -f "$BUILD_DIR"/main.{aux,bbl,blg,idx,ilg,ind,log,out,pdf,toc,xdv}

run_xelatex() {
	(
		cd "$BUILD_DIR"
		TEXINPUTS="$ROOT_DIR:${TEXINPUTS:-}" \
		xelatex \
			-interaction=nonstopmode \
			-halt-on-error \
			main.tex
	)
}

run_xelatex
(
	cd "$BUILD_DIR"
	BIBINPUTS="$ROOT_DIR:${BIBINPUTS:-}" \
	BSTINPUTS="$ROOT_DIR:${BSTINPUTS:-}" \
	bibtexu main
)
run_xelatex
run_xelatex

cp "$BUILD_DIR/main.pdf" "$OUTPUT_PDF"
printf 'Screen PDF build written to %s\n' "$OUTPUT_PDF"
