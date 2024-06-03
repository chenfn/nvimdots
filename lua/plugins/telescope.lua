return {
  'nvim-telescope/telescope.nvim',
  cmd = "Telescope",
  version = false,
  dependencies = {
    {'nvim-lua/plenary.nvim'},
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  keys = {
    { "<leader>/",  "<cmd>Telescope live_grep<cr>", desc="Grep (Root Dir)" },  -- find grep
    { "<leader>?",  "<cmd>Telescope keymaps<cr>", desc="Key Bindings" },    -- show key bindings list
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc="Find Files" }, -- find file by name
    { "<leader>ft", "<cmd>Telescope treesitter<cr>", desc="Treesitter" }, -- find symbols in buffer
    { "<leader>fb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc="Buffer" }, -- current buffer
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc="Recent" }, -- find history
    { "<leader>bl", "<cmd>Telescope buffers<cr>", desc="Buffer List" },  -- buffer list
  },
  config = function(_, opts)
    local telescope = require('telescope')
    local actions = require('telescope.actions')

    local command = vim.api.nvim_create_user_command
    command('TGrep', function(input)
      require('telescope.builtin').grep_string({search = input.args})
    end, {nargs = 1})

    local function defaults(title)
      return {
        prompt_title = title,
        results_title = false
      }
    end

    local function dropdown(title, previewer)
      return {
        prompt_title = title,
        previewer = previewer or false,
        theme = 'dropdown'
      }
    end


    require('telescope').setup {
      defaults = {
        mappings = {
          i = {
            ['<esc>'] = actions.close,
            ['<M-k>'] = actions.move_selection_previous,
            ['<M-j>'] = actions.move_selection_next,
            ['<M-b>'] = actions.select_default,
          }
        },

        -- Default layout options
        prompt_prefix = ' ',
        selection_caret = '❯ ',
        layout_strategy = 'vertical',
        sorting_strategy = 'ascending',
        layout_config = {
          preview_cutoff = 25,
          mirror = true,
          prompt_position = 'top'
        },
      },
      pickers = {
        buffers = dropdown(),
        find_files = dropdown(),
        oldfiles = dropdown('History'),
        keymaps = dropdown(),
        command_history = dropdown(),
        colorscheme = dropdown(),

        grep_string = defaults('Search'),
        treesitter = defaults('Buffer Symbols'),
        current_buffer_fuzzy_find = defaults('Lines'),
        live_grep = defaults('Grep'),

        commands = defaults(),
        help_tags = defaults(),
      },
      extensions = {
        fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                           -- the default case_mode is "smart_case"
        }
      }
    }
    require('telescope').load_extension('fzf')
  end,
}
