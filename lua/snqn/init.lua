local theme = require("snqn.theme")
local util = require("snqn.util")

local M = {}

local defaults = {
    transparent = false,
    transparent_highlights = false,
    disable_semantic_tokens = true,
    palettes = {},
    highlight_overrides = {},
}

M.options = util.merge({}, defaults)

function M.setup(opts)
    M.options = util.merge({}, defaults, M.options, opts or {})
end

function M.load(opts)
    local incoming = opts or {}

    if type(incoming) ~= "table" then
        incoming = { name = incoming }
    end

    local resolved_opts = util.merge({}, M.options, incoming)

    theme.apply(resolved_opts)
    vim.g.colors_name = resolved_opts.name or "snqn"
end

return M
