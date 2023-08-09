-- https://github.com/ahmedkhalf/project.nvim

return {
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup {
      patterns = {
        ".git",
        "Project.toml",         -- julia
        "Manifest.toml",        -- julia
        "Cargo.toml",           -- rust
        "build.zig",            -- zig
        ".obsidian",            -- obsidian
        "Makefile",             -- c/c++
        "package.json",         -- js/ts
        ".venv",                -- python
      },

      silent_chdir = true, -- false makes this useful but annoying
    }
    require('telescope').load_extension('projects')
  end,
}
