#!/usr/bin/env bash
set -euo pipefail

mkdir -p build_test_pics output
xelatex -interaction=nonstopmode -halt-on-error -output-directory=build_test_pics test_pics_main.tex
cp build_test_pics/test_pics_main.pdf output/test_pics.pdf
