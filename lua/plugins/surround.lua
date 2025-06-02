return {
    "echasnovski/mini.surround",
    version = false,
    config = function()
        local surround = require("mini.surround")
        surround.setup({
            mappings = {
                add = 'msa',            -- Add surrounding in Normal and Visual modes
                delete = 'msd',         -- Delete surrounding
                find = 'msf',           -- Find surrounding (to the right)
                find_left = 'msF',      -- Find surrounding (to the left)
                highlight = 'msh',      -- Highlight surrounding
                replace = 'msr',        -- Replace surrounding
                update_n_lines = 'msn', -- Update `n_lines`

                suffix_last = 'l',      -- Suffix to search with "prev" method
                suffix_next = 'n',      -- Suffix to search with "next" method
            },
        })
    end
}
