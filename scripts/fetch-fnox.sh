#!/usr/bin/env bash
# Puts fnox's official Linux x64 binary for the version in fnox-version.txt into package/bin/, after
# checking it against the attestation fnox's own release workflow made for it: the file must have been
# built by jdx/fnox's workflow, or this stops. Needs gh (preinstalled on GitHub's runners) and GH_TOKEN.
set -euo pipefail

cd "$(dirname "$0")/.."
version="$(tr -d '[:space:]' <fnox-version.txt)"
asset="fnox-x86_64-unknown-linux-musl.tar.gz"
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT

gh release download "v$version" --repo jdx/fnox --pattern "$asset" --dir "$work"
gh attestation verify "$work/$asset" --repo jdx/fnox

mkdir -p package/bin
tar -xzf "$work/$asset" -C "$work"
install -m 0755 "$(find "$work" -type f -name fnox | head -n 1)" package/bin/fnox
printf '%s\n' "$version" >package/FNOX_VERSION

# The binary must be the version it claims to be.
package/bin/fnox --version | grep -Fq "$version"
echo "fnox $version verified and packed into package/bin/fnox"
