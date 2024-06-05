return {
  {
    'nvimdev/indentmini.nvim',
    event = 'BufEnter',
    config = function()
      require('indentmini').setup()
      -- use comment color
      -- vim.cmd.highlight('default link IndentLine Comment')

      -- There is no default value.
      vim.cmd.highlight('IndentLine guifg=#424242')
      -- Current indent line highlight
      vim.cmd.highlight('IndentLineCurrent guifg=#949596')
    end,
  },
}
