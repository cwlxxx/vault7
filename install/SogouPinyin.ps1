# =========================================================
# Section : Sogou Pinyin Installer & Language Adjuster (Safe IME Switch)
# Author  : Liang Edition
# Target  : PowerShell 7+
# Desc    : Installs/updates Sogou Pinyin via Winget, ensures en-US first,
#           ensures zh-Hans-CN is present, and switches zh IME to Sogou TIP.
#           Does NOT remove the zh language; only switches its input method.
# =========================================================

try {
    Write-Host "🔍 Checking for existing Sogou installation..." -ForegroundColor Cyan
    $SogouInstalled = winget list | Select-String -Pattern "Sogou Pinyin"

    if (-not $SogouInstalled) {
        Write-Host "➕ Installing Sogou Pinyin via Winget..." -ForegroundColor Yellow
        winget install --id Sogou.SogouInput --source winget --accept-package-agreements --accept-source-agreements
        Write-Host "✅ Sogou Pinyin installation completed." -ForegroundColor Green
    } else {
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
    } else {
        Write-Host "⚠️ English (US) not found — adding manually."
        $usLang = New-WinUserLanguageList en-US
        $langList.Insert(0, $usLang[0])
    }

    # --- Step 4 : Ensure zh-Hans-CN is present (for Sogou) ---
    $zhEntry = $langList | Where-Object { $_.LanguageTag -match 'zh-(CN|Hans-CN)' } | Select-Object -First 1
    if (-not $zhEntry) {
        Write-Host "➕ Adding Chinese (Simplified, zh-Hans-CN)..." -ForegroundColor Cyan
        $zhHans = New-WinUserLanguageList zh-Hans-CN
        foreach ($l in $zhHans) { $langList.Add($l) }
        $zhEntry = $langList | Where-Object { $_.LanguageTag -match 'zh-(CN|Hans-CN)' } | Select-Object -First 1
    } else {
        Write-Host "✅ zh-Hans-CN already present." -ForegroundColor Green
    }

    # --- Step 5 : Switch zh IME to Sogou TIP (don’t remove zh language) ---
    function Get-SogouZhTips {
        $tips = @()
        $base = "HKCU:\Software\Microsoft\CTF\TIP"
        if (Test-Path $base) {
            foreach ($tip in Get-ChildItem $base -ErrorAction SilentlyContinue) {
                $isSogou = $false
                # quick name check
                if ($tip.Name -match "Sogou") { $isSogou = $true }
                # description check
                $lpPath = Join-Path $tip.PSPath "LanguageProfile\0x00000804"
                if (-not $isSogou -and (Test-Path $lpPath)) {
                    foreach ($lp in Get-ChildItem $lpPath -ErrorAction SilentlyContinue) {
                        try {
                            $desc = (Get-ItemProperty $lp.PSPath -ErrorAction SilentlyContinue).Description
                            if ($desc -match "Sogou") { $isSogou = $true }
                        } catch {}
                    }
                }
                if ($isSogou -and (Test-Path $lpPath)) {
                    foreach ($lp in Get-ChildItem $lpPath -ErrorAction SilentlyContinue) {
                        $guid = $lp.PSChildName # e.g. {XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX}
                        if ($guid) { $tips += $guid }
                    }
                }
            }
        }
        return $tips | Select-Object -Unique
    }

    if ($zhEntry) {
        $sogouTips = Get-SogouZhTips
        if ($sogouTips.Count -gt 0) {
            $preferred = $sogouTips[0]
            # IME TIP format is LANGID:GUID, where zh-CN = 0x0804 -> "0804"
            $zhEntry.InputMethodTips = @("0804:$preferred")
            Write-Host "🎯 Set zh IME to Sogou ($preferred)." -ForegroundColor Yellow
        } else {
            Write-Host "⚠️ Sogou TIP not detected in registry yet. Keeping current zh IME." -ForegroundColor DarkYellow
        }
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

    Write-Host "`n✅ Sogou Pinyin ready — English (US) default, zh uses Sogou IME." -ForegroundColor Cyan
}
catch {
    Write-Host "❌ Error during setup: $($_.Exception.Message)" -ForegroundColor Red
}
# =========================================================
# End of Sogou Pinyin Installer
# =========================================================
