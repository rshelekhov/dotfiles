# Brewfile Management

This repository contains a `Brewfile` that tracks all Homebrew packages, casks, and taps installed on my macOS system.

## What is Brewfile?

Brewfile is a dependency file for Homebrew that allows you to define all your installed packages in one place. It makes it easy to:

- Replicate your development environment on a new machine
- Keep track of installed software
- Share your setup with others
- Backup your package list

## Location

The Brewfile is located at: `~/github.com/dotfiles/Brewfile`

## Usage

### Installing packages from Brewfile

On a new machine or to sync packages:

```bash
cd ~/github.com/dotfiles
brew bundle install
```

Or from any directory:

```bash
brew bundle install --file=~/github.com/dotfiles/Brewfile
```

### Updating Brewfile

When you install new packages via Homebrew, update the Brewfile:

```bash
cd ~/github.com/dotfiles
brew bundle dump --force --describe
git add Brewfile
git commit -m "Update Brewfile with new packages"
git push
```

**Flags explanation:**

- `--force` - Overwrites existing Brewfile
- `--describe` - Adds descriptions for each package
- `--no-restart` - Excludes restart information for services

### Checking what's missing

To see which packages from Brewfile are not installed:

```bash
cd ~/github.com/dotfiles
brew bundle check
```

### Cleaning up

To uninstall packages not listed in Brewfile:

```bash
cd ~/github.com/dotfiles
brew bundle cleanup
```

Add `--force` to skip confirmation:

```bash
brew bundle cleanup --force
```

## Brewfile Structure

The Brewfile contains:

- `tap` - Third-party repositories
- `brew` - Command-line tools and libraries
- `cask` - GUI applications
- `mas` - Mac App Store applications (requires mas-cli)

Example:

```ruby
tap "homebrew/bundle"
brew "git"
brew "node"
cask "visual-studio-code"
mas "Xcode", id: 497799835
```

## Best Practices

1. **Update regularly**: Run `brew bundle dump --force` after installing new software
2. **Commit changes**: Keep your Brewfile in version control
3. **Document custom taps**: Add comments for non-obvious packages
4. **Review before cleanup**: Always check what will be removed with `brew bundle cleanup` before using `--force`

## Initial Setup on New Machine

1. Install Homebrew:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

2. Clone this repository:

```bash
git clone <your-repo-url> ~/github.com/dotfiles
```

3. Install all packages:

```bash
cd ~/github.com/dotfiles
brew bundle install
```
