return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'main',
    dependencies = {
      { 'zbirenbaum/copilot.lua' },
      { 'nvim-lua/plenary.nvim' },
    },
    opts = {
      parameters = {
        model = 'gpt-4o',
      },
      question_header = '## User ',
      answer_header = '## Copilot ',
      error_header = '## Error ',
      separator = '---',
      auto_follow_cursor = false,
      show_help = false,
      prompts = {
        Explain = {
          prompt = '/COPILOT_EXPLAIN Write an explanation for the selected code.',
        },
        Review = {
          prompt = '/COPILOT_REVIEW Review the selected code for issues.',
        },
        Fix = {
          prompt = '/COPILOT_GENERATE There is an issue in this code. Rewrite the code to show a solution.',
        },
      },
    },
    config = function(_, opts)
      local chat = require 'CopilotChat'
      chat.setup(opts)

      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = 'CopilotChat: ' .. desc })
      end

      -- 1. Chat Toggle (Fenster öffnen / schließen)
      map({ 'n', 'v' }, '<leader>cc', function()
        chat.toggle()
      end, 'Toggle Chat')

      -- 2. Markierten Code direkt im Chat besprechen
      map('v', '<leader>ce', function()
        chat.ask('Explain this code', { selection = require('CopilotChat.select').visual })
      end, 'Explain Selection')

      -- 3. Inline-Diff / Code direkt umschreiben lassen
      map({ 'n', 'v' }, '<leader>cr', function()
        chat.toggle {
          window = {
            layout = 'float',
            title = 'Copilot Prompt',
          },
        }
      end, 'Review / Fix Prompt')
    end,
  },
}
