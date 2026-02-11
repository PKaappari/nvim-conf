# Neovim Keymappings

Leader key: `Space`

## General

| Key | Description |
|-----|-------------|
| `Esc` | Clear search highlight |
| `J` (normal) | Join lines (keep cursor position) |
| `J` (visual) | Move selection down |
| `K` (visual) | Move selection up |
| `p` (visual) | Paste without overwriting register |

## Navigation

| Key | Description |
|-----|-------------|
| `Ctrl+h/j/k/l` | Move between windows |
| `Alt+h` | Previous buffer |
| `Alt+l` | Next buffer |
| `Alt+k` | Previous tab |
| `Alt+j` | Next tab |
| `Ctrl+o` | Jump back |
| `Ctrl+i` | Jump forward |

## Window Resize

| Key | Description |
|-----|-------------|
| `Ctrl+Up/Down` | Increase/decrease window height |
| `Ctrl+Left/Right` | Decrease/increase window width |

## Find (Snacks Picker)

| Key | Description |
|-----|-------------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Find buffers |
| `<leader>fh` | Find help |
| `<leader>fr` | Resume last picker |
| `<leader>fw` | Grep word under cursor |
| `<leader>fo` | Recent files |
| `<leader>fi` | Find icon |

## LSP

| Key | Description |
|-----|-------------|
| `gd` / `<leader>ld` | Go to definition |
| `gr` / `<leader>lr` | References |
| `<leader>lD` | Go to declaration |
| `<leader>li` | Implementation |
| `<leader>lt` | Type definition |
| `<leader>la` | Code action |
| `<leader>lh` / `K` | Hover |
| `<leader>ls` | Signature help |
| `<leader>ln` | Rename file |
| `rn` | Rename symbol |

## Diagnostics

| Key | Description |
|-----|-------------|
| `[d` / `]d` | Previous/next diagnostic |
| `<leader>dd` | Document diagnostics |
| `<leader>dw` | Workspace diagnostics |

## Quickfix

| Key | Description |
|-----|-------------|
| `[q` / `]q` | Previous/next quickfix item |

## Git

| Key | Description |
|-----|-------------|
| `<leader>gg` | Lazygit |
| `<leader>gs` | Git status |
| `<leader>gb` | Git branches |
| `<leader>gl` | Git log |

## Git Hunks (Gitsigns)

| Key | Description |
|-----|-------------|
| `]h` / `[h` | Next/previous hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hu` | Undo stage hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |
| `<leader>hd` | Diff this |

## Buffers

| Key | Description |
|-----|-------------|
| `<leader>bd` | Delete buffer |
| `<leader>bo` | Delete other buffers |
| `<leader>ba` | Delete all buffers |

## Treesitter Text Objects

### Select (use with operators like `d`, `c`, `y`, `v`)

| Key | Description |
|-----|-------------|
| `af` / `if` | Around/inside function |
| `ac` / `ic` | Around/inside class |
| `aa` / `ia` | Around/inside argument |
| `ai` / `ii` | Around/inside conditional |
| `al` / `il` | Around/inside loop |

### Move

| Key | Description |
|-----|-------------|
| `]f` / `[f` | Next/previous function start |
| `]F` / `[F` | Next/previous function end |
| `]c` / `[c` | Next/previous class start |
| `]C` / `[C` | Next/previous class end |
| `]a` / `[a` | Next/previous argument |

### Swap

| Key | Description |
|-----|-------------|
| `<leader>a` | Swap with next argument |
| `<leader>A` | Swap with previous argument |

## Other

| Key | Description |
|-----|-------------|
| `<leader><CR>` | Toggle terminal |
| `-` | Open file explorer (oil.nvim) |
