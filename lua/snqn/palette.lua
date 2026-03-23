local util = require("snqn.util")

local M = {}

local default_dark = {
    base00 = "#07060B",
    base01 = "#1C1B28",
    base02 = "#323246",
    base03 = "#4C4B69",
    base04 = "#72708E",
    base05 = "#BFBDCA",
    base06 = "#EBE9F1",
    base07 = "#F5F3FA",
    base08 = "#FE587C",
    base09 = "#FF837C",
    base0A = "#FCE66F",
    base0B = "#62FF90",
    base0C = "#58E7E2",
    base0D = "#7285FE",
    base0E = "#8C6BFF",
    base0F = "#B967FF",
}

function M.resolve(opts)
    opts = opts or {}

    local palettes = opts.palettes or {}
    local base = util.merge(default_dark, palettes.dark or {}, palettes or {})
    local bg = base.base00
    local bg_alt = base.base01
    local bg_dim = base.base02

    return {
        mode = "dark",
        base = base,
        bg = bg,
        bg_alt = bg_alt,
        bg_dim = bg_dim,
        bg_float = util.mix(bg_alt, bg, 0.35),
        bg_edge = util.mix(bg_dim, bg, 0.35),
        border = util.mix(bg_dim, bg, 0.15),
        gutter = bg,
        fg = base.base05,
        fg_strong = base.base06,
        fg_soft = base.base04,
        muted = base.base03,
        local_decl = util.mix(base.base0D, bg, 0.22),
        definition = base.base0D,
        literal = base.base0B,
        constant = base.base0E,
        comment = base.base0F,
        accent = base.base0C,
        error = base.base08,
        warn = base.base09,
        info = base.base0C,
        hint = base.base04,
        syntax_literal_bg = nil,
        syntax_definition_bg = nil,
        syntax_comment_bg = nil,
        directory_bg = nil,
        selection = util.mix(base.base0D, bg, 0.82),
        current = util.mix(base.base0D, bg, 0.84),
        search = util.mix(base.base0B, bg, 0.78),
        inc_search = util.mix(base.base0D, bg, 0.70),
        diff_add = util.mix(base.base0B, bg, 0.80),
        diff_change = util.mix(base.base0D, bg, 0.82),
        diff_delete = util.mix(base.base08, bg, 0.82),
    }
end

return M
