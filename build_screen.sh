#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
BUILD_DIR="$ROOT_DIR/build_screen"
OUTPUT_DIR="$ROOT_DIR/output"
OUTPUT_PDF="$OUTPUT_DIR/StorySuna2023_Sobolev.pdf"
RAW_PDF="$BUILD_DIR/main.pdf"
COMPRESSED_PDF="$BUILD_DIR/main_screen_compressed.pdf"
SCREEN_PDFSETTINGS="${SCREEN_PDFSETTINGS:-/printer}"

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

gs \
	-q \
	-dNOPAUSE \
	-dBATCH \
	-dSAFER \
	-sDEVICE=pdfwrite \
	-dCompatibilityLevel=1.5 \
	-dPDFSETTINGS="$SCREEN_PDFSETTINGS" \
	-dDetectDuplicateImages=true \
	-dCompressFonts=true \
	-dSubsetFonts=true \
	-dAutoRotatePages=/None \
	-sOutputFile="$COMPRESSED_PDF" \
	"$RAW_PDF"

cp "$COMPRESSED_PDF" "$OUTPUT_PDF"
printf 'Compressed screen PDF build written to %s\n' "$OUTPUT_PDF"
printf 'Ghostscript PDFSETTINGS=%s\n' "$SCREEN_PDFSETTINGS"
