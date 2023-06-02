-- Добавляем Packer как пакеn
vim.cmd [[packadd packer.nvim]]
-- Используем данный коллбэк как список для плагинов
return require('packer').startup(function()

    -- Добавляем Packer в список, чтобы он обновлял сам себя
    use 'wbthomason/packer.nvim'

    -- LSP сервер
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'

    use {
        'nvim-tree/nvim-web-devicons',
        config = function()
            require'nvim-web-devicons'.setup {
                default = true
            }
        end
    }

    -- Удобное меню для обозрения проблем LSP
    use {
        "nvim-lualine/lualine.nvim",
        requires = {"nvim-tree/nvim-web-devicons", opt = true},
        config = function()
            require('lualine').setup()
        end,
    }

    use {
        'akinsho/bufferline.nvim',
        requires = {"nvim-tree/nvim-web-devicons", opt = true},
        config = function()
            require('bufferline').setup{
                options = {
                    diagnostic = 'nvim_lsp',

                }
            }
        end,
    }
    -- Highlight, edit, and navigate code using a fast incremental parsing library
    use {
        'nvim-treesitter/nvim-treesitter',
        requires = {"windwp/nvim-ts-autotag",},
        config = function()
            require('nvim-treesitter').setup{
                ensure_installed = {'lua', 'css', 'html', 'json', 'python', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'jsx', 'tsx'},
                autotag = {
                    enable = true,
                },
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                }
            }
        end
    }
    -- Автодополнялка
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'saadparwaiz1/cmp_luasnip'
    --- Автодополнлялка к файловой системе
    -- Snippets plugin
    use 'L3MON4D3/LuaSnip'
    use 'joshdick/onedark.vim'
    -- Wakatime
    use 'wakatime/vim-wakatime'
    -- Стартовая страница, если просто набрать vim в консоле
    use 'mhinz/vim-startify'
    -- Комментирует по gc все, вне зависимости от языка программирования
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    -- Обрамляет строку в теги по ctrl- y + ,
    use 'mattn/emmet-vim'
    -- Закрывает автоматом скобки
    use 'cohama/lexima.vim'
    -- Линтер, работает для всех языков
    use 'dense-analysis/ale'
    -- Даже если включена русская раскладка vim команды будут работать
    use 'powerman/vim-plugin-ruscmd'
    -- 'Автоформатирование' кода для всех языков
    use 'Chiel92/vim-autoformat'


    -- use 'kyazdani42/nvim-web-devicons'

    use { 'nvim-tree/nvim-tree.lua',
    requires = 'nvim-tree/nvim-web-devicons',
    config = function() require'nvim-tree'.setup {} end, }
    -- Подсвечивает закрывающий и откры. тэг. Если, где-то что-то не закрыто, то не подсвечивает.
    use 'idanarye/breeze.vim'
    -- Закрывает автоматом html и xml тэги. Пишешь <h1> и он автоматом закроется </h1>
    use 'alvan/vim-closetag'
    -- Подсвечивает #ffffff
    use 'ap/vim-css-color'
    -- Навигация внутри файла по классам и функциям
    use 'majutsushi/tagbar'
    -- Замена fzf и ack
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/plenary.nvim'}}
    }


    use 'mxw/vim-jsx'

    use {"akinsho/toggleterm.nvim", tag = '*', config = function()
        require("toggleterm").setup()
    end}
end)
