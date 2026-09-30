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
- **The trusted publisher has _Allow npm publish_ ticked**, unlike the handbook's default. Without it npm
  accepts only `npm stage publish` from the workflow, and a direct publish fails with _403 OIDC permission
  denied for this action_.
- **No tokens.** The package requires two-factor authentication and disallows tokens; publishing is over
  OIDC only.
- **A three-day wait**, the same one every Cuzom repository gives a new dependency, so that a release
  withdrawn upstream in its first days never reaches the mirror.

Nothing is committed per version either: the package version is fnox's own, set at publishing time, so
no bot writes to this repository.

## The conventions record announces nothing here (2026-09-30)

Every Cuzom repository records in `.cuzom-conventions.toml` the handbook and `dev-tools` versions it was
last checked against, and the shared Renovate preset opens a pull request when a newer one is released:
that pull request is what normally starts the next alignment. **In this repository it never arrives.** The
preset resolves both versions as GitHub releases of Cuzom's shared repositories, which are private, and
Renovate gives a public repository a token scoped to that repository alone.

So the record here is a record and not a trigger. It still says what this repository was checked against,
which is what lets the next audit read only what changed since; but the next alignment has to be started by
someone comparing the numbers with the current releases, not by a pull request.

Alternatives considered:

- **Drop the record.** Rejected: it is the one reference to the shared conventions a public repository
  keeps, and without it the next audit would have to start from every rule rather than from a diff.
- **Give Renovate a token that can read the private repositories.** Rejected: a public repository would
  then hold a credential that reads Cuzom's private repositories, to save one comparison of two numbers.

This stops being true the day the handbook is public.

## A mise.toml for one tool (2026-09-30)

Nobody runs anything from this repository on a machine, so a `mise.toml` does not buy the usual thing,
that CI runs the versions a machine runs. It is here for a narrower reason: **a Node version written into a
workflow is never updated.** Renovate pins the actions a workflow uses, but not the version an action is
told to install. A version in `mise.toml` is one it maintains, so both workflows install Node through
`jdx/mise-action` from this file, and no workflow names a version of its own.
