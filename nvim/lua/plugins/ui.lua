return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "catppuccin",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          "filename",
        },
        lualine_c = {
          "diagnostics",
          {
            "navic",
            color_correction = nil, -- Can be nil, "static" or "dynamic". This option is useful only when you have highlights enabled.
            navic_opts = nil, -- lua table with same format as setup's option. All options except "lsp" options take effect when set here.
          },
        },
        lualine_x = {
          "filetype",
        },
        lualine_y = { "branch", "diff" },
        lualine_z = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
      },
    },
    extensions = { "neo-tree", "lazy", "fzf" },
  },
  -- {
  --   "akinsho/bufferline.nvim",
  --   keys = {
  --     { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
  --     { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
  --     { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
  --     { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
  --     { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
  --     { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
  --     { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
  --     { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
  --     { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
  --     { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
  --   },
  -- },
  {
    "echasnovski/mini.indentscope",
    opts = {
      -- symbol = "▏",
      symbol = "│",
      options = { try_as_border = true },
    },
  },
  {
    "echasnovski/mini.icons",
    opts = {},
  },
  {
    "echasnovski/mini.animate",
    opts = function(_, opts)
      -- don't use animate when scrolling with the mouse
      local mouse_scrolled = false
      for _, scroll in ipairs({ "Up", "Down" }) do
        local key = "<ScrollWheel" .. scroll .. ">"
        vim.keymap.set({ "", "i" }, key, function()
          mouse_scrolled = true
          return key
        end, { expr = true })
      end

      local animate = require("mini.animate")
      return vim.tbl_deep_extend("force", opts, {
        resize = {
          timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
        },
        scroll = {
          timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
          subscroll = animate.gen_subscroll.equal({
            predicate = function(total_scroll)
              if mouse_scrolled then
                mouse_scrolled = false
                return false
              end
              return total_scroll > 1
            end,
          }),
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = function()
      return { mode = "cursor", max_lines = 3 }
    end,
  },
  {
    "sphamba/smear-cursor.nvim",
    opts = {
      hide_target_hack = true,
      cursor_color = "none",
    },
    specs = {
      -- disable mini.animate cursor
      {
        "echasnovski/mini.animate",
        optional = true,
        opts = {
          cursor = { enable = false },
        },
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true })
        end,
        desc = "Explorer NeoTree (Root Dir)",
      },
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (Root Dir)", remap = true },
      { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
      {
        "<leader>gs",
        function()
          require("neo-tree.command").execute({ toggle = true, source = "git_status" })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    lazy = false, -- neo-tree will lazily load itself
    ---@module "neo-tree"
    ---@type neotree.Config?
    opts = {
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },
        hijack_netrw_behavior = "open_default",
        use_libuv_file_watcher = true,
      },
      window = { width = 30 },
      -- popup_border_style = "rounded",
    },
  },
  {
    "OXY2DEV/ui.nvim",
    lazy = false,
  },
}
