# ============================================================
# 🧱 Advance Windows Setup Menu - No GUI
# ============================================================


# ------------------------------------------------------------
# ⚙️ Section : Ensure Administrator - Start
# ------------------------------------------------------------
function Ensure-Admin {
    if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
        ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Host "Restarting as Administrator..." -ForegroundColor Yellow
        Start-Process pwsh -Verb RunAs -ArgumentList "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", "`"$PSCommandPath`""
        exit
    }
}
# ------------------------------------------------------------
# ⚙️ Section : Ensure Administrator - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# 🪟 Section : Console Window Setup - Start
# ------------------------------------------------------------
function Set-Console {
    $Host.UI.RawUI.WindowTitle = "Advance Windows Setup Menu - No GUI"
    $ui = $Host.UI.RawUI
    $width = 82
    $height = 44
    $ui.BufferSize = New-Object System.Management.Automation.Host.Size($width, 9999)
    $ui.WindowSize = New-Object System.Management.Automation.Host.Size($width, $height)
}
# ------------------------------------------------------------
# 🪟 Section : Console Window Setup - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# 💻 Section : Detect Windows Edition & Version - Start
# ------------------------------------------------------------
try {
    # Load the latest version from GitHub
    $remoteScript = "https://raw.githubusercontent.com/cwlxx9/vault7/main/Status-WindowsVersion.ps1"
    $null = irm $remoteScript | iex

    # Execute the function (assumed defined in Status-PowerStatus.ps1)
    $sleepstatus = Get-PowerStatus
}
catch {
    Write-Host "Error loading or executing Status-WindowsVersion.ps1: $($_.Exception.Message)" -ForegroundColor Red
    $sleepstatus = "Error"
}
# ------------------------------------------------------------
# 💻 Section : Detect Windows Edition & Version - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# 🔋 Section : Power Status Detection - Start
# ------------------------------------------------------------
try {
    # Load the latest version from GitHub
    $remoteScript = "https://raw.githubusercontent.com/cwlxx9/vault7/main/Status-PowerStatus.ps1"
    $null = irm $remoteScript | iex

    # Execute the function (assumed defined in Status-PowerStatus.ps1)
    $sleepstatus = Get-PowerStatus
}
catch {
    Write-Host "Error loading or executing Status-PowerStatus.ps1: $($_.Exception.Message)" -ForegroundColor Red
    $sleepstatus = "Error"
}
# ------------------------------------------------------------
# 🔋 Section : Power Status Detection - End
# ------------------------------------------------------------



# ------------------------------------------------------------
# ⚡ Section : Fast Startup Detection - Start
# ------------------------------------------------------------
try {
    # Load the latest version from GitHub
    $remoteScript = "https://raw.githubusercontent.com/cwlxx9/vault7/main/Status-FastStartupDetection.ps1"
    $null = irm $remoteScript | iex

    # Execute the function (assumed defined in Status-PowerStatus.ps1)
    $sleepstatus = Get-PowerStatus
}
catch {
    Write-Host "Error loading or Status-FastStartupDetection.ps1: $($_.Exception.Message)" -ForegroundColor Red
    $sleepstatus = "Error"
}
# ------------------------------------------------------------
# ⚡ Section : Fast Startup Detection - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# 🧭 Section : Main Menu Display - Start
# ------------------------------------------------------------
function Show-MainMenu {
    Clear-Host
    $title = "Advance Windows Setup Menu - No GUI"
    $psVersion = $PSVersionTable.PSVersion.ToString()
    $computer = $env:COMPUTERNAME
    $winVersion = Get-WindowsEdition

    # --- Header Box ---
    $lineWidth = 80
    $borderLine = "═" * $lineWidth
    Write-Host ""
    Write-Host "╔$borderLine╗" -ForegroundColor DarkCyan

    # Center title
    $paddedTitle = $title.PadLeft(([math]::Floor(($lineWidth + $title.Length) / 2))).PadRight($lineWidth)
    Write-Host "║$paddedTitle║" -ForegroundColor White
    Write-Host "╠$borderLine╣" -ForegroundColor DarkCyan

    # Info line
    $info = "PC Name: $computer  |  $winVersion  |  PowerShell: $psVersion"
    if ($info.Length -gt $lineWidth) { $info = $info.Substring(0, $lineWidth) }
    $paddedInfo = $info.PadLeft(([math]::Floor(($lineWidth + $info.Length) / 2))).PadRight($lineWidth)
    Write-Host "║$paddedInfo║" -ForegroundColor White
    Write-Host "╚$borderLine╝" -ForegroundColor DarkCyan
    Write-Host ""

    # --- Menu Sections ---
    Write-Host " ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ NEW PC SETUP ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓" -ForegroundColor White
    Write-Host ""
    Write-Host "  	[1] Basic Software Installer " -ForegroundColor Cyan
	Write-Host ""
    Write-Host " ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛" -ForegroundColor White
    Write-Host ""

    Write-Host " ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ MICROSOFT OFFICE ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓" -ForegroundColor White
    Write-Host ""
    Write-Host "  	[2] Microsoft Office Installer " -ForegroundColor Cyan -NoNewline
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
    Write-Host "  	[6] User Account Control" -ForegroundColor Cyan
    Write-Host "  	[7] Enable Desktop Icon " -ForegroundColor Cyan -NoNewline
	Write-Host "( This PC , User , Network , Recycle Bin )" -ForegroundColor Yellow
    Write-Host "  	[8] Sleep > Never | Turn Off Monitor > Never" -ForegroundColor Cyan
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
# ------------------------------------------------------------
# 🧭 Section : Main Menu Display - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# 🧰 Section : Action Functions - Start
# ------------------------------------------------------------
function Option1_Action { irm https://raw.githubusercontent.com/cwlxx9/vault7/main/Install-All(ver1).ps1 | iex }
function Option2_Action { irm 192.168.0.3/powershell/Install-mso2024.ps1 | iex; irm 192.168.0.3/powershell/create-office-shortcut.ps1 | iex }
function Option3_Action { irm 192.168.0.3/powershell/create-office-shortcut.ps1 | iex }
function Option4_Action { irm https://raw.githubusercontent.com/cwlxx9/vault7/main/change-pcname.ps1 | iex }
function Option5_Action { irm 192.168.0.3/powershell/ | iex }
function Option6_Action { irm https://raw.githubusercontent.com/cwlxx9/vault7/main/Run-UAC-Setting.ps1 | iex }
function Option7_Action { irm https://raw.githubusercontent.com/cwlxx9/vault7/main/Setting-EnableDesktopIcons.ps1 | iex }
function Option8_Action { irm https://raw.githubusercontent.com/cwlxx9/vault7/main/Setting-NoSleepNoMonitorOff.ps1 | iex }
function Option9_Action { irm https://raw.githubusercontent.com/cwlxx9/vault7/main/Setting-DisableWindowsFastStartup.ps1 | iex }
function OptionU1_Action { irm 192.168.0.3/powershell/Uninstall-OneDrive.ps1 | iex }
function OptionU2_Action { irm 192.168.0.3/powershell/ | iex }
function OptionC_Action { irm https://get.activated.win | iex }
# ------------------------------------------------------------
# 🧰 Section : Action Functions - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# 🔁 Section : Main Menu Loop - Start
# ------------------------------------------------------------
function Start-MenuNoGUI {
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
}
# ------------------------------------------------------------
# 🔁 Section : Main Menu Loop - End
# ------------------------------------------------------------

# ------------------------------------------------------------
# 🚀 Section : Script Start - Start
# ------------------------------------------------------------
Start-MenuNoGUI
# ------------------------------------------------------------
# 🚀 Section : Script Start - End
# ------------------------------------------------------------

