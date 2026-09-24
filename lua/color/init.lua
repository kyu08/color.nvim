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
	stringStyle = {},
	builtinVariableStyle = { italic = true },
	inlayHintStyle = {},
	--- lualine の "color" テーマを差し替える(任意)。
	--- 移植元テーマの lualine 配色を使いたい場合に lualine テーマのテーブルを渡す。
	--- lualine 側のテーマを使う場合は読み込み順を気にしなくて済むよう関数で渡せる。
	---@type table|fun(): table|nil
	lualineTheme = nil,
	transparent = false,
	dimInactive = false,
	terminalColors = true,
	---@type fun(colors: { palette: table, theme: table }): table<string, table>
	overrides = function()
		return {}
	end,
}

local default_config = vim.deepcopy(M.config)

--- スタイル設定を更新する。色(パレット)は load() に渡す。
--- *Style と lualineTheme は深くマージせず丸ごと置き換える。
--- (深くマージすると statementStyle = {} を渡しても既定の bold が消えないため)
---@param config? ColorConfig
function M.setup(config)
	config = config or {}
	M.config = vim.tbl_deep_extend("force", M.config, config)
	for key, value in pairs(config) do
		if key:match("Style$") or key == "lualineTheme" then
			M.config[key] = value
		end
	end
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
		-- 前回の load() の設定を持ち越さないよう、既定値から組み立て直す
		M.config = vim.deepcopy(default_config)
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
