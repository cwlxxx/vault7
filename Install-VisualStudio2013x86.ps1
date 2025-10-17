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
