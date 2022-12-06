If (-Not (Test-Path -Path $HOME\.config\oh-my-posh)) {
  git clone https://github.com/cscribn/config-oh-my-posh.git  $HOME\.config\oh-my-posh
}

If ($IsMacOS) {
  $Env:PATH += ":/opt/homebrew/bin"
}

oh-my-posh init pwsh --config $HOME\.config\oh-my-posh\themes\powerlevel10k_modern_ansi.omp.json | Invoke-Expression
Import-Module posh-git
Import-Module PSReadLine
Import-Module -Name Terminal-Icons
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

If (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
