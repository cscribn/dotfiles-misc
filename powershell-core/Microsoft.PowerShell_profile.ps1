If (-Not (Test-Path -Path $HOME\.config\oh-my-posh)) {
  git clone https://github.com/cscribn/dotfiles-oh-my-posh.git  $HOME\.config\oh-my-posh
}

If ($IsMacOS) { $Env:PATH = "/opt/homebrew/bin:" + $Env:PATH }

If (-Not $IsLinux) { Import-Module posh-git; Import-Module -Name Terminal-Icons }

Import-Module PSReadLine; Set-PSReadLineOption -EditMode Windows -PredictionSource History

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
If (Test-Path($ChocolateyProfile)) { Import-Module "$ChocolateyProfile" }

oh-my-posh init pwsh --config $HOME\.config\oh-my-posh\themes\powerlevel10k_amped_modern.omp.json | Invoke-Expression
