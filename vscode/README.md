# VS Code Configuration

This directory contains VS Code user configuration files managed through dotfiles.

## Files

- `keybindings.json` - Custom keyboard shortcuts for VS Code
- `settings.json` - VS Code user settings and preferences

## Setup

The configuration files in this directory are symlinked to their original locations:

```bash
~/Library/Application Support/Code/User/keybindings.json -> ~/github.com/dotfiles/vscode/keybindings.json
~/Library/Application Support/Code/User/settings.json -> ~/github.com/dotfiles/vscode/settings.json
```

This allows version control of VS Code settings while keeping them in their expected locations.

## Manual Setup

If you need to recreate the symlinks:

```bash
# Backup existing files first (if needed)
cp ~/Library/Application\ Support/Code/User/keybindings.json ~/keybindings.json.backup
cp ~/Library/Application\ Support/Code/User/settings.json ~/settings.json.backup

# Create symlinks
ln -sf ~/github.com/dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
ln -sf ~/github.com/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
```
