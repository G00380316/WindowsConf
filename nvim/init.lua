vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

require("set")
require("keymaps")
local function load_plugins()
    local plugins = {}
    local path = vim.fn.stdpath("config") .. "/lua/plugins"

    for _, file in ipairs(vim.fn.glob(path .. "/**/*.lua", true, true)) do
        local plugin = dofile(file)
        if plugin then
            table.insert(plugins, plugin)
        end
    end

    return plugins
end

require("lazy").setup(load_plugins())

local config_path = vim.fn.stdpath("config") .. "/colorscheme.txt"

local yank_group = vim.api.nvim_create_augroup("HighlightYank", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})