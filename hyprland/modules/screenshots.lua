local settings = require("modules.settings")
local main_mod = settings.main_mod

hl.bind(main_mod .. " + SHIFT + S", hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f -'))
hl.bind("Print", hl.dsp.exec_cmd("grim - | swappy -f -"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy && notify-send "Screenshot" "Copied to clipboard"'))
