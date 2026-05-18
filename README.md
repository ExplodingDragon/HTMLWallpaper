# HTML Wallpaper

HTML Wallpaper is a KDE Plasma 6 wallpaper plugin that renders a web page as
your desktop background with Qt WebEngine.

## Features

- Display a remote website or a local HTML file as wallpaper
- Force refresh on a configurable interval
- Manual hard refresh from the wallpaper settings
- Persistent cookies and HTML5 local storage
- English and Simplified Chinese translations

## Requirements

- KDE Plasma 6
- Qt WebEngine runtime available in the Plasma session

## Installation

### Install from a packaged archive

If you downloaded a release archive, unpack it first. The extracted directory
must contain `metadata.json` at its root. GitHub Releases attach a ready-to-use
package archive built from the `package` contents.

```bash
kpackagetool6 -t Plasma/Wallpaper -i /path/to/package
qdbus6 org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.refreshCurrentShell
```

To upgrade an existing installation:

```bash
kpackagetool6 -t Plasma/Wallpaper -u /path/to/package
qdbus6 org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.refreshCurrentShell
```

If the extracted directory is named `htmlwallpaper-*`, install that directory
directly.

### Install directly from this repository

```bash
kpackagetool6 -t Plasma/Wallpaper -i ./package
qdbus6 org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.refreshCurrentShell
```

## Usage

1. Open desktop wallpaper settings in Plasma.
2. Select `HTML Wallpaper`.
3. Set the target URL.
4. Optionally adjust zoom, refresh interval, or insecure HTTPS behavior.

For local files, use a `file:///absolute/path/to/file.html` URL.

## Packaging

This repository includes a GitHub Actions workflow that:

- builds a distributable archive on every push and pull request
- uploads the package as a workflow artifact for non-tag builds
- creates a GitHub Release and uploads the archive when the ref is a tag

The CI build produces a `.zip` file containing the `package` directory contents
at the archive root, so it can be installed after extraction with
`kpackagetool6`.

## License

LGPL-2.0-or-later
