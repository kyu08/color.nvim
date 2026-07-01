-- load() 済みの色を利用する。まだ load されていなければエラーにする。
local loaded = require("color")._colors
if not loaded then
	error("color.nvim: require('color').load({...}) must be called before using this lualine theme")
end
local theme = loaded.theme

local color = {}

color.normal = {
	a = { bg = theme.syn.fun, fg = theme.ui.bg_m3 },
	b = { bg = theme.diff.change, fg = theme.syn.fun },
	c = { bg = theme.ui.bg_p1, fg = theme.ui.fg },
}

color.insert = {
	a = { bg = theme.diag.ok, fg = theme.ui.bg },
	b = { bg = theme.ui.bg, fg = theme.diag.ok },
}

color.command = {
	a = { bg = theme.syn.operator, fg = theme.ui.bg },
	b = { bg = theme.ui.bg, fg = theme.syn.operator },
}

color.visual = {
	a = { bg = theme.syn.keyword, fg = theme.ui.bg },
	b = { bg = theme.ui.bg, fg = theme.syn.keyword },
}

color.replace = {
	a = { bg = theme.syn.constant, fg = theme.ui.bg },
	b = { bg = theme.ui.bg, fg = theme.syn.constant },
}

color.inactive = {
	a = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
	b = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim, gui = "bold" },
	c = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
}

if vim.g.color_lualine_bold then
	for _, mode in pairs(color) do
		mode.a.gui = "bold"
	end
end

return color
