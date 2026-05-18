#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PACKAGE_DIR="$ROOT_DIR/package"
BUILD_DIR="$ROOT_DIR/build"
STAGE_DIR="$BUILD_DIR/package"
LOCALE_DIR="$STAGE_DIR/contents/locale"
DOMAIN="plasma_wallpaper_de.unkn0wn.htmlwallpaper"

rm -rf "$STAGE_DIR"
mkdir -p "$LOCALE_DIR"

cp -a "$PACKAGE_DIR/." "$STAGE_DIR/"

for po_file in "$ROOT_DIR"/translate/*.po; do
    lang="$(basename "${po_file%.po}")"
    target_dir="$LOCALE_DIR/$lang/LC_MESSAGES"
    mkdir -p "$target_dir"
    msgfmt "$po_file" -o "$target_dir/$DOMAIN.mo"
done

archive_base="htmlwallpaper"
if [[ -n "${GITHUB_REF_NAME:-}" ]]; then
    archive_base="${archive_base}-${GITHUB_REF_NAME}"
elif [[ -n "${GITHUB_SHA:-}" ]]; then
    archive_base="${archive_base}-${GITHUB_SHA::7}"
fi

mkdir -p "$BUILD_DIR"
if command -v zip >/dev/null 2>&1; then
    ARCHIVE_PATH="$BUILD_DIR/${archive_base}.zip"
    (
        cd "$STAGE_DIR"
        zip -qr "$ARCHIVE_PATH" .
    )
else
    ARCHIVE_PATH="$BUILD_DIR/${archive_base}.tar.gz"
    tar -C "$STAGE_DIR" -czf "$ARCHIVE_PATH" .
fi

printf '%s\n' "$ARCHIVE_PATH"
