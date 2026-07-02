local M = {}

--- themes.lua のマッピングが参照する必須パレットキー。
--- ここを変えたら themes.lua の参照と揃えること。
local REQUIRED_KEYS = {
	"bg0",
	"bg1",
	"bg2",
	"bg3",
	"bg4",
	"bg5",
	"fg",
	"fgDim",
	"fgDark",
	"fgBright",
	"selection",
	"search",
	"keyword",
	"string",
	"number",
	"comment",
	"func",
	"constant",
	"member",
	"boolean",
	"identifier",
	"parameter",
	"annotation",
	"punct",
	"bracket",
	"operator",
	"type",
	"preproc",
	"deprecated",
	"regex",
	"diffAdd",
	"diffDelete",
	"diffChange",
	"diffText",
	"vcsAdded",
	"vcsRemoved",
	"vcsChanged",
	"error",
	"warning",
	"info",
	"hint",
	"ok",
	"whitespace",
	"nontext",
	"floatBg",
	"floatBorder",
}

--- 呼び出し側から渡されたフラットなパレットから theme 構造を生成する。
--- パレットが未指定・空、または必須キーが欠けていればエラーで落とす
--- (デフォルトにフォールバックしない)。
---@param opts { palette: table<string, ColorSpec> }
---@return { theme: ThemeColors, palette: table }
function M.setup(opts)
	opts = opts or {}
	local palette = opts.palette
	if type(palette) ~= "table" or vim.tbl_isempty(palette) then
		error("color.nvim: palette must be provided")
	end

	local missing = {}
	for _, key in ipairs(REQUIRED_KEYS) do
		if palette[key] == nil then
			missing[#missing + 1] = key
		end
	end
	if #missing > 0 then
		error("color.nvim: palette is missing required keys: " .. table.concat(missing, ", "))
	end

	local theme_colors = require("color.themes").classic(palette)

	return {
		theme = theme_colors,
		palette = palette,
	}
end

return M
