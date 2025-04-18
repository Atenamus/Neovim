vim.cmd("let g:netrw_liststyle =3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

--tabs and indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.wrap = true

--search settings
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

--for coloschemes
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

--backspace
opt.backspace = "indent,eol,start"

--clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

--split window
opt.splitright = true --split vertical windows to right
opt.splitbelow = true --split horizontal windows to below

opt.showmode = false

--folding
opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

--terminal options'
vim.o.shell = "pwsh -NoLogo"
