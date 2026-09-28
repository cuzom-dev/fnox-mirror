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

Nothing is committed to publish a version, and no bot writes to this repository.

1. The [Mirror workflow](.github/workflows/mirror.yml) runs daily from `main`. When fnox has a release that
   is at least three days old and not yet on npm, it takes it (`scripts/pick-version.sh`).
2. It downloads that release's `fnox-x86_64-unknown-linux-musl.tar.gz` from
   [jdx/fnox](https://github.com/jdx/fnox/releases), **verifies it against the attestation fnox's own release
   workflow made** (`gh attestation verify --repo jdx/fnox`) and checks that the binary reports that version
   (`scripts/fetch-fnox.sh`).
3. It publishes the package **under fnox's own version number** — `@cuzom/fnox-mirror@1.35.3` is fnox 1.35.3 —
   over OIDC, with provenance, from the `npm` environment that only `main` may use. No token exists.

"Run workflow" with a version publishes that one at once. No person approves each release; why, and what
stands in for that approval, is in [docs/decisions.md](docs/decisions.md).

## When it can go

As soon as fnox is installable in a Claude cloud session some other way — published to npm by its author,
or the cloud's GitHub proxy allowing release downloads — this repository is archived and the package
deprecated.

## Licence

fnox is © jdx under the MIT licence, which this package keeps (`package/LICENSE`, `THIRD_PARTY_NOTICES.md`).
This repository's own files — the scripts, workflows and documents — are © Cuzom Oy under
[Apache-2.0](LICENSE), like Cuzom's other shared tooling. As-is, no warranty, no support.
