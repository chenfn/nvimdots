local check_file_size = function(_, bufnr)
  return vim.api.nvim_buf_line_count(bufnr) > 100000
end

return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "VeryLazy" },
  version = false, -- last release is way too old and doesn't work on Windows
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag", -- Automatically end & rename tags
    "nvim-treesitter/playground",
  },
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "css",
      "cmake",
      "cpp",
      "comment",
      "diff",
      "dockerfile",
      "git_config",
      "git_rebase",
      "gitattributes",
      "gitcommit",
      "gitignore",
      "go",
      "gomod",
      "gosum",
      "gowork",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "jsonc",
      "lua",
      "luadoc",
      "luap",
      "make",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "regex",
      "toml",
      "tsx",
      "typescript",
      "vue",
      "vim",
      "vimdoc",
      "scss",
      "sql",
      "rust",
      "yaml",
      "zig",
    },
    highlight = {
      enable = true,
      use_languagetree = true,
      disable = check_file_size,
    },
    indent = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<CR>",
        node_incremental = "<CR>",
        node_decremental = "<BS>",
        scope_incremental = "<TAB>",
      },
    },
    playground = {
      enable = false,
      disable = {},
      updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
    },
    autotag = {
      enable = true,
      disable = check_file_size,
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
