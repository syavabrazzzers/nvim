--[[ Переменные ]]--
-- Переменная для настройки опций Neovim
-- Все время использовать vim.opt - не удобно, поэтому сделаем алиас
local opt = vim.opt

-- Глобальные переменные
-- То же самое делаем и с vim.global
local g = vim.g

--[[ Поиск ]]--
-- Игнорировать регистр при поиске
-- Если теперь введем "IGNORE", то он найдет и "ignore"
opt.ignorecase = true

-- Не игнорировать регистр, если есть символы в верхнем регистре
-- Если напишем "Ignore", то он будет искать только "Ignore"
opt.smartcase = true

-- Подсвечивать найденные текстовые объекты
opt.showmatch = true

opt.number = true
opt.relativenumber = true

-- Конфиг ale + eslint
g.ale_fixers = { javascript= { 'eslint' } }
g.ale_sign_error = '❌'
g.ale_sign_warning = '⚠️'
g.ale_fix_on_save = 1
-- Запуск линтера, только при сохранении
g.ale_lint_on_text_changed = 'never'
g.ale_lint_on_insert_leave = 0
-----------------------------------------------------------
-- Табы и отступы
-----------------------------------------------------------
vim.cmd([[
filetype indent plugin on
syntax enable
]])
opt.expandtab = true      -- use spaces instead of tabs
opt.shiftwidth = 4        -- shift 4 spaces when tab
opt.tabstop = 4           -- 1 tab == 4 spaces
opt.smartindent = true    -- autoindent new lines
-- don't auto commenting new lines
vim.cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]
-- remove line lenght marker for selected filetypes
vim.cmd [[autocmd FileType text,markdown,html,xhtml,javascript setlocal cc=0]]
-- 2 spaces for selected filetypes
vim.cmd [[
autocmd FileType xml,html,xhtml,css,scss,javascript,typescript,lua,yaml,htmljinja setlocal shiftwidth=2 tabstop=2
]]

opt.clipboard = 'unnamedplus'

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

opt.termguicolors = true
vim.cmd'colorscheme onedark'

opt.cursorline = true

opt.splitright = true
opt.splitbelow = true

opt.colorcolumn = '80'

opt.swapfile = false
opt.so = 7

opt.wrap = true

-----------------------------------------------------------
-- Установки для плагинов
-----------------------------------------------------------
-- LSP settings
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
	local opts = {}
	if server.name == "sumneko_lua" then
		-- only apply these settings for the "sumneko_lua" server
		opts.settings = {
			Lua = {
				diagnostics = {
					-- Get the language server to recognize the 'vim', 'use' global
					globals = {'vim', 'use'},
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		}
	end
	server:setup(opts)
end)


-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
-- vim.o.completeopt = 'menuone,preview,noinsert'
g.lsp_document_highlight_enabled = 1

-- luasnip setup
local luasnip = require 'luasnip'
-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'path' },
		{ name = 'buffer', option = {
			get_bufnrs = function()
				return vim.api.nvim_list_bufs()
			end
            }
		}
	},
    mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
    ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
}

