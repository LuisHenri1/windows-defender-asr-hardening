$ErrorActionPreference = "Stop"

function Test-IsAdministrator {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

Write-Host "Checking Microsoft Defender status..." -ForegroundColor Cyan

if (-not (Test-IsAdministrator)) {
    Write-Host "ERROR: Run PowerShell as Administrator." -ForegroundColor Red
    exit 1
}

try {
    $service = Get-Service -Name WinDefend -ErrorAction Stop
    $status = Get-MpComputerStatus -ErrorAction Stop

    Write-Host "`nService information:" -ForegroundColor Yellow
    Write-Host "Name: $($service.Name)"
    Write-Host "Status: $($service.Status)"
    Write-Host "StartType: $($service.StartType)"

    Write-Host "`nDefender information:" -ForegroundColor Yellow
    Write-Host "AMServiceEnabled: $($status.AMServiceEnabled)"
    Write-Host "AntivirusEnabled: $($status.AntivirusEnabled)"
    Write-Host "RealTimeProtectionEnabled: $($status.RealTimeProtectionEnabled)"
    Write-Host "AntispywareEnabled: $($status.AntispywareEnabled)"
    Write-Host "BehaviorMonitorEnabled: $($status.BehaviorMonitorEnabled)"
    Write-Host "IoavProtectionEnabled: $($status.IoavProtectionEnabled)"
    Write-Host "NISEnabled: $($status.NISEnabled)"
    Write-Host "AMRunningMode: $($status.AMRunningMode)"

    if ($service.Status -ne "Running") {
        Write-Host "`nWARNING: WinDefend is not running." -ForegroundColor Red
    } else {
        Write-Host "`nMicrosoft Defender service appears to be available." -ForegroundColor Green
    }
}
catch {
    Write-Host "ERROR: Unable to query Microsoft Defender status." -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
}
