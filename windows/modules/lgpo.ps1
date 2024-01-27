Move-Item -Path .\assets\STIG_GPO_OCT_2023\Chrome -Destination .\assets\STIG_GPO\ -Force
Move-Item -Path .\assets\STIG_GPO_OCT_2023\Edge -Destination .\assets\STIG_GPO\ -Force
Move-Item -Path .\assets\STIG_GPO_OCT_2023\IE -Destination .\assets\STIG_GPO\ -Force
Move-Item -Path .\assets\STIG_GPO_OCT_2023\Defender_AV -Destination .\assets\STIG_GPO\ -Force
#Move-Item -Path .\assets\STIG_GPO_OCT_2023\Defender_Firewall -Destination .\assets\STIG_GPO\ -Force
Move-Item -Path .\assets\STIG_GPO_OCT_2023\Firefox -Destination .\assets\STIG_GPO\ -Force

# Determine Windows version
$os = (Get-WmiObject -class Win32_OperatingSystem).Caption

# Check if $os has 'Server' and '2012' in it
if ($os -match 'Server' -and $os -match '2012') {
    Move-Item -Path .\assets\STIG_GPO_OCT_2023\WinSvr_2012 -Destination .\assets\STIG_GPO\ -Force
} elseif ($os -match 'Server' -and $os -match '2016') {
    Move-Item -Path .\assets\STIG_GPO_OCT_2023\WinSvr_2016 -Destination .\assets\STIG_GPO\ -Force
} elseif ($os -match 'Server' -and $os -match '2019') {
    Move-Item -Path .\assets\STIG_GPO_OCT_2023\WinSvr_2019 -Destination .\assets\STIG_GPO\ -Force
} elseif ($os -match 'Server' -and $os -match '2022') {
    Move-Item -Path .\assets\STIG_GPO_OCT_2023\WinSvr_2022 -Destination .\assets\STIG_GPO\ -Force
} elseif ($os -match 'Windows 10') {
    Move-Item -Path .\assets\STIG_GPO_OCT_2023\Win10 -Destination .\assets\STIG_GPO\ -Force
} elseif ($os -match 'Windows 11') {
    Move-Item -Path .\assets\STIG_GPO_OCT_2023\Win11 -Destination .\assets\STIG_GPO\ -Force
} else {
    Write-Warning "Cannot determine Windows version. Skipping OS GPOs."
}

& .\assets\LGPO.exe /g .\assets\STIG_GPO\



