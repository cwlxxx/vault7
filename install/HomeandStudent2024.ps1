# ============================================================
# 🏢 Microsoft Office – Home and Student (2021 placeholder for now)
# ============================================================

$downloadPath = Join-Path $env:TEMP "OfficeInstaller"
$installerName = "Office_Home_Student.exe"
$targetFile = Join-Path $downloadPath $installerName

# Ensure download folder exists
if (!(Test-Path $downloadPath)) {
    New-Item -ItemType Directory -Path $downloadPath | Out-Null
}



# ✅ Download installer if missing
if (!(Test-Path $targetFile)) {
    Write-Host "Downloading Microsoft Office Home and Student..." -ForegroundColor Cyan
    $url = "https://c2rsetup.officeapps.live.com/c2r/download.aspx?ProductreleaseID=HomeStudent2021Retail&platform=x64&language=en-us&version=O16GA"
    Invoke-WebRequest -Uri $url -OutFile $targetFile -UseBasicParsing
}


try {
    # 🚀 Start installer normally
    Write-Host "`nInstalling Microsoft Office Home and Student..." -ForegroundColor Yellow
    $process = Start-Process -FilePath $targetFile -PassThru
    $process.WaitForExit()

    Write-Host "`n✅ Installation completed successfully!" -ForegroundColor Green

    # 🧩 Run shortcut creation script (online, via irm)
    Write-Host "Creating Office shortcuts..." -ForegroundColor Cyan
    irm "https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/settings/CreateMSOfficeShortcut.ps1" | iex

    # 🧹 Cleanup installer files
    Write-Host "Cleaning up temporary files..." -ForegroundColor Yellow
    Remove-Item -Path $targetFile -Force -ErrorAction SilentlyContinue
    Remove-Item -Path $downloadPath -Force -Recurse -ErrorAction SilentlyContinue

    Write-Host "`n🎉 All done! Microsoft Office 2024 Home and Business is ready to use." -ForegroundColor Green
}
catch {
    Write-Host "`n❌ Error: $($_.Exception.Message)" -ForegroundColor Red
}

# Exit cleanly (no Pause)
exit
