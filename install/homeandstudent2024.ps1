# ============================================================
# 🏢 Microsoft Office 2024 - Home and Student (Download Only)
# ============================================================

# Create folder
$downloadPath = Join-Path $env:TEMP "OfficeInstaller"
if (!(Test-Path $downloadPath)) {
    New-Item -ItemType Directory -Path $downloadPath | Out-Null
}

# Define file path
$installerName = "Office_Home_Student_2024.exe"
$targetFile = Join-Path $downloadPath $installerName

# Define download link
$url = "https://c2rsetup.officeapps.live.com/c2r/download.aspx?ProductreleaseID=Home2024Retail&platform=x64&language=en-us&version=O16GA"

Write-Host "Downloading Microsoft Office 2024 Home and Student..." -ForegroundColor Cyan
Write-Host "Destination: $targetFile" -ForegroundColor Yellow

try {
    # ✅ Use Invoke-WebRequest for modern HTTPS streaming
    Invoke-WebRequest -Uri $url -OutFile $targetFile -UseBasicParsing
    Write-Host "`n✅ Download completed successfully!" -ForegroundColor Green
    Write-Host "File saved to: $targetFile" -ForegroundColor White
}
catch {
    Write-Host "`n❌ Download failed: $($_.Exception.Message)" -ForegroundColor Red
}

Pause
