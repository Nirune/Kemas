# Kemas

**Kemas** is a brutalist, terminal-native Linux installer for prebuilt packages.

Turn `.tar.gz`, `.tar.xz`, `.tar.zst`, `.zip`, `.deb`, and `.AppImage` archives into proper desktop apps — extraction, desktop entries, icons, and executable symlinks handled in one command, through a `gum`-powered TUI.

## Features

- Install local archives or download packages from URLs (direct links or GitHub repos / releases).
- Live download progress bar with percentage, size, speed, and ETA.
- Pick assets from GitHub repositories and release pages.
- `.deb` and `.AppImage` support (isolated, user-level extraction — no system files touched).
- Create desktop entries and application icons (auto-scored icon candidates with terminal preview, letter fallback, URL / GitHub folder / file sources).
- Runtime diagnostics (ELF architecture check, `ldd` missing-library detection, GTK/GIO split-runtime hints).
- Launch apps through Kemas while capturing runtime output, with package discovery on failure.
- Manage persistent app configuration and data (backup, reset, delete — never removed without confirmation).
- Discover alternatives from native repositories (pacman / apt / dnf / zypper) and Flatpak remotes.
- Recover by finding alternative packages for installed applications.
- Track and remove packages installed through Kemas, including system packages.
- Clean up leftover application data with backup/restore.
- Self-update from GitHub (`kemas update`).
- Settings: package source folder, icon font, accent color, letter/icon colors, clean or Nerd Font interface style.

## Installation

### Requirements

- Linux
- Bash
- `curl` (for URL downloads)
- `gum` (for the interactive interface)

Optional but recommended:

- `chafa` — terminal icon previews
- `imagemagick` — letter icons / icon conversion
- `desktop-file-utils` — `.desktop` validation
- `binutils` (`readelf`) — runtime architecture check
- `unzip` — `.zip` extraction

### Install from GitHub

Clone the repository and run the installer:

```bash
git clone https://github.com/Nirune/Kemas.git
cd Kemas
./install.sh
```

Kemas will be installed to:

- Executable: `~/.local/opt/kemas/kemas`
- Command symlink: `~/.local/bin/kemas`

Make sure `~/.local/bin` is included in your `PATH`.

### Verify Installation

```bash
kemas --help
```

### Update

Pull the latest source and run the installer again:

```bash
cd Kemas
git pull
./install.sh
```

Or self-update from GitHub:

```bash
kemas update
```

The installer updates the executable without removing your existing configuration or application data.

## Usage

```bash
# Open the interactive menu
kemas

# Install a local archive
kemas ./application.tar.gz

# Install from a URL
kemas https://example.com/application.tar.gz

# Install from a GitHub repo / releases page (pick an asset)
kemas https://github.com/user/repo/releases

# List installed applications
kemas installed
kemas installed --with-kemas
kemas installed --outside

# Manage packages (kemas-tracked or system)
kemas pkg list
kemas pkg update
kemas pkg uninstall <app>

# Diagnose an installed application
kemas diagnose <app>
kemas check <app>        # alias for diagnose

# Launch an application through Kemas
kemas launch <app>

# Discover alternatives
kemas discover <query>

# Find package alternatives
kemas recover <app>

# Manage leftover application data
kemas cleanup

# Check for Kemas updates
kemas update

# Show help
kemas --help
```

## Application Layout

Kemas uses the following user-level installation layout:

```text
~/.local/
├── opt/
│   └── <application>/
├── bin/
│   └── <application> -> ~/.local/opt/<application>/...
└── share/
    ├── applications/
    │   └── <application>.desktop
    └── icons/
        └── hicolor/
```

Configuration:

```text
~/.config/kemas/config
```

App data and backups:

```text
~/.local/share/kemas/
├── apps/          # per-app registry
├── configs/       # persistent config paths
├── packages/      # packages installed via kemas
├── leftovers/     # kept leftover data lists
├── backups/       # data backups (tar.gz)
└── downloads/     # URL download cache
```

## Supported Archive Formats

- `.tar.gz` / `.tgz`
- `.tar.xz` / `.txz`
- `.tar.zst`
- `.tar.bz2`
- `.zip`
- `.deb` (isolated user-level extraction)
- `.AppImage`

## Runtime Diagnostics

`kemas diagnose <app>` statically inspects an installed app:

- ELF binary architecture vs. host
- Missing shared libraries via `ldd`
- Bundled GTK/GIO mixed with host GLib
- GDK Pixbuf loaders and cache
- AppRun launcher detection

`kemas launch <app>` runs the app capturing stdout/stderr to a log, and offers package discovery on failure.

## Package Discovery & Recovery

- `kemas discover <query>` — search official repos, AUR (paru), and Flathub; install with your confirmation.
- `kemas recover <app>` — automatically search for alternatives using the app's command name and display name.

## Settings

Run `kemas` and choose **Settings** to adjust:

- Package source folder (default: `~/Downloads`)
- Letter icon font
- Icon background / letter color
- TUI accent color
- Interface style: `clean` (unicode) or `nerd` (Nerd Font glyphs)

Settings are saved to `~/.config/kemas/config`.

## Compatibility

Kemas is designed for Linux distributions. Dependency availability and package discovery depend on the distribution and its configured package managers (pacman, apt, dnf, zypper, apk, flatpak).

## License

See [LICENSE](LICENSE).
