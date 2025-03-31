# uv-install

This is a short POSIX shell script to install or upgrade to the latest version of [uv](https://github.com/astral-sh/uv).
It is intended to be easier to audit than [astral.sh/uv/install.sh](https://astral.sh/uv/install.sh).

On systems other than GNU/Linux, including Linux with musl libc, you will have to specify the download prefix manually (for example, `uv-aarch64-unknown-linux-musl`).
Go to the latest [GitHub release](https://github.or/astral-sh/uv/releases) of uv and examine the filenames to find the correct prefix.

The script requires sha256sum(1) and wget(1).
(BusyBox works.)
It has been tested on Alpine Linux 3.20, Debian 12, Fedora 39, Termux, and Ubuntu 24.04.

## Usage

```none
Usage: uv-install [OPTIONS]

Install uv.

Options:
  -d, --dest-dir DIR   Installation directory (default: '/usr/local/bin/')
  -p, --prefix PREFIX  Archive prefix (default: 'uv-x86_64-unknown-linux-gnu')

  -h, --help           Show this help message and exit
```

## Examples

```none
# Install for all users as root on Alpine Linux.
./uv-install --prefix uv-x86_64-unknown-linux-musl

# Install for the current user on x86_64 Debian, Fedora, or Ubuntu.
./uv-install --dest-dir ~/.local/bin/
```

## License

MIT.
