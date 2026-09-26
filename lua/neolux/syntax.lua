local palette = require("neolux.palette")

local M = {}

function M.setup()
    local groups = {
        -- 1. SYNTAX GROUPS
        -- These act as a fallback and foundation.
        Comment        = { fg = palette.beige, italic = true },
        -- Constants
        Constant       = { fg = palette.purple },
        String         = { fg = palette.beige },
        Character      = { fg = palette.beige },
        Number         = { fg = palette.purple },
        Float          = { fg = palette.purple },
        Boolean        = { fg = palette.purple },
        -- Identifiers
        Identifier     = { fg = palette.fg },
        Function       = { fg = palette.green },
        -- Statements
        Statement      = { fg = palette.pink },
        Conditional    = { fg = palette.pink, bold = true }, -- if, then, else
        Repeat         = { fg = palette.pink, bold = true }, -- for, while
        Label          = { fg = palette.pink },
        Operator       = { fg = palette.pink },
        Keyword        = { fg = palette.pink, bold = true },
        Exception      = { fg = palette.pink, bold = true }, -- try, catch
        -- Preprocessors
        PreProc        = { fg = palette.light_blue }, -- import, from
        Include        = { fg = palette.blue },
        Define         = { fg = palette.purple },
        Macro          = { fg = palette.light_blue },
        PreCondit      = { fg = palette.light_blue },
        -- Types
        Type           = { fg = palette.light_blue }, -- class, int, string
        StorageClass   = { fg = palette.light_blue },
        Structure      = { fg = palette.light_blue },
        Typedef        = { fg = palette.light_blue },
        -- Special Characters & Tags
        Special        = { fg = palette.blue },
        SpecialChar    = { fg = palette.pink },       -- Special characters inside strings
        Tag            = { fg = palette.pink },
        Delimiter      = { fg = palette.yellow },     -- brackets (, [, {
        SpecialComment = { fg = palette.orange, bold = true },
        Debug          = { fg = palette.beige },
        -- Text Markup & Alerts
        Underlined     = { underline = true },
        Ignore         = { fg = palette.bg },         -- Hidden text
        Error          = { fg = palette.bg, bg = palette.pink, bold = true },
        Todo           = { fg = palette.bg, bg = palette.yellow, bold = true },

        -- 2. TREE-SITTER GROUPS
        ["@variable"]           = { fg = palette.fg }, -- Normal variables
        ["@variable.builtin"]   = { fg = palette.green }, -- 'self' or 'this'
        ["@variable.parameter"] = { fg = palette.orange }, -- Function arguments
        ["@variable.member"]    = { fg = palette.light_blue }, -- Attributes
        ["@function"]           = { link = "Function" },
        ["@function.builtin"]   = { fg = palette.light_blue }, -- print(), len()
        ["@keyword"]            = { link = "Keyword" },
        ["@keyword.function"]   = { fg = palette.light_blue }, -- 'def' or 'function'
        ["@keyword.return"]     = { fg = palette.pink, bold = true }, -- 'return'
        ["@type"]               = { link = "Type" },
        ["@type.builtin"]       = { link = "Type" }, -- built-in types
        ["@constant"]           = { link = "Constant" },
        ["@constant.builtin"]   = { fg = palette.purple }, -- 'None', 'NULL', 'True', 'False'
        ["@constructor"]        = { fg = palette.light_blue }, -- '__init__'
        ["@string"]             = { link = "String" },
        ["@number"]             = { link = "Number" },
        ["@boolean"]            = { link = "Boolean" },
        ["@comment"]            = { link = "Comment" },
        ["@punctuation.delimiter"] = { fg = palette.beige }, -- Commas, colons
        ["@property"]           = { link = "@variable.member" }, -- e.g., the 'name' in user.name
        ["@function.method"]    = { link = "Function" }, -- Green for class methods
        ["@function.method.call"] = { link = "Function" },
        ["@module"]             = { fg = palette.purple }, -- e.g., the 'numpy' in 'import numpy'
        ["@string.escape"]      = { fg = palette.purple, bold = true }, -- \n, \t
        ["@string.regexp"]      = { fg = palette.blue }, -- Regex patterns
        ["@tag"]                = { fg = palette.pink }, -- <div>, <MyComponent>
        ["@tag.attribute"]      = { fg = palette.green, italic = true }, -- className, onClick
        ["@tag.delimiter"]      = { fg = palette.yellow }, -- The < and > brackets
        ["@operator"]           = { link = "Operator" }, -- +, -, =, ->
        ["@keyword.directive"]  = { fg = palette.pink }, -- #include, #define in C
        ["@keyword.import"]     = { link = "Include" }, -- import, require
        ["@lsp.type.class"]                      = { link = "Type" },
        ["@lsp.type.property"]                   = { link = "@variable.member" },
        ["@lsp.type.namespace"]                  = { link = "@module" },
        ["@lsp.mod.declaration.parameter"]       = { fg = palette.orange },
        ["@lsp.typemod.method.defaultLibrary"]   = { link = "Function" },
        ["@lsp.typemod.function.defaultLibrary"] = { link = "Function" },
        ["@attribute"]           = { fg = palette.blue }, -- The 'dataclass' word
        ["@attribute.builtin"]   = { fg = palette.blue }, -- Built-ins like property or staticmethod
        ["@tag.builtin"]           = { fg = palette.pink }, -- Standard DOM tags (div, span, a, p)
        ["@tag.attribute.builtin"] = { fg = palette.green }, -- Standard attributes (class, id, href)
        ["@string.special.url"]    = { fg = palette.blue, underline = true }, -- The actual URL string inside href="url"
        ["@constant.character"]    = { fg = palette.purple }, -- HTML entities like &nbsp;, &amp;, &copy;
        ["@markup.heading"]        = { fg = palette.orange, bold = true }, -- Text inside <h1>, <h2>, etc.
        ["@markup.strong"]         = { fg = palette.fg, bold = true }, -- Text inside <b> or <strong>
        ["@markup.italic"]         = { fg = palette.fg, italic = true }, -- Text inside <i> or <em>
        ["@tag.css"]                  = { fg = palette.pink },       -- body, div, span selectors
        ["@property.css"]             = { fg = palette.light_blue }, -- background-color, margin, display
        ["@type.css"]                 = { link = "@tag.css" },      -- Fallback for element selectors
        ["@variable.css"]             = { fg = palette.green },      -- Custom properties / variables (--primary-color)
        ["@string.css"]               = { link = "String" },
        ["@number.css"]               = { link = "Number" },        -- 10rem, 0.05em, 100vh
        ["@keyword.css"]              = { link = "Keyword" },       -- !important, @media, @keyframes
        ["@constant.css"]             = { fg = palette.purple },    -- CSS keywords (flex, bold, none, hidden)
        ["@punctuation.delimiter.css"] = { fg = palette.beige },    -- Colons, semicolons
        ["@punctuation.special.tsx"]   = { fg = palette.orange },
        ["@punctuation.special.jsx"]   = { fg = palette.orange },
        ["@punctuation.special"]       = { fg = palette.yellow },
        ["@punctuation.special.python"] = { fg = palette.yellow },
        ["@punctuation.special.vue"]       = { fg = palette.orange },
        ["@punctuation.special.svelte"]    = { fg = palette.orange },
        ["@punctuation.bracket.tsx"]       = { fg = palette.orange },
        ["@punctuation.bracket.jsx"]       = { fg = palette.orange },
        ["@function.call"]      = { link = "Function" },
        ["@method.call"]        = { link = "Function" },
        ["@keyword.operator"]   = { link = "Operator" }, -- e.g. 'and', 'or', 'in', 'sizeof'
        ["@keyword.coroutine"]  = { fg = palette.pink, bold = true }, -- async, await, yield
        ["@keyword.storage"]    = { link = "StorageClass" }, -- static, const, mut, extern
        ["@keyword.type"]       = { link = "Type" },
        ["@string.documentation"] = { fg = palette.beige, italic = true }, -- Python docstrings / JSDoc
        ["@label"]              = { fg = palette.pink }, -- C/C++ goto labels, loop tags
        ["@lsp.type.parameter"]                  = { fg = palette.orange },
        ["@lsp.typemod.variable.parameter"]      = { fg = palette.orange },
        ["@lsp.typemod.variable.parameterScope"] = { fg = palette.orange },
        ["@lsp.typemod.parameter.declaration"]   = { fg = palette.orange },
        ["@lsp.typemod.parameter.definition"]    = { fg = palette.orange },
        ["@lsp.typemod.parameter.readonly"]      = { fg = palette.orange },

        -- 3. RAINBOW DELIMITERS
        ["@punctuation.bracket"]           = { fg = palette.yellow }, -- Fallback for standard brackets
        ["@punctuation.bracket.delimiter"] = { link = "@punctuation.bracket" },
        ["@lsp.type.bracket"]              = { link = "@punctuation.bracket" },
        RainbowDelimiterYellow = { fg = palette.pink }, -- I know this is not yellow
        RainbowDelimiterOrange = { fg = palette.orange },
        RainbowDelimiterRed    = { fg = palette.yellow },
        RainbowDelimiterCyan   = { fg = palette.light_blue },
        RainbowDelimiterBlue   = { fg = palette.blue },
        RainbowDelimiterViolet = { fg = palette.purple },
        RainbowDelimiterGreen  = {fg = palette.green},

        -- 4. MARKDOWN STRUCTURE
        ["@markup.heading.1.markdown"]  = { fg = palette.pink, bold = true },
        ["@markup.heading.2.markdown"]  = { fg = palette.orange, bold = true },
        ["@markup.heading.3.markdown"]  = { fg = palette.yellow, bold = true },
        ["@markup.heading.4.markdown"]  = { fg = palette.green, bold = true },
        ["@markup.heading.5.markdown"]  = { fg = palette.light_blue, bold = true },
        ["@markup.heading.6.markdown"]  = { fg = palette.purple, bold = true },
        ["@markup.link.url.markdown"]   = { fg = palette.blue, underline = true },
        ["@markup.link.label.markdown"] = { fg = palette.green },
        ["@markup.raw"]            = { fg = palette.orange },      -- Inline code blocks `code`
        ["@markup.raw.block"]      = { fg = palette.fg },          -- Fenced code blocks ```
        ["@markup.list"]           = { fg = palette.pink },        -- Markdown bullets (- / *)
        ["@markup.list.checked"]   = { fg = palette.green },    -- [x] Checkboxes
        ["@markup.list.unchecked"] = { fg = palette.gray3 },    -- [ ] Checkboxes

        -- 5. GIT SIGNS
        GitSignsAdd    = { fg = palette.green, bg = "NONE" }, -- New lines
        GitSignsChange = { fg = palette.yellow, bg = "NONE" }, -- Changed lines
        GitSignsDelete = { fg = palette.pink, bg = "NONE" },   -- Deleted lines
        DiffAdd    = { fg = palette.green, bg = palette.gray1 },
        DiffChange = { fg = palette.yellow, bg = palette.gray1 },
        DiffDelete = { fg = palette.pink, bg = palette.gray1 },
        DiffText   = { fg = palette.fg, bg = palette.gray2, bold = true },

        -- 6. LSP DIAGNOSTICS
        DiagnosticError = { fg = palette.pink },
        DiagnosticWarn  = { fg = palette.yellow },
        DiagnosticInfo  = { fg = palette.light_blue },
        DiagnosticHint  = { fg = palette.beige },
        DiagnosticUnderlineError = { sp = palette.pink, undercurl = true },
        DiagnosticUnderlineWarn  = { sp = palette.yellow, undercurl = true },
        DiagnosticUnderlineInfo  = { sp = palette.light_blue, undercurl = true },
        DiagnosticUnderlineHint  = { sp = palette.beige, undercurl = true },
    }

    -- Loop through and apply
    for group, settings in pairs(groups) do
        vim.api.nvim_set_hl(0, group, settings)
    end
end

return M
