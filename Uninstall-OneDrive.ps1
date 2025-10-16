# --- Step 1: Ensure script is running with administrator privileges ---
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# --- Step 2: Confirmation Prompt ---
Write-Host "WARNING: This script will perform a complete uninstallation of Microsoft OneDrive." -ForegroundColor Yellow
Write-Host "This will affect all user profiles on this PC." -ForegroundColor Yellow
$confirmation = Read-Host "Are you sure you want to proceed? (Y/N)"

if ($confirmation -notmatch '^[yY]$') {
    Write-Host "Uninstallation cancelled by user. Exiting script." -ForegroundColor Red
    exit
}

# --- Step 3: Stop all OneDrive processes ---
Write-Host "Stopping all running OneDrive processes..." -ForegroundColor Yellow
Stop-Process -Name "OneDrive" -Force -ErrorAction SilentlyContinue | Out-Null
Write-Host "OneDrive processes stopped." -ForegroundColor Green

# --- Step 4: Run the official uninstaller for all users ---
Write-Host "Running OneDrive uninstaller for all users..." -ForegroundColor Yellow
try {
    # Find the path to the OneDrive uninstaller
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

    # Remove user-specific OneDrive folder
    if (Test-Path -Path $oneDriveProfileFolder) {
        Remove-Item -Path $oneDriveProfileFolder -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
    }

    # Remove user-specific AppData folder
    if (Test-Path -Path $oneDriveAppData) {
        Remove-Item -Path $oneDriveAppData -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
    }
}

# Remove all-user program data folder
if (Test-Path -Path $oneDriveProgramData) {
    Remove-Item -Path $oneDriveProgramData -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
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
# Disable OneDrive Group Policy (prevents it from starting)
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -Value 1 -ErrorAction SilentlyContinue | Out-Null

# Remove OneDrive uninstall key
Remove-Item -Path "HKCU:\SOFTWARE\Microsoft\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue | Out-Null

Write-Host "Registry cleanup complete." -ForegroundColor Green

Write-Host "`nMicrosoft OneDrive has been completely uninstalled." -ForegroundColor Green
Write-Host "A system restart may be required for all changes to take effect." -ForegroundColor Green