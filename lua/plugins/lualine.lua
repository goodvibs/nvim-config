return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "echasnovski/mini.icons",
        "bwpge/lualine-pretty-path",
    },
    config = function()
        local lualine = require("lualine")
        local lazy_status = require("lazy.status") -- to configure lazy pending updates count

        local colors = {
            blue = "#65D1FF",
            green = "#3EFFDC",
            violet = "#FF61EF",
            yellow = "#FFDA7B",
            red = "#FF4A4A",
            fg = "#c3ccdc",
            bg = "#112638",
            inactive_bg = "#2c3043",
        }

        local theme = {
            normal = {
                a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
                b = { bg = colors.bg, fg = colors.fg },
                c = { bg = colors.bg, fg = colors.fg },
                z = { bg = colors.bg, fg = colors.fg }
            },
            insert = {
                a = { bg = colors.green, fg = colors.bg, gui = "bold" },
                b = { bg = colors.bg, fg = colors.fg },
                c = { bg = colors.bg, fg = colors.fg },
                z = { bg = colors.bg, fg = colors.fg }
            },
            visual = {
                a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
                b = { bg = colors.bg, fg = colors.fg },
                c = { bg = colors.bg, fg = colors.fg },
                z = { bg = colors.bg, fg = colors.fg }
            },
            command = {
                a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
                b = { bg = colors.bg, fg = colors.fg },
                c = { bg = colors.bg, fg = colors.fg },
                z = { bg = colors.bg, fg = colors.fg }
            },
            replace = {
                a = { bg = colors.red, fg = colors.bg, gui = "bold" },
                b = { bg = colors.bg, fg = colors.fg },
                c = { bg = colors.bg, fg = colors.fg },
                z = { bg = colors.bg, fg = colors.fg }
            },
            inactive = {
                a = { bg = colors.inactive_bg, fg = colors.fg, gui = "bold" },
                b = { bg = colors.inactive_bg, fg = colors.fg },
                c = { bg = colors.inactive_bg, fg = colors.fg },
            },
        }

        -- Helper function to get diagnostics count
        local function diagnostics_count(severity)
            local count = vim.diagnostic.count(0, { severity = severity })
            return count > 0 and tostring(count) or ""
        end


        -- configure lualine with modified theme
        lualine.setup({
            options = {
                theme = theme,
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = { 'alpha', 'dashboard' },
                    winbar = {},
                },
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 100,
                    tabline = 1000,
                    winbar = 1000,
                },
                icons_enabled = true,
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = {
                    { 'branch', icon = '󰘬', color = { fg = colors.violet } },
                    {
                        'pretty_path',
                        color = { fg = colors.fg },
                    },
                },
                lualine_c = {
                    {
                        'diagnostics',
                        sources = { 'nvim_diagnostic' },
                        symbols = {
                            error = '󰅚 ',
                            warn = '󰀪 ',
                            info = '󰋽 ',
                            hint = '󰌵 ',
                        },
                        colored = true,
                        update_in_insert = false,
                        always_visible = false,
                    },
                },
                lualine_x = {
                    {
                        function()
                            return vim.bo.filetype ~= '' and vim.bo.filetype or 'no ft'
                        end,
                        color = { fg = colors.fg },
                    },
                    {
                      'encoding',
                      -- Show '[BOM]' when the file has a byte-order mark
                        show_bomb = false,
                    },
                    {
                        lazy_status.updates,
                        cond = lazy_status.has_updates,
                        color = { fg = "#ff9e64" },
                    },
                    {
                        function()
                            return ('%s %d events'):format(Snacks.profiler.config.icons.status,
                                #Snacks.profiler.core.events)
                        end,
                        color = 'DiagnosticError',
                        cond = function()
                            return Snacks.profiler.core.running
                        end,
                    },
                    {
                        function()
                            local reg = vim.fn.reg_recording()
                            return '󰑊 ' .. reg
                        end,
                        color = { fg = colors.violet },
                        cond = function()
                            return vim.fn.reg_recording() ~= ''
                        end,
                    },
                },
                lualine_y = {
                    {
                      'lsp_status',
                      icon = '', -- f013
                      symbols = {
                        spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
                        done = '✓',
                        separator = ' ',
                      },
                      ignore_lsp = {},
                      show_name = true,
                    }
                },
                lualine_z = {
                    {
                        'location',
                        padding = { left = 0, right = 1 },
                        color = { fg = colors.fg },
                    },
                    {
                        'progress',
                        padding = { left = 1, right = 0 },
                        color = { fg = colors.fg },
                    },
                },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {
                    { 'branch', icon = '󰘬' },
                    { 'pretty_path' },
                },
                lualine_c = {},
                lualine_x = {
                    { 'encoding' },
                },
                lualine_y = {},
                lualine_z = {
                    {
                        'location',
                    },
                    {
                        'progress',
                    }
                },
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {},
        })
    end,
}
