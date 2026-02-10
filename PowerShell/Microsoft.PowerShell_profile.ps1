oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/kali.omp.json" | Invoke-Expression

Import-Module -Name Terminal-Icons

Import-Module PSReadLine
Set-PSReadLineOption -PredictionViewStyle ListView -EditMode Emacs


# Helper function to see if the prediction view is visible
function _is_prediction_visible {
	$visible = $false
	if ($null -ne [Microsoft.PowerShell.PSConsoleReadLine].singleton) {
		$predictionState = [Microsoft.PowerShell.PSConsoleReadLine]::GetSingleton()._prediction
		if ($predictionState.view.count -gt 0) {
			$visible = $true
		}
	}
	$visible
}

# Binds Ctrl+p to navigate history OR predictions
Set-PSReadLineKeyHandler -Key Ctrl+p -ScriptBlock {
	if (_is_prediction_visible) {
		[Microsoft.PowerShell.PSConsoleReadLine]::PreviousPrediction()
	}
	else {
		[Microsoft.PowerShell.PSConsoleReadLine]::PreviousHistory()
	}
}

# Binds Ctrl+n to navigate history OR predictions
Set-PSReadLineKeyHandler -Key Ctrl+n -ScriptBlock {
	if (_is_prediction_visible) {
		[Microsoft.PowerShell.PSConsoleReadLine]::NextPrediction()
	}
	else {
		[Microsoft.PowerShell.PSConsoleReadLine]::NextHistory()
	}
}

# . "$PSScriptRoot\utilities.ps1"
