#! /usr/bin/env bash
# Requires shasum(1) and wget(1).
set -euo pipefail

dest_dir=/usr/local/bin/
prefix=uv-$(uname -m)-unknown-linux-gnu
url=https://github.com/astral-sh/uv/releases/latest/download/$prefix.tar.gz

temp_dir=$(mktemp -d)
clean_up() {
    rm -r "$temp_dir"
}
trap clean_up EXIT

cd "$temp_dir"
wget -q "$url" "$url.sha256"

archive=$prefix.tar.gz
shasum --check --quiet "$archive".sha256
tar -xf "$archive"
install "$prefix"/uv "$dest_dir"
