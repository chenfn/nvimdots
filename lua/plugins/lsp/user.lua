local M = {}

function M.lspconfig(lsp)
  lsp.extend_lspconfig()

  lsp.on_attach(M.lsp_attach)

  lsp.set_server_config({
    single_file_support = false,
    root_dir = function()
      return vim.fn.getcwd()
    end,
  })

  lsp.store_config('tsserver', {
    settings = {
      completions = {
        completeFunctionCalls = true
      }
    }
  })

  local configs = require('lspconfig.configs')

  configs.nvim_lua = {
    default_config = lsp.nvim_lua_ls({
      cmd = {'lua-language-server'},
      filetypes = {'lua'},
    })
  }
end

function M.lsp_attach(_, bufnr)
  local telescope = require('telescope.builtin')
  local lsp = vim.lsp.buf
  local bind = vim.keymap.set
  local command = vim.api.nvim_buf_create_user_command

  command(0, 'LspFormat', function(input)
    vim.lsp.buf.format({async = input.bang})
  end, {})

  local opts = {silent = true, buffer = bufnr}

  bind({'n', 'x'}, 'gq', '<cmd>LspFormat!<cr>', opts)

  bind('n', 'K', lsp.hover, opts)
  bind('n', 'gd', lsp.definition, opts)
  bind('n', 'gD', lsp.declaration, opts)
  bind('n', 'gi', lsp.implementation, opts)
  bind('n', 'go', lsp.type_definition, opts)
  bind('n', 'gr', lsp.references, opts)
  bind('n', 'gs', lsp.signature_help, opts)
  bind('n', '<F2>', lsp.rename, opts)
  bind('n', '<F4>', lsp.code_action, opts)

  bind('n', 'gl', vim.diagnostic.open_float, opts)
  bind('n', '[d', vim.diagnostic.goto_prev, opts)
  bind('n', ']d', vim.diagnostic.goto_next, opts)

  bind('n', '<leader>fd', telescope.lsp_document_symbols, opts)
  bind('n', '<leader>fq', telescope.lsp_workspace_symbols, opts)
end

function M.diagnostics(lsp)
  local augroup = vim.api.nvim_create_augroup
  local autocmd = vim.api.nvim_create_autocmd

  lsp.set_sign_icons({
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = '»'
  })

  vim.diagnostic.config({
    virtual_text = false,
  })

  local group = augroup('diagnostic_cmds', {clear = true})

  autocmd('ModeChanged', {
    group = group,
    pattern = {'n:i', 'v:s'},
    desc = 'Disable diagnostics while typing',
    callback = function(e) vim.diagnostic.disable(e.buf) end
  })

  autocmd('ModeChanged', {
    group = group,
    pattern = 'i:n',
    desc = 'Enable diagnostics when leaving insert mode',
    callback = function(e) vim.diagnostic.enable(e.buf) end
  })
end

return M