local g = vim.g
local opt = vim.opt

-- #  Globals
-- ## Leader keys
g.mapleader = " "
g.maplocalleader = " "

-- #  General
opt.backup       = false          -- Don't store backup
opt.writebackup  = false          -- Don't store backup
opt.undofile     = true           -- Enable persistent undo

opt.mouse        = 'a'            -- Enable mouse
opt.mousescroll  = 'ver:25,hor:6' -- Customize mouse scroll
opt.switchbuf    = 'usetab'       -- Use already opened buffers when switching
opt.shada        = "'100,<50,s10,:1000,/100,@100,h" -- Limit what is stored in ShaDa file

vim.cmd('filetype plugin indent on') -- Enable all filetype plugins

-- # UI
opt.breakindent   = true      -- Indent wrapped lines to match line start
opt.colorcolumn   = '+1'      -- Draw colored column one step to the right of desired maximum width
opt.cursorline    = true      -- Enable highlighting of the current line
opt.laststatus    = 2         -- Always show statusline
opt.linebreak     = true      -- Wrap long lines at 'breakat' (if 'wrap' is set)
opt.list          = true      -- Show helpful character indicators
opt.number        = true      -- Show line numbers
opt.pumblend      = 10        -- Make builtin completion menus slightly transparent
opt.pumheight     = 10        -- Make popup menu smaller
opt.ruler         = false     -- Don't show cursor position
opt.shortmess     = 'aoOWFcS' -- Disable certain messages from |ins-completion-menu|
opt.showmode      = false     -- Don't show mode in command line
opt.showtabline   = 2         -- Always show tabline
opt.signcolumn    = 'yes'     -- Always show signcolumn or it would frequently shift
opt.splitbelow    = true      -- Horizontal splits will be below
opt.splitright    = true      -- Vertical splits will be to the right
opt.termguicolors = true      -- Enable gui colors
opt.winblend      = 10        -- Make floating windows slightly transparent
opt.wrap          = false     -- Display long lines as just one line

opt.fillchars = table.concat(
  { 'eob: ', 'fold:╌', 'horiz:═', 'horizdown:╦', 'horizup:╩', 'vert:║', 'verthoriz:╬', 'vertleft:╣', 'vertright:╠' },
  ','
)
opt.listchars = table.concat({ 'extends:…', 'nbsp:␣', 'precedes:…', 'tab:> ' }, ',')
opt.cursorlineopt = 'screenline,number' -- Show cursor line only screen line when wrapped

if vim.fn.has('nvim-0.9') == 1 then
  opt.shortmess:append('C')   -- Don't show "Scanning..." messages
  opt.splitkeep = 'screen'    -- Reduce scroll during window split
end

-- # Colors
if vim.fn.exists('syntax_on') ~= 1 then vim.cmd('syntax enable') end

-- # Editing
opt.autoindent    = true     -- Use auto indent
opt.expandtab     = true     -- Convert tabs to spaces
opt.formatoptions = 'rqnl1j' -- Improve comment editing
opt.ignorecase    = true     -- Ignore case when searching (use `\C` to force not doing that)
opt.incsearch     = true     -- Show search results while typing
opt.infercase     = true     -- Infer letter cases for a richer built-in keyword completion
opt.shiftwidth    = 2        -- Use this number of spaces for indentation
opt.smartcase     = true     -- Don't ignore case when searching if pattern has upper case
opt.smartindent   = true     -- Make indenting smart
opt.tabstop       = 2        -- Insert 2 spaces for a tab
opt.virtualedit   = 'block'  -- Allow going past the end of line in visual block mode

opt.iskeyword:append('-')  -- Treat dash separated words as a word text object
opt.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]

-- # Splling
opt.spelllang    = 'en,ru,uk'   -- Define spelling dictionaries
opt.spelloptions = 'camel'      -- Treat parts of camelCase words as seprate words
opt.complete:append('kspell') -- Add spellcheck options for autocomplete
opt.complete:remove('t')      -- Don't use tags for completion

opt.dictionary = vim.fn.stdpath('config') .. '/misc/dict/english.txt' -- Use specific dictionarie

