local colors = require("modules.colors")

hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 10,
    border_size = 2,
    col = {
      active_border = colors.rgb("bright_white"),
      inactive_border = colors.rgb("white"),
    },
    resize_on_border = false,
    allow_tearing = false,
    layout = "dwindle",
  },

  decoration = {
    rounding = 5,
    rounding_power = 2,
    active_opacity = 1.0,
    inactive_opacity = 0.9,
    shadow = {
      enabled = true,
      range = 5,
      render_power = 4,
      color = colors.rgb("black"),
    },
    blur = {
      enabled = true,
      size = 1,
      passes = 1,
      vibrancy = 0.1,
    },
  },

  misc = {
    force_default_wallpaper = -1,
    disable_hyprland_logo = true,
  },
})
