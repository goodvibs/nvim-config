return {
    "echasnovski/mini.surround",
    version = false,
    config = function()
        local surround = require("mini.surround")
        surround.setup({
            mappings = {
                add = 'msa',
                delete = 'msd',
            },
        })
    end
}
