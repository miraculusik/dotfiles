local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"j-hui/fidget.nvim",
			"folke/neodev.nvim",
		},
	},

	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind.nvim",
		},
	},

	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
		dependencies = "nvim-treesitter/nvim-treesitter-textobjects",
	},

	-- Git related plugins
	{ "tpope/vim-fugitive", lazy = true },
	{ "tpope/vim-rhubarb", lazy = true },
	{ "lewis6991/gitsigns.nvim", lazy = true },

	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim", config = true },

	-- null_ls
	{ "jose-elias-alvarez/null-ls.nvim" },

	-- Fuzzy Finder (files, lsp, etc)
	{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },

	-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },

	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		version = "nightly",
	},

	-- status line
	{ "bluz71/nvim-linefly", dependencies = { "nvim-tree/nvim-web-devicons" } },

	-- color schemes
	{ "rebelot/kanagawa.nvim", priority = 1000, lazy = true },
	{ "catppuccin/nvim", name = "catppuccin" },

	-- Add indentation guides even on blank lines
	{ "lukas-reineke/indent-blankline.nvim" },

	-- autopairs and autotag
	{ "windwp/nvim-autopairs" },
	{ "windwp/nvim-ts-autotag", ft = { "html" }, lazy = true },

	-- highlight css colors
	{
		"brenoprata10/nvim-highlight-colors",
		ft = { "css" },
		config = true,
		lazy = true,
	},

	-- tmux and nvim navigate keys
	{ "christoomey/vim-tmux-navigator" },

	-- predefined snippets
	{ "rafamadriz/friendly-snippets" },

	-- highlight under the word
	{ "RRethy/vim-illuminate" },

	{ -- todo comments
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({
				highlight = {
					after = "",
				},
			})
		end,
	},

	-- Lazygit
	{ "kdheepak/lazygit.nvim" },

	-- Neorg
	{ "nvim-neorg/neorg" },

	-- bufferline
	{
		"akinsho/bufferline.nvim",
		version = "v3.*",
		dependencies = "nvim-tree/nvim-web-devicons",
	},
})

--  Options
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.scrolloff = 8
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.colorcolumn = "99999"
vim.opt.showtabline = 0
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.cursorline = false
vim.opt.signcolumn = "yes"
vim.opt.title = true
vim.opt.titlestring = "%<%F%=%l/%L - nvim"
vim.opt.clipboard:append("unnamedplus") -- access system clipboard
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.wrap = false
vim.o.hlsearch = true
vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.o.completeopt = "menuone,noselect"
vim.o.termguicolors = true
vim.wo.signcolumn = "yes"
vim.wo.number = true

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.concealcursor = "nc"
vim.opt.conceallevel = 2

-- remove wrap for neorg and markdown
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.norg", "*.md" },
	command = "setlocal wrap",
})
-- show strikethrough
vim.api.nvim_set_hl(0, "@text.strike", { strikethrough = true })

-- Keymaps
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>h", "<cmd>nohl<CR>") -- remove highlight
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- nvim_treesitter
vim.keymap.set("n", "<leader><right>", ":vertical resize -2<Cr>") -- window resize
vim.keymap.set("n", "<leader><left>", ":vertical resize +2<Cr>") -- window resize
vim.keymap.set("n", "<leader><up>", ":resize +2<Cr>") -- window resize
vim.keymap.set("n", "<leader><down>", ":resize -2<Cr>") -- window resize
vim.keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
vim.keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window
vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<CR>") -- TODO comment
vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })
vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })
-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist)
-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>ht", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
-- Neorg
vim.keymap.set("n", "<leader>m", ":Neorg workspace notes<CR>")
-- bufferline keymaps
vim.keymap.set("n", "<leader>bn", ":BufferLineCycleNext<CR>")
vim.keymap.set("n", "<leader>bb", ":BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<leader>bs", ":BufferLinePick<CR>")
vim.keymap.set("n", "<leader>bc", ":BufferLinePickClose<CR>")
vim.keymap.set("n", "<leader>bcl", ":BufferLineCloseLeft<CR>")
vim.keymap.set("n", "<leader>bcr", ":BufferLineCloseRight<CR>")
-- comment with '<leader>\'
vim.keymap.set("n", "<leader>/", function()
	return vim.v.count == 0 and "<Plug>(comment_toggle_linewise_current)" or "<Plug>(comment_toggle_linewise_count)"
end, { expr = true })

-- vim.opt.background = "dark"
vim.cmd("colorscheme kanagawa")

require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
})

require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
			},
		},
	},
})

-- Configure Treesitter
require("nvim-treesitter.install").compilers = { "gcc-12" }
require("nvim-treesitter.configs").setup({
	auto_install = true,
	highlight = { enable = true },
	indent = { enable = true, disable = { "python" } },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<c-space>",
			node_incremental = "<c-space>",
			scope_incremental = "<c-s>",
			node_decremental = "<c-backspace>",
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>a"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>A"] = "@parameter.inner",
			},
		},
	},
	-- autotag = { enable = true },
})

-- LSP settings.
local on_attach = function(_, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end
		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end
	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })
end

-- mason-lsp
local servers = {}
require("neodev").setup()
require("mason").setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
	automatic_installation = true,
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
		})
	end,
})

require("fidget").setup() -- Turn on lsp status information

-- cmp setup
require("nvim-autopairs").setup({
	disable_in_replace_mode = false,
})

local cmp = require("cmp")
local luasnip = require("luasnip")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local lspkind = require("lspkind")

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "neorg" },
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
			local strings = vim.split(kind.kind, "%s", { trimempty = true })
			kind.kind = " " .. (strings[1] or "") .. " "
			kind.menu = "    (" .. (strings[2] or "") .. ")"
			return kind
		end,
	},
})

-- friendly snippets
require("luasnip/loaders/from_vscode").lazy_load()

-- lsp border
local _border = "rounded"
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = _border,
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = _border,
})
vim.diagnostic.config({
	float = { border = _border },
})

-- null_ls setup
local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		bufnr = bufnr,
	})
end
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	debug = false,
	sources = {
		formatting.prettier.with({ extra_args = { "--single-quote", "--jsx-single-quote" } }), -- "--no-semi",
		formatting.black,
		formatting.stylua,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
		end
	end,
})

require("illuminate").configure({
	filetypes_denylist = {
		"NvimTree",
		"lazy",
		"norg",
		"toggleterm",
		"TelescopePrompt",
	},
})

require("nvim-tree").setup({
	renderer = {
		indent_markers = { enable = true },
	},
})

require("neorg").setup({
	load = {
		["core.defaults"] = {},
		["core.norg.completion"] = { config = { engine = "nvim-cmp" } },
		["core.norg.concealer"] = {
			config = {
				icon_preset = "varied",
				folds = false,
				dim_code_blocks = {
					enabled = true,
					padding = { left = 1 },
				},
			},
		},
		["core.norg.dirman"] = {
			config = {
				workspaces = {
					notes = "~/notes",
				},
			},
		},
	},
})

require("nvim-web-devicons").set_icon({
	norg = {
		icon = "",
		color = "#56949f",
		cterm_color = "65",
		name = "Norg",
	},
})

require("bufferline").setup()

require("indent_blankline").setup({
	char = "┊",
})
