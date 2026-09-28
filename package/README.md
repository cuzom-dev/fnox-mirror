# @cuzom/fnox-mirror — not for general use

**Install fnox from [fnox.jdx.dev](https://fnox.jdx.dev/guide/installation.html), not from here.**
This package is not a fnox distribution, is not supported, and may disappear without notice.

It holds one file: the official Linux x64 build of [fnox](https://github.com/jdx/fnox) by jdx, unchanged,
from fnox's own GitHub release, verified against that release's attestation before it was packed. The
fnox version is in `FNOX_VERSION`.

**Why it exists.** Claude Code's cloud sessions can reach package registries such as npm, but not the
GitHub release downloads of repositories outside the session, which is where fnox — and mise, when it
installs fnox — downloads from. This copy lets those sessions of Cuzom Oy install fnox with
`npm install -g @cuzom/fnox-mirror`. Everywhere else, use fnox's own installation.

fnox is © jdx, under the MIT licence (`LICENSE`). The packaging is in
[cuzom-dev/fnox-mirror](https://github.com/cuzom-dev/fnox-mirror).
