# ============================================================
# 🧱 Microsoft Visual C++ Redistributable (2015–2022) Downloader & Installer (x86)
# ============================================================

# ------------------------------------------------------------
# 🚀 Section : Download VC++ 2015–2022 (x86) - Start
# ------------------------------------------------------------

$downloadUrl = "https://aka.ms/vs/17/release/vc_redist.x86.exe"
$destinationFolder = Join-Path $env:TEMP "Installer"
$destinationFile = Join-Path $destinationFolder "vc_redist2015-2022_x86.exe"

try {
    # Ensure the folder exists
    if (-not (Test-Path $destinationFolder)) {
        New-Item -ItemType Directory -Path $destinationFolder -Force | Out-Null
    }

    Write-Host "🚀 Downloading VC++ 2015–2022 (x86) using BITS..."

    Start-BitsTransfer -Source $downloadUrl -Destination $destinationFile -DisplayName "VC++ 2015–2022 x86" -Description "Downloading Microsoft Visual C++ Redistributable (2015–2022) x86"

    Write-Host "✅ Download completed successfully: $destinationFile"
}
catch {
    Write-Host "❌ Failed to download VC++ 2015–2022 (x86). Error: $($_.Exception.Message)" -ForegroundColor Red
}

# ------------------------------------------------------------
# 🚀 Section : Download VC++ 2015–2022 (x86) - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# ⚙️ Section : Install VC++ 2015–2022 (x86) - Start
# ------------------------------------------------------------

$installerPath = Join-Path $env:TEMP "Installer\vc_redist2015-2022_x86.exe"

if (Test-Path $installerPath) {
    Write-Host "🧩 Installing Microsoft Visual C++ Redistributable (2015–2022) 32-bit..."
    
    # Launch installer with GUI (no /quiet), wait until finish
    Start-Process -FilePath $installerPath -ArgumentList "/install", "/norestart" -Wait

    Write-Host "✅ Installation completed for Microsoft Visual C++ Redistributable (2015–2022) 32-bit."
}
else {
    Write-Host "⚠️ Installer not found: $installerPath" -ForegroundColor Yellow
}

# ------------------------------------------------------------
# ⚙️ Section : Install VC++ 2015–2022 (x86) - End
# ------------------------------------------------------------
