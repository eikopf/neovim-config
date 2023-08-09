local iron = require("iron.core")

iron.setup {
  config = {
    scratch_repl = true,

    repl_definition = {
      sh = {
        command = {"sh", "-c", "zsh || sh"}
      },

      fish = {
        command = {"sh", "-c", "fish || echo 'fish not installed'"}
      },

      python = {
        command = {"sh", "-c", "python -m bpython || ipython || python"}
      },

      julia = {
        command = {"sh", "-c", "julia || echo 'julia not installed'"}
      },

      r = {
        command = {"sh", "-c", "python -m radian || r"}
      },

      lua = {
        command = {"sh", "-c", "croissant || lua"}
      },
    },

    repl_open_cmd = require('iron.view').split.vertical.botright(0.5),
  },

  highlight = {
    italic = true,
  },

  ignore_blank_lines = true,
}
