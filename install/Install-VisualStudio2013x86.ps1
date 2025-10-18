# ============================================================
# 🧱 Microsoft Visual C++ Redistributable 2013 (VC++ 12.0) Downloader & Silent Installer (x86)
# ============================================================

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

    Start-BitsTransfer -Source $downloadUrl -Destination $destinationFile -DisplayName "VC++ 2013 x86" -Description "Downloading Visual C++ 2013 Redistributable (x86)"

    Write-Host "✅ Download completed successfully: $destinationFile"
}
catch {
    Write-Host "❌ Failed to download VC++ 2013 (x86). Error: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# ------------------------------------------------------------
# 🚀 Section : Download Visual Studio 2013 (VC++ 12.0) x86 - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# ⚙️ Section : Silent Install Visual Studio 2013 (VC++ 12.0) x86 - Start
# ------------------------------------------------------------

if (Test-Path $destinationFile) {
    Write-Host "🧩 Installing Visual Studio 2013 (VC++ 12.0) 32-bit silently..."
    
    # Silent install with simple progress indicator
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
# ⚙️ Section : Silent Install Visual Studio 2013 (VC++ 12.0) x86 - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# 🧹 Section : Cleanup Temporary Files - Start
# ------------------------------------------------------------

try {
    if (Test-Path $destinationFile) {
        Remove-Item $destinationFile -Force
        Write-Host "🧹 Installer file removed from %TEMP%\Installer."
    }

    if (-not (Get-ChildItem $destinationFolder -ErrorAction SilentlyContinue)) {
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
