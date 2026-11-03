# Kemas

**Kemas** is a lightweight Linux application installer for prebuilt packages.

Install applications from `.tar.gz`, `.tar.xz`, `.tar.zst`, and `.zip` archives without manually managing extraction, desktop entries, icons, and executable paths.

## Features

- Install local archives or download packages from URLs.
- Select assets from GitHub repositories and release pages.
- Create desktop entries and application icons.
- Manage persistent application configuration and data.
- Diagnose installation issues, runtime dependencies, and compatibility.
- Launch applications while capturing runtime errors.
- Discover alternatives from native repositories and Flatpak remotes.
- Recover by finding alternative packages for installed applications.
- Clean up leftover application data.

## Installation

### Requirements

- Linux
- Bash
- `curl` (for URL downloads)
- `gum` (for the interactive interface)

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

The installer updates the executable without removing your existing configuration or application data.

## Usage

```bash
# Open the interactive menu
kemas

# Install a local archive
kemas ./application.tar.gz

# Install from a URL
kemas https://example.com/application.tar.gz

# Diagnose an installed application
kemas diagnose application

# Launch an application through Kemas
kemas launch application

# Discover alternatives
kemas discover application

# Find package alternatives
kemas recover application

# Manage leftover application data
kemas cleanup

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
```

Configuration:

```text
~/.config/kemas/config
```

## Supported Archive Formats

- `.tar.gz`
- `.tar.xz`
- `.tar.zst`
- `.zip`

## Compatibility

Kemas is designed for Linux distributions. Dependency availability and package discovery depend on the distribution and its configured package managers.

## License

See [LICENSE](LICENSE).
