-- this is mostly just here to fix an
-- issue with the transparency plugin

return {
  "m4xshen/smartcolumn.nvim",
  opts = {
    colorcolumn = "80",

    disabled_filetypes = {
      "help",
      "text",
      "markdown",
    },

    custom_colorcolumn = {
      java = "180",
      rust = "120",
    },

    scope = "file",
  },
}
