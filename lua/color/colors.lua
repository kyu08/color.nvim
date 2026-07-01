local M = {}

--- 呼び出し側から渡されたフラットなパレットから theme 構造を生成する。
--- パレットが未指定・空ならエラーで落とす(デフォルトにフォールバックしない)。
---@param opts { palette: table<string, ColorSpec> }
---@return { theme: ThemeColors, palette: table }
function M.setup(opts)
	opts = opts or {}
	local palette = opts.palette
	if type(palette) ~= "table" or vim.tbl_isempty(palette) then
		error("color.nvim: palette must be provided")
	end

	local theme_colors = require("color.themes").classic(palette)

	return {
		theme = theme_colors,
		palette = palette,
	}
end

return M
