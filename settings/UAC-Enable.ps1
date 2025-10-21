
$regPath = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
try {
    Write-Host "⚙️ Restoring default User Account Control (UAC) settings..." -ForegroundColor Cyan
    # Enable UAC system-wide
    Set-ItemProperty -Path $regPath -Name 'EnableLUA' -Value 1 -Force
    # Default behavior: notify when apps make changes (on secure desktop)
    Set-ItemProperty -Path $regPath -Name 'ConsentPromptBehaviorAdmin' -Value 5 -Force
    Write-Host "✅ Default UAC level restored successfully." -ForegroundColor Green
    Write-Host "⚠️ A system reboot is required for changes to take full effect." -ForegroundColor Yellow
}
catch {
    Write-Host "❌ Failed to restore UAC default settings: $($_.Exception.Message)" -ForegroundColor Red
}
