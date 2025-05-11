return {
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    priority = 1000,
    opts = {
      color_overrides = {
        mocha = {
          -- base = "#000000",
          -- mantle = "#000000",
        },
      },
      custom_highlights = function(colors)
        return {
          NeoTreeWinSeparator = {
            fg = colors.surface0,
          },
          WinSeparator = {
            fg = colors.surface0,
          },
        }
      end,
      -- transparent_background = true,
      -- dim_inactive = {
      --   percentage = 0.10,
      --   enabled = true,
      --   shade = "dark",
      -- },
    },
    integrations = {
      cmp = true,
      -- flash = true,
      fzf = true,
      gitsigns = true,
      lsp_trouble = true,
      mason = true,
      mini = true,
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
      -- navic = { enabled = true, custom_bg = "lualine" },
      neotree = true,
      noice = true,
      notify = true,
      treesitter = true,
      treesitter_context = true,
    },
    init = function()
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
    specs = {
      {
        "akinsho/bufferline.nvim",
        version = "*",
        opts = function(_, opts)
          if (vim.g.colors_name or ""):find("catppuccin") then
            opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
          end
        end,
      },
    },
  },
}
