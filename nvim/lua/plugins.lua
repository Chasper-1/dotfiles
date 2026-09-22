return {
    -- *** ТЕМА: Everforest ***
    {
        "sainnhe/everforest",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("everforest")
        end,
    },

    -- *** ОСНОВА: Treesitter ***
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                "markdown",
                "markdown_inline",
                "lua",
                "vim",
            },
            highlight = {
                enable = true,
            },
        },
    },

    -- *** ПОИСК: Telescope ***
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("telescope").setup({
                defaults = {
                    file_ignore_patterns = {
                        "node_modules",
                        "vendor",
                    },
                },
            })

            vim.keymap.set("n", "<leader>f", function()
                require("telescope.builtin").find_files()
            end, { desc = "Fuzzy search files" })
        end,
    },
    

    -- *** OBSIDIAN ***
    {
        "epwalsh/obsidian.nvim",
        version = "*",
        ft = "markdown",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        opts = {
            dir = "~/Документы/obsidian",

            daily_notes = {
                folder = "Daily",
                date_format = "%Y-%m-%d",
            },
        },
        keys = {
            {
                "<leader>o",
                "<cmd>Obsidian today<cr>",
                desc = "Open Daily Note",
            },
            {
                "<leader>z",
                "<cmd>Obsidian search<cr>",
                desc = "Search Obsidian Vault",
            },
            {
                "<leader>b",
                "<cmd>Obsidian backlinks<cr>",
                desc = "Show Backlinks",
            },
        },
    },

    -- *** BUFFERLINE ***
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("bufferline").setup({
                options = {
                    mode = "tabs",
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            text_align = "left",
                        },
                    },
                    sort_by = "tabs",
                },
            })
        end,
    },

    -- *** STATUSLINE ***
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "everforest",
                    component_separators = "|",
                    section_separators = "",
                },

                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { "filename" },
                    lualine_x = { "filesize", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
            })
        end,
    },

    {
        "nvim-tree/nvim-web-devicons",
    },

    -- *** OUTLINE ***
    {
        "stevearc/aerial.nvim",
        opts = {
            open_automatically = true,
        },
        keys = {
            {
                "<leader>a",
                "<cmd>AerialToggle<cr>",
                desc = "Toggle Outline/Aerial",
            },
        },
    },

    -- *** YUCK ***
    "elkowar/yuck.vim",

    -- *** NBCL ***
    "NBCL-Lang/nbcl",

    -- *** LSP ***
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = {
                                "vim",
                            },
                        },
                    },
                },
            })

            vim.lsp.enable("lua_ls")
        end,
    },

    -- *** AUTOCOMPLETE ***
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },

                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({
                        select = true,
                    }),
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                }),

                sources = cmp.config.sources({
                    {
                        name = "nvim_lsp",
                    },
                    {
                        name = "buffer",
                    },
                    {
                        name = "path",
                    },
                }),
            })
        end,
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },

    {
        "numToStr/Comment.nvim",
        config = true,
    },

    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            {
                "s",
                mode = {
                    "n",
                    "x",
                    "o",
                },
                function()
                    require("flash").jump()
                end,
                desc = "Flash",
            },
        },
    },
}
