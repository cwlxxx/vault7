# Install Zoom 
winget install --id Zoom.Zoom --source winget
# Wait for Zoom installation to finish creating shortcuts
Write-Host "⏳ Waiting for Zoom installation to complete..." -ForegroundColor Cyan
$shortcutNames = @("Zoom.lnk", "Zoom Meetings.lnk")
$desktopPaths = @(
    "$env:PUBLIC\Desktop",
    [Environment]::GetFolderPath('Desktop')
)
# Wait loop (max 30 seconds total)
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
    Write-Host "🧩 Zoom shortcut detected — proceeding to remove..." -ForegroundColor Yellow
} else {
    Write-Host "⚠️ No Zoom shortcut detected after waiting — continuing anyway." -ForegroundColor DarkYellow
}
# Attempt to remove all possible Zoom shortcuts
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
Write-Host "✅ Zoom desktop shortcut cleanup completed." -ForegroundColor Cyan
