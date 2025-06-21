oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/kali.omp.json" | Invoke-Expression

Import-Module -Name Terminal-Icons

Import-Module PSReadLine
Set-PSReadLineOption -PredictionViewStyle ListView -EditMode Emacs

# . "$PSScriptRoot\utilities.ps1"
