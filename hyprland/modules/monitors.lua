hl.monitor({
  output = "desc:Xiaomi Corporation Mi Monitor 5745300002903",
  mode = "2560x1440@180",
  position = "0x0",
  scale = 1,

  -- Color and HDR settings
  bitdepth = 10,
  cm = "hdr",
  supports_hdr = 1,
  supports_wide_color = 1,

  -- SDR/HDR balancing
  sdr_min_luminance = 0.005,
  sdr_max_luminance = 220,
})
