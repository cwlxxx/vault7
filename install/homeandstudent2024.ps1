# ============================================================
# 🏢 Microsoft Office 2024 - Home and Student (Download Only)
# ============================================================

# Create download directory
$downloadPath = Join-Path $env:TEMP "OfficeInstaller"
if (!(Test-Path $downloadPath)) {
    New-Item -ItemType Directory -Path $downloadPath | Out-Null
}

# Define installer name and target
$installerName = "Office_Home_Student_2024.exe"
$targetFile = Join-Path $downloadPath $installerName

# Define download link
$url = "https://c2rsetup.officeapps.live.com/c2r/download.aspx?ProductreleaseID=Home2024Retail&platform=x64&language=en-us&version=O16GA"

Write-Host "Downloading Microsoft Office 2024 Home and Student..." -ForegroundColor Cyan
Write-Host "Destination: $targetFile" -ForegroundColor Yellow

# Start BITS download
Start-BitsTransfer -Source $url -Destination $targetFile -DisplayName "Office 2024 Home and Student" -Description "Downloading Office setup..." -Priority High

# Confirm completion
if (Test-Path $targetFile) {
    Write-Host "`n✅ Download completed successfully!" -ForegroundColor Green
    Write-Host "File saved to: $targetFile" -ForegroundColor White
} else {
    Write-Host "`n❌ Download failed. Please check your internet connection or URL." -ForegroundColor Red
}

Pause
