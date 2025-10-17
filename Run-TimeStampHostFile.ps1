# ============================================================
# 🧱 Add Setup Info to Hosts File (Uniform Blue Buttons + 5s Pause)
# ============================================================

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# ------------------------------------------------------------
# 🪟 Section : Company Selection GUI - Start
# ------------------------------------------------------------
$form = New-Object System.Windows.Forms.Form
$form.Text = "PC Setup By"
$form.StartPosition = "CenterScreen"
$form.Size = New-Object System.Drawing.Size(360, 220)
$form.FormBorderStyle = 'FixedDialog'
$form.MaximizeBox = $false
$form.MinimizeBox = $false
$form.BackColor = [System.Drawing.Color]::FromArgb(32, 32, 32)
$form.TopMost = $true

$label = New-Object System.Windows.Forms.Label
$label.Text = "PC Setup By:"
$label.ForeColor = 'White'
$label.Font = New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(115, 30)
$form.Controls.Add($label)

# Shared button color (modern blue)
$buttonColor = [System.Drawing.Color]::FromArgb(0, 120, 215)

$buttonHytec = New-Object System.Windows.Forms.Button
$buttonHytec.Text = "Hytec"
$buttonHytec.Size = New-Object System.Drawing.Size(120, 60)
$buttonHytec.Location = New-Object System.Drawing.Point(40, 90)
$buttonHytec.BackColor = $buttonColor
$buttonHytec.ForeColor = 'White'
$buttonHytec.FlatStyle = 'Flat'
$buttonHytec.Font = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Regular)
$form.Controls.Add($buttonHytec)

$buttonEasyPC = New-Object System.Windows.Forms.Button
$buttonEasyPC.Text = "Easy PC"
$buttonEasyPC.Size = New-Object System.Drawing.Size(120, 60)
$buttonEasyPC.Location = New-Object System.Drawing.Point(190, 90)
$buttonEasyPC.BackColor = $buttonColor
$buttonEasyPC.ForeColor = 'White'
$buttonEasyPC.FlatStyle = 'Flat'
$buttonEasyPC.Font = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Regular)
$form.Controls.Add($buttonEasyPC)

$global:SetupBy = $null
$buttonHytec.Add_Click({ $global:SetupBy = "Hytec"; $form.Close() })
$buttonEasyPC.Add_Click({ $global:SetupBy = "Easy PC"; $form.Close() })

$form.ShowDialog() | Out-Null
# ------------------------------------------------------------
# 🪟 Section : Company Selection GUI - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# 🧱 Section : Write Setup Info to Hosts File - Start
# ------------------------------------------------------------
if (-not $SetupBy) { exit }

$TempFile = Join-Path $env:TEMP "hosttemp.txt"
$HostFile = "C:\Windows\System32\drivers\etc\hosts"

$SetupInfo = @()
$SetupInfo += "# PC Setup Date : $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')."
$SetupInfo += "# PC Setup By $SetupBy."
$SetupInfo += ""

$SetupInfo | Out-File -FilePath $TempFile -Encoding UTF8

if (Test-Path $HostFile) {
    Get-Content $HostFile | Add-Content -Path $TempFile -Encoding UTF8
    Move-Item -Path $TempFile -Destination $HostFile -Force
}

# Print updated hosts file content
Write-Host "`n=========================================" -ForegroundColor DarkGray
Write-Host " Updated Hosts File Content" -ForegroundColor Cyan
Write-Host "=========================================`n" -ForegroundColor DarkGray
Write-Host ""
Get-Content $HostFile | ForEach-Object { Write-Host $_ }
Write-Host ""
Write-Host "`n=========================================" -ForegroundColor DarkGray
Write-Host " End of Hosts File" -ForegroundColor Green
Write-Host "=========================================`n" -ForegroundColor DarkGray

# Pause 5 seconds before exiting
Write-Host "⏳ Closing in 1 seconds..." -ForegroundColor Yellow
Start-Sleep -Seconds 1
# ------------------------------------------------------------
# 🧱 Section : Write Setup Info to Hosts File - End
# ------------------------------------------------------------
