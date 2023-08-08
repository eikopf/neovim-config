local quarto = require("quarto")

-- the passed table gets 
-- merged with the default 
-- settings
quarto.setup {
  keymap = {
    rename = '<leader>lr',
  },
}
