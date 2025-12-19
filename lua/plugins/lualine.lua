return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'echasnovski/mini.icons',
        'nvim-tree/nvim-web-devicons',
        'bwpge/lualine-pretty-path',
    },
    config = function()
        local lualine = require('lualine')

        local colors = {
            bg       = '#202328',
            fg       = '#bbc2cf',
            yellow   = '#ECBE7B',
            cyan     = '#008080',
            darkblue = '#081633',
            green    = '#98be65',
            orange   = '#FF8800',
            violet   = '#a9a1e1',
            magenta  = '#c678dd',
            blue     = '#51afef',
            red      = '#ec5f67',
        }

        local function mode_color()
            local mode_colors = {
                n = colors.red,
                i = colors.green,
                v = colors.blue,
                [''] = colors.blue,
                V = colors.blue,
                c = colors.magenta,
                no = colors.red,
                s = colors.orange,
                S = colors.orange,
                [''] = colors.orange,
                ic = colors.yellow,
                R = colors.violet,
                Rv = colors.violet,
                cv = colors.red,
                ce = colors.red,
                r = colors.cyan,
                rm = colors.cyan,
                ['r?'] = colors.cyan,
                ['!'] = colors.red,
                t = colors.red,
            }

            return mode_colors[vim.fn.mode()] or colors.fg
        end

        local conditions = {
            buffer_not_empty = function()
                return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
            end,
            hide_in_width = function()
                return vim.fn.winwidth(0) > 80
            end,
            check_git_workspace = function()
                local filepath = vim.fn.expand('%:p:h')
                local gitdir = vim.fn.finddir('.git', filepath .. ';')
                return gitdir and #gitdir > 0 and #gitdir < #filepath
            end,
        }

        local config = {
            options = {
                component_separators = '',
                section_separators = '',
                icons_enabled = true,
                theme = {
                    normal = { c = { fg = colors.fg, bg = colors.bg } },
                    inactive = { c = { fg = colors.fg, bg = colors.bg } },
                },
            },
            sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                lualine_c = {},
                lualine_x = {},
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                lualine_c = {},
                lualine_x = {},
            },
        }

        local function ins_left(component)
            table.insert(config.sections.lualine_c, component)
        end

        local function ins_right(component)
            table.insert(config.sections.lualine_x, component)
        end


        ins_left {
            function() return '▊' end,
            color = function()
                return { fg = mode_color() }
            end,
            padding = { left = 0, right = 1 },
        }


        ins_left {
            function()
                local mode_map = {
                    n  = 'NORMAL',
                    i  = 'INSERT',
                    v  = 'VISUAL',
                    V  = 'V-LINE',
                    [''] = 'V-BLOCK',
                    c  = 'COMMAND',
                    R  = 'REPLACE',
                    r  = 'PROMPT',
                    t  = 'TERMINAL',
                }
                return mode_map[vim.fn.mode()] or vim.fn.mode()
            end,
            color = function()
                return { fg = mode_color(), gui = 'bold' }
            end,
            padding = { right = 1 },
        }

        ins_left {
            'branch',
            icon = '',
            color = { fg = colors.violet, gui = 'bold' },
        }


        ins_left {
            'pretty_path',
            cond = conditions.buffer_not_empty,
            color = { fg = colors.magenta, gui = 'bold' },
        }


        ins_left {
            function()
                local cwd = vim.loop and vim.loop.cwd() or vim.fn.getcwd()

                return vim.fn.fnamemodify(cwd, ':~')
            end,

            cond = function() return vim.fn.empty(vim.fn.expand('%:t')) == 1 end,
            color = { fg = colors.magenta, gui = 'bold' },
        }

        ins_left {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = { error = ' ', warn = ' ', info = ' ' },
            diagnostics_color = {
                error = { fg = colors.red },
                warn = { fg = colors.yellow },
                info = { fg = colors.cyan },
            },
        }


        ins_left {
            function() return '%=' end,
        }


        ins_left {
            function()
                local msg = 'No Active Lsp'
                local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
                local clients = vim.lsp.get_clients()
                if next(clients) == nil then
                    return msg
                end
                for _, client in ipairs(clients) do
                    local filetypes = client.config.filetypes
                    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                        return client.name
                    end
                end
                return msg
            end,
            icon = '⏿ LSP:',
            color = { fg = '#ffffff', gui = 'bold' },
        }


        ins_right {
            'o:encoding',
            fmt = string.upper,
            cond = conditions.hide_in_width,
            color = { fg = colors.green, gui = 'bold' },
        }

        ins_right {
            'fileformat',
            fmt = string.upper,
            icons_enabled = false,
            color = { fg = colors.green, gui = 'bold' },
        }

        ins_right {
            'diff',
            symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
            diff_color = {
                added = { fg = colors.green },
                modified = { fg = colors.orange },
                removed = { fg = colors.red },
            },
            cond = conditions.hide_in_width,
        }


        ins_right {
            'filesize',
            cond = conditions.buffer_not_empty,
        }

        ins_right {
            'location',
            padding = { left = 1, right = 0 },
            color = { fg = colors.fg },
        }

        ins_right {
            'progress',
            padding = { left = 1, right = 0 },
            color = { fg = colors.fg, gui = 'bold' },
        }


        ins_right {
            function() return '▊' end,
            color = function()
                return { fg = mode_color() }
            end,
            padding = { left = 1 },
        }

        lualine.setup(config)
    end,
}
