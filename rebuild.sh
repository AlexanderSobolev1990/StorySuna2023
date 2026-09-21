#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$ROOT_DIR/scripts/common.sh"

BUILD_DIR="$ROOT_DIR/build"

need_cmd cmake
need_cmd make

clean_dir "$BUILD_DIR"
mkdir -p "$ROOT_DIR/output"

cmake -S "$ROOT_DIR" -B "$BUILD_DIR"
cmake --build "$BUILD_DIR"
