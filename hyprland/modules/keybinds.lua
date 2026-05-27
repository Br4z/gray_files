local settings = require("modules.settings")
local main_mod = settings.main_mod

-- General
hl.bind(main_mod .. " + Return", hl.dsp.exec_cmd(settings.terminal))
hl.bind(main_mod .. " + slash", hl.dsp.exec_cmd(settings.menu))
hl.bind(main_mod .. " + W", hl.dsp.window.close())
hl.bind(main_mod .. " + T", hl.dsp.exec_cmd(settings.file_manager))

-- Window state
hl.bind(main_mod .. " + M", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(main_mod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(main_mod .. " + P", hl.dsp.window.pseudo())
hl.bind(main_mod .. " + S", hl.dsp.layout("togglesplit"))

-- Move focus
hl.bind(main_mod .. " + I", hl.dsp.focus({ direction = "u" }))
hl.bind(main_mod .. " + O", hl.dsp.focus({ direction = "r" }))
hl.bind(main_mod .. " + E", hl.dsp.focus({ direction = "d" }))
hl.bind(main_mod .. " + N", hl.dsp.focus({ direction = "l" }))

-- Move windows
hl.bind(main_mod .. " + SHIFT + I", hl.dsp.window.move({ direction = "u" }))
hl.bind(main_mod .. " + SHIFT + O", hl.dsp.window.move({ direction = "r" }))
hl.bind(main_mod .. " + SHIFT + E", hl.dsp.window.move({ direction = "d" }))
hl.bind(main_mod .. " + SHIFT + N", hl.dsp.window.move({ direction = "l" }))

for _, workspace in ipairs(settings.workspaces) do
  hl.bind(main_mod .. " + " .. workspace, hl.dsp.focus({ workspace = workspace }))
  hl.bind(main_mod .. " + SHIFT + " .. workspace, hl.dsp.window.move({ workspace = workspace }))
end

-- Resize windows
hl.bind(main_mod .. " + right", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
hl.bind(main_mod .. " + left", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
hl.bind(main_mod .. " + up", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
hl.bind(main_mod .. " + down", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
