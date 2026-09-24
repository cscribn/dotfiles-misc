$Env:POWERSHELL_UPDATECHECK = 'Off'
$Sep = [IO.Path]::DirectorySeparatorChar

If ($IsWindows) {
  Set-Alias -Name btop -Value "C:\Users\chadb\AppData\Local\Microsoft\WinGet\Links\btop4win.exe"
}

If (-Not (Test-Path -Path ~${Sep}.config${Sep}oh-my-posh)) {
  git clone https://github.com/cscribn/dotfiles-oh-my-posh.git  ~\.config\oh-my-posh
}

If ($IsMacOS) { $Env:PATH = "/opt/homebrew/bin:" + $Env:PATH }

$Env:LEADING_SYMBOL = '('
$Env:TRAILING_SYMBOL = ')'
oh-my-posh init pwsh --config ~${Sep}.config${Sep}oh-my-posh${Sep}themes${Sep}powerlevel10k_amped_rainbow.omp.json | Invoke-Expression

If (-Not $IsLinux) {
  Import-Module posh-git
  Import-Module Terminal-Icons; . "$PSScriptRoot\Terminal-Icons.Emoji.ps1"
}

Import-Module PSReadLine
Set-PSReadLineOption -EditMode Windows -PredictionSource History
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
