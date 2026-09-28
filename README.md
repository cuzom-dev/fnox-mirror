# fnox-mirror — not for general use

**Looking for fnox? Install it from [fnox.jdx.dev](https://fnox.jdx.dev/guide/installation.html).** This
repository is not a fnox distribution, and the npm package it publishes is not for anyone outside Cuzom Oy.

## What it is

[fnox](https://github.com/jdx/fnox) (© jdx, MIT) is the tool every Cuzom repository uses to give a process
its environment variables. On a laptop or in a development container, mise installs it from fnox's own
GitHub releases. **Claude Code's cloud sessions cannot**: their network lets package registries such as npm
through, but GitHub release downloads only for the repositories attached to the session — and fnox is not
on npm or PyPI, and building it from source takes longer than a cloud environment's setup may.

So this repository republishes one file, unchanged: fnox's official **Linux x64** build, as the npm package
[`@cuzom/fnox-mirror`](https://www.npmjs.com/package/@cuzom/fnox-mirror), which a cloud session installs with
`npm install -g @cuzom/fnox-mirror`. The package installs on Linux x64 only, and says on its first line not to
use it.

## How a version gets here

1. `fnox-version.txt` pins the fnox version. Renovate opens a pull request when fnox releases a new one.
2. Merging it releases this repository (release-please).
3. The release workflow downloads that version's `fnox-x86_64-unknown-linux-musl.tar.gz` from
   [jdx/fnox's release](https://github.com/jdx/fnox/releases), **verifies it against the attestation fnox's
   own release workflow made** (`gh attestation verify --repo jdx/fnox`), checks that the binary reports that
   version, and stages the npm package with provenance.
4. A person approves the staged package on npmjs.com. Nothing reaches npm without that.

The binary is never committed here; `scripts/fetch-fnox.sh` is the whole of the fetching and checking.

## When it can go

As soon as fnox is installable in a Claude cloud session some other way — published to npm by its author,
or the cloud's GitHub proxy allowing release downloads — this repository is archived and the package
deprecated.

## Licence

fnox is © jdx under the MIT licence, which this package keeps (`package/LICENSE`, `THIRD_PARTY_NOTICES.md`).
This repository's own files — the scripts, workflows and documents — are © Cuzom Oy under
[Apache-2.0](LICENSE), like Cuzom's other shared tooling. As-is, no warranty, no support.
