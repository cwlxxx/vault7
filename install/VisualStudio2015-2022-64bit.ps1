# Visual C++ Redistributable (2015–2022) - 64-bit

Write-Host "🔍 Checking for Visual C++ 2015–2022 (x64)..."

if (-not (winget list --id Microsoft.VCRedist.2015+.x64 | Select-String "Installed")) {
    Write-Host "📦 Installing Visual C++ 2015–2022 (x64)..." -ForegroundColor Cyan
    winget install --id Microsoft.VCRedist.2015+.x64 --source winget --accept-package-agreements --accept-source-agreements
    Write-Host "✅ Installation completed." -ForegroundColor Green
} else {
    Write-Host "✅ Visual C++ 2015–2022 (x64) is already installed. Skipping." -ForegroundColor Yellow
}
