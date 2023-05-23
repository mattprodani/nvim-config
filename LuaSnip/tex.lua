local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local line_begin = require("luasnip.extras.expand_conditions").line_begin
local in_mathzone = function()
  -- The `in_mathzone` function requires the VimTeX plugin
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

local get_visual = function(args, parent)
  if (#parent.snippet.env.SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else  -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

return {
-- Examples of Greek letter snippets, autotriggered for efficiency
  --
  ls.parser.parse_snippet(
    { trig = "sum", name = "sum" },
    "\\sum_{n=${1:1}}^{${2:\\infty}} ${3:a_n z^n}"
  ),
s({trig="..", dscr="cdot", snippetType="autosnippet"},
  {
    t("\\cdot"),
  }

),
s({trig="neq", snippetType="autosnippet"},
  {
    t("\\neq"),
  },

  {condition = in_mathzone}  -- `condition` option passed in the snippet `opts` table 
),
s({trig="leq", snippetType="autosnippet"},
  {
    t("\\leq"),
  },

  {condition = in_mathzone}  -- `condition` option passed in the snippet `opts` table 
),
s({trig="geq", snippetType="autosnippet"},
  {
    t("\\geq"),
  },

  {condition = in_mathzone}  -- `condition` option passed in the snippet `opts` table 
),
s({trig="inv", snippetType="autosnippet"},
  {
    t("^{-1}"),
  },

  {condition = in_mathzone}  -- `condition` option passed in the snippet `opts` table 
),
s({trig="tt", dscr="Transpose superscript", snippetType="autosnippet"},
  {
    t("^{T}"),
  },

  {condition = in_mathzone}  -- `condition` option passed in the snippet `opts` table 
),
s({trig=";a", snippetType="autosnippet"},
  {
    t("\\alpha"),
  }
),
s({trig=";b", snippetType="autosnippet"},
  {
    t("\\beta"),
  }
),
s({trig=";g", snippetType="autosnippet"},
  {
    t("\\gamma"),
  }
),
s({trig=";l", snippetType="autosnippet"},
  {
    t("\\lambda"),
  }
),
s({trig=";i", snippetType="autosnippet"},
  {
    t("\\infty"),
  }
),
s({trig=";s", snippetType="autosnippet"},
  {
    t("\\sigma"),
  }
),
s({trig=";d", snippetType="autosnippet"},
  {
    t("\\delta"),
  }
),
s({trig=";D", snippetType="autosnippet"},
  {
    t("\\Delta"),
  }
),
s({trig=";S", snippetType="autosnippet"},
  {
    t("\\Sigma"),
  }
),

s({trig = "([^%a])mm", snippetType="autosnippet", wordTrig = false, regTrig = true},
  fmta(
    "<>$<>$",
    {
      f( function(_, snip) return snip.captures[1] end ),
      d(1, get_visual),
    }
  )
),
  s({trig = "ff"},
  fmta(
    "\\frac{<>}{<>}",
    {
      i(1),
      i(2),
    }
  ),
  {condition = in_mathzone}  -- `condition` option passed in the snippet `opts` table 
),
  s({trig = "bb"},
  fmta(
    "\\binom{<>}{<>}",
    {
      i(1),
      i(2),
    }
  ),
  {condition = in_mathzone}  -- `condition` option passed in the snippet `opts` table 
),
  s({trig = "sum"},
  fmta(
      "\\sum_{<>}^{<>}",
    {
      i(1),
      i(2),
    }
  ),
  {condition = in_mathzone}  -- `condition` option passed in the snippet `opts` table 
),

s({trig = "h1", dscr="Top-level section"},
  fmta(
    [[\section*{<>}]],
    { i(1) }
  ), 
  {condition = line_begin}  -- set condition in the `opts` table
),
s({trig = "h2", dscr="sub section"},
  fmta(
    [[\subsection*{<>}]],
    { i(1) }
  ), 
  {condition = line_begin}  -- set condition in the `opts` table
),
s({trig = "h3", dscr="subsubsection"},
  fmta(
    [[\subsubsection*{<>}]],
    { i(1) }
  ), 
  {condition = line_begin}  -- set condition in the `opts` table
),

s({trig="ali", dscr="align* environment", snippetType="autosnippet"},
  fmta(
    [[
      \begin{align*}
          <>
      \end{align*}
    ]],
    {
      i(0)
    }
  ),
  {condition = line_begin}
),
s({trig="env", dscr="A generic new environmennt", snippetType="autosnippet"},
  fmta(
    [[
      \begin{<>}
          <>
      \end{<>}
    ]],
    {
      i(1),
      i(2),
      rep(1),
    }
  ),
  {condition = line_begin}
),

s({trig = "tii", dscr = "Expands 'tii' into LaTeX's textit{} command."},
  fmta("\\textit{<>}",
    {
      d(1, get_visual),
    }
  )
),
s({trig = "lr(",  type="autosnippet",dscr = "Left Right (."},
  fmta("\\left({<>}\\right)",
    {
      d(1, get_visual),
    }
  ),
  {condition = line_begin}
),
  s({trig = "lr[", type="autosnippet", dscr = "Left Right []."},
  fmta("\\left[{<>}\\right]",
    {
      d(1, get_visual),
    }
  ),
  {condition = line_begin}
),
  s({trig="hh", dscr="Hat env", snippetType="autosnippet"},
  fmta(
    [[\hat{<>}]],

    { i(0) }
  )
),
  s({trig="eq", dscr="", snippetType="autosnippet"},
  fmta(
    [[
      \begin{equation*}
          <>
      \end{equation*}
    ]],
    { i(0) }
  ),
  {condition = line_begin}
),
}
