-- this is mostly just here to fix an
-- issue with the transparency plugin

return {
  "m4xshen/smartcolumn.nvim",
  opts = {
    colorcolumn = "1000", -- fuck off

    disabled_filetypes = {
      "help",
      "text",
      "markdown",
    },

    scope = "file",
  },
}
