-- this expects the ZK_NOTEBOOK_DIR env. variable to be defined

require("zk").setup {
  picker = "telescope",

  lsp = {
    cmd = { "zk", "lsp" },
    name = "zk",
  },

  auto_attach = {
    enabled = true,
    filetypes = { "markdown" },
  }
}
