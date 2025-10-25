# --- Step 1: Ensure script is running with administrator privileges ---
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

Add-Type -AssemblyName PresentationFramework

# --- Step 2: Confirmation Prompt (using Windows popup) ---
$result = [System.Windows.MessageBox]::Show(
    "WARNING: This script will perform a complete uninstallation of Microsoft OneDrive.`n`nThis will affect all user profiles on this PC.`n`nAre you sure you want to proceed?",
    "Confirm Uninstall",
    [System.Windows.MessageBoxButton]::YesNo,
    [System.Windows.MessageBoxImage]::Warning
)

if ($result -ne [System.Windows.MessageBoxResult]::Yes) {
    [System.Windows.MessageBox]::Show("Uninstallation cancelled by user.", "Cancelled", [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Information)
    exit
}

# --- Step 3: Stop all OneDrive processes ---
Write-Host "Stopping all running OneDrive processes..." -ForegroundColor Yellow
Stop-Process -Name "OneDrive" -Force -ErrorAction SilentlyContinue | Out-Null
Write-Host "OneDrive processes stopped." -ForegroundColor Green

# --- Step 4: Run the official uninstaller for all users ---
Write-Host "Running OneDrive uninstaller for all users..." -ForegroundColor Yellow
try {
    $setupPath = "$env:SystemRoot\SysWOW64\OneDriveSetup.exe"
    if (-not (Test-Path -Path $setupPath)) {
        $setupPath = "$env:SystemRoot\System32\OneDriveSetup.exe"
    }

    if (Test-Path -Path $setupPath) {
        Start-Process -FilePath $setupPath -ArgumentList "/uninstall" -NoNewWindow -Wait
        Write-Host "OneDrive uninstaller executed successfully." -ForegroundColor Green
    }
    else {
        Write-Warning "Could not find OneDriveSetup.exe. Continuing with manual cleanup."
    }
}
catch {
    Write-Error "An error occurred during uninstaller execution: $_"
}

# --- Step 5: Remove leftover files and folders ---
Write-Host "Removing leftover OneDrive application data and folders..." -ForegroundColor Yellow
$users = Get-ChildItem -Path C:\Users -Exclude Public, Default.migrated | Where-Object { $_.PSIsContainer }
foreach ($user in $users) {
    $userProfilePath = $user.FullName
    $oneDriveAppData = "$userProfilePath\AppData\Local\Microsoft\OneDrive"
    $oneDriveProgramData = "$env:ProgramData\Microsoft OneDrive"
    $oneDriveProfileFolder = "$userProfilePath\OneDrive"

    if (Test-Path -Path $oneDriveProfileFolder) {
        Remove-Item -Path $oneDriveProfileFolder -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
    }
    if (Test-Path -Path $oneDriveAppData) {
        Remove-Item -Path $oneDriveAppData -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
    }
}

if (Test-Path -Path "$env:ProgramData\Microsoft OneDrive") {
    Remove-Item -Path "$env:ProgramData\Microsoft OneDrive" -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
}

Write-Host "Leftover files and folders have been removed." -ForegroundColor Green

# --- Step 6: Remove OneDrive from File Explorer navigation pane ---
Write-Host "Removing OneDrive from File Explorer..." -ForegroundColor Yellow
$regPath = "HKCU:\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
if (Test-Path -Path $regPath) {
    Set-ItemProperty -Path $regPath -Name "System.IsPinnedToNameSpaceTree" -Value 0 -ErrorAction SilentlyContinue
    Write-Host "Registry key for File Explorer navigation pane has been updated." -ForegroundColor Green
}
else {
    Write-Warning "Could not find File Explorer registry key."
}

# --- Step 7: Clean up remaining registry keys ---
Write-Host "Cleaning up remaining registry keys..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -Value 1 -ErrorAction SilentlyContinue | Out-Null
Remove-Item -Path "HKCU:\SOFTWARE\Microsoft\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue | Out-Null

Write-Host "Registry cleanup complete." -ForegroundColor Green

# --- Step 8: Completion Message ---
[System.Windows.MessageBox]::Show(
    "Microsoft OneDrive has been completely uninstalled.`nA system restart may be required for all changes to take effect.",
    "Uninstall Complete",
    [System.Windows.MessageBoxButton]::OK,
    [System.Windows.MessageBoxImage]::Information
)
