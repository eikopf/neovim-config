local iron = require("iron.core")

iron.setup {
  config = {
    scratch_repl = true,

    repl_definition = {
      sh = {
        command = {"zsh"}
      },

      fish = {
        command = {"fish"}
      },

      python = {
        command = {"bpython"}
      },

      julia = {
        command = {"julia"}
      },

      r = {
        command = {"radian"} -- still don't know how to suppress warnings
      },

      lua = {
        command = {"croissant"} -- weird luarocks behaviour on macOS
      },
    },

    repl_open_cmd = require('iron.view').split.vertical.botright(0.5),
  },

  highlight = {
    italic = true,
  },

  ignore_blank_lines = true,
}
