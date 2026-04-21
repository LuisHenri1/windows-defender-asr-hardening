$ErrorActionPreference = "Stop"

function Test-IsAdministrator {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-IsAdministrator)) {
    Write-Host "ERROR: Run PowerShell as Administrator." -ForegroundColor Red
    exit 1
}

New-Item -ItemType Directory -Force -Path ".\logs" | Out-Null
$logFile = ".\logs\rollback-log.txt"

$ruleIds = @(
    "56A863A9-875E-4185-98A7-B882C64B5CE5",
    "7674BA52-37EB-4A4F-A9A1-F0F9A1619A2C",
    "D4F940AB-401B-4EFC-AADC-AD5F3C50688A",
    "9E6C4E1F-7D60-472F-BA1A-A39EF669E4B2",
    "BE9BA2D9-53EA-4CDC-84E5-9B1EEEE46550",
    "01443614-CD74-433A-B99E-2ECDC07BFC25",
    "5BEB7EFE-FD9A-4556-801D-275E5FFC04CC",
    "D3E037E1-3EB8-44C8-A917-57927947596D",
    "3B576869-A4EC-4529-8536-B80A7769E899",
    "75668C1F-73B5-4CF0-BB93-3ECF5CB7CC84",
    "26190899-1602-49E8-8B27-EB1D0A1CE869",
    "E6DB77E5-3DF2-4CF1-B95A-636979351E5B",
    "D1E49AAC-8F56-4280-B9BA-993A6D77406C",
    "B2B3F03D-6A65-4F7B-A9C7-1C7EF74A9BA4",
    "92E97FA1-2EDF-4476-BDD6-9DD0B4DDDC7B",
    "C1DB55AB-C21A-4637-BB3F-A12568109D35",
    "A8F5898E-1DC8-49A9-9878-85004B8A61E6",
    "C0033C00-D16D-4114-A5A0-DC9B3A7D2CEB"
)

foreach ($id in $ruleIds) {
    try {
        Add-MpPreference `
            -AttackSurfaceReductionRules_Ids $id `
            -AttackSurfaceReductionRules_Actions Disabled `
            -ErrorAction Stop

        $message = "$(Get-Date) DISABLED: $id"
        Write-Host $message -ForegroundColor Green
        Add-Content -Path $logFile -Value $message
    }
    catch {
        $message = "$(Get-Date) FAILED TO DISABLE: $id | $($_.Exception.Message)"
        Write-Host $message -ForegroundColor Red
        Add-Content -Path $logFile -Value $message
    }
}

Write-Host "`nRollback complete." -ForegroundColor Cyan
