# ---------------------------------------------
# Section : Add Chinese (Simplified, China) IME - Start
# ---------------------------------------------
try {
    Write-Host "🔍 Checking current keyboard language list..." -ForegroundColor Cyan
    $langList = Get-WinUserLanguageList

    # --- Step 1 : Ensure English (US) is present and default ---
    $usLang = $langList | Where-Object { $_.LanguageTag -eq 'en-US' }
    if ($usLang) {
        Write-Host "✅ English (US) already exists — setting as default." -ForegroundColor Green
        $langList = @($usLang) + ($langList | Where-Object { $_.LanguageTag -ne 'en-US' })
    } else {
        Write-Host "⚠️ English (US) not found — adding it manually." -ForegroundColor Yellow
        $usLang = New-WinUserLanguageList en-US
        $langList = @($usLang) + $langList
    }

    # --- Step 2 : Ensure Chinese (Simplified, China) IME exists ---
    $zhCN = $langList | Where-Object { $_.LanguageTag -eq 'zh-CN' }
    if ($zhCN) {
        Write-Host "✅ Chinese (Simplified, China) already in list." -ForegroundColor Green
    } else {
        Write-Host "➕ Adding Chinese (Simplified, China) with Microsoft Pinyin IME..." -ForegroundColor Yellow
        $zhCN = New-WinUserLanguageList zh-CN
        $langList += $zhCN
    }

    # --- Step 3 : Apply new list ---
    Set-WinUserLanguageList $langList -Force
    Write-Host "✅ Keyboard language list updated successfully." -ForegroundColor Green

    # --- Step 4 : Refresh input service (instant effect) ---
    Write-Host "🔄 Refreshing input method bar..." -ForegroundColor Cyan
    Start-Process -FilePath "cmd.exe" -ArgumentList '/c taskkill /im ctfmon.exe /f' -WindowStyle Hidden | Out-Null
    Start-Sleep -Seconds 1
    Start-Process -FilePath "$env:SystemRoot\System32\ctfmon.exe" -WindowStyle Hidden

    # --- Step 5 : Show final list ---
    Write-Host "`n📋 Final keyboard layout list:"
    Get-WinUserLanguageList | ForEach-Object {
        Write-Host " - $($_.LanguageTag)"
    }

    Write-Host "`n✨ Input language refreshed — Microsoft Pinyin added successfully." -ForegroundColor Green
}
catch {
    Write-Host "❌ Error updating language list: $($_.Exception.Message)" -ForegroundColor Red
}
# ---------------------------------------------
# Section : Add Chinese (Simplified, China) IME - End
# ---------------------------------------------
