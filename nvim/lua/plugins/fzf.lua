return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "echasnovski/mini.icons" },
    opts = {
      fzf_colors = {
        true,
      },
      winopts = {
        height = 0.85, -- window height
        width = 0.50, -- window width
        row = 0.35, -- window row position (0=top, 1=bottom)
        col = 0.50, -- window col position (0=left, 1=right)
      },
    },
    lsp = {
      code_actions = {
        previewer = "codeaction_native",
        preview_pager = "delta --side-by-side --width=$FZF_PREVIEW_COLUMNS",
      },
    },
    keys = {
      {
        "<Leader>ff",
        function()
          require("fzf-lua").files()
        end,
        desc = "Find Files",
      },
      {
        "<Leader>fg",
        function()
          require("fzf-lua").live_grep()
        end,
        desc = "Live Grep",
      },
      {
        "<Leader>fh",
        function()
          require("fzf-lua").help_tags()
        end,
        desc = "Help Tags",
      },
      {
        "<Leader>fv",
        function()
          require("fzf-lua").files({ cwd = "~/.config/nvim" })
        end,
        desc = "Nvim Dotfiles",
      },
      { "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      {
        "<leader>fr",
        function()
          require("fzf-lua").registers()
        end,
        desc = "Registers",
      },
      {
        "<leader>fk",
        function()
          require("fzf-lua").keymaps()
        end,
        desc = "Keymaps",
      },
      {
        "<leader>fl",
        function()
          require("fzf-lua").blines()
        end,
        desc = "Current Buffer",
      },
      {
        "<leader>ca",
        function()
          require("fzf-lua").register_ui_select()
          require("fzf-lua").lsp_code_actions()
        end,
        desc = "Code Actions",
      },
      {
        "<leader>cd",
        function()
          require("fzf-lua").lsp_document_diagnostics()
        end,
        desc = "Diagnostics",
      },
    },
  },
}
