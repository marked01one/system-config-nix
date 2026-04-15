local function configlsp()
  local lspconfig = require('lspconfig')
  local mason_lspconfig = require('mason-lspconfig')

  require('mason').setup()

  -- Define list of servers to install.
  local langservers = {
    -- Web & Frontend.
    "ts_ls",
    "html",
    "cssls",
    "volar",
    "angularls",
    -- Data/Config.
    "yamlls",
    "jsonls",
    -- Backend/System.
    "gopls",
    "pyright",
    "rust_analyzer",
    "jdtls",
    "nixd",
  }

  mason_lspconfig.setup({ensure_installed = langservers})

  -- Automatically setup all servers in the list.
  mason_lspconfig.setup_handlers({
    function(server_name)
      lspconfig[server_name].setup({
        capabilities = capabilities,
      })
    end,

  })

end

return {
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  config = configlsp,
}
