-- https://github.com/ahmedkhalf/project.nvim

return {
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup {
      patterns = {
        ".git",
        "Project.toml",
        "Cargo.toml",
        "build.zig"
      },

      silent_chdir = true, -- false makes this useful but annoying
    }
    require('telescope').load_extension('projects')
  end,
}
