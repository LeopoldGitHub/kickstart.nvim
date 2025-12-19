return {
  'tpope/vim-fugitive',
  config = function()
    -- Keymaps for easier access
    vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = 'Git Status' })
    vim.keymap.set('n', '<leader>gp', function()
      vim.cmd.Git 'push'
    end, { desc = 'Git Push' })

    -- Command to handle merge conflicts easily
    vim.keymap.set('n', 'gu', '<cmd>diffget //2<CR>', { desc = 'Git Diff Get Target (Left)' })
    vim.keymap.set('n', 'gh', '<cmd>diffget //3<CR>', { desc = 'Git Diff Get Merge (Right)' })
  end,
}
