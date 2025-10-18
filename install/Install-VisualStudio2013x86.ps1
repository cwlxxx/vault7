# ------------------------------------------------------------
# 🚀 Section : Download Visual Studio 2013 (VC++ 12.0) x86 - Start
# ------------------------------------------------------------

$downloadUrl = "https://aka.ms/highdpimfc2013x86enu"
$destinationFolder = Join-Path $env:TEMP "Installer"
$destinationFile = Join-Path $destinationFolder "vcredist2013_x86.exe"

try {
    # Ensure the folder exists
    if (-not (Test-Path $destinationFolder)) {
        New-Item -ItemType Directory -Path $destinationFolder -Force | Out-Null
    }

    Write-Host "🚀 Downloading Visual Studio 2013 (VC++ 12.0) 32-bit using BITS..."

    # Start BITS download
    Start-BitsTransfer -Source $downloadUrl -Destination $destinationFile -DisplayName "VC++ 2013 x86" -Description "Downloading Visual C++ 2013 Redistributable (x86)"

    Write-Host "✅ Download completed successfully: $destinationFile"
}
catch {
    Write-Host "❌ Failed to download VC++ 2013 (x86). Error: $($_.Exception.Message)" -ForegroundColor Red
}

# ------------------------------------------------------------
# 🚀 Section : Download Visual Studio 2013 (VC++ 12.0) x86 - End
# ------------------------------------------------------------

# ------------------------------------------------------------
# ⚙️ Section : Install Visual Studio 2013 (VC++ 12.0) x86 - Start
# ------------------------------------------------------------

$installerPath = Join-Path $env:TEMP "Installer\vcredist2013_x86.exe"

if (Test-Path $installerPath) {
    Write-Host "🧩 Installing Visual Studio 2013 (VC++ 12.0) 32-bit..."
    
    # Launch installer with GUI (no /quiet), wait until finish
    Start-Process -FilePath $installerPath -ArgumentList "/install", "/norestart" -Wait

    Write-Host "✅ Installation completed for Visual Studio 2013 (VC++ 12.0) 32-bit."
}
else {
    Write-Host "⚠️ Installer not found: $installerPath" -ForegroundColor Yellow
}

# ------------------------------------------------------------
# ⚙️ Section : Install Visual Studio 2013 (VC++ 12.0) x86 - End
# ------------------------------------------------------------

