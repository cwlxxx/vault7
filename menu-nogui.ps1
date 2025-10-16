# ============================================================
#   Liang Windows Setup Menu - Auto Windows Version Edition
# ============================================================

function Ensure-Admin {
    if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
        ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Host "Restarting as Administrator..." -ForegroundColor Yellow
        Start-Process pwsh -Verb RunAs -ArgumentList "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", "`"$PSCommandPath`""
        exit
    }
}

function Set-Console {
    $Host.UI.RawUI.WindowTitle = "Liang Windows Setup Menu"
    $ui = $Host.UI.RawUI
    $width = 82
    $height = 44
    $ui.BufferSize = New-Object System.Management.Automation.Host.Size($width, 9999)
    $ui.WindowSize = New-Object System.Management.Automation.Host.Size($width, $height)
}

function Get-WindowsEdition {
    $os = Get-CimInstance Win32_OperatingSystem
    $caption = $os.Caption
    $build = [System.Environment]::OSVersion.Version.Build

    # --- Edition Detection ---
    if ($caption -match "Home") { $edition = "Home" }
    elseif ($caption -match "Pro") { $edition = "Pro" }
    elseif ($caption -match "Enterprise") { $edition = "Ent" }
    elseif ($caption -match "Education") { $edition = "Edu" }
    else { $edition = "Edition" }

    # --- Version Tag Based on Build ---
    switch ($build) {
        {$_ -ge 26100} { $version = "24H2"; break }
        {$_ -ge 22621} { $version = "22H2"; break }
        {$_ -ge 22000} { $version = "21H2"; break }
        {$_ -ge 19045} { $version = "22H2"; break }
        {$_ -ge 19044} { $version = "21H2"; break }
        {$_ -ge 19043} { $version = "21H1"; break }
        {$_ -ge 19042} { $version = "20H2"; break }
        default { $version = "N/A" }
    }

    # --- Windows Generation ---
    if ($build -ge 22000) {
        $osVer = "Win11 $edition $version"
    } else {
        $osVer = "Win10 $edition $version"
    }

    return $osVer
}

function Get-PowerStatus {
    try {
        # Get active power scheme GUID
        $scheme = (powercfg /getactivescheme) -replace '.*GUID:\s+([a-f0-9-]+).*', '$1'

        # Extract AC power timeout values (in minutes)
        $monitorTimeout = [int](powercfg /query $scheme SUB_VIDEO VIDEOIDLE | Select-String -Pattern 'Current AC Power Setting Index: ([0-9]+)').Matches.Groups[1].Value
        $sleepTimeout   = [int](powercfg /query $scheme SUB_SLEEP STANDBYIDLE | Select-String -Pattern 'Current AC Power Setting Index: ([0-9]+)').Matches.Groups[1].Value

        # Convert 0 → "Never"
        $monitorStatus = if ($monitorTimeout -eq 0) { "Never" } else { "$monitorTimeout min" }
        $sleepStatus   = if ($sleepTimeout -eq 0) { "Never" } else { "$sleepTimeout min" }

        return " - Turn off the display: $monitorStatus`n  	    - Put the computer to sleep: $sleepStatus"
    }
    catch {
        return "Error reading power settings"
    }
}
$sleepstatus = Get-PowerStatus

function Get-FastStartupStatus {
    try {
        $key = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power"
        $value = (Get-ItemProperty -Path $key -Name HiberbootEnabled -ErrorAction SilentlyContinue).HiberbootEnabled

        switch ($value) {
            1 { return "Enabled" }
            0 { return "Disabled" }
            default { return "Unknown" }
        }
    }
    catch {
        return "Error"
    }
}
$faststartupstatus = Get-FastStartupStatus

function Show-MainMenu {
    Clear-Host
    $title = "Liang Windows Setup Menu"
    $psVersion = $PSVersionTable.PSVersion.ToString()
    $computer = $env:COMPUTERNAME
    $winVersion = Get-WindowsEdition

    # --- Header Box (Fixed Border Widths) ---
    $lineWidth = 80
    $borderLine = "═" * $lineWidth
    Write-Host ""
    Write-Host "╔$borderLine╗" -ForegroundColor DarkCyan

    # Center title
    $paddedTitle = $title.PadLeft(([math]::Floor(($lineWidth + $title.Length) / 2))).PadRight($lineWidth)
    Write-Host "║$paddedTitle║" -ForegroundColor White
    Write-Host "╠$borderLine╣" -ForegroundColor DarkCyan

    # --- Center Info Line ---
    $info = "PC Name: $computer  |  $winVersion  |  PowerShell: $psVersion"
    if ($info.Length -gt $lineWidth) { $info = $info.Substring(0, $lineWidth) }
    $paddedInfo = $info.PadLeft(([math]::Floor(($lineWidth + $info.Length) / 2))).PadRight($lineWidth)
    Write-Host "║$paddedInfo║" -ForegroundColor White
    Write-Host "╚$borderLine╝" -ForegroundColor DarkCyan
    Write-Host ""


    # --- Menu Sections ---
    Write-Host " ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ NEW PC SETUP ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓" -ForegroundColor White
    Write-Host ""
    Write-Host "  	[1] Install Basic Software " -ForegroundColor Cyan -NoNewline
	Write-Host "( Included all Settings Patch Below )" -ForegroundColor Yellow
    Write-Host ""
    Write-Host " ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛" -ForegroundColor White
    Write-Host ""

    Write-Host " ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ MICROSOFT OFFICE ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓" -ForegroundColor White
    Write-Host ""
    Write-Host "  	[2] Microsoft Office Home & Business 2024 " -ForegroundColor Cyan -NoNewline
	Write-Host "( Included Shortcuts )" -ForegroundColor Yellow
    Write-Host "  	[3] Create Shortcuts " -ForegroundColor Cyan -NoNewline
    Write-Host "( Word , Excel , Outlook , PowerPoint )" -ForegroundColor Yellow
	Write-Host ""
    Write-Host " ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛" -ForegroundColor White
    Write-Host ""

    Write-Host " ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ SETTINGS PATCH ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓" -ForegroundColor White
    Write-Host "  	[4] Change PC Name" -ForegroundColor Cyan -NoNewline
	Write-Host " ( Current: $computer )"  -ForegroundColor Green
    Write-Host "  	[5] " -ForegroundColor Cyan
    Write-Host "  	[6] Open User Account Control" -ForegroundColor Cyan
    Write-Host "  	[7] Enable Desktop Icon " -ForegroundColor Cyan -NoNewline
	Write-Host "( This PC , User , Network , Recycle Bin )" -ForegroundColor Yellow
    Write-Host "  	[8] Never Sleep Never Turn Off Monitor" -ForegroundColor Cyan
	Write-Host "  	   $sleepstatus" -ForegroundColor Green
    Write-Host "  	[9] Disable Windows Fast Startup " -ForegroundColor Cyan -NoNewline
	Write-Host "( Current: $faststartupstatus )" -ForegroundColor Green
    Write-Host " ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛" -ForegroundColor White
    Write-Host ""

    Write-Host " ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ UNINSTALLER ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓" -ForegroundColor White
    Write-Host "  	[U1] Uninstall Microsoft OneDrive" -ForegroundColor Cyan
    Write-Host "  	[U2] Uninstall McAfee Antivirus" -ForegroundColor Cyan
    Write-Host " ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛" -ForegroundColor White
    Write-Host ""

    Write-Host " ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ TOOLS ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓" -ForegroundColor White
    Write-Host ""
    Write-Host "  	[C] Microsoft Activation Script " -ForegroundColor Cyan -NoNewline
	Write-Host "( get.activated.win )" -ForegroundColor Yellow
    Write-Host ""
    Write-Host " ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛" -ForegroundColor White
    Write-Host ""
}

# ============================================================
#   ACTION FUNCTIONS
# ============================================================

function Option1_Action { irm 192.168.0.3/powershell/Install-All.ps1 | iex }
function Option2_Action { irm 192.168.0.3/powershell/Install-mso2024.ps1 | iex; irm 192.168.0.3/powershell/create-office-shortcut.ps1 | iex }
function Option3_Action { irm 192.168.0.3/powershell/create-office-shortcut.ps1 | iex }
function Option4_Action { irm 192.168.0.3/powershell/change-pcname.ps1 | iex }
function Option5_Action { irm 192.168.0.3/powershell/ | iex }
function Option6_Action { irm 192.168.0.3/powershell/Run-UAC-Setting.ps1 | iex }
function Option7_Action { irm 192.168.0.3/powershell/Enable-DesktopIcons.ps1 | iex }
function Option8_Action { irm 192.168.0.3/powershell/setting-nosleep-nooffmonitor.ps1 | iex }
function Option9_Action { irm 192.168.0.3/powershell/Run-disable-windows-fast-startup.ps1 | iex }
function OptionU1_Action { irm 192.168.0.3/powershell/Uninstall-OneDrive.ps1 | iex }
function OptionU2_Action { irm 192.168.0.3/powershell/ | iex }
function OptionC_Action { irm https://get.activated.win | iex }

# ============================================================
#   MAIN LOOP
# ============================================================

function Start-LiangMenu {
    Ensure-Admin
    Set-Console

    $running = $true
    while ($running) {
        Show-MainMenu
        $choice = Read-Host "Please enter your selection (Q to quit)"
        switch ($choice.ToUpper()) {
            "1" { Clear-Host; Set-Console; Option1_Action }
            "2" { Clear-Host; Set-Console; Option2_Action }
            "3" { Clear-Host; Set-Console; Option3_Action }
            "4" { Clear-Host; Set-Console; Option4_Action }
            "5" { Clear-Host; Set-Console; Option5_Action }
            "6" { Clear-Host; Set-Console; Option6_Action }
            "7" { Clear-Host; Set-Console; Option7_Action }
            "8" { Clear-Host; Set-Console; Option8_Action }
            "9" { Clear-Host; Set-Console; Option9_Action }
            "U1" { Clear-Host; Set-Console; OptionU1_Action }
            "U2" { Clear-Host; Set-Console; OptionU2_Action }
            "C" { Clear-Host; Set-Console; OptionC_Action }
            "Q" { $running = $false }
            default { Write-Host "`nInvalid selection. Try again." -ForegroundColor Red; Pause }
        }
    }
    Write-Host "`nGoodbye, Liang!" -ForegroundColor Green
}

# ============================================================
#   START
# ============================================================

Start-LiangMenu
