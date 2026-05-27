hl.window_rule({
  name = "open-browser-in-workspace-1",
  match = { class = "brave-browser" },
  workspace = "1",
})

hl.window_rule({
  name = "open-ide-in-workspace-2",
  match = { class = "code" },
  workspace = "2",
})

hl.window_rule({
  name = "open-explorer-in-workspace-3",
  match = { class = "thunar" },
  workspace = "3",
})

hl.window_rule({
  name = "open-terminal-in-workspace-3",
  match = { class = "kitty" },
  workspace = "3",
})

hl.window_rule({
  name = "suppress-maximize-events",
  match = { class = ".*" },
  suppress_event = "maximize",
})

hl.window_rule({
  name = "fix-xwayland-drags",
  match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false,
  },
  no_focus = true,
})

hl.window_rule({
  name = "move-hyprland-run",
  match = { class = "hyprland-run" },
  move = "20 monitor_h-120",
  float = true,
})
