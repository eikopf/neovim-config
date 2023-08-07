-- neorg wiki: https://github.com/nvim-neorg/neorg/wiki

return {
  "nvim-neorg/neorg",
  build = ":Neorg sync-parsers",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },
  config = function()
    require("neorg").setup {
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour

        ["core.concealer"] = { -- Adds pretty icons to your documents
          config = {
            folds = true,
            icon_preset = "basic",
          },
        },

        ["core.integrations.telescope"] = {},

        ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = "~/notes",
              journal = "~/notes/journal",
              projects = "~/notes/projects",
            },

            index = "index.norg",
          },
        },

        ["core.journal"] = {
          config = {
            journal_folder = "journal",
            strategy = "flat",
            use_template = false,
            workspace = "notes",
          },
        },

        ["core.keybinds"] = {
          config = {
            default_keybinds = true,
          },
        },
      },
    }
  end,
}

