# Install IrfanView
winget install --id=IrfanSkiljan.IrfanView --source winget
# Wait for IrfanView installation to finish creating shortcuts
Write-Host "⏳ Waiting for IrfanView installation to complete..." -ForegroundColor Cyan
$shortcutNames = @("IrfanView.lnk", "IrfanView 64-bit.lnk")
$desktopPaths = @(
    "$env:PUBLIC\Desktop",
    [Environment]::GetFolderPath('Desktop')
)
# Wait up to 30 seconds for shortcut creation
$foundShortcut = $false
for ($i = 0; $i -lt 30; $i++) {
    foreach ($desktop in $desktopPaths) {
        foreach ($name in $shortcutNames) {
            $shortcut = Join-Path $desktop $name
            if (Test-Path $shortcut) {
                $foundShortcut = $true
                break
            }
        }
        if ($foundShortcut) { break }
    }
    if ($foundShortcut) { break }
    Start-Sleep -Seconds 1
}
if ($foundShortcut) {
    Write-Host "🧩 IrfanView shortcut detected — proceeding to remove..." -ForegroundColor Yellow
} else {
    Write-Host "⚠️ No IrfanView shortcut detected after waiting — continuing anyway." -ForegroundColor DarkYellow
}
# Attempt to remove all possible IrfanView shortcuts
foreach ($desktop in $desktopPaths) {
    foreach ($name in $shortcutNames) {
        $shortcut = Join-Path $desktop $name
        if (Test-Path $shortcut) {
            try {
                Remove-Item $shortcut -Force
                Write-Host "🗑️ Removed desktop shortcut: $shortcut" -ForegroundColor Green
            } catch {
                Write-Host "⚠️ Failed to remove shortcut: $shortcut — $($_.Exception.Message)" -ForegroundColor Red
            }
        }
    }
}
Write-Host "✅ IrfanView desktop shortcut cleanup completed." -ForegroundColor Cyan
