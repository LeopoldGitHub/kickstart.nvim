local M = {}
M.dirFinder = function()
  local ok_builtin, builtin = pcall(require, 'telescope.builtin')
  local ok_oil, oil = pcall(require, 'oil')
  local ok_devicons, devicons = pcall(require, 'nvim-web-devicons')
  local previewers = require 'telescope.previewers'
  if not ok_builtin or not ok_oil then
    return
  end

  local entry_display = require 'telescope.pickers.entry_display'

  builtin.find_files {
    prompt_title = 'Find Dirs',
    cwd = vim.fn.getcwd(),
    -- Removed '--type d' to find both files and folders
    find_command = { 'fd', '--type', 'd', '--hidden', '--exclude', '.git', '--exclude', '.github' },
    previewer = previewers.new_buffer_previewer {
      title = 'Preview',
      define_preview = function(self, entry, status)
        local full_path = vim.fn.getcwd() .. '/' .. entry.value

        if vim.fn.isdirectory(full_path) == 1 then
          -- 1. Get the list. '-p' adds a '/' to the end of directories
          local lines = vim.fn.systemlist('ls -pa --group-directories-first ' .. full_path)
          vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)

          -- 2. Smart Highlighting: Loop through lines and color only dirs
          for i, line in ipairs(lines) do
            if line:sub(-1) == '/' then
              vim.api.nvim_buf_add_highlight(self.state.bufnr, -1, 'Directory', i - 1, 0, -1)
            end
          end
        else
          -- Standard file preview
          require('telescope.previewers.utils').buffer_previewer_utils.repository_files_previewer(entry, self.state.bufnr)
        end
      end,
    },
    entry_maker = function(entry)
      local is_dir = vim.fn.isdirectory(entry) == 0
      local displayer = entry_display.create {
        separator = ' ',
        items = {
          { width = 1 },
          { remaining = true },
        },
      }

      local make_display = function(ent)
        local icon, icon_highlight
        if is_dir then
          icon = ''
          icon_highlight = 'Directory'
        else
          -- Get the standard file icon based on extension
          icon, icon_highlight = devicons.get_icon(ent.value, string.match(ent.value, '%l+$'), { default = true })
        end

        return displayer {
          { icon, icon_highlight },
          ent.value,
        }
      end

      return {
        value = entry,
        display = make_display,
        ordinal = entry,
        is_dir = is_dir, -- Store the type for the action later
      }
    end,

    attach_mappings = function(prompt_bufnr, map)
      local actions = require 'telescope.actions'
      local action_state = require 'telescope.actions.state'

      map('i', '<CR>', function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        if selection then
          local full_path = vim.fn.getcwd() .. '/' .. selection.value

          if selection.is_dir then
            -- If it's a directory, open Oil
            oil.open(full_path)
          else
            -- If it's a file, open it normally in a buffer
            vim.cmd('edit ' .. vim.fn.fnameescape(full_path))
          end
        end
      end)
      return true
    end,
  }
end
return M
