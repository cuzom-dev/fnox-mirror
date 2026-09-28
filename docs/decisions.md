# Decisions

## No release pull request and no approval per version (2026-09-28)

The handbook publishes a Cuzom package through release-please and `npm stage publish`, with a person
approving each version (npm-packages.md). This repository does not, because it is a mirror: its only
content is someone else's binary, so a new version is fnox's decision, and a person approving it would be
approving a binary they cannot inspect.

What stands in for the approval:

- **The binary's origin is verified**, not trusted: `gh attestation verify --repo jdx/fnox` passes only
  for a file built by fnox's own release workflow.
- **Only `main` can publish.** The publishing job runs in the GitHub environment `npm`, which only `main`
  may use, and npm's trusted publisher for the package accepts this repository's `mirror.yml` in that
  environment only. A workflow changed on a branch — by anyone, an agent included — cannot publish.
- **The trusted publisher has *Allow npm publish* ticked**, unlike the handbook's default. Without it npm
  accepts only `npm stage publish` from the workflow, and a direct publish fails with *403 OIDC permission
  denied for this action*.
- **No tokens.** The package requires two-factor authentication and disallows tokens; publishing is over
  OIDC only.
- **A three-day wait**, the same one every Cuzom repository gives a new dependency, so that a release
  withdrawn upstream in its first days never reaches the mirror.

Nothing is committed per version either: the package version is fnox's own, set at publishing time, so
no bot writes to this repository.
