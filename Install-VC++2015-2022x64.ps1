# ------------------------------------------------------------
# 🚀 Section : Download VC++ 2015–2022 (x64) - Start
# ------------------------------------------------------------

$downloadUrl = "https://aka.ms/vs/17/release/vc_redist.x64.exe"
$destinationFolder = Join-Path $env:TEMP "Installer"
$destinationFile = Join-Path $destinationFolder "vc_redist2015-2022_x64.exe"

try {
    # Ensure the folder exists
    if (-not (Test-Path $destinationFolder)) {
        New-Item -ItemType Directory -Path $destinationFolder -Force | Out-Null
    }

    Write-Host "🚀 Downloading VC++ 2015–2022 (x64) using BITS..."

    Start-BitsTransfer -Source $downloadUrl -Destination $destinationFile -DisplayName "VC++ 2015–2022 x64" -Description "Downloading Microsoft Visual C++ Redistributable (2015–2022) x64"

    Write-Host "✅ Download completed successfully: $destinationFile"
}
catch {
    Write-Host "❌ Failed to download VC++ 2015–2022 (x64). Error: $($_.Exception.Message)" -ForegroundColor Red
}

# ------------------------------------------------------------
# 🚀 Section : Download VC++ 2015–2022 (x64) - End
# ------------------------------------------------------------
