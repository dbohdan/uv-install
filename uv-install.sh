#! /usr/bin/env bash
# Requires curl(1), jq(1), and shasum(1).
set -euo pipefail

# Config.
dest_dir=/usr/local/bin/
prefix=uv-$(uname -m)-unknown-linux-gnu
repo=astral-sh/uv
# End of config.

json_url="https://api.github.com/repos/$repo/releases/latest"
json=$(curl --fail --silent "$json_url")
mapfile -t download_urls < <(jq --arg prefix "$prefix" --raw-output '.assets[] | select(.name | contains($prefix)) | .browser_download_url' <<<"$json")

temp_dir=$(mktemp -d)
clean_up() {
    rm -r "$temp_dir"
}
trap clean_up EXIT

cd "$temp_dir"
for url in "${download_urls[@]}"; do
    curl --fail --location --remote-header-name --remote-name "$url"
done

archive="$prefix".tar.gz
shasum --check --quiet "$archive".sha256
tar -xf "$archive"
install "$prefix"/uv "$dest_dir"
