# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Neovim configuration using lazy.nvim as the plugin manager. All configuration is in Lua.

## Architecture

**Entry point:** `init.lua` — sets leader key (space), bootstraps lazy.nvim, loads config modules in order: settings → keymaps → autocommands.

**Core config** (`lua/config/`):
- `settings.lua` — editor options, diagnostics, folding, filetype detection
- `keymaps.lua` — global keybindings (mnemonic groups: `<leader>f*` find, `<leader>g*` git, `<leader>s*` search, `<leader>l*` LSP)
- `autocommands.lua` — autocmds for LSP, formatting hooks, filetype detection

**Plugins** (`lua/plugins/`): Each plugin has its own file returning a lazy.nvim spec table. Key plugins:
- `snacks.lua` — primary productivity plugin (picker, git, grep, terminal, notifications) — priority 1000
- `lsp.lua` — LSP via nvim-lspconfig + mason (servers: lua_ls, jsonls, cssls, pyright, ruff)
- `completions.lua` — blink.cmp completion engine with Copilot integration
- `typescript-tools.lua` — dedicated TypeScript LSP with import organization
- `formatting.lua` — conform.nvim (eslint_d, stylua, ruff, pretterd)
- `lint.lua` — nvim-lint (eslint_d, luacheck, markdownlint)
- `theme.lua` — Catppuccin (mocha) + lualine + bufferline
- `git.lua` — fugitive, gitsigns
- `copilot.lua` — GitHub Copilot + CopilotChat

## Conventions

- **Lua style:** 2-space indentation, 120-column width (enforced by `stylua.toml`)
- **Plugin specs:** one file per plugin in `lua/plugins/`, return a table (or list of tables)
- **Lazy loading:** high-priority plugins set `priority = 1000`; others load on events (`VeryLazy`, `InsertEnter`, `BufReadPre`)
- **Keymaps:** always include a `desc` field for which-key integration
- **Leader key:** space; all custom bindings use `<leader>` prefix

## Formatting

Lua files are formatted with stylua. Run: `stylua lua/`
