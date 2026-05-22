#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
BUILD_DIR="$ROOT_DIR/build_pdfx"
OUTPUT_DIR="$ROOT_DIR/output"
OUTPUT_PDF="$OUTPUT_DIR/StorySuna2023_Sobolev_PDFX-1a.pdf"
PDFX_PICTURES_DIR="$BUILD_DIR/pictures_pdfx"
JOB_NAME="main_x1a"

mkdir -p "$BUILD_DIR" "$OUTPUT_DIR" "$PDFX_PICTURES_DIR"
cp -a "$ROOT_DIR/pictures/disign" "$PDFX_PICTURES_DIR/"
cp -a "$ROOT_DIR/pictures/linographs_150dpi" "$PDFX_PICTURES_DIR/"
find "$PDFX_PICTURES_DIR" -type f -iname '*.png' \
	-exec mogrify -colorspace Gray -background white -alpha remove -alpha off +profile icc {} +
ln -sfn "$PDFX_PICTURES_DIR" "$BUILD_DIR/pictures"
rm -f "$BUILD_DIR"/"$JOB_NAME".{aux,bbl,blg,idx,ilg,ind,log,out,pdf,toc,xdv}

run_xelatex() {
	(
		cd "$BUILD_DIR"
		TEXINPUTS="$ROOT_DIR:${TEXINPUTS:-}" \
		xelatex \
			-interaction=nonstopmode \
			-halt-on-error \
			-shell-escape \
			-output-driver="xdvipdfmx -z 0" \
			"$JOB_NAME.tex"
	)
}

run_xelatex
(
	cd "$BUILD_DIR"
	BIBINPUTS="$ROOT_DIR:${BIBINPUTS:-}" \
	BSTINPUTS="$ROOT_DIR:${BSTINPUTS:-}" \
	bibtexu "$JOB_NAME"
)
run_xelatex
run_xelatex

cp "$BUILD_DIR/$JOB_NAME.pdf" "$OUTPUT_PDF"
printf 'PDF/X build written to %s\n' "$OUTPUT_PDF"
