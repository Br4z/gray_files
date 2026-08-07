$codeUserPath = Join-Path $env:APPDATA "Zed\User"
$files = "settings.json", "keymap.json"

New-Item -ItemType Directory -Path $codeUserPath -Force | Out-Null

foreach ($name in $files) {
  $sourcePath = (Resolve-Path (Join-Path $PSScriptRoot $name)).Path
  $destinationPath = Join-Path $codeUserPath $name

  if (Test-Path -LiteralPath $destinationPath) {
    Remove-Item -LiteralPath $destinationPath -Force
  }

  New-Item -ItemType SymbolicLink -Path $destinationPath -Target $sourcePath | Out-Null
  Write-Host "$destinationPath -> $sourcePath"
}
