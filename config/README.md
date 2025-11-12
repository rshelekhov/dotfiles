# Configuration Files Management

This repository contains configuration files (dotfiles) for various tools and applications.

## Structure

```
~/github.com/dotfiles/
├── Brewfile          # Homebrew packages
└── config/
    ├── skhdrc        # skhd hotkey configuration
    └── README.md     # This file
```

## Symlinks Setup

Configuration files are stored in this repository but symlinked to their expected locations so applications can find them.

### skhd Configuration

**Actual location**: `~/github.com/dotfiles/config/skhdrc`  
**Symlink location**: `~/.config/skhd/skhdrc`

To install skhd:

```bash
brew install koekeishiya/formulae/skhd
```

Useful Commands

```bash
# Start skhd service
skhd --start-service

# Stop skhd service
skhd --stop-service

# Restart skhd service
skhd --restart-service

# Reload configuration without restarting
skhd --reload
```

To create the symlink:

```bash
# Create skhd config directory if it doesn't exist
mkdir -p ~/.config/skhd

# Create primary symlink
ln -s ~/github.com/dotfiles/config/skhdrc ~/.config/skhd/skhdrc

# Create fallback symlink (required - skhd searches here first)
ln -s ~/github.com/dotfiles/config/skhdrc ~/.skhdrc
```

To verify the symlink:

```bash
ls -la ~/.config/skhd/skhdrc
# Should show: ~/.config/skhd/skhdrc -> /Users/YOUR_USERNAME/github.com/dotfiles/config/skhdrc

ls -la ~/.skhdrc
# Should show: .skhdrc -> /Users/YOUR_USERNAME/github.com/dotfiles/config/skhdrc
```

To reload skhd after making changes:

```bash
skhd --reload
```

## Initial Setup on New Machine

1. Clone this repository:

```bash
mkdir -p ~/github.com
git clone github.com/rshelekhov/dotfiles ~/github.com/dotfiles
```

2. Install Homebrew packages:

```bash
cd ~/github.com/dotfiles
brew bundle install
```

3. Create symlinks for configuration files:

```bash
# skhd
mkdir -p ~/.config/skhd
ln -s ~/github.com/dotfiles/config/skhdrc ~/.config/skhd/skhdrc
ln -s ~/github.com/dotfiles/config/skhdrc ~/.skhdrc
```

4. Start services:

```bash
skhd --start-service
```
