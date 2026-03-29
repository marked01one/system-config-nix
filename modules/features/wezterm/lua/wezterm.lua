-- Pull in the wezterm API
local wezterm = require("wezterm")
local commands = require("commands")
local utils = require('utils')

local config = wezterm.config_builder()

config.enable_wayland = false

config.initial_cols = 120
config.initial_rows = 50

config.line_height = 1.0

-- Color theme
config.colors = utils.theme;

-- Appearance
config.window_decorations = "TITLE|RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
  left = 4,
  right = 4,
  top = 2,
  bottom = 2
}

-- Fonts
config.font_size = 12
config.font = wezterm.font_with_fallback {
  -- 1. Primary font for alpha-numeric characters & common symbols.
  {
    family = "JetBrainsMono Nerd Font",
    weight = "Regular"
  },
  -- 2. CJK Fallback font
  {
    -- Default fallback to Simplified Chinese for regional variants
    family = "Noto Sans Mono CJK SC",
    weight = "Regular",
    scale = 1.05
  }
}

-- Custom commands
wezterm.on("augment-command-palette", function()
  return commands
end)

-- Miscellaneous settings
config.max_fps = 240
config.prefer_egl = true

return config
