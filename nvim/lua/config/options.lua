vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.autoformat = true

local opt = vim.opt

opt.autowrite = true
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
opt.confirm = true
opt.cursorline = true
opt.expandtab = true
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.foldlevel = 99
opt.ignorecase = true
opt.linebreak = true
opt.list = true
opt.mouse = "a"
opt.pumblend = 10
opt.pumheight = 10
opt.relativenumber = true
opt.number = true
opt.ruler = false
opt.scrolloff = 4
opt.shiftround = true
opt.shiftwidth = 2
opt.showmode = false
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.spelllang = { "en" }
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true

opt.tabstop = 2
opt.termguicolors = true
opt.pumblend = 0
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.winminwidth = 5
opt.wrap = false
opt.scrolloff = 10
opt.listchars:append({
  -- tab = "│─",
  -- multispace = space,
  -- lead = space,
  trail = "·",
  -- eol = "$",
  -- extends:
  -- precedes:
  -- nbsp = space,
})
