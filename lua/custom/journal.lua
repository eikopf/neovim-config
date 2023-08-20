-- this module provides functionality for using
-- a folder of markdown files as a journal

-- a lot of the date functionality here is taken from
-- renerocksai's telekasten.nvim.

local date = require("custom.utils.dates")

local M = {} -- init module

M.journal_dir = "~/journal"

local function as_markdown_path(filename)
  return M.journal_dir .. "/" .. filename .. ".md"
end

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

return M -- return module
