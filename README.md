# Lazy Template

Base configuration for Neovim. For those looking to make Neovim their new main editor. Here you'll find a popular combination of plugin to make your experience a little bit better.

A few things have been configured to resemble other modern text editors. You'll find a file explorer with tree style view, list open files in tabs, git integration and a terminal easy to toggle.

Autocompletion and "code intellisense" is provided by the LSP client built into Neovim. This means if you want smart completion and error detection for a programming language you'll need to install a [language server](#about-language-servers).

## Requirements

* Neovim v0.10 or greater is recommended.
  * v0.9.5 is the minimum required.
  * v0.11 is the latest stable version.
* git.
* A `C` compiler. Can be `gcc`, `tcc` or `zig`.
* (optional) A patched font to display icons. I hear [nerdfonts](https://www.nerdfonts.com/) has a good collection.
* (optional) [ripgrep](https://github.com/BurntSushi/ripgrep). Improves project wide search speed.
* (optional) [fd](https://github.com/sharkdp/fd). Improves file search speed.

### Note for windows users

If you need a `C` compiler then `zig` is the easiest to install. It's available on `winget`, `scoop` and `chocolatey`. You can also find some links in the [zig download page](https://ziglang.org/download/). 

## Installation

* Clone this repository in Neovim's configuration folder.

  If you don't know the location of that folder, use this command in your terminal.

  ```sh
  nvim --headless -c 'echo stdpath("config") | echo "" | quit'
  ```

* After you cloned the repository in Neovim's folder, start Neovim using this command in your terminal.

  ```sh
  nvim
  ```

  The plugin manager will be installed automatically. And then all the plugins will be installed.

## About language servers

They are external programs that provide IDE-like features to Neovim. If you want to know more about language servers watch this wonderful 5 minutes video: [LSP explained](https://www.youtube.com/watch?v=LaS32vctfOY).

In this configuration there is a plugin that will help you install language servers: `mason-lspconfig`. If you execute the command `:LspInstall` while you are inside a file then `mason-lspconfig` will suggest a list of language servers that support that particular type of file.

Keep in mind you need to meet the requirements of the language servers. For example, if you want to download the language server for the `go` programming language then you need to have `go` installed in your system. If you want to download a language server written in javascript you'll need NodeJS.

## Learn more about the plugin manager

`lazy.nvim` is the plugin manager used in this configuration. Here are a few resources that will help you understand some of it's features:

* [Lazy.nvim: plugin configuration](https://dev.to/vonheikemen/lazynvim-plugin-configuration-3opi). Here you'll learn about the "plugin spec" and how to split your plugin setup into multiple files.

* [Lazy.nvim: how to revert a plugin back to a previous version](https://dev.to/vonheikemen/lazynvim-how-to-revert-a-plugin-back-to-a-previous-version-1pdp). Learn how to recover from a bad plugin update.

## Keybindings

Leader key: `Space`.

| Mode     | Key               | Action                                                          |
| ---      | ---               | ---                                                             |
| Normal   | `<leader>h`       | Go to first non empty character in line.                        |
| Normal   | `<leader>l`       | Go to last non empty character in line.                         |
| Normal   | `<leader>a`       | Select all text.                                                |
| Normal   | `gy`              | Copy selected text to clipboard.                                |
| Normal   | `gp`              | Paste clipboard content.                                        |
| Normal   | `<leader>w`       | Save file.                                                      |
| Normal   | `<leader>qq`      | Exit Neovim.                                                    |
| Normal   | `<leader>bq`      | Close current buffer.                                           |
| Normal   | `<leader>bc`      | Close current buffer while preserving the window layout.        |
| Normal   | `<leader>bl`      | Go to last active buffer.                                       |
| Normal   | `<leader><space>` | Search open buffers.                                            |
| Normal   | `<leader>ff`      | Find file in current working directory.                         |
| Normal   | `<leader>fh`      | Search oldfiles history.                                        |
| Normal   | `<leader>fg`      | Search pattern in current working directory.                    |
| Normal   | `<leader>fd`      | Search diagnostics in current file.                             |
| Normal   | `<leader>fs`      | Search pattern in current file.                                 |
| Normal   | `<leader>u`       | Search undo history.                                            |
| Normal   | `<leader>?`       | Search keymaps.                                                 |
| Normal   | `<leader>/`       | Search snack pickers.                                           |
| Normal   | `<leader>e`       | Open file explorer.                                             |
| Normal   | `<leader>ui`      | Toggle indent guide lines.                                      |
| Normal   | `<Ctrl-g>`        | Toggle a terminal window.                                       |
| Normal   | `gw`              | Begin a 2 character jump.                                       |
| Normal   | `gcc`             | Toggle comment in current line.                                 |
| Operator | `gc`              | Toggle comment in text.                                         |
| Operator | `sa`              | Add surrounding.                                                |
| Normal   | `sd`              | Delete surrounding.                                             |
| Normal   | `sr`              | Surround replace.                                               |
| Normal   | `sf`              | Find surrounding.                                               |
| Normal   | `sb`              | Pick a visible tab.                                             |
| Insert   | `<Ctrl-j>`        | Expand snippet trigger.                                         |
| Insert   | `<Ctrl-h>`        | Go to previous snippet tabstop.                                 |
| Insert   | `<Ctrl-l>`        | Go to next snippet tabstop.                                     |
| Normal   | `K`               | Displays hover information about the symbol under the cursor.   |
| Normal   | `gd`              | Jump to the definition.                                         |
| Normal   | `gq`              | Format code in current buffer.                                  |
| Normal   | `gO`              | Lists symbols in the current buffer.                            |
| Normal   | `<C-s>`           | Displays a function's signature information.                    |
| Normal   | `gri`             | Lists all the implementations for the symbol under the cursor.  |
| Normal   | `grr`             | Lists all the references.                                       |
| Normal   | `grn`             | Renames all references to the symbol under the cursor.          |
| Normal   | `gra`             | Selects a code action available at the current cursor position. |
| Normal   | `grd`             | Jump to declaration.                                            |
| Normal   | `grt`             | Jumps to the definition of the type symbol                      |
| Normal   | `<Ctrl-w>d`       | Show diagnostics in a floating window.                          |
| Normal   | `[d`              | Move to the previous diagnostic.                                |
| Normal   | `]d`              | Move to the next diagnostic.                                    |

### Autocomplete keybindings

| Mode   | Key           | Action                                                                   |
| ---    | ---           | ---                                                                      |
| Insert | `<Up>`        | Move to previous item.                                                   |
| Insert | `<Down>`      | Move to next item.                                                       |
| Insert | `<Ctrl-p>`    | Move to previous item.                                                   |
| Insert | `<Ctrl-n>`    | Move to next item.                                                       |
| Insert | `<Ctrl-u>`    | Scroll up in documentation window.                                       |
| Insert | `<Ctrl-d>`    | Scroll down in documentation window.                                     |
| Insert | `<Ctrl-e>`    | Cancel completion.                                                       |
| Insert | `<C-y>`       | Confirm completion.                                                      |
| Insert | `<Enter>`     | Confirm completion.                                                      |
| Insert | `<Tab>`       | If completion menu is open, go to next item. Else, open completion menu. |
| Insert | `<Shift-Tab>` | If completion menu is open, go to previous item.                         |

## Plugin list

| Name                                                                                            | Description                                                           |
| ---                                                                                             | ---                                                                   |
| [lazy.nvim](https://github.com/folke/lazy.nvim)                                                 | Plugin manager.                                                       |
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)                                     | Collection of colorscheme for Neovim.                                 |
| [snacks.nvim](https://github.com/folke/snacks.nvim)                                             | Collection of QoL plugins.                                            |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim)                                   | Pretty tabline.                                                       |
| [mini.nvim](https://github.com/echasnovski/mini.nvim)                                           | Collection of independent lua modules that enhance Neovim's features. |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)                                     | Shows indicators in gutter based on file changes detected by git.     |
| [vim-fugitive](https://github.com/tpope/vim-fugitive)                                           | Git integration into Neovim/Vim.                                      |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)                           | Configures treesitter parsers. Provides modules to manipulate code.   |
| [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)   | Creates textobjects based on treesitter queries.                      |
| [vim-repeat](https://github.com/tpope/vim-repeat)                                               | Add "repeat" support for plugins.                                     |
| [mason.nvim](https://github.com/williamboman/mason.nvim)                                        | Portable package manager for Neovim.                                  |
| [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)                    | Integrates nvim-lspconfig and mason.nvim.                             |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)                                      | Quickstart configs for Neovim's LSP client.                           |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)                                                 | Autocompletion engine.                                                |
| [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)                                             | nvim-cmp source. Suggest words in the current buffer.                 |
| [cmp-path](https://github.com/hrsh7th/cmp-path)                                                 | nvim-cmp source. Show suggestions based on file system paths.         |
| [cmp-mini-snippets](https://github.com/abeldekat/cmp-mini-snippets)                             | nvim-cmp source. Show suggestions based on installed snippets.        |
| [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)                                         | nvim-cmp source. Show suggestions based on LSP servers queries.       |
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)                            | Collection of snippets.                                               |
| [nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring) | It helps detect comment syntax.                                       |

