# ============================================================
# 🧱 Microsoft Visual C++ Redistributable (2015–2022) Downloader & Silent Installer (x86)
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
    exit 1
}

# ------------------------------------------------------------
# 🚀 Section : Download VC++ 2015–2022 (x86) - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# ⚙️ Section : Silent Install VC++ 2015–2022 (x86) - Start
# ------------------------------------------------------------

if (Test-Path $destinationFile) {
    Write-Host "🧩 Installing Microsoft Visual C++ Redistributable (2015–2022) 32-bit silently..."
    
    # Silent install with progress feedback
    $process = Start-Process -FilePath $destinationFile -ArgumentList "/install", "/quiet", "/norestart" -PassThru
    while (-not $process.HasExited) {
        Write-Host "." -NoNewline
        Start-Sleep -Seconds 2
    }
    Write-Host "`n✅ Installation completed successfully."
}
else {
    Write-Host "⚠️ Installer not found: $destinationFile" -ForegroundColor Yellow
    exit 1
}

# ------------------------------------------------------------
# ⚙️ Section : Silent Install VC++ 2015–2022 (x86) - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# 🧹 Section : Cleanup Temporary Files - Start
# ------------------------------------------------------------

try {
    if (Test-Path $destinationFile) {
        Remove-Item $destinationFile -Force
        Write-Host "🧹 Installer file removed from %TEMP%\Installer."
    }

    # Remove folder if empty
    if (-not (Get-ChildItem $destinationFolder)) {
        Remove-Item $destinationFolder -Force
        Write-Host "🧹 Temporary installer folder cleaned up."
    }
}
catch {
    Write-Host "⚠️ Cleanup failed: $($_.Exception.Message)" -ForegroundColor Yellow
}

# ------------------------------------------------------------
# 🧹 Section : Cleanup Temporary Files - End
# ------------------------------------------------------------
