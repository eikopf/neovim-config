-- this file does *not* concern the project.nvim plugin; it is
-- reserved for custom functions and code related to project management,
-- centering around a single `projects_dir` folder.

local M = {} -- init module

-- define global projects folder
M.projects_dir = "/Users/oliver/projects"

-- this function takes user input and tries
-- to create a new folder in M.projects_dir.
-- if it succeeds then we move into that dir,
-- and register it with projects.nvim.
function M.new_project_prompt()
  vim.ui.input({
    prompt = "mkdir in " .. M.projects_dir .. ": ",
    default = "untitled-project",
    completion = nil,
  }, function(input)
      if input == nil then
        return
      end
      local path = M.projects_dir .. '/' .. input
      local result = vim.fn.mkdir(path)
      if result == 1 then
        require("oil").open(path)
      end
    end)
end

-- same as above, but with a parameter
function M.new_project(opts)
  if opts == nil then
    return
  end
  local path = M.projects_dir .. '/' .. opts.fargs[1]
  local result = vim.fn.mkdir(path)
  if result == 1 then
    require("oil").open(path)
  end
end

-- register global commands
vim.api.nvim_create_user_command(
  'NewProject',
  M.new_project,
  { desc = "Creates a project folder in the defined projects_dir", nargs='?' }
)
vim.api.nvim_create_user_command('NewProjectPrompt', M.new_project_prompt, {})

return M
