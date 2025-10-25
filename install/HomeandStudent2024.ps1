# ============================================================
# 🏢 Microsoft Office – Home and Student (2021 placeholder for now)
# ============================================================

$downloadPath = Join-Path $env:TEMP "OfficeInstaller"
$installerName = "Office_Home_Student.exe"
$targetFile = Join-Path $downloadPath $installerName

if (!(Test-Path $downloadPath)) { New-Item -ItemType Directory -Path $downloadPath | Out-Null }

# ✅ Download installer if missing
if (!(Test-Path $targetFile)) {
    Write-Host "Downloading Microsoft Office Home and Student..." -ForegroundColor Cyan
    $url = "https://c2rsetup.officeapps.live.com/c2r/download.aspx?ProductreleaseID=HomeStudent2021Retail&platform=x64&language=en-us&version=O16GA"
    Invoke-WebRequest -Uri $url -OutFile $targetFile
}

try {
    Write-Host "`nInstalling Microsoft Office Home and Student..." -ForegroundColor Yellow
    Start-Process -FilePath $targetFile -Wait
    Write-Host "`n✅ Installation completed successfully!" -ForegroundColor Green

    Write-Host "Creating Office shortcuts..." -ForegroundColor Cyan
    irm "https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/settings/CreateMSOfficeShortcut.ps1" | iex

    Write-Host "Cleaning up temporary files..." -ForegroundColor Yellow
    if (Test-Path $targetFile) { Remove-Item -Path $targetFile -Force -ErrorAction SilentlyContinue }
    if (Test-Path $downloadPath) { Remove-Item -Path $downloadPath -Force -Recurse -ErrorAction SilentlyContinue }

    Write-Host "`n🎉 All done! Microsoft Office is ready to use." -ForegroundColor Green
}
catch {
    Write-Host "`n❌ Error: $($_.Exception.Message)" -ForegroundColor Red
}

exit
