### Notes

#### Useful plugins

- [`mini.nvim`](https://github.com/echasnovski/mini.nvim) -> Library of 20+ independent Lua modules improving overall Neovim
- [`barbecue.nvim`](https://github.com/utilyre/barbecue.nvim) -> vs code like winbar
- [`neorg`](https://github.com/nvim-neorg/neorg) -> note taking
- [`mind.nvim`](https://github.com/phaazon/mind.nvim) -> note taking and task workflows
- [`nabla.nvim`](https://github.com/jbyuki/nabla.nvim) -> Markdown scentific latex pop-up
- [`neoformat`](https://github.com/sbdchd/neoformat) -> Code formatter
- [`syntax-tree-surfer`](https://github.com/ziontee113/syntax-tree-surfer#version-20-beta-update-) -> tree-sitter function
- [`splitjoin.nvim`](https://github.com/bennypowers/splitjoin.nvim) -> Split or join list-like syntax constructs

#### snippets

```lua
-- emmet_ls setup
local lspconfig = require('lspconfig')
local capabilitiesE = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.emmet_ls.setup({
	-- on_attach = on_attach,
	capabilities = capabilitiesE,
	filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
	init_options = {
		html = {
			options = {
				-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
				["bem.enabled"] = true,
			},
		},
	}
})
```
