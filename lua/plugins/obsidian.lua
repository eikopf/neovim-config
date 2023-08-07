return {
  "epwalsh/obsidian.nvim",
  lazy = true,
  event = { "BufReadPre /Users/oliver/Documents/Documents - Oliver’s MacBook Pro/Obsidian/Main Vaults/Core Vault/**.md" },
  -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
  -- event = { "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md" },
  dependencies = { "nvim-lua/plenary.nvim", },
  opts = {
    dir = "/Users/oliver/Documents/Documents - Oliver’s MacBook Pro/Obsidian/Main Vaults/Core Vault",  -- no need to call 'vim.fn.expand' here
  },
}
