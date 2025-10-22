# =========================================================
# Section : Sogou Pinyin Installer & Language Adjuster
# Author  : Liang Edition
# Target  : PowerShell 7+
# Desc    : Installs Sogou Pinyin via Winget, removes Microsoft Pinyin,
#           keeps English (US) default and zh-Hans-CN second.
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
    $originalLangList = Get-WinUserLanguageList

    # Deep clone into editable generic list
    $langList = [System.Collections.Generic.List[
        Microsoft.InternationalSettings.Commands.WinUserLanguage]]::new()
    foreach ($lang in $originalLangList) { $langList.Add($lang) }

    # --- Step 3 : Ensure English (US) is present and default ---
    $usLang = $langList | Where-Object { $_.LanguageTag -eq 'en-US' }
    if ($usLang) {
        Write-Host "✅ English (US) found — setting as default."
        foreach ($lang in $usLang) { $null = $langList.Remove($lang) }
        foreach ($lang in [array]$usLang) { $langList.Insert(0, $lang) }
    }
    else {
        Write-Host "⚠️ English (US) not found — adding manually."
        $usLang = New-WinUserLanguageList en-US
        $langList.Insert(0, $usLang[0])
    }

    # --- Step 4 : Remove Microsoft Pinyin (zh-CN / zh-Hans-CN) ---
    $beforeCount = $langList.Count
    $filtered = $langList | Where-Object {
        if ($_.LanguageTag -match 'zh-(CN|Hans-CN)') {
            # Verify if IME belongs to Microsoft (not Sogou)
            $isMicrosoftIME = $true
            try {
                $imeKey = "HKCU:\Software\Microsoft\CTF\TIP"
                if (Test-Path $imeKey) {
                    $isMicrosoftIME = (Get-ChildItem $imeKey -Recurse -ErrorAction SilentlyContinue |
                        Where-Object { $_.Name -match "Sogou" }) -eq $null
                }
            } catch { }

            if ($isMicrosoftIME) {
                Write-Host "🗑️ Removing Microsoft Pinyin (zh-CN / zh-Hans-CN)..." -ForegroundColor Yellow
                $false
            } else { $true }
        } else { $true }
    }

    # Re-wrap filtered list to remain editable
    $langList = [System.Collections.Generic.List[
        Microsoft.InternationalSettings.Commands.WinUserLanguage]]::new()
    foreach ($lang in $filtered) { $langList.Add($lang) }

    if ($langList.Count -lt $beforeCount) {
        Write-Host "✅ Microsoft Pinyin removed from language list." -ForegroundColor Green
    }

    # --- Step 5 : Ensure zh-Hans-CN present for Sogou ---
    if (-not ($langList | Where-Object { $_.LanguageTag -match 'zh-Hans-CN' })) {
        Write-Host "➕ Adding Chinese (Simplified, zh-Hans-CN) for Sogou IME..." -ForegroundColor Cyan
        $zhHans = New-WinUserLanguageList zh-Hans-CN
        foreach ($lang in $zhHans) { $langList.Add($lang) }
    } else {
        Write-Host "✅ zh-Hans-CN already present (Sogou compatible)." -ForegroundColor Green
    }

    # --- Step 6 : Apply updated language list ---
    Set-WinUserLanguageList $langList -Force | Out-Null
    Write-Host "✅ Updated language configuration applied." -ForegroundColor Green

    # --- Step 7 : Refresh input service (ctfmon) ---
    Write-Host "🔄 Refreshing input service..." -ForegroundColor Cyan
    Start-Process -FilePath "cmd.exe" -ArgumentList '/c taskkill /im ctfmon.exe /f' -WindowStyle Hidden | Out-Null
    Start-Sleep -Milliseconds 800
    Start-Process -FilePath "$env:SystemRoot\System32\ctfmon.exe" -WindowStyle Hidden | Out-Null

    # --- Step 8 : Show summary ---
    Write-Host "`n📋 Final language list:" -ForegroundColor Cyan
    Get-WinUserLanguageList | ForEach-Object { Write-Host " - $($_.LanguageTag)" }

    Write-Host "`n✅ Sogou Pinyin ready — Microsoft Pinyin removed, English (US) default." -ForegroundColor Cyan
}
catch {
    Write-Host "❌ Error during setup: $($_.Exception.Message)" -ForegroundColor Red
}
# =========================================================
# End of Sogou Pinyin Installer
# =========================================================
