If (-Not (Test-Path -Path $HOME\.config\oh-my-posh)) {
  git clone https://github.com/cscribn/dotfiles-oh-my-posh.git  $HOME\.config\oh-my-posh
}

If ($IsMacOS) { $Env:PATH = "/opt/homebrew/bin:" + $Env:PATH }

# https://fsackur.github.io/2023/11/20/Deferred-profile-loading-for-better-performance/
$Deferred = {
  If (-Not $IsLinux) { Import-Module posh-git; Import-Module -Name Terminal-Icons }

  Import-Module PSReadLine; Set-PSReadLineOption -EditMode Windows -PredictionSource History

  $ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
  If (Test-Path($ChocolateyProfile)) { Import-Module "$ChocolateyProfile" }
}

If ($IsWindows) {
  # https://seeminglyscience.github.io/powershell/2017/09/30/invocation-operators-states-and-scopes
  $GlobalState = [psmoduleinfo]::new($false)
  $GlobalState.SessionState = $ExecutionContext.SessionState

  # to run our code asynchronously
  $Runspace = [runspacefactory]::CreateRunspace($Host)
  $Powershell = [powershell]::Create($Runspace)
  $Runspace.Open()
  $Runspace.SessionStateProxy.PSVariable.Set('GlobalState', $GlobalState)

  # ArgumentCompleters are set on the ExecutionContext, not the SessionState
  # Note that $ExecutionContext is not an ExecutionContext, it's an EngineIntrinsics 😡
  $Private = [Reflection.BindingFlags]'Instance, NonPublic'
  $ContextField = [Management.Automation.EngineIntrinsics].GetField('_context', $Private)
  $Context = $ContextField.GetValue($ExecutionContext)

  # Get the ArgumentCompleters. If null, initialise them.
  $ContextCACProperty = $Context.GetType().GetProperty('CustomArgumentCompleters', $Private)
  $ContextNACProperty = $Context.GetType().GetProperty('NativeArgumentCompleters', $Private)
  $CAC = $ContextCACProperty.GetValue($Context)
  $NAC = $ContextNACProperty.GetValue($Context)
  if ($null -eq $CAC)
  {
    $CAC = [Collections.Generic.Dictionary[string, scriptblock]]::new()
    $ContextCACProperty.SetValue($Context, $CAC)
  }
  if ($null -eq $NAC)
  {
    $NAC = [Collections.Generic.Dictionary[string, scriptblock]]::new()
    $ContextNACProperty.SetValue($Context, $NAC)
  }

  # Get the AutomationEngine and ExecutionContext of the runspace
  $RSEngineField = $Runspace.GetType().GetField('_engine', $Private)
  $RSEngine = $RSEngineField.GetValue($Runspace)
  $EngineContextField = $RSEngine.GetType().GetFields($Private) | Where-Object {$_.FieldType.Name -eq 'ExecutionContext'}
  $RSContext = $EngineContextField.GetValue($RSEngine)

  # Set the runspace to use the global ArgumentCompleters
  $ContextCACProperty.SetValue($RSContext, $CAC)
  $ContextNACProperty.SetValue($RSContext, $NAC)

  $Wrapper = {
    # Without a sleep, you get issues:
    #   - occasional crashes
    #   - prompt not rendered
    #   - no highlighting
    # Assumption: this is related to PSReadLine.
    # 20ms seems to be enough on my machine, but let's be generous - this is non-blocking
    Start-Sleep -Milliseconds 200

    . $GlobalState {. $Deferred; Remove-Variable Deferred}
  }

  $null = $Powershell.AddScript($Wrapper.ToString()).BeginInvoke()
} Else {
  . $Deferred; Remove-Variable Deferred
}

oh-my-posh init pwsh --config $HOME\.config\oh-my-posh\themes\powerlevel10k_amped_modern.omp.json | Invoke-Expression
