-- fix terminal mode by making <Esc> work again
--vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

-- choose colorscheme at startup
--if vim.g.neovide then
  --vim.cmd("colorscheme onedark")
--else
  --vim.cmd("colorscheme doom-one")
--end
--
-- TANGERINE & HIBISCUS BOOTSTRAP

-- using lazy.nvim as the package manager
local pack = "lazy"

-- bootstrapping procedure
local function bootstrap(url, ref)
    local name = url:gsub(".*/", "")
    local path

    if pack == "lazy" then
        path = vim.fn.stdpath("data") .. "/lazy/" .. name
        vim.opt.rtp:prepend(path)
    else
        path = vim.fn.stdpath("data") .. "/site/pack/".. pack .. "/start/" .. name
    end

    if vim.fn.isdirectory(path) == 0 then
        print(name .. ": installing in data dir...")

        vim.fn.system {"git", "clone", url, path}
        if ref then
            vim.fn.system {"git", "-C", path, "checkout", ref}
        end

        vim.cmd "redraw"
        print(name .. ": finished installing")
    end
end

-- bootstrap stable version of tangerine, pinning at v2.8 by default
bootstrap("https://github.com/udayvir-singh/tangerine.nvim", "v2.8")

-- bootstrap stable version of hibiscus, pinning at v1.7 by default
bootstrap("https://github.com/udayvir-singh/hibiscus.nvim", "v1.7")

