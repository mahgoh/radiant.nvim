local augroup = vim.api.nvim_create_augroup("Radiant", { clear = true })

local function add_filetype()
  vim.filetype.add({
    extension = {
      rad = "radiant"
    }
  })
end

local function register_lsp()
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'radiant',
    callback = function(_args)
      vim.lsp.start({
        name = 'radiant-lsp',
        cmd = { 'radls', '--stdio' }
      })
    end,
  })
end

local function register_user_commands()
  vim.api.nvim_create_user_command(
    'RadiantGenerate',
    ':!rad generate %',
    {}
  )

  vim.api.nvim_create_user_command(
    'RadiantDeploy',
    ':!rad deploy %',
    {}
  )

  vim.api.nvim_create_user_command(
    'RadiantDeployDry',
    ':!rad deploy % --dry-run',
    {}
  )
end

local function setup_treesitter()
  local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
  parser_config.radiant = {
    install_info = {
      url = 'https://github.com/mahgoh/tree-sitter-radiant',
      files = { "src/parser.c" },           -- note that some parsers also require src/scanner.c or src/scanner.cc
      branch = "main",                      -- default branch in case of git repo if different from master
      generate_requires_npm = false,        -- if stand-alone parser without npm dependencies
      requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
    },
    filetype = "radiant",                   -- if filetype does not match the parser name
  }
end

local function main()
  add_filetype()
  register_user_commands()
  register_lsp()
  setup_treesitter()
end

local function setup()
  vim.api.nvim_create_autocmd("VimEnter",
    {
      group = augroup,
      desc = "Language support for Radiant",
      once = true,
      callback = main
    }
  )
end

return { setup = setup }
