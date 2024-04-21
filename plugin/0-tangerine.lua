-- this is the file that *actually* invokes tangerine.nvim after bootstrapping

-- refer to the complete set of options: https://github.com/udayvir-singh/tangerine.nvim#setup
local opts = {
	-- compiled .lua files are placed here
	target = vim.fn.stdpath [[data]] .. "/tangerine",

	compiler = {
		-- this defines the set of events that invoke :FnlCompile
		-- "oninit" occurs when init.fnl is loaded
		-- "onsave" occurs when any .fnl config file is saved
		hooks = { "oninit", "onsave" },

		-- verbosity is true by default, but should probably be
		-- disabled once the configuration has (somewhat) stabilised
		verbose = true,
	}
}

require("tangerine").setup({})
