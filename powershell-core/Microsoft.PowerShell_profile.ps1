$Env:POWERSHELL_UPDATECHECK = 'Off'
$Sep = [IO.Path]::DirectorySeparatorChar

If (-Not (Test-Path -Path ~${Sep}.config${Sep}oh-my-posh)) {
  git clone https://github.com/cscribn/dotfiles-oh-my-posh.git  ~\.config\oh-my-posh
}

If ($IsMacOS) { $Env:PATH = "/opt/homebrew/bin:" + $Env:PATH }

oh-my-posh init pwsh --config ~${Sep}.config${Sep}oh-my-posh${Sep}themes${Sep}powerlevel10k_amped_modern.omp.json | Invoke-Expression

If (-Not $IsLinux) {
  If (-Not (Get-Module -Name posh-git)) { Import-Module posh-git }
  If (-Not (Get-Module -Name Terminal-Icons)) { Import-Module Terminal-Icons }
}

If (-Not (Get-Module -Name PSReadLine)) {
  Import-Module PSReadLine
  Set-PSReadLineOption -EditMode Windows -PredictionSource History
}

# $ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
# If (Test-Path($ChocolateyProfile)) { Import-Module "$ChocolateyProfile" }
