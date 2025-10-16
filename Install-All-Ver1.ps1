Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# ==============================
# 💡 Applications List (edit here)
# ==============================
$applications = @(
    @{ Name = "Zoom - winget"; Script = "winget install --id Zoom.Zoom --source winget --accept-package-agreements --accept-source-agreements --silent" },
    @{ Name = "Sougou Pinyin - winget"; Script = "winget install --id Sogou.SogouInput --source winget --accept-package-agreements --accept-source-agreements --silent" },
    @{ Name = "AnyDesk - winget"; Script = "winget install --id AnyDesk.AnyDesk --source winget --accept-package-agreements --accept-source-agreements --silent" },
    @{ Name = "doPDF 11 - winget"; Script = "winget install --id Softland.doPDF.11 --source winget --accept-package-agreements --accept-source-agreements --silent" },
    @{ Name = "WinRAR - winget"; Script = "winget install --id RARLab.WinRAR --source winget --accept-package-agreements --accept-source-agreements --silent" },
    @{ Name = "UltraViewer - winget"; Script = "winget install --id DucFabulous.UltraViewer --source winget --accept-package-agreements --accept-source-agreements --silent" },
    @{ Name = "IrfanView - winget"; Script = "winget install --id=IrfanSkiljan.IrfanView --source winget --disable-package-auto-start --accept-package-agreements --accept-source-agreements --silent" },
    @{ Name = "K-Lite Full - winget"; Script = "winget install --id CodecGuide.K-LiteCodecPack.Full --source winget --accept-package-agreements --accept-source-agreements --silent" },
    @{ Name = "VLC Player - winget"; Script = "winget install --id VideoLAN.VLC --source winget --accept-package-agreements --accept-source-agreements --silent" },
    @{ Name = "Mozilla FireFox - winget"; Script = "winget install --id Mozilla.Firefox --source winget --accept-package-agreements --accept-source-agreements --silent" },
    @{ Name = "Google Chrome - winget"; Script = "winget install --id Google.Chrome --source winget --accept-package-agreements --accept-source-agreements --silent" },
    @{ Name = "Adobe Acrobat Reader - winget"; Script = "winget install --id Adobe.Acrobat.Reader.64-bit --source winget --accept-package-agreements --accept-source-agreements --silent" },
    @{ Name = "Java Runtime - javadl.oracle.com"; Script = "irm 192.168.0.3/powershell/Install-Java.ps1 | iex" },
    @{ Name = "Avira Anti-Virus - package.avira.com"; Script = "irm 192.168.0.3/powershell/Install-avira.ps1 | iex" }
)

# ==============================
# ⚙️ Settings List (edit here)
# ==============================
$settings = @(
    @{ Name = "Open UAC Settings"; Script = "Start-Process UserAccountControlSettings.exe -Wait" },
    @{ Name = "Enable 'This PC' Icon etc."; Script = "irm 192.168.0.3/powershell/Enable-DesktopIcons.ps1 | iex" },
    @{ Name = "Never Turn Off Monitor and Never Sleep"; Script = "irm 192.168.0.3/powershell/setting-nosleep-nooffmonitor.ps1 | iex" }
#    @{ Name = "System Information"; Script = "msinfo32" }
)

# ==============================
# 🖥️ GUI Layout
# ==============================
$form = New-Object System.Windows.Forms.Form
$form.Text = "Basic Software and Setup"
$form.Size = New-Object System.Drawing.Size(1100, 750)
$form.StartPosition = "CenterScreen"
$form.BackColor = [System.Drawing.Color]::FromArgb(32,32,32)
$form.ForeColor = [System.Drawing.Color]::White
$form.Font = New-Object System.Drawing.Font("Segoe UI", 10)

# Title
$label = New-Object System.Windows.Forms.Label
$label.Text = "Select items to install or run:"
$label.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(15, 10)
$form.Controls.Add($label)

# Applications box
$appGroup = New-Object System.Windows.Forms.GroupBox
$appGroup.Text = "Applications"
$appGroup.Size = New-Object System.Drawing.Size(550, 400)
$appGroup.Location = New-Object System.Drawing.Point(15, 40)
$appGroup.ForeColor = "White"
$form.Controls.Add($appGroup)

# Settings box (shorter height)
$setGroup = New-Object System.Windows.Forms.GroupBox
$setGroup.Text = "Settings"
$setGroup.Size = New-Object System.Drawing.Size(550, 200)
$setGroup.Location = New-Object System.Drawing.Point(15, 455)
$setGroup.ForeColor = "White"
$form.Controls.Add($setGroup)

# Log box
$logBox = New-Object System.Windows.Forms.TextBox
$logBox.Multiline = $true
$logBox.ScrollBars = "Vertical"
$logBox.ReadOnly = $true
$logBox.BackColor = [System.Drawing.Color]::FromArgb(25,25,25)
$logBox.ForeColor = "White"
$logBox.Size = New-Object System.Drawing.Size(480, 600)
$logBox.Location = New-Object System.Drawing.Point(580, 40)
$form.Controls.Add($logBox)

# Progress bar
$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Location = New-Object System.Drawing.Point(580, 650)
$progressBar.Size = New-Object System.Drawing.Size(480, 25)
$form.Controls.Add($progressBar)

# ==============================
# Checkboxes creation
# ==============================
$checkboxes = [System.Collections.ArrayList]::new()

function Add-Checkboxes-TwoColumns {
    param (
        [Parameter(Mandatory=$true)][object[]]$items,
        [Parameter(Mandatory=$true)]$container
    )

    $colCount = 2
    $colWidth = 260
    $xStart = 15
    $yStart = 25
    $yOffset = 30
    $rowsPerCol = [int][math]::Ceiling($items.Count / $colCount)

    for ($i = 0; $i -lt $items.Count; $i++) {
        if ($i -lt $rowsPerCol) {
            $col = 0
            $row = $i
        } else {
            $col = 1
            $row = $i - $rowsPerCol
        }

        $x = [int]($xStart + ($col * $colWidth))
        $y = [int]($yStart + ($row * $yOffset))

        $cb = New-Object System.Windows.Forms.CheckBox
        $cb.Text = $items[$i].Name
        $cb.Tag  = $items[$i].Script
        $cb.ForeColor = "White"
        $cb.AutoSize = $true
        $cb.Checked = $true
        $cb.Location = New-Object System.Drawing.Point($x, $y)
        $container.Controls.Add($cb)
        [void]$checkboxes.Add($cb)
    }
}

Add-Checkboxes-TwoColumns -items $applications -container $appGroup
Add-Checkboxes-TwoColumns -items $settings -container $setGroup

# ==============================
# Buttons (bottom left-aligned, centered under Settings)
# ==============================

[int]$btnY = 670
[int]$startX = 180   # Shifted right for visual balance
[int]$spacing = 120
[int]$btnWidth = 100
[int]$btnHeight = 30

# Define colors properly as System.Drawing.Color objects
$normalDark = [System.Drawing.Color]::FromArgb(60, 60, 60)
$hoverDark  = [System.Drawing.Color]::FromArgb(90, 90, 90)
$white      = [System.Drawing.Color]::White
$blueNormal = [System.Drawing.Color]::FromArgb(0, 120, 215)
$blueHover  = [System.Drawing.Color]::FromArgb(40, 140, 255)

function Set-ButtonStyle {
    param ($btn, [System.Drawing.Color]$normalColor, [System.Drawing.Color]$hoverColor, [System.Drawing.Color]$textColor)

    $btn.FlatStyle = 'Flat'
    $btn.FlatAppearance.BorderSize = 0
    $btn.BackColor = $normalColor
    $btn.FlatAppearance.MouseOverBackColor = $hoverColor
    $btn.ForeColor = $textColor
    $btn.Font = New-Object System.Drawing.Font("Segoe UI", 9)
}

# --- Check All ---
$btnCheckAll = New-Object System.Windows.Forms.Button
$btnCheckAll.Text = "Check All"
$btnCheckAll.Size = New-Object System.Drawing.Size($btnWidth, $btnHeight)
$btnCheckAll.Location = New-Object System.Drawing.Point($startX, $btnY)
Set-ButtonStyle $btnCheckAll $normalDark $hoverDark $white
$form.Controls.Add($btnCheckAll)

# --- Uncheck All ---
$btnUncheckAll = New-Object System.Windows.Forms.Button
$btnUncheckAll.Text = "Uncheck All"
$btnUncheckAll.Size = New-Object System.Drawing.Size($btnWidth, $btnHeight)
$btnUncheckAll.Location = New-Object System.Drawing.Point(($startX + $spacing), $btnY)
Set-ButtonStyle $btnUncheckAll $normalDark $hoverDark $white
$form.Controls.Add($btnUncheckAll)

# --- Run Selected ---
$btnRun = New-Object System.Windows.Forms.Button
$btnRun.Text = "Run Selected"
$btnRun.Size = New-Object System.Drawing.Size(120, $btnHeight)
$btnRun.Location = New-Object System.Drawing.Point(($startX + (2 * $spacing) + 10), $btnY)
Set-ButtonStyle $btnRun $blueNormal $blueHover $white
$form.Controls.Add($btnRun)





# ==============================
# Button Actions
# ==============================
$btnCheckAll.Add_Click({
    foreach ($cb in $checkboxes) { 
        $cb.Checked = $true 
    }
})

$btnUncheckAll.Add_Click({
    foreach ($cb in $checkboxes) { 
        $cb.Checked = $false 
    }
})

$btnRun.Add_Click({
    $selected = @()
    $appCount = $applications.Count

    # Collect SETTINGS first (run these before applications)
    for ($j = 0; $j -lt $settings.Count; $j++) {
        $idx = $appCount + $j
        if ($checkboxes[$idx].Checked) { 
            $selected += $settings[$j] 
        }
    }

    # Collect APPLICATIONS after
    for ($i = 0; $i -lt $appCount; $i++) {
        if ($checkboxes[$i].Checked) { 
            $selected += $applications[$i] 
        }
    }

    if ($selected.Count -eq 0) {
        [System.Windows.Forms.MessageBox]::Show("Please select at least one item.", "No Selection", "OK", "Warning")
        return
    }

    $progressBar.Value = 0
    $progressBar.Maximum = $selected.Count
    $logBox.Clear()

    foreach ($item in $selected) {
        $logBox.AppendText("▶ Running: $($item.Name)`r`n")
        $form.Refresh()

        try {
            # Create PowerShell process for full output capture
            $psi = New-Object System.Diagnostics.ProcessStartInfo
            $psi.FileName = "powershell.exe"
            $psi.Arguments = "-NoProfile -ExecutionPolicy Bypass -Command `"$($item.Script)`""
            $psi.RedirectStandardOutput = $true
            $psi.RedirectStandardError = $true
            $psi.UseShellExecute = $false
            $psi.CreateNoWindow = $true

            $process = New-Object System.Diagnostics.Process
            $process.StartInfo = $psi
            $process.Start() | Out-Null

            # Stream output smoothly as it appears
            while (-not $process.HasExited) {
                while (-not $process.StandardOutput.EndOfStream) {
                    $line = $process.StandardOutput.ReadLine()
                    if ($line) {
                        $logBox.AppendText("$line`r`n")
                        $logBox.SelectionStart = $logBox.Text.Length
                        $logBox.ScrollToCaret()
                        $form.Refresh()
                    }
                }
                Start-Sleep -Milliseconds 100
            }

            # Read remaining output/errors after process exit
            $remainingOut = $process.StandardOutput.ReadToEnd()
            $remainingErr = $process.StandardError.ReadToEnd()
            if ($remainingOut) {
                $logBox.AppendText("$remainingOut`r`n")
            }
            if ($remainingErr) {
                $logBox.AppendText("⚠ Error:`r`n$remainingErr`r`n")
            }

            $logBox.AppendText("✔ Completed: $($item.Name)`r`n`r`n")
            $logBox.SelectionStart = $logBox.Text.Length
            $logBox.ScrollToCaret()
        }
        catch {
            $logBox.AppendText("❌ Failed: $($item.Name) - $($_.Exception.Message)`r`n`r`n")
            $logBox.SelectionStart = $logBox.Text.Length
            $logBox.ScrollToCaret()
        }

        $progressBar.PerformStep()
        $form.Refresh()
    }

    [System.Windows.Forms.MessageBox]::Show("All selected items completed.", "Done", "OK", "Information")
})


# ==============================
# Run Form
# ==============================
[void]$form.ShowDialog()


