local M = {}

---@alias ColorSpec string RGB Hex string
---@alias ColorTable table<string, ColorSpec>

--- default config (スタイルのみ。色は load() に渡す)
---@class ColorConfig
M.config = {
	undercurl = true,
	commentStyle = {},
	functionStyle = {},
	keywordStyle = {},
	statementStyle = { bold = true },
	booleanStyle = {},
	typeStyle = {},
	transparent = false,
	dimInactive = false,
	terminalColors = true,
	---@type fun(colors: { palette: table, theme: table }): table<string, table>
	overrides = function()
		return {}
	end,
}

--- スタイル設定を更新する。色(パレット)は load() に渡す。
---@param config? ColorConfig
function M.setup(config)
	M.config = vim.tbl_deep_extend("force", M.config, config or {})
end

--- カラースキームを適用する。
--- palette は約50キーのフラットな色テーブル(必須)。未指定・空ならエラーで落とす。
---@param palette table<string, ColorSpec>
---@param config? ColorConfig スタイルの上書き(任意)
function M.load(palette, config)
	if type(palette) ~= "table" or vim.tbl_isempty(palette) then
		error("color.nvim: palette must be provided, e.g. require('color').load({ bg2 = '#121314', ... })")
	end
	if config then
		M.setup(config)
	end

	if vim.g.colors_name then
		vim.cmd("hi clear")
	end
	vim.g.colors_name = "color"
	vim.o.termguicolors = true

	local colors = require("color.colors").setup({ palette = palette })
	M._palette = palette
	M._colors = colors

	local highlights = require("color.highlights").setup(colors, M.config)
	require("color.highlights").highlight(highlights, M.config.terminalColors and colors.theme.term or {})
end

return M
