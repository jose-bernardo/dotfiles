return {
  -- {
  --   "themaxmarchuk/tailwindcss-colors.nvim",
  --   module = "tailwindcss-colors",
  --   opts = {},
  -- },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "SmiteshP/nvim-navic",
      { "williamboman/mason-lspconfig.nvim", config = function() end },
    },
    opts = {
      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = "",
          },
        },
        -- float = { border = "rounded", width = 50 },
        float = { width = 50 },
      }),
      severity_sort = true,
      inlay_hints = {
        enabled = true,
      },
      -- LSP Server Settings
      ---@type lspconfig.options
      servers = {
        lua_ls = {
          Lua = {
            diagnostics = { global = { "vim" } },
          },
        },
      },
    },
    config = function()
      local attach_navic = function(client, buffer)
        local navic = require("nvim-navic")
        if client.server_capabilities.documentSymbolProvider then
          navic.attach(client, buffer)
        end
      end

      local on_attach = function(client, buffer)
        attach_navic(client, buffer)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
        vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Goto References" })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Goto Implementation" })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declarations" })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
        vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help" })
        -- vim.keymap.set("n", "<Leader>cd", vim.diagnostic.open_float, { desc = "Show Diagnostics" })
        vim.keymap.set("n", "<Leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
        -- vim.keymap.set("n", "", vim.lsp.diagnostic.goto_next, { desc = "Go to next diagnostic" })
        -- vim.keymap.set("n", "", vim.lsp.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
        -- vim.keymap.set(
        --   "n",
        --   "<Leader>ca",
        --   vim.lsp.buf.code_action,
        --   { desc = "Code Action", noremap = true, silent = true }
        -- )
      end

      local handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { max_width = 70, max_height = 20 }),
        ["textDocument/signatureHelp"] = vim.lsp.with(
          vim.lsp.handlers.signature_help,
          { max_width = 70, max_height = 20 }
        ),
      }

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local ensure_installed = {
        clangd = {},
        rust_analyzer = {},
        gopls = {},
        ts_ls = {},
        pyright = {},
        eslint = {},
        phpactor = {},
        lua_ls = {},
        marksman = {},
        ltex = {},
      }

      for server_name, _ in pairs(ensure_installed) do
        require("lspconfig")[server_name].setup({
          capabilities = capabilities,
          on_attach = on_attach,
          handlers = handlers,
        })
      end

      require("lspconfig")["lua_ls"].setup({
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      -- require(mason-lspconfig").setup_handlers({
      --   function(server)
      --     require("lspconfig")[server].setup({
      --       handler = handlers,
      --       on_attach = on_attach,
      --       capabilities = capabilities,
      --     })
      --   end,
      --
      --   ["lua_ls"] = function()
      --     require("lspconfig")["lua_ls"].setup({
      --       settings = {
      --         Lua = {
      --           diagnostics = { globals = { "vim" } },
      --         },
      --       },
      --     })
      --   end,
      -- })
    end,
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "simple",
      })
      vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
    end,
    opts = {},
  },
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "rust_analyzer",
        "gopls",
        "ts_ls",
        "pyright",
        "eslint",
        "phpactor",
      },
    },
  },
}
