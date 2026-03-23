local M = {}

local function clamp(value)
    return math.min(255, math.max(0, math.floor(value + 0.5)))
end

function M.hex_to_rgb(hex)
    hex = hex:gsub("#", "")

    return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16)
end

function M.rgb_to_hex(r, g, b)
    return string.format("#%02X%02X%02X", clamp(r), clamp(g), clamp(b))
end

function M.mix(fg, bg, amount)
    local fr, fgc, fb = M.hex_to_rgb(fg)
    local br, bgc, bb = M.hex_to_rgb(bg)

    return M.rgb_to_hex(
        fr + (br - fr) * amount,
        fgc + (bgc - fgc) * amount,
        fb + (bb - fb) * amount
    )
end

function M.lighten(color, amount)
    return M.mix(color, "#FFFFFF", amount)
end

function M.darken(color, amount)
    return M.mix(color, "#000000", amount)
end

function M.merge(...)
    return vim.tbl_deep_extend("force", ...)
end

return M
