return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      panel = {
        enabled = false,
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = '<M-l>', -- Alt + l to accept suggestion
          accept_word = false,
          accept_line = false,
          next = '<M-]>', -- Alt + ] for next suggestion
          prev = '<M-[>', -- Alt + [ for previous suggestion
          dismiss = '<C-]>', -- Ctrl + ] to dismiss
        },
      },
      filetypes = {
        yaml = true,
        markdown = true,
        terraform = true,
        hcl = true,
        help = false,
        gitcommit = false,
        gitrebase = false,
        ['.'] = false,
      },
    }
  end,
}
