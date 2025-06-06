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

        local my_lualine_theme = {
            normal = {
                a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
                b = { bg = colors.bg, fg = colors.fg },
                c = { bg = colors.bg, fg = colors.fg },
                z = { bg = colors.bg, colors.fg }
            },
            insert = {
                a = { bg = colors.green, fg = colors.bg, gui = "bold" },
                b = { bg = colors.bg, fg = colors.fg },
                c = { bg = colors.bg, fg = colors.fg },
                z = { bg = colors.bg, colors.fg }
            },
            visual = {
                a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
                b = { bg = colors.bg, fg = colors.fg },
                c = { bg = colors.bg, fg = colors.fg },
                z = { bg = colors.bg, colors.fg }
            },
            command = {
                a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
                b = { bg = colors.bg, fg = colors.fg },
                c = { bg = colors.bg, fg = colors.fg },
                z = { bg = colors.bg, colors.fg }
            },
            replace = {
                a = { bg = colors.red, fg = colors.bg, gui = "bold" },
                b = { bg = colors.bg, fg = colors.fg },
                c = { bg = colors.bg, fg = colors.fg },
                z = { bg = colors.bg, colors.fg }
            },
            inactive = {
                a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
                b = { bg = colors.inactive_bg, fg = colors.semilightgray },
                c = { bg = colors.inactive_bg, fg = colors.semilightgray },
            },
        }

        -- configure lualine with modified theme
        lualine.setup({
            options = {
                theme = my_lualine_theme,
                component_separators = { left = '|', right = '|' },
                section_separators = { left = '', right = '' },
            },
            sections = {
                lualine_b = {
                    { 'branch' },
                    { 'pretty_path' }
                },
                lualine_c = {
                    { "aerial" }
                },
                lualine_x = {
                    {
                        lazy_status.updates,
                        cond = lazy_status.has_updates,
                        color = { fg = "#ff9e64" },
                    },
                    { "lsp_status" },
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
                            return ' recording to ' .. reg
                        end,
                        color = 'DiagnosticInfo',
                        cond = function()
                            return vim.fn.reg_recording() ~= ''
                        end,
                    },
                    {
                        function()
                            return vim.api.nvim_call_function("codeium#GetStatusString", {})
                        end
                    }
                },
                lualine_y = {}
            },
            inactive_sections = {
                lualine_b = {
                    { 'branch' },
                    { 'pretty_path' },
                },
                lualine_c = {},
            }
        })
    end,
}
