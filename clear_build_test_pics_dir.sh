#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$ROOT_DIR/scripts/common.sh"

clean_dir "$ROOT_DIR/build_test_pics"
