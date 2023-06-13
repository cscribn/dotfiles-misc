If (-Not (Test-Path -Path $HOME\.config\oh-my-posh)) {
  git clone https://github.com/cscribn/config-oh-my-posh.git  $HOME\.config\oh-my-posh
}

If ($IsMacOS) {
  $Env:PATH += ":/opt/homebrew/bin"
}

oh-my-posh init pwsh --config $HOME\.config\oh-my-posh\themes\powerlevel10k_amped_modern.omp.json | Invoke-Expression

Import-Module posh-git
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -EditMode Windows
Import-Module -Name Terminal-Icons
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

If (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
