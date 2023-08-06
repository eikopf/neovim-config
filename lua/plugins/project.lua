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

      silent_chdir = false,
    }
    require('telescope').load_extension('projects')
  end,
}
