# ------------------------------------------------------------
# 🔋 Section : Power Status Detection - Start
# ------------------------------------------------------------
function Get-PowerStatus {
    try {
        # --- Get the active power scheme GUID ---
        $schemeLine = powercfg /getactivescheme 2>$null
        if ($schemeLine -match '([0-9a-fA-F\-]{36})') {
            $schemeGuid = $matches[1]
        } else {
            throw "Unable to detect active power scheme."
        }

        # --- Registry base path for active scheme ---
        $basePath = "HKLM:\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes\$schemeGuid"

        # --- Registry paths for display & sleep ---
        $videoKey = Join-Path $basePath "7516b95f-f776-4464-8c53-06167f40cc99\3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e"   # SUB_VIDEO\VIDEOIDLE
        $sleepKey = Join-Path $basePath "238C9FA8-0AAD-41ED-83F4-97BE242C8F20\29F6C1DB-86DA-48C5-9FDB-F2B67B1F44DA"   # SUB_SLEEP\STANDBYIDLE

        # --- Read values safely ---
        $videoValue = Get-ItemProperty -Path $videoKey -ErrorAction SilentlyContinue
        $sleepValue = Get-ItemProperty -Path $sleepKey -ErrorAction SilentlyContinue

        if (-not $videoValue -or -not $sleepValue) {
            throw "Cannot read registry values (need admin?)."
        }

        # --- Helper to interpret seconds ---
        $formatTimeout = {
            param($secs)
            if ($null -eq $secs) { return "Unknown" }
            if ($secs -eq 0) { return "Never" }
            $mins = [math]::Floor($secs / 60)
            if ($mins -eq 0) { return "$secs sec" }
            elseif ($mins -eq 1) { return "1 min" }
            else { return "$mins min" }
        }

        # --- Return structured object ---
        return [pscustomobject]@{
            ActiveScheme     = $schemeGuid
            MonitorTimeoutDC = & $formatTimeout $videoValue.DCSettingIndex
            MonitorTimeoutAC = & $formatTimeout $videoValue.ACSettingIndex
            SleepTimeoutDC   = & $formatTimeout $sleepValue.DCSettingIndex
            SleepTimeoutAC   = & $formatTimeout $sleepValue.ACSettingIndex
        }
    }
    catch {
        return [pscustomobject]@{
            ActiveScheme     = "Unknown"
            MonitorTimeoutDC = "Error"
            MonitorTimeoutAC = "Error"
            SleepTimeoutDC   = "Error"
            SleepTimeoutAC   = "Error"
            ErrorMessage     = $_.Exception.Message
        }
    }
}

# ------------------------------------------------------------
# 🔋 Section : Power Status Detection - End
# ------------------------------------------------------------
