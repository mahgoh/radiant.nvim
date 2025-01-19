# radiant.nvim
`radiant.nvim` adds language support for Radiant for Neovim (experimental).

## Features
- Registers `.rad` filetype
- Language server
- Treesitter parser with highlights
- User commands to generate and deploy

## Requirements
- Neovim >= 0.10.0
- `rad` and `radls` in your PATH

## Installation
[lazy.nvim](https://github.com/folke/lazy.nvim):
```lua
{
    "mahgoh/radiant.nvim",
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
}
```
