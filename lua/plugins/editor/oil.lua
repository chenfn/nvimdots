return {
  'stevearc/oil.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "-",
      function()
        require("oil").open_float()
      end,
      desc = "oil: open parent directory",
    },
    {
      "_",
      function()
        require("oil").open_float(vim.fn.getcwd())
      end,
      desc = "oil: open cwd",
    },
  },
  opts = {
    delete_to_trash = true,
    prompt_save_on_select_new_entry = false,
    restore_win_options = false,
    skip_confirm_for_simple_edits = true,
    view_options = {
      show_hidden = true,
      is_always_hidden = function(name, _)
        local always_hidden = {
          "..",
          ".git",
          "node_modules",
        }
        for _, a in ipairs(always_hidden) do
          if a == name then
            return true
          end
        end
      end,
    },
    float = {
      max_width = 60,
      max_height = 20,
    },
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<C-s>"] = "actions.select_vsplit",
      ["<C-h>"] = "actions.select_split",
      ["<C-t>"] = "actions.select_tab",
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = "actions.close",
      ["<C-l>"] = "actions.refresh",
      ["-"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = "actions.tcd",
      ["gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
      ["g\\"] = "actions.toggle_trash",
      ["gd"] = {
        desc = "toggle detail view",
        callback = function()
          local oil = require("oil")
          local config = require("oil.config")
          if #config.columns == 1 then
            oil.set_columns({ "icon", "permissions", "size", "mtime" })
          else
            oil.set_columns({ "icon" })
          end
        end,
      },
    },
  },
}
