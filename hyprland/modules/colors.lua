local colors = {
  background = "262626",
  foreground = "BCBCBC",

  black = "1C1C1C",
  red = "AF5F5F",
  green = "5F875F",
  yellow = "87875F",
  blue = "5F87AF",
  magenta = "5F5F87",
  cyan = "5F8787",
  white = "6C6C6C",

  bright_black = "444444",
  bright_red = "D78787",
  bright_green = "87AF87",
  bright_yellow = "FFFFAF",
  bright_blue = "87AFD7",
  bright_magenta = "8787AF",
  bright_cyan = "5FAFAF",
  bright_white = "FFFFFF",
}

function colors.rgb(name)
  local value = colors[name]
  assert(value, "Unknown Hyprland color: " .. tostring(name))
  return "rgb(" .. value .. ")"
end

return colors
