local os = require("os")

local colors = {
  base00 = os.getenv("STYLIX_BASE_00"),
  base01 = os.getenv("STYLIX_BASE_01"),
  base02 = os.getenv("STYLIX_BASE_02"),
  base03 = os.getenv("STYLIX_BASE_03"),
  base04 = os.getenv("STYLIX_BASE_04"),
  base05 = os.getenv("STYLIX_BASE_05"),
  base06 = os.getenv("STYLIX_BASE_06"),
  base07 = os.getenv("STYLIX_BASE_07"),
  base08 = os.getenv("STYLIX_BASE_08"),
  base09 = os.getenv("STYLIX_BASE_09"),
  base0A = os.getenv("STYLIX_BASE_0A"),
  base0B = os.getenv("STYLIX_BASE_0B"),
  base0C = os.getenv("STYLIX_BASE_0C"),
  base0D = os.getenv("STYLIX_BASE_0D"),
  base0E = os.getenv("STYLIX_BASE_0E"),
  base0F = os.getenv("STYLIX_BASE_0F"),
}

local theme = {
  ansi = {
    colors.base00 or 'black',
    colors.base08 or 'maroon',
    colors.base0B or 'green',
    colors.base0A or 'olive',
    colors.base0D or 'navy',
    colors.base0E or 'purple',
    colors.base0C or 'teal',
    colors.base05 or 'silver',
  },
  brights = {
    colors.base03 or 'gray',
    colors.base08 or 'red',
    colors.base0B or 'lime',
    colors.base0A or 'yellow',
    colors.base0D or 'blue',
    colors.base0E or 'fuchsia',
    colors.base0C or 'aqua',
    colors.base07 or 'white',
  },

  -- The default text color
  foreground = colors.base05 or 'silver',
  -- The default background color
  background = colors.base00 or 'black',

  cursor_bg = colors.base05 or '#52ad70',
  cursor_fg = colors.base00 or 'black',
  compose_cursor = colors.base06 or 'orange';

  scrollbar_thumb = colors.base01 or '#222222',
  selection_fg = colors.base00 or 'black',
  selection_bg = colors.base05 or '#fffacd',
  split = colors.base03 or '#444444',
  visual_bell = colors.base09 or 'red';
}

return theme
