#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

for script in \
	clear_build_dir.sh \
	clear_build_pdfx_dir.sh \
	clear_build_screen_dir.sh \
	clear_build_test_pics_dir.sh
do
	"$ROOT_DIR/$script"
done

printf 'All build directories cleared.\n'
