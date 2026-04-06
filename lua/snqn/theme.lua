local palette = require("snqn.palette")
local util = require("snqn.util")

local M = {}

local function editor_bg(opts, color)
    if opts.transparent then
        return "NONE"
    end

    return color
end

local function surface_bg(opts, color)
    if opts.transparent and opts.transparent_highlights then
        return "NONE"
    end

    return color
end

local function emphasis(fg, sp)
    return {
        fg = fg,
        sp = sp or fg,
        underline = true,
        nocombine = true,
    }
end

local function syntax_group(fg, bg)
    local group = { fg = fg }

    if bg then
        group.bg = bg
    end

    return group
end

local function set_terminal_colors(colors)
    vim.g.terminal_color_0 = colors.bg_dim
    vim.g.terminal_color_1 = colors.error
    vim.g.terminal_color_2 = colors.literal
    vim.g.terminal_color_3 = colors.comment
    vim.g.terminal_color_4 = colors.definition
    vim.g.terminal_color_5 = colors.definition
    vim.g.terminal_color_6 = colors.accent
    vim.g.terminal_color_7 = colors.fg
    vim.g.terminal_color_8 = colors.muted
    vim.g.terminal_color_9 = colors.warn
    vim.g.terminal_color_10 = util.lighten(colors.literal, 0.10)
    vim.g.terminal_color_11 = util.lighten(colors.comment, 0.06)
    vim.g.terminal_color_12 = util.lighten(colors.definition, 0.08)
    vim.g.terminal_color_13 = util.lighten(colors.definition, 0.08)
    vim.g.terminal_color_14 = util.lighten(colors.accent, 0.06)
    vim.g.terminal_color_15 = util.lighten(colors.fg, colors.mode == "light" and 0.04 or 0.18)
end

local function semantic_token_guard(enabled)
    if not enabled then
        return
    end

    local group = vim.api.nvim_create_augroup("SnqnSemanticTokens", { clear = true })
    vim.api.nvim_create_autocmd("LspAttach", {
        group = group,
        callback = function(event)
            local client = vim.lsp.get_client_by_id(event.data.client_id)
            if client then
                client.server_capabilities.semanticTokensProvider = nil
            end
        end,
    })
end

function M.build(opts)
    local colors = palette.resolve(opts)

    local groups = {
        ["@snqn.base"] = { fg = colors.fg },
        ["@snqn.muted"] = { fg = colors.muted },
        ["@snqn.definition"] = syntax_group(colors.definition, opts.transparent and nil or colors.syntax_definition_bg),
        ["@snqn.literal"] = syntax_group(colors.literal, opts.transparent and nil or colors.syntax_literal_bg),
        ["@snqn.comment"] = syntax_group(colors.comment, opts.transparent and nil or colors.syntax_comment_bg),

        Normal = { fg = colors.fg, bg = editor_bg(opts, colors.bg) },
        NormalNC = { fg = colors.fg, bg = editor_bg(opts, colors.bg) },
        NormalFloat = { fg = colors.fg, bg = surface_bg(opts, colors.bg_float) },
        FloatBorder = { fg = colors.border, bg = surface_bg(opts, colors.bg_float) },
        FloatTitle = { fg = colors.definition, bg = surface_bg(opts, colors.bg_float) },
        SignColumn = { fg = colors.muted, bg = editor_bg(opts, colors.gutter) },
        FoldColumn = { fg = colors.muted, bg = editor_bg(opts, colors.gutter) },
        LineNr = { fg = colors.muted, bg = editor_bg(opts, colors.gutter) },
        CursorLineNr = { fg = colors.definition, bg = surface_bg(opts, colors.gutter) },
        CursorLine = { bg = surface_bg(opts, colors.bg_alt) },
        CursorColumn = { bg = surface_bg(opts, colors.bg_alt) },
        ColorColumn = { bg = surface_bg(opts, colors.bg_alt) },
        Conceal = { fg = colors.muted },
        Directory = syntax_group(colors.definition, opts.transparent and nil or colors.directory_bg),
        EndOfBuffer = { fg = colors.bg_edge },
        Folded = { fg = colors.fg_soft, bg = surface_bg(opts, colors.bg_alt) },
        NonText = { fg = colors.bg_edge },
        Whitespace = { fg = colors.bg_edge },
        SpecialKey = { fg = colors.muted },
        VertSplit = { fg = colors.border, bg = editor_bg(opts, colors.bg) },
        WinSeparator = { fg = colors.border, bg = editor_bg(opts, colors.bg) },
        Title = { fg = colors.definition },

        Visual = opts.transparent and opts.transparent_highlights and emphasis(colors.definition) or { bg = surface_bg(opts, colors.selection) },
        Search = opts.transparent and opts.transparent_highlights and emphasis(colors.comment) or { fg = colors.fg_strong, bg = surface_bg(opts, colors.search) },
        CurSearch = opts.transparent and opts.transparent_highlights and emphasis(colors.warn) or { fg = colors.fg_strong, bg = surface_bg(opts, colors.inc_search) },
        IncSearch = opts.transparent and opts.transparent_highlights and emphasis(colors.warn) or { fg = colors.fg_strong, bg = surface_bg(opts, colors.inc_search) },
        MatchParen = opts.transparent and opts.transparent_highlights and emphasis(colors.definition) or { fg = colors.fg, bg = surface_bg(opts, colors.current) },

        Pmenu = { fg = colors.fg, bg = surface_bg(opts, colors.bg_float) },
        PmenuSel = opts.transparent and opts.transparent_highlights and emphasis(colors.definition) or { fg = colors.fg, bg = surface_bg(opts, colors.selection) },
        PmenuSbar = { bg = surface_bg(opts, colors.bg_alt) },
        PmenuThumb = { bg = surface_bg(opts, colors.bg_dim) },

        StatusLine = { fg = colors.fg, bg = surface_bg(opts, colors.bg_alt) },
        StatusLineNC = { fg = colors.fg_soft, bg = surface_bg(opts, colors.bg_alt) },
        TabLine = { fg = colors.fg_soft, bg = surface_bg(opts, colors.bg_alt) },
        TabLineFill = { bg = surface_bg(opts, colors.bg_alt) },
        TabLineSel = { fg = colors.definition, bg = surface_bg(opts, colors.bg) },
        WinBar = { fg = colors.fg, bg = editor_bg(opts, colors.bg) },
        WinBarNC = { fg = colors.fg_soft, bg = editor_bg(opts, colors.bg) },

        Comment = { link = "@snqn.comment" },
        Constant = { link = "@snqn.literal" },
        String = { link = "@snqn.literal" },
        Character = { link = "@snqn.literal" },
        Number = { link = "@snqn.literal" },
        Boolean = { link = "@snqn.literal" },
        Float = { link = "@snqn.literal" },
        Identifier = { link = "@snqn.base" },
        Function = { link = "@snqn.base" },
        Statement = { link = "@snqn.muted" },
        Conditional = { link = "@snqn.muted" },
        Repeat = { link = "@snqn.muted" },
        Label = { link = "@snqn.base" },
        Operator = { link = "@snqn.muted" },
        Keyword = { link = "@snqn.muted" },
        Exception = { link = "@snqn.muted" },
        PreProc = { link = "@snqn.muted" },
        Include = { link = "@snqn.muted" },
        Define = { link = "@snqn.muted" },
        Macro = { link = "@snqn.definition" },
        PreCondit = { link = "@snqn.muted" },
        Type = { link = "@snqn.base" },
        StorageClass = { link = "@snqn.muted" },
        Structure = { link = "@snqn.base" },
        Typedef = { link = "@snqn.definition" },
        Special = { link = "@snqn.base" },
        SpecialChar = { link = "@snqn.muted" },
        Tag = { link = "@snqn.definition" },
        Delimiter = { link = "@snqn.muted" },
        Debug = { link = "@snqn.warn" },

        DiagnosticError = { fg = colors.error },
        DiagnosticWarn = { fg = colors.warn },
        DiagnosticInfo = { fg = colors.info },
        DiagnosticHint = { fg = colors.hint },
        DiagnosticUnderlineError = { sp = colors.error, undercurl = true },
        DiagnosticUnderlineWarn = { sp = colors.warn, undercurl = true },
        DiagnosticUnderlineInfo = { sp = colors.info, undercurl = true },
        DiagnosticUnderlineHint = { sp = colors.hint, undercurl = true },
        DiagnosticVirtualTextError = opts.transparent and opts.transparent_highlights and { fg = colors.error } or { fg = colors.error, bg = surface_bg(opts, colors.diff_delete) },
        DiagnosticVirtualTextWarn = opts.transparent and opts.transparent_highlights and { fg = colors.warn } or { fg = colors.warn, bg = surface_bg(opts, colors.search) },
        DiagnosticVirtualTextInfo = opts.transparent and opts.transparent_highlights and { fg = colors.info } or { fg = colors.info, bg = surface_bg(opts, colors.diff_change) },
        DiagnosticVirtualTextHint = opts.transparent and opts.transparent_highlights and { fg = colors.hint } or { fg = colors.hint, bg = surface_bg(opts, colors.bg_alt) },

        DiffAdd = opts.transparent and opts.transparent_highlights and { fg = colors.literal } or { bg = surface_bg(opts, colors.diff_add) },
        DiffChange = opts.transparent and opts.transparent_highlights and { fg = colors.change } or { bg = surface_bg(opts, colors.diff_change) },
        DiffDelete = opts.transparent and opts.transparent_highlights and { fg = colors.error } or { bg = surface_bg(opts, colors.diff_delete) },
        DiffText = opts.transparent and opts.transparent_highlights and emphasis(colors.definition) or { bg = surface_bg(opts, colors.current) },
        Added = { fg = colors.literal },
        Changed = { fg = colors.change },
        Removed = { fg = colors.error },

        Error = { fg = colors.error },
        ErrorMsg = { fg = colors.error },
        WarningMsg = { fg = colors.warn },
        MoreMsg = { fg = colors.definition },
        ModeMsg = { fg = colors.definition },
        Question = { fg = colors.definition },

        ["@comment"] = { link = "@snqn.comment" },
        ["@comment.documentation"] = { link = "@snqn.comment" },
        ["@comment.todo"] = opts.transparent and opts.transparent_highlights and { fg = colors.comment, underline = true } or { fg = colors.fg_strong, bg = surface_bg(opts, colors.comment) },
        ["@markup.quote"] = { link = "@snqn.comment" },
        ["@markup.link"] = { fg = colors.definition },
        ["@markup.link.label"] = { fg = colors.definition },
        ["@markup.link.url"] = { fg = colors.accent },
        ["@markup.raw"] = { link = "@snqn.literal" },
        ["@markup.heading"] = { link = "@snqn.definition" },

        ["@string"] = { link = "@snqn.literal" },
        ["@string.escape"] = { link = "@snqn.literal" },
        ["@character"] = { link = "@snqn.literal" },
        ["@character.special"] = { link = "@snqn.literal" },
        ["@number"] = { link = "@snqn.literal" },
        ["@number.float"] = { link = "@snqn.literal" },
        ["@boolean"] = { link = "@snqn.literal" },
        ["@constant"] = { link = "@snqn.literal" },
        ["@constant.builtin"] = { link = "@snqn.literal" },
        ["@constant.macro"] = { link = "@snqn.definition" },

        ["@variable"] = { link = "@snqn.base" },
        ["@variable.builtin"] = { link = "@snqn.base" },
        ["@variable.parameter"] = { link = "@snqn.base" },
        ["@variable.member"] = { link = "@snqn.base" },
        ["@property"] = { link = "@snqn.base" },
        ["@field"] = { link = "@snqn.base" },

        ["@module"] = { link = "@snqn.definition" },
        ["@module.builtin"] = { link = "@snqn.definition" },
        ["@label"] = { link = "@snqn.base" },

        ["@type"] = { link = "@snqn.base" },
        ["@type.builtin"] = { link = "@snqn.base" },
        ["@type.definition"] = { link = "@snqn.definition" },
        ["@attribute"] = { link = "@snqn.base" },

        ["@function"] = { link = "@snqn.base" },
        ["@function.builtin"] = { link = "@snqn.base" },
        ["@function.call"] = { link = "@snqn.base" },
        ["@function.method"] = { link = "@snqn.base" },
        ["@function.method.call"] = { link = "@snqn.base" },
        ["@constructor"] = { link = "@snqn.definition" },
        ["@method"] = { link = "@snqn.base" },

        ["@keyword"] = { link = "@snqn.muted" },
        ["@keyword.function"] = { link = "@snqn.muted" },
        ["@keyword.operator"] = { link = "@snqn.muted" },
        ["@keyword.import"] = { link = "@snqn.muted" },
        ["@keyword.storage"] = { link = "@snqn.muted" },
        ["@keyword.return"] = { link = "@snqn.muted" },
        ["@conditional"] = { link = "@snqn.muted" },
        ["@repeat"] = { link = "@snqn.muted" },
        ["@exception"] = { link = "@snqn.muted" },

        ["@operator"] = { link = "@snqn.muted" },
        ["@punctuation"] = { link = "@snqn.muted" },
        ["@punctuation.bracket"] = { link = "@snqn.muted" },
        ["@punctuation.delimiter"] = { link = "@snqn.muted" },
        ["@punctuation.special"] = { link = "@snqn.muted" },

        ["@tag"] = { link = "@snqn.definition" },
        ["@tag.attribute"] = { link = "@snqn.base" },
        ["@tag.delimiter"] = { link = "@snqn.muted" },

        gitcommitSummary = { fg = colors.definition },
        gitcommitComment = { link = "@snqn.comment" },
        gitcommitUntracked = { fg = colors.literal },
        gitcommitDiscarded = { fg = colors.error },
        gitcommitSelected = { fg = colors.change },

        TelescopeNormal = { fg = colors.fg, bg = editor_bg(opts, colors.bg_float) },
        TelescopeBorder = { fg = colors.border, bg = editor_bg(opts, colors.bg_float) },
        TelescopeTitle = { fg = colors.definition, bg = editor_bg(opts, colors.bg_float) },
        TelescopeSelection = opts.transparent and opts.transparent_highlights and emphasis(colors.definition) or { bg = surface_bg(opts, colors.selection) },
        TelescopeMatching = { fg = colors.comment },

        OilDir = syntax_group(colors.definition, opts.transparent and nil or colors.directory_bg),
        OilDirIcon = { fg = colors.definition },
        OilHidden = { fg = colors.muted },
        OilHiddenDir = { fg = colors.muted },
    }

    groups["@snqn.warn"] = { fg = colors.warn }

    if type(opts.highlight_overrides) == "function" then
        groups = util.merge(groups, opts.highlight_overrides(colors, opts) or {})
    else
        groups = util.merge(groups, opts.highlight_overrides or {})
    end

    return colors, groups
end

function M.apply(opts)
    local colors, groups = M.build(opts)

    vim.cmd("hi clear")
    if vim.fn.exists("syntax_on") == 1 then
        vim.cmd("syntax reset")
    end

    vim.o.background = "dark"
    set_terminal_colors(colors)
    semantic_token_guard(opts.disable_semantic_tokens)

    for group, spec in pairs(groups) do
        vim.api.nvim_set_hl(0, group, spec)
    end

    return colors, groups
end

return M
