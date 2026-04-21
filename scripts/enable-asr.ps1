$ErrorActionPreference = "Stop"

function Test-IsAdministrator {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Test-DefenderAvailable {
    try {
        $service = Get-Service -Name WinDefend -ErrorAction Stop
        $status = Get-MpComputerStatus -ErrorAction Stop

        if ($service.Status -ne "Running") {
            throw "WinDefend service is not running."
        }

        if (-not $status.AMServiceEnabled) {
            throw "Microsoft Defender Antivirus service is not enabled."
        }
    }
    catch {
        throw $_
    }
}

if (-not (Test-IsAdministrator)) {
    Write-Host "ERROR: Run PowerShell as Administrator." -ForegroundColor Red
    exit 1
}

New-Item -ItemType Directory -Force -Path ".\logs" | Out-Null
$logFile = ".\logs\enable-log.txt"

$rules = @{
    "56A863A9-875E-4185-98A7-B882C64B5CE5" = "Block abuse of exploited vulnerable signed drivers"
    "7674BA52-37EB-4A4F-A9A1-F0F9A1619A2C" = "Block Adobe Reader from creating child processes"
    "D4F940AB-401B-4EFC-AADC-AD5F3C50688A" = "Block all Office applications from creating child processes"
    "9E6C4E1F-7D60-472F-BA1A-A39EF669E4B2" = "Block credential stealing from LSASS"
    "BE9BA2D9-53EA-4CDC-84E5-9B1EEEE46550" = "Block executable content from email client and webmail"
    "01443614-CD74-433A-B99E-2ECDC07BFC25" = "Block untrusted executable files"
    "5BEB7EFE-FD9A-4556-801D-275E5FFC04CC" = "Block execution of potentially obfuscated scripts"
    "D3E037E1-3EB8-44C8-A917-57927947596D" = "Block JavaScript or VBScript from launching downloaded executable content"
    "3B576869-A4EC-4529-8536-B80A7769E899" = "Block Office applications from creating executable content"
    "75668C1F-73B5-4CF0-BB93-3ECF5CB7CC84" = "Block Office applications from injecting code into other processes"
    "26190899-1602-49E8-8B27-EB1D0A1CE869" = "Block Office communication applications from creating child processes"
    "E6DB77E5-3DF2-4CF1-B95A-636979351E5B" = "Block persistence through WMI event subscription"
    "D1E49AAC-8F56-4280-B9BA-993A6D77406C" = "Block process creations from PSExec and WMI"
    "B2B3F03D-6A65-4F7B-A9C7-1C7EF74A9BA4" = "Block untrusted and unsigned processes from USB"
    "92E97FA1-2EDF-4476-BDD6-9DD0B4DDDC7B" = "Block Win32 API calls from Office macros"
    "C1DB55AB-C21A-4637-BB3F-A12568109D35" = "Use advanced protection against ransomware"
    "A8F5898E-1DC8-49A9-9878-85004B8A61E6" = "Block webshell creation for servers"
    "C0033C00-D16D-4114-A5A0-DC9B3A7D2CEB" = "Block use of copied or impersonated system tools"
}

try {
    Test-DefenderAvailable
}
catch {
    Write-Host "ERROR: Microsoft Defender is not available for ASR configuration." -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    Add-Content -Path $logFile -Value "$(Get-Date) PRECHECK FAILED | $($_.Exception.Message)"
    return
}

foreach ($id in $rules.Keys) {
    try {
        Add-MpPreference `
            -AttackSurfaceReductionRules_Ids $id `
            -AttackSurfaceReductionRules_Actions Enabled `
            -ErrorAction Stop

        $message = "$(Get-Date) SUCCESS: $($rules[$id])"
        Write-Host $message -ForegroundColor Green
        Add-Content -Path $logFile -Value $message
    }
    catch {
        $message = "$(Get-Date) FAILED: $($rules[$id]) | $($_.Exception.Message)"
        Write-Host $message -ForegroundColor Red
        Add-Content -Path $logFile -Value $message
    }
}

Write-Host "`nFinished processing ASR rules." -ForegroundColor Cyan
