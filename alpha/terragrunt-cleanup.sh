#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

find "$SCRIPT_DIR/environments" -name '.terragrunt*' -exec rm -rf '{}' \; 2>/dev/null
