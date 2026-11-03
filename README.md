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

Installation instructions will be added here.

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
