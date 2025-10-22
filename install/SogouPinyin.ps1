# =========================================================
# Section : Sogou Pinyin Installer & Language Adjuster
# Author  : Liang Edition
# Target  : PowerShell 7+
# Desc    : Installs Sogou Pinyin via winget, removes Microsoft Pinyin,
#           keeps English (US) as default. No popups, no pause.
# =========================================================

try {
    Write-Host "🔍 Checking for existing Sogou installation..." -ForegroundColor Cyan
    $SogouInstalled = winget list | Select-String -Pattern "Sogou Pinyin"

    if (-not $SogouInstalled) {
        Write-Host "➕ Installing Sogou Pinyin via Winget..." -ForegroundColor Yellow
        winget install --id Sogou.SogouInput --source winget --accept-package-agreements --accept-source-agreements
        Write-Host "✅ Sogou Pinyin installation completed." -ForegroundColor Green
    }
    else {
        Write-Host "✅ Sogou Pinyin already installed." -ForegroundColor Green
    }

    # --- Step 2 : Adjust Windows language list ---
    Write-Host "⚙️ Adjusting language settings..." -ForegroundColor Cyan
    $langList = Get-WinUserLanguageList

    # --- Step 3 : Ensure English (US) is default ---
    $usLang = $langList | Where-Object { $_.LanguageTag -eq 'en-US' }
    if ($usLang) {
        Write-Host "✅ English (US) found — setting as default."
        $langList = @($usLang) + ($langList | Where-Object { $_.LanguageTag -ne 'en-US' })
    } else {
        Write-Host "⚠️ English (US) not found — adding manually."
        $usLang = New-WinUserLanguageList en-US
        $langList = @($usLang) + $langList
    }

    # --- Step 4 : Remove Microsoft Pinyin (zh-CN) if exists ---
    $before = $langList.Count
    $langList = $langList | Where-Object {
        if ($_.LanguageTag -eq 'zh-CN') {
            Write-Host "🗑️ Removing Microsoft Pinyin (zh-CN)..." -ForegroundColor Yellow
            $false
        } else {
            $true
        }
    }
    if ($before -ne $langList.Count) {
        Write-Host "✅ Microsoft Pinyin removed from language list." -ForegroundColor Green
    }

    # --- Step 5 : Apply updated language list ---
    Set-WinUserLanguageList $langList -Force | Out-Null
    Write-Host "✅ Updated language configuration applied." -ForegroundColor Green

    # --- Step 6 : Refresh input method bar (ctfmon restart) ---
    Write-Host "🔄 Refreshing input service..." -ForegroundColor Cyan
    Start-Process -FilePath "cmd.exe" -ArgumentList '/c taskkill /im ctfmon.exe /f' -WindowStyle Hidden | Out-Null
    Start-Sleep -Milliseconds 800
    Start-Process -FilePath "$env:SystemRoot\System32\ctfmon.exe" -WindowStyle Hidden | Out-Null

    Write-Host "`n📋 Final language list:"
    Get-WinUserLanguageList | ForEach-Object { Write-Host " - $($_.LanguageTag)" }

    Write-Host "`n✅ Sogou Pinyin ready — Microsoft Pinyin removed, English (US) default." -ForegroundColor Cyan
}
catch {
    Write-Host "❌ Error during setup: $($_.Exception.Message)" -ForegroundColor Red
}
# =========================================================
# End of Sogou Pinyin Installer
# =========================================================
