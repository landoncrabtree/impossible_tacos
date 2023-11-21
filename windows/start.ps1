# Checks if the script is running as administrator
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!"
    Exit
}

# Set execution policy to unrestricted
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force

# Load chocolatey install module
Start-Process powershell.exe -ArgumentList "-File .\modules\chocolatey.ps1" -Verb RunAs -Wait
Write-Host "Chocolatey installed."

# Load users module
Start-Process powershell.exe -ArgumentList "-File .\modules\users.ps1" -Verb RunAs -Wait
Write-Host "Authorized users created."
Write-Host "Administrator and Guest accounts disabled."
Write-Host "Administrators group updated."
Write-Host "Non-authorized users disabled."

# Load GPO module
Start-Process powershell.exe -ArgumentList "-File .\modules\lgpo.ps1" -Verb RunAs -Wait
Write-Host "STIG GPOs applied."

# Load change passwords module
Start-Process powershell.exe -ArgumentList "-File .\modules\change_passwords.ps1" -Verb RunAs -Wait
Write-Host "All user passwords changed."

# Load prohibited media module
Start-Process powershell.exe -ArgumentList "-File .\modules\prohibited.ps1" -Verb RunAs -Wait
Write-Host "Scanned filesystem for prohibited media."

# Load malwarebytes module
Start-Process powershell.exe -ArgumentList "-File .\modules\malwarebytes.ps1" -Verb RunAs -Wait
Write-Host "Malwarebytes installed (Scan must be run manually)."

