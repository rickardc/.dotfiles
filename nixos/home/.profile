# ~/.profile

# Add ~/.local/bin and gh to PATH
export PATH="$HOME/.local/bin:$PATH"

# Ensure VS Code or other GUI apps can find gh
export GH_CONFIG_DIR="$HOME/.config/gh"

# Ensure DBUS variables exist (needed for some GUI features)
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ] && [ -n "$XDG_RUNTIME_DIR" ]; then
    export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"
fi
