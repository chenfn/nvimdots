return {
  {
    'neovim/nvim-lspconfig',
    cmd = "Lsp",
    event = "BufReadPre",
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
      "mason.nvim",
      {'williamboman/mason-lspconfig.nvim'},
      {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
    },
    init = function()
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0

      -- disable lsp semantic highlights
      vim.api.nvim_create_autocmd('ColorScheme', {
        desc = 'Clear LSP highlight groups',
        callback = function()
          local higroups = vim.fn.getcompletion('@lsp', 'highlight')
          for _, name in ipairs(higroups) do
            vim.api.nvim_set_hl(0, name, {})
          end
        end,
      })
    end,
    config = function()
      local lz = require('lsp-zero')
      local user = require("plugins.lsp.user")

      user.lspconfig(lz)
      user.diagnostics(lz)

      require('mason-lspconfig').setup({"lua_ls"})

      vim.api.nvim_create_user_command(
        'Lsp',
        function(input)
          if input.args == '' then
            return
          end

          lz.use(input.args, {})
        end,
        {desc = 'Initialize a language server', nargs = '?'}
      )

      require('lsp-zero').use('nvim_lua', {})
    end
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = 'rounded'
      }
    }
  },
}
