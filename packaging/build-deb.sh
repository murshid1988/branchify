#!/usr/bin/env bash
# Build a .deb package for branchify from the repo root.
#
# Usage: packaging/build-deb.sh <version>
# Produces: branchify_<version>_all.deb

set -euo pipefail

VERSION="${1:?usage: build-deb.sh <version>}"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD="$(mktemp -d)"
trap 'rm -rf "$BUILD"' EXIT

mkdir -p "$BUILD/DEBIAN" "$BUILD/usr/bin" "$BUILD/usr/share/man/man1" "$BUILD/usr/share/doc/branchify"

install -m755 "$ROOT/branchify.sh" "$BUILD/usr/bin/branchify"
gzip -9 -c "$ROOT/branchify.1" > "$BUILD/usr/share/man/man1/branchify.1.gz"
install -m644 "$ROOT/LICENSE" "$BUILD/usr/share/doc/branchify/copyright"

cat > "$BUILD/DEBIAN/control" <<EOF
Package: branchify
Version: ${VERSION}
Section: utils
Priority: optional
Architecture: all
Maintainer: murshid1988 <murshid1988@gmail.com>
Homepage: https://github.com/murshid1988/branchify
Description: Convert an arbitrary string into a valid git branch name
 branchify converts free-form text (a commit message, ticket title, or
 any string) into a branch name that passes git check-ref-format --branch.
EOF

OUT="$ROOT/branchify_${VERSION}_all.deb"
dpkg-deb --build --root-owner-group "$BUILD" "$OUT"
echo "Built $OUT"
