Function Run-Step([string] $Description, [ScriptBlock]$Script)
{
  & $Script
}

If (-Not (Test-Path -Path $HOME\.config\oh-my-posh)) {
  git clone https://github.com/cscribn/config-oh-my-posh.git  $HOME\.config\oh-my-posh
}

If ($IsMacOS) {
  $Env:PATH += ":/opt/homebrew/bin"
}

Run-Step "oh-my-posh" {
	oh-my-posh init pwsh --config $HOME\.config\oh-my-posh\themes\powerlevel10k_amped_modern.omp.json | Invoke-Expression
}

Run-Step "posh-git" {
  Import-Module posh-git
}

Run-Step "PSReadline" {
  Import-Module PSReadLine
  Set-PSReadLineOption -PredictionSource HistoryAndPlugin
  Set-PSReadLineOption -PredictionViewStyle ListView
  Set-PSReadLineOption -EditMode Windows
}

Run-Step "Terminal-Icons" {
  Import-Module -Name Terminal-Icons
}

Run-Step "Chocolatey" {
  $ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

  If (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
  }
}
