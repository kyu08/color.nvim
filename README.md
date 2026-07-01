# color.nvim

呼び出し側から渡したパレットでハイライトを生成する Neovim カラースキームエンジンです。[kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) を fork し、構造を流用しています。

テーマごとにリポジトリを作らず、色定義(パレット)を lua から渡して使うことを想定しています。

## Usage

`require("color").load(palette)` にフラットな色テーブルを渡す。パレット未指定(nil/空)ならエラーで落ちる(デフォルトへフォールバックしない)。

```lua
require("color").load({
  bg0 = "#0E0F10", bg1 = "#191A1B", bg2 = "#121314", bg3 = "#242526",
  bg4 = "#202122", bg5 = "#242526", bg6 = "#333536",
  fg = "#BBBEBF", fgDim = "#8C8C8C", fgDark = "#555555", fgBright = "#FFFFFF",
  selection = "#276782", search = "#276782", searchCur = "#3994BC",
  keyword = "#FF7B72", string = "#A5D6FF", number = "#79C0FF", comment = "#8B949E",
  func = "#D2A8FF", constant = "#79C0FF", annotation = "#FFA657", docComment = "#8B949E",
  markup = "#A5D6FF", punct = "#BBBEBF", bracket = "#FFD700", operator = "#FF7B72",
  type = "#4EC9B0", preproc = "#FF7B72", deprecated = "#555555", regex = "#7EE787", todo = "#CD9731",
  diffAdd = "#1B3A1B", diffDelete = "#3A1B1B", diffChange = "#2A2A4A", diffText = "#2A2A4A",
  vcsAdded = "#7EE787", vcsRemoved = "#FFA198", vcsChanged = "#CD9731",
  error = "#F44747", warning = "#CD9731", info = "#6796E6", hint = "#3A94BC", ok = "#7EE787",
  whitespace = "#8C8C8C", nontext = "#858889", floatBg = "#202122", floatBorder = "#333536", matchParen = "#48A0C7",
})
```

スタイル(italic/bold 等)を上書きしたい場合は第2引数に渡す:

```lua
require("color").load(palette, { commentStyle = { italic = true } })
```

## パレットのキー

- 背景: `bg0`〜`bg6`(`bg2` が主エディタ背景)
- 前景: `fg` / `fgDim` / `fgDark` / `fgBright`
- 選択・検索: `selection` / `search` / `searchCur`
- 構文: `keyword` / `string` / `number` / `comment` / `func` / `constant` / `annotation` / `docComment` / `markup` / `punct` / `bracket` / `operator` / `type` / `preproc` / `deprecated` / `regex` / `todo`
- Diff: `diffAdd` / `diffDelete` / `diffChange` / `diffText`
- VCS: `vcsAdded` / `vcsRemoved` / `vcsChanged`
- 診断: `error` / `warning` / `info` / `hint` / `ok`
- UI: `whitespace` / `nontext` / `floatBg` / `floatBorder` / `matchParen`

## Credits

- [kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) — ハイライト生成の構造を流用
