
return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  opts = {
    formatters_by_ft = {
      -- Conform will use the first available formatter in the list
      -- Formatters can also be specified with additional options
      lua = { "stylua" },
      go = {
        "gofumpt",
        "goimports",
      },
      html = { "prettierd" },
      json = { "prettierd" },
      jsonc = { "prettierd" },
      rust = { "rustfmt" },
      bash = { "shfmt" },
      javascript = { "prettierd" },
      typescript = { "prettierd" },
      javascriptreact = { "prettierd" },
      typescriptreact = { "prettierd" },
      vue = { "prettierd" },
      python = {
        "isort",
        "black",
        "ruff"
      },
      markdown = {
        "prettierd",
        "markdownlint",
      },
    },
  }
}
