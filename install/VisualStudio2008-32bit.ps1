# Visual C++ Redistributable (2008) - 32-bit

Write-Host "🔍 Checking for Visual C++ 2008 (x86)..."

if (-not (winget list --id Microsoft.VCRedist.2008.x86 | Select-String "Installed")) {
    Write-Host "📦 Installing Visual C++ 2008 (x86)..." -ForegroundColor Cyan
    winget install --id Microsoft.VCRedist.2008.x86 --source winget --accept-package-agreements --accept-source-agreements
    Write-Host "✅ Installation completed." -ForegroundColor Green
} else {
    Write-Host "✅ Visual C++ 2008 (x86) is already installed. Skipping." -ForegroundColor Yellow
}
