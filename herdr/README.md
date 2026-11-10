# herdr + Ghostty

Terminal setup: [herdr](https://herdr.dev) (a TUI multiplexer for coding agents) on top of Ghostty, with the dark Ayu theme.

## Contents

```
herdr/
├── config.toml       # theme, sidebar, keybindings, Claude limits in the tab bar
├── claude-usage.sh   # prints "Claude 5h 7% · 3h7m │ week 33% · 4h47m" for tab_bar_right
└── README.md
ghostty/
└── config.ghostty    # theme = Ayu, window padding, herdr-agent-usage icon font
```

The files live in this repository and are symlinked to the locations the apps expect:

| In the repo | Symlink |
|---|---|
| `herdr/config.toml` | `~/.config/herdr/config.toml` |
| `herdr/claude-usage.sh` | `~/.config/herdr/claude-usage.sh` |
| `ghostty/config.ghostty` | `~/Library/Application Support/com.mitchellh.ghostty/config.ghostty` |

## What is configured and why

- **Theme.** herdr uses `name = "terminal"`, so it takes its colors from the Ghostty theme (`theme = Ayu`).
  Overrides in `[theme.custom]`:
  - sidebar `#11151C`, slightly lighter than the `#0B0E14` background;
  - accent `#E6B450`;
  - selection `#1C212B`, the same hue as the sidebar;
  - `panel_bg = #131721`, which lightens the tab bar (herdr has no separate token for it).
- **Ghostty.** `window-padding-color = extend-always`, `window-padding-balance` and
  `window-step-resize` remove the dark strip at the bottom of the window.
- **Sidebar.** Width 36 (32–48), space and agent rows as on herdr.dev, `row_gap = 1`.
  The Claude agent row (`rows_by_agent.claude`) is custom: status, then session title (bright),
  then model (muted), then context (grey, yellow or red when running low).
  It has no `# herdr-agent-usage-provider` marker, so the plugin does not overwrite it.
- **Claude limits** appear once, on the right of the tab bar (`tab_bar_right` → `claude-usage.sh`),
  instead of on every agent row. The data comes from the herdr-agent-usage plugin cache.
- **Keybindings.** Prefix `ctrl+b`, plus direct `ctrl+shift+…` chords for agents and spaces.

## Setup on a new machine

1. Create the symlinks:

   ```sh
   D=~/github.com/dotfiles
   mkdir -p ~/.config/herdr "$HOME/Library/Application Support/com.mitchellh.ghostty"
   ln -sf $D/herdr/config.toml ~/.config/herdr/config.toml
   ln -sf $D/herdr/claude-usage.sh ~/.config/herdr/claude-usage.sh
   ln -sf $D/ghostty/config.ghostty "$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"
   ```

2. Install the [herdr-agent-usage](https://github.com/levi-qiao/herdr-agent-usage) plugin for limits.
   Use the `levi-qiao` repository: another repository has the same name.
   It needs Rust 1.95+. Homebrew no longer updates Rust on Intel Macs, so install rustup without touching PATH:

   ```sh
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path --profile minimal --default-toolchain none
   git clone https://github.com/levi-qiao/herdr-agent-usage.git ~/github.com/herdr-agent-usage
   cd ~/github.com/herdr-agent-usage
   PATH="$HOME/.cargo/bin:$PATH" ./install.sh --agent claude,codex,opencode
   ```

   The installer:
   - adds sidebar rows and keybindings to `config.toml` (it does not duplicate rows that are already there);
   - replaces `statusLine` in `~/.claude/settings.json`;
   - copies the icon font to `~/Library/Fonts` and adds `font-codepoint-map` to the Ghostty config.

   In the plugin settings (`ctrl+b`, then `shift+q`), set the fields to `provider,topic,model,context`.
   Leave out 5h/7d/30d, since they are shown in the tab bar. Press `a` to apply.

3. Connect the other herdr plugins separately:
   - `herdr-navigator`: `github:thanhdat77/herdr-navigator`
   - `rs.linear-kickoff`: local, `~/personal/herdr-linear-kickoff`

4. Apply the config:

   ```sh
   herdr server reload-config
   ```

   In Ghostty, press `Cmd+Shift+,`. Window settings only apply to a new window (`Cmd+N`).

5. Claude Code: the grey background of your messages comes from the Claude Code theme, not from herdr.
   To match Ayu, pick `/theme` → "Dark mode (ANSI colors only)".

## Notes

- herdr-agent-usage writes `config.toml` with `fs::write`, which follows the symlink.
  The plugin's changes land in this repository, so check `git diff` after plugin updates.
- `herdr config reset-keys` and similar commands may replace the file instead of the symlink.
  To check: `ls -la ~/.config/herdr/config.toml`.
