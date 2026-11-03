#!/bin/sh
set -eu

APP_NAME="kemas"
SOURCE_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

SOURCE="$SOURCE_DIR/$APP_NAME"
INSTALL_DIR="${HOME}/.local/opt/${APP_NAME}"
INSTALL_PATH="$INSTALL_DIR/$APP_NAME"
BIN_DIR="${HOME}/.local/bin"
BIN_PATH="$BIN_DIR/$APP_NAME"

info() {
    printf '[Kemas] %s\n' "$1"
}

error() {
    printf '[Kemas] Error: %s\n' "$1" >&2
    exit 1
}

# Validate source
[ -f "$SOURCE" ] || error "Source file not found: $SOURCE"

# Create user-level directories
mkdir -p "$INSTALL_DIR" "$BIN_DIR"

# Avoid overwriting an unrelated executable
if [ -e "$BIN_PATH" ] && [ ! -L "$BIN_PATH" ]; then
    error "$BIN_PATH already exists and is not a symlink. Move it manually before installing."
fi

# Install atomically
TEMP_FILE=$(mktemp "$INSTALL_DIR/.kemas.XXXXXX")
trap 'rm -f "$TEMP_FILE"' EXIT HUP INT TERM

install -m 755 "$SOURCE" "$TEMP_FILE"
mv -f "$TEMP_FILE" "$INSTALL_PATH"

# Create or refresh the launcher symlink
ln -sfn "$INSTALL_PATH" "$BIN_PATH"

info "Installation completed."
info "Executable: $INSTALL_PATH"
info "Symlink:    $BIN_PATH"

case ":${PATH:-}:" in
    *":$BIN_DIR:"*)
        info "PATH already includes $BIN_DIR."
        ;;
    *)
        printf '\n'
        info "$BIN_DIR is not currently in PATH."
        printf 'Add it to your shell configuration:\n'
        printf '  fish:  fish_add_path %s\n' "$BIN_DIR"
        printf '  bash:  export PATH="%s:$PATH"\n' "$BIN_DIR"
        printf '  zsh:   export PATH="%s:$PATH"\n' "$BIN_DIR"
        ;;
esac

printf '\n'
info "Run 'kemas --help' to get started."