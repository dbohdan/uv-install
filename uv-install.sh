#! /usr/bin/env bash
# Requires sha256sum(1) and wget(1).
set -euo pipefail

dest_dir=/usr/local/bin/
prefix=uv-$(uname -m)-unknown-linux-gnu

usage() {
    cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Install uv.

Options:
  -d, --dest-dir DIR   Installation directory (default: '$dest_dir')
  -p, --prefix PREFIX  Archive prefix (default: '$prefix')

  -h, --help           Show this help message and exit
EOF
}

check_missing_arg() {
    if [[ $# -ge 2 ]]; then
        return
    fi

    echo "Error: '$1' requires an argument" >&2
    exit 2
}

while [[ $# -gt 0 ]]; do
    case "$1" in
    -d | --dest-dir)
        check_missing_arg "$@"

        dest_dir=$(realpath "$2")
        shift 2
        ;;

    -p | --prefix)
        check_missing_arg "$@"

        prefix=$2
        shift 2
        ;;

    -h | --help)
        usage
        exit 0
        ;;

    -*)
        echo "Error: unknown option '$1'" >&2
        exit 2
        ;;

    *)
        echo "Error: unexpected argument '$1'" >&2
        exit 2
        ;;
    esac
done

url=https://github.com/astral-sh/uv/releases/latest/download/$prefix.tar.gz

temp_dir=$(mktemp -d)
clean_up() {
    rm -r "$temp_dir"
}
trap clean_up EXIT

cd "$temp_dir"
wget -q "$url" "$url".sha256

archive=$prefix.tar.gz
sha256sum -c "$archive".sha256 >/dev/null
tar -xf "$archive"

mkdir -p "$dest_dir"
install "$prefix"/uv "$dest_dir"
