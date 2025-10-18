# ============================================================
# 🧱 Block Executables in Folder - Smart Firewall Rules (Indexed, Multi-Folder)
# ============================================================

# ------------------------------------------------------------
# 🧩 Section : Script Metadata - Start
# ------------------------------------------------------------
$ScriptName    = "Block Executables in Folder - Smart Firewall Rules (Indexed, Multi-Folder)"
$ScriptVersion = "2.0"
$ScriptAuthor  = "Liang"
$Title         = "$ScriptName - v$ScriptVersion by $ScriptAuthor"

Write-Host "`n==============================================" -ForegroundColor DarkCyan
Write-Host "🧱 $ScriptName" -ForegroundColor Cyan
Write-Host "📜 Version : $ScriptVersion" -ForegroundColor Gray
Write-Host "👤 Author  : $ScriptAuthor" -ForegroundColor Gray
Write-Host "==============================================" -ForegroundColor DarkCyan

$Host.UI.RawUI.WindowTitle = $Title
# ------------------------------------------------------------
# 🧩 Section : Script Metadata - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# ⚙️ Section : Configuration - Start
# ------------------------------------------------------------
$TargetFolders = @(
    "C:\Program Files\kdenlive",
    "C:\Program Files\OBS Studio"
)
$RulePrefix    = "Blocked By CWL"
$FileType      = ".exe"
$ExitDelaySec  = 5
# ------------------------------------------------------------
# ⚙️ Section : Configuration - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# 🧩 Section : Helper Function - Start
# ------------------------------------------------------------
function Test-FirewallRuleMatch {
    param (
        [Parameter(Mandatory)] [Microsoft.Management.Infrastructure.CimInstance] $Rule,
        [Parameter(Mandatory)] [string] $ExpectedName,
        [Parameter(Mandatory)] [string] $ExpectedProgram,
        [Parameter(Mandatory)] [string] $ExpectedDirection
    )

    $filter = Get-NetFirewallApplicationFilter -ErrorAction SilentlyContinue |
              Where-Object { $_.InstanceID -eq $Rule.InstanceID }
    $programPath = $filter.Program

    $match = (
        ($Rule.DisplayName -eq $ExpectedName) -and
        ($Rule.Direction   -eq $ExpectedDirection) -and
        ($Rule.Action      -eq 'Block') -and
        ($Rule.Enabled     -eq 'True') -and
        ($Rule.Profile     -eq 'Any') -and
        ($programPath      -eq $ExpectedProgram)
    )

    if (-not $match) {
        $reasons = @()
        if ($Rule.DisplayName -ne $ExpectedName)      { $reasons += "Rule name mismatch" }
        if ($Rule.Direction   -ne $ExpectedDirection) { $reasons += "Direction mismatch" }
        if ($Rule.Action      -ne 'Block')            { $reasons += "Action not Block" }
        if ($Rule.Enabled     -ne 'True')             { $reasons += "Rule disabled" }
        if ($Rule.Profile     -ne 'Any')              { $reasons += "Profile mismatch" }
        if ($programPath      -ne $ExpectedProgram)   { $reasons += "Program path mismatch" }

        return ,$false, ($reasons -join ", ")
    }

    return ,$true, "OK"
}
# ------------------------------------------------------------
# 🧩 Section : Helper Function - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# 🚀 Section : Indexing Firewall Rules - Start
# ------------------------------------------------------------
Write-Host "`n⚡ Indexing all existing firewall rules..." -ForegroundColor Cyan
$allRules = @()
$ruleCount = 0

Get-NetFirewallRule -ErrorAction SilentlyContinue | ForEach-Object {
    $ruleCount++
    if ($ruleCount % 50 -eq 0) {
        Write-Host "   🔢 Indexed $ruleCount rules..." -ForegroundColor DarkGray
    }
    $appFilter = Get-NetFirewallApplicationFilter -AssociatedNetFirewallRule $_ -ErrorAction SilentlyContinue
    if ($appFilter.Program) {
        $allRules += [PSCustomObject]@{
            Name    = $_.Name
            Display = $_.DisplayName
            Program = $appFilter.Program
        }
    }
}

Write-Host "✅ Done indexing firewall rules. Total indexed: $ruleCount" -ForegroundColor Green
# ------------------------------------------------------------
# 🚀 Section : Indexing Firewall Rules - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# 🚀 Section : Execution - Start
# ------------------------------------------------------------
[int]$addedCount = 0
[int]$removedDupCount = 0

foreach ($folder in $TargetFolders) {
    Write-Host "`n🔍 Scanning folder: $folder" -ForegroundColor Cyan
    $exeFiles = Get-ChildItem -Path $folder -Recurse -Filter "*$FileType" -ErrorAction SilentlyContinue

    if (-not $exeFiles) {
        Write-Host "❌ No files found in $folder" -ForegroundColor Red
        continue
    }

    foreach ($exe in $exeFiles) {
        $exePath = $exe.FullName
        $ruleNameIn  = "$RulePrefix IN $exePath"
        $ruleNameOut = "$RulePrefix OUT $exePath"

        Write-Host "`n🟦 Checking: $exePath" -ForegroundColor Yellow

        # ------------------------------------------------------------
        # 🧹 Remove duplicate rules (same path)
        # ------------------------------------------------------------
        $dupRules = $allRules | Where-Object { $_.Program -eq $exePath }
        if ($dupRules) {
            foreach ($r in $dupRules) {
                Remove-NetFirewallRule -Name $r.Name -ErrorAction SilentlyContinue
                Write-Host "   🧹 Removed duplicate rule → $($r.Display)" -ForegroundColor DarkGray
                $removedDupCount++
            }
        }

        # ------------------------------------------------------------
        # 🔨 Create new inbound and outbound rules
        # ------------------------------------------------------------
        foreach ($direction in @("Inbound", "Outbound")) {
            $ruleName = if ($direction -eq "Inbound") { $ruleNameIn } else { $ruleNameOut }

            New-NetFirewallRule -DisplayName $ruleName `
                                -Direction $direction `
                                -Action Block `
                                -Program $exePath `
                                -Profile Any `
                                -Enabled True `
                                -ErrorAction SilentlyContinue | Out-Null

            Write-Host "   ➕ [$direction] $exePath → Added new firewall rule." -ForegroundColor Green
            $addedCount++
        }
    }
}
# ------------------------------------------------------------
# 🚀 Section : Execution - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# 📊 Section : Summary - Start
# ------------------------------------------------------------
Write-Host "`n==============================================" -ForegroundColor DarkCyan
Write-Host "✅ Completed processing of all target folders" -ForegroundColor Cyan
Write-Host "🧹 Duplicates Removed : $removedDupCount" -ForegroundColor DarkGray
Write-Host "🧱 New Rules Added    : $addedCount" -ForegroundColor Green
Write-Host "==============================================" -ForegroundColor DarkCyan
Write-Host "`nWaiting $ExitDelaySec seconds before exit..." -ForegroundColor Gray
Start-Sleep -Seconds $ExitDelaySec
# ------------------------------------------------------------
# 📊 Section : Summary - End
# ------------------------------------------------------------
