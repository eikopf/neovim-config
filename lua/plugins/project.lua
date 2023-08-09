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

    -- enable telescope integration
    require('telescope').load_extension('projects')
  end,
}

-- notes:
-- annoyingly, project.nvim will not automatically switch the cwd unless
-- it finds one of the pattern files, even when switching into a manually
-- added project via the telescope integration. this might be worth a PR.
