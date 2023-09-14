-- this module provides functionality for using
-- a folder of markdown files as daily/weekly notes

-- a lot of the date functionality here is taken from
-- renerocksai's telekasten.nvim.

local date = require("custom.utils.dates")
local telescope = require("telescope.builtin")

local M = {} -- init module

-- module constants
M.dir = "~/notes"

-- helper functions
local function as_markdown_path(filename)
  return M.dir .. "/" .. filename .. ".md"
end

-- module functions
M.get_today_path = function()
  return as_markdown_path(date.calculate_dates(nil, 1).date)
end

M.get_yesterday_path = function()
  return as_markdown_path(date.calculate_dates(nil, 1).prevday)
end

M.get_tomorrow_path = function()
  return as_markdown_path(date.calculate_dates(nil, 1).nextday)
end

M.get_week_path = function()
  return as_markdown_path(date.calculate_dates(nil, 1).isoweek)
end

M.get_previous_week_path = function()
  return as_markdown_path(date.calculate_dates(nil, 1).isonextweek)
end

M.get_next_week_path = function()
  return as_markdown_path(date.calculate_dates(nil, 1).isoprevweek)
end

M.search_notes = function()
  telescope.find_files({ search_dirs = {M.dir} })
end

M.grep_notes = function()
  telescope.live_grep({ search_dirs = {M.dir} })
end

M.search_weeks = function()
  telescope.find_files({ search_dirs = {M.dir}, search_file = "-W"})
end

M.grep_weeks = function()
  telescope.live_grep({ search_dirs = {M.dir}, glob_pattern = "*-W*.md", "--glob" })
end

-- lists path functions with corresponding canonical names
local path_functions = {
  { M.get_today_path, "Today" },
  { M.get_tomorrow_path, "Tomorrow" },
  { M.get_yesterday_path, "Yesterday" },
  { M.get_week_path, "Week" },
  { M.get_next_week_path, "NextWeek" },
  { M.get_previous_week_path, "PrevWeek" },
}

-- for each path function, define corresponding user commands
for _, func in ipairs(path_functions) do
  local path_function = func[1] -- a function, not a value
  local name = func[2]

  -- define edit commands
  vim.api.nvim_create_user_command('NotesEdit' .. name, function ()
    local path = path_function()
    vim.cmd("edit " .. path)
    vim.cmd("cd " .. M.dir)
  end, {})

  -- define deletion commands
  vim.api.nvim_create_user_command('NotesRm' .. name, function ()
    local path = path_function()
    vim.cmd("silent !rm " .. path)
    print("Notes: Deleted " .. path)
  end, {})
end

vim.api.nvim_create_user_command('NotesSearchAll', M.search_notes, {})
vim.api.nvim_create_user_command('NotesSearchWeeks', M.search_weeks, {})
vim.api.nvim_create_user_command('NotesGrepAll', M.grep_notes, {})
vim.api.nvim_create_user_command('NotesGrepWeeks', M.grep_weeks, {})

return M -- return module
