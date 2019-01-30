set-location c:\

$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal $identity
$isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

function prompt  { 
    if ($isAdmin) {
        "[" + (Get-Location) + "] # " 
    }
    else {
        "[" + (Get-Location) + "] $ "
    }
}
function Color-Console {
  $Host.ui.rawui.backgroundcolor = "black"
  $Host.ui.rawui.foregroundcolor = "white"
  $hosttime = (Get-ChildItem -Path $pshome\PowerShell.exe).CreationTime
  $hostversion="$($Host.Version.Major)`.$($Host.Version.Minor)"
  $admin = ""
  if ($isAdmin) {
	$admin = "[ADMIN]"
  }
  $Host.UI.RawUI.WindowTitle = "$admin $($env:COMPUTERNAME): PowerShell $hostversion ($hosttime)"
  Clear-Host
}
Color-Console
function Edit-Profile {
 
        notepad $profile.CurrentUserAllHosts
}
Remove-Variable identity
Remove-Variable principal

