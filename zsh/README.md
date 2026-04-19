# zsh

Portable zsh snippets. Sourced from `~/.zshrc`.

## Layout

- `node-env.zsh` — Node.js env vars (disables happy-eyeballs for Tailscale exit node compatibility)

## Setup on a new machine

Add this to the end of `~/.zshrc`:

```sh
for f in ~/github.com/dotfiles/zsh/*.zsh; do
  source "$f"
done
```

Or, if you only want a single snippet:

```sh
source ~/github.com/dotfiles/zsh/node-env.zsh
```

## Why files are split from `~/.zshrc`

`~/.zshrc` typically contains machine-specific state: absolute paths, API tokens,
shell plugin managers (oh-my-zsh, zinit), secrets that must not be committed.

This directory only holds **portable, non-secret** snippets safe to push to
a public/private remote. If a snippet needs secrets, load them via `~/.env`
(git-ignored) instead.

## Adding a new snippet

1. Create `zsh/<topic>.zsh` with a top comment explaining what and why.
2. Verify with `source zsh/<topic>.zsh` in a new shell — no errors.
3. Commit. The `for` loop in `~/.zshrc` picks it up on next shell startup.
