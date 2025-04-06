;; LSP configuration

(local {: first} (require :lib.table))

;; NOTE: rust-analyzer is configured by rustaceanvim

(local servers {:clangd {}
                :ts_ls {}
                :fennel_ls {}
                :julials {}
                :lua_ls {}
                :nixd {}
                :ocamllsp {}
                :ruff {}})

(set servers.fennel_ls.settings {:fennel-ls {:extra-globals :vim}})
(set servers.fennel_ls.root_dir
     (fn [path]
       (first (vim.fs.find [:fnl :git] {:upward true :type :directory : path}))))

(set servers.julials.on_new_config
     (fn [new_config _]
       (let [julia (vim.fn.expand "~/.julia/environments/nvim-lspconfig/bin/julia")
             lsp (require :lspconfig)]
         (if (lsp.util.path_is_file julia)
             (tset new_config :cmd 1 julia)))))

(fn config [_ opts]
  (let [lsp (require :lspconfig)
        blink (require :blink.cmp)]
    (each [server config (pairs opts.servers)]
      (tset config :capabilities
            (blink.get_lsp_capabilities config.capabilities))
      ((. lsp server :setup) config))))

{1 :neovim/nvim-lspconfig
 :dependencies [:saghen/blink.cmp]
 :opts {: servers}
 : config}
