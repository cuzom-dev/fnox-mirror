#!/usr/bin/env bash
# Prints "version=<v>" when there is a fnox version to publish, and nothing when there is not. The version is
# $WANTED when a person asked for one, otherwise fnox's latest release once it is at least three days old —
# the same waiting period every Cuzom repository gives a new dependency (handbook,
# dependencies-and-security.md). A version already on npm is never published again.
set -euo pipefail

min_days=3
if [ -n "${WANTED:-}" ]; then
  version="${WANTED#v}"
else
  IFS=$'\t' read -r tag published < <(gh api repos/jdx/fnox/releases/latest --jq '[.tag_name, .published_at] | @tsv')
  version="${tag#v}"
  age_days=$((($(date +%s) - $(date -d "$published" +%s)) / 86400))
  if [ "$age_days" -lt "$min_days" ]; then
    echo "fnox $version is $age_days days old; publishing it once it is $min_days" >&2
    exit 0
  fi
fi

if npm view "@cuzom/fnox-mirror@$version" version >/dev/null 2>&1; then
  echo "@cuzom/fnox-mirror@$version is already on npm" >&2
  exit 0
fi
echo "version=$version"
