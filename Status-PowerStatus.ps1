# ------------------------------------------------------------
# 🔋 Section : Power Status Detection - Start
# ------------------------------------------------------------
function Get-PowerStatus {
    try {
        # get active scheme GUID (robust)
        $schemeLine = powercfg /getactivescheme 2>$null
        if ($schemeLine -match 'GUID[:\s]*([0-9a-fA-F\-]+)') {
            $scheme = $matches[1]
        } else {
            # fallback: use "powercfg /getactivescheme" full output trimmed
            $scheme = ($schemeLine -join "`n").Trim()
        }

        # helper: parse a powercfg /query block and extract AC or DC index (prefer AC)
        $parseIndex = {
            param($block)
            # find lines like:
            #   Current AC Power Setting Index: 0x00000000
            #   Current DC Power Setting Index: 0x00000000
            $ac = $null; $dc = $null
            foreach ($line in $block) {
                if ($line -match 'Current\s+AC\s+Power\s+Setting\s+Index:\s*(0x[0-9a-fA-F]+|\d+)') { $ac = $matches[1] }
                if ($line -match 'Current\s+DC\s+Power\s+Setting\s+Index:\s*(0x[0-9a-fA-F]+|\d+)') { $dc = $matches[1] }
                if ($line -match 'Current\s+Power\s+Setting\s+Index:\s*(0x[0-9a-fA-F]+|\d+)') {
                    # some locales/use-cases don't label AC/DC; treat as both
                    if (-not $ac) { $ac = $matches[1] }
                    if (-not $dc) { $dc = $matches[1] }
                }
            }
            # prefer AC, then DC, then null
            return $ac ?? $dc
        }

        # get raw blocks for video idle and standby idle
        $videoBlock = (powercfg /query $scheme SUB_VIDEO VIDEOIDLE) 2>$null
        $sleepBlock = (powercfg /query $scheme SUB_SLEEP STANDBYIDLE) 2>$null

        $videoIndexRaw = & $parseIndex $videoBlock
        $sleepIndexRaw = & $parseIndex $sleepBlock

        # convert raw (hex or decimal) to int; null => -1 (unknown)
        $toInt = {
            param($raw)
            if (-not $raw) { return -1 }
            if ($raw -match '^0x') { return [convert]::ToInt32($raw,16) }
            else { return [int]$raw }
        }

        $monitorSeconds = & $toInt $videoIndexRaw
        $sleepSeconds   = & $toInt $sleepIndexRaw

        # Interpret values: powercfg often stores timeouts in seconds; 0 means 'Never'
        $formatTimeout = {
            param($secs)
            if ($secs -lt 0) { return "Unknown" }
            if ($secs -eq 0) { return "Never" }
            # if value looks like minutes already (e.g., > 3600 unlikely) still convert to minutes for readability
            $mins = [math]::Floor($secs / 60)
            if ($mins -eq 0) {
                return "$secs sec"
            } elseif ($mins -eq 1) {
                return "1 min"
            } else {
                return "$mins min"
            }
        }

        $monitorStatus = & $formatTimeout $monitorSeconds
        $sleepStatus   = & $formatTimeout $sleepSeconds

        return " - Turn off the display: $monitorStatus`n    - Put the computer to sleep: $sleepStatus"
    }
    catch {
        return "Error reading power settings: $($_.Exception.Message)"
    }
}
$sleepstatus = Get-PowerStatus
# ------------------------------------------------------------
# 🔋 Section : Power Status Detection - End
# ------------------------------------------------------------
