# fnox-mirror: notes for an agent

Cuzom's shared practice: `../dev-handbook/AGENTS.md` (or `cuzom-dev/dev-handbook`). Specific to this
repository:

- **It republishes someone else's binary.** Never modify the binary, never commit it, and never skip the
  attestation check in `scripts/fetch-fnox.sh` — that check is the whole reason the package can be trusted.
- **The package is for Cuzom's Claude cloud sessions only**, and says so. Do not widen it: no other
  platforms, no extra features, no wrapper code.
- **Nothing is committed to publish a fnox version**: the Mirror workflow publishes each release by itself.
  Do not add a version file, release-please or a Renovate rule for fnox back.
