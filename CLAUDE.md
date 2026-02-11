# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Neovim configuration using lazy.nvim as the plugin manager. All configuration is in Lua. Minimal fullstack setup for TypeScript, Python, and Lua development.

## Architecture

**Entry point:** `init.lua` — sets leader key (space), bootstraps lazy.nvim, loads config modules in order: settings → keymaps → autocmds.

**Core config** (`lua/config/`):
- `settings.lua` — editor options, diagnostics, folding
- `keymaps.lua` — global keybindings (mnemonic groups: `<leader>f*` find, `<leader>g*` git, `<leader>l*` LSP, `<leader>d*` diagnostics, `<leader>h*` hunks)
- `autocmds.lua` — autocmds for yank highlight, window resize, last location, close-with-q

**Plugins** (`lua/plugins/`): Each plugin has its own file returning a lazy.nvim spec table. Key plugins:
- `fzf.lua` — fzf-lua fuzzy finder (files, grep, buffers, git, diagnostics)
- `oil.lua` — oil.nvim file explorer
- `lsp.lua` — nvim-lspconfig + mason + lazydev (servers: ts_ls, eslint, pyright, ruff, lua_ls, jsonls, cssls)
- `completions.lua` — blink.cmp completion engine with Copilot source
- `formatting.lua` — conform.nvim (stylua, prettier, ruff)
- `treesitter.lua` — nvim-treesitter for syntax highlighting
- `theme.lua` — tokyonight colorscheme
- `git.lua` — gitsigns
- `copilot.lua` — GitHub Copilot inline suggestions
- `which-key.lua` — keymap discovery popup
- `mini.lua` — mini.nvim (pairs, surround, comment, icons)

## Conventions

- **Lua style:** 2-space indentation, 120-column width (enforced by `stylua.toml`)
- **Plugin specs:** one file per plugin in `lua/plugins/`, return a table (or list of tables)
- **Lazy loading:** high-priority plugins set `priority = 1000`; others load on events (`VeryLazy`, `InsertEnter`, `BufReadPre`)
- **Keymaps:** always include a `desc` field for which-key integration
- **Leader key:** space; all custom bindings use `<leader>` prefix

## Formatting

Lua files are formatted with stylua. Run: `stylua lua/`
