Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# ------------------------------------------------------------
# 🧩 Section : Script Metadata - Start
# ------------------------------------------------------------
# Update this version string whenever you edit the script.
$ScriptVersion = "2.1"
$ScriptTitle   = "Basic Software And Setup Menu - Ver. $ScriptVersion"
# ------------------------------------------------------------
# 🧩 Section : Script Metadata - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# 💡 Section : Applications List - Start
# ------------------------------------------------------------
$applications = @(
    @{ Name = "Sougou Pinyin - winget"; Script = "winget install --id Sogou.SogouInput --source winget --accept-package-agreements --accept-source-agreements --silent" },
    @{ Name = "Zoom - winget"; Script = "winget install --id Zoom.Zoom --source winget --accept-package-agreements --accept-source-agreements --silent" },
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
    @{ Name = "Java Runtime - javadl.oracle.com"; Script = "irm https://raw.githubusercontent.com/cwlxxx/vault7/main/ | iex" },
    @{ Name = "Avira Anti-Virus - package.avira.com"; Script = "irm https://raw.githubusercontent.com/cwlxxx/vault7/main/ | iex" }
)
# ------------------------------------------------------------
# 💡 Section : Applications List - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# 🧩 Section : Runtime & Frameworks List - Start
# ------------------------------------------------------------
$runtimes = @(
    @{ Name = "Visual C++ Redistributable 2013(x86)"; Script = "irm https://raw.githubusercontent.com/cwlxxx/vault7/main/Install-VisualStudio2013x86.ps1 | iex" },
	@{ Name = "Visual C++ Redistributable 2013(x64)"; Script = "irm https://raw.githubusercontent.com/cwlxxx/vault7/main/Install-VisualStudio2013x64.ps1 | iex" },
	@{ Name = "Visual C++ Redistributable 2015-2022 (x86)"; Script = "irm https://raw.githubusercontent.com/cwlxxx/vault7/main/Install-VC++2015-2022x86.ps1| iex" },
	@{ Name = "Visual C++ Redistributable 2015-2022 (x64)"; Script = "irm https://raw.githubusercontent.com/cwlxxx/vault7/main/Install-VC++2015-2022x64.ps1 | iex" }
)
# ------------------------------------------------------------
# 🧩 Section : Runtime & Frameworks List - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# ⚙️ Section : Settings List - Start
# ------------------------------------------------------------
$settings = @(
	@{ Name = "Time Stamp In Host Files"; Script = "irm https://raw.githubusercontent.com/cwlxxx/vault7/main/Run-TimeStampHostFile.ps1 | iex" },
	@{ Name = "Open UAC Settings"; Script = "irm https://raw.githubusercontent.com/cwlxxx/vault7/main/Run-UAC-Setting.ps1 | iex" },
    @{ Name = "Enable 'This PC' Icon etc."; Script = "irm https://raw.githubusercontent.com/cwlxxx/vault7/main/Setting-EnableDesktopIcons.ps1 | iex" },
    @{ Name = "Never Turn Off Monitor and Never Sleep"; Script = "irm https://raw.githubusercontent.com/cwlxxx/vault7/main/Setting-NoSleepNoMonitorOff.ps1 | iex" },
    @{ Name = "Disable Windows Fast Startup"; Script = "irm https://raw.githubusercontent.com/cwlxxx/vault7/main/Setting-DisableWindowsFastStartup.ps1 | iex" }
)
# ------------------------------------------------------------
# ⚙️ Section : Settings List - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# 🪟 Section : Form Setup - Start
# ------------------------------------------------------------
$form = New-Object System.Windows.Forms.Form
$form.Text = $ScriptTitle
$form.StartPosition = "CenterScreen"
$form.Size = New-Object System.Drawing.Size(1300, 870)
$form.BackColor = [System.Drawing.Color]::FromArgb(30,30,30)
$form.ForeColor = "White"
$form.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$form.FormBorderStyle = 'FixedDialog'
$form.MaximizeBox = $false
$form.MinimizeBox = $true
$form.ControlBox = $true
# ------------------------------------------------------------
# 🪟 Section : Form Setup - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# 🧩 Section : GUI Layout - Start
# ------------------------------------------------------------

# Disable resizing again
$form.FormBorderStyle = 'FixedDialog'

# GroupBox: Applications
$appGroup = New-Object System.Windows.Forms.GroupBox
$appGroup.Text = "Applications"
$appGroup.ForeColor = 'White'
$appGroup.BackColor = $form.BackColor
$appGroup.Location = New-Object System.Drawing.Point(10, 42)
$appGroup.Size = New-Object System.Drawing.Size(620, 390)
$form.Controls.Add($appGroup)

# Header Label
$headerLabel = New-Object System.Windows.Forms.Label
$headerLabel.Text = "Select Items To Install or Run:"
$headerLabel.ForeColor = "White"
$headerLabel.Font = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
$headerLabel.Location = New-Object System.Drawing.Point(10, 15)
$headerLabel.AutoSize = $true
$form.Controls.Add($headerLabel)

# GroupBox: Runtime and Frameworks (new)
$runtimeGroup = New-Object System.Windows.Forms.GroupBox
$runtimeGroup.Text = "Runtime and Frameworks"
$runtimeGroup.ForeColor = 'White'
$runtimeGroup.BackColor = $form.BackColor
$runtimeGroup.Location = New-Object System.Drawing.Point(10, 440)
$runtimeGroup.Size = New-Object System.Drawing.Size(620, 140)
$form.Controls.Add($runtimeGroup)

# GroupBox: Settings
$setGroup = New-Object System.Windows.Forms.GroupBox
$setGroup.Text = "Settings"
$setGroup.ForeColor = 'White'
$setGroup.BackColor = $form.BackColor
$setGroup.Location = New-Object System.Drawing.Point(10, 588)
$setGroup.Size = New-Object System.Drawing.Size(620, 140)
$form.Controls.Add($setGroup)

# Log Box
$logBox = New-Object System.Windows.Forms.TextBox
$logBox.Multiline = $true
$logBox.ScrollBars = "Vertical"
$logBox.ReadOnly = $true
$logBox.BackColor = "#1e1e1e"
$logBox.ForeColor = "White"
$logBox.Font = New-Object System.Drawing.Font("Consolas", 10)
$logBox.Location = New-Object System.Drawing.Point(640, 50)
$logBox.Size = New-Object System.Drawing.Size(630, 680)
$form.Controls.Add($logBox)

# ProgressBar
$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Style = "Blocks"
$progressBar.Location = New-Object System.Drawing.Point(640, 750)
$progressBar.Size = New-Object System.Drawing.Size(610, 30)
$form.Controls.Add($progressBar)
# ------------------------------------------------------------
# 🧩 Section : GUI Layout - End
# ------------------------------------------------------------



# ------------------------------------------------------------
# ☑️ Section : Checkbox Creation - Start
# ------------------------------------------------------------
$checkboxes = [System.Collections.ArrayList]::new()

function Add-Checkboxes-TwoColumns {
    param (
        [Parameter(Mandatory=$true)][object[]]$items,
        [Parameter(Mandatory=$true)]$container
    )

    $colCount = 2
    $colWidth = 280
    $xStart = 20
    $yStart = 28
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
Add-Checkboxes-TwoColumns -items $runtimes -container $runtimeGroup
Add-Checkboxes-TwoColumns -items $settings -container $setGroup
# ------------------------------------------------------------
# ☑️ Section : Checkbox Creation - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# 🔘 Section : Buttons Layout - Start
# ------------------------------------------------------------

# --- Independent Position Controls ---
[int]$exitX        = 36
[int]$exitY        = 750

[int]$checkAllX    = 340
[int]$checkAllY    = 750

[int]$uncheckAllX  = 230
[int]$uncheckAllY  = 750

[int]$runX         = 450
[int]$runY         = 750

[int]$btnWidth     = 100
[int]$btnHeight    = 30

# --- Colors ---
$normalDark = [System.Drawing.Color]::FromArgb(60, 60, 60)
$hoverDark  = [System.Drawing.Color]::FromArgb(90, 90, 90)
$white      = [System.Drawing.Color]::White
$blueNormal = [System.Drawing.Color]::FromArgb(0, 120, 215)
$blueHover  = [System.Drawing.Color]::FromArgb(40, 140, 255)
$redNormal  = [System.Drawing.Color]::FromArgb(180, 40, 40)
$redHover   = [System.Drawing.Color]::FromArgb(200, 60, 60)

# --- Helper Function ---
function Set-ButtonStyle {
    param (
        $btn,
        [System.Drawing.Color]$normalColor,
        [System.Drawing.Color]$hoverColor,
        [System.Drawing.Color]$textColor
    )

    $btn.FlatStyle = 'Flat'
    $btn.FlatAppearance.BorderSize = 0
    $btn.BackColor = $normalColor
    $btn.FlatAppearance.MouseOverBackColor = $hoverColor
    $btn.ForeColor = $textColor
    $btn.Font = New-Object System.Drawing.Font("Segoe UI", 9)
}

# --- Exit Button (far left) ---
$btnExit = New-Object System.Windows.Forms.Button
$btnExit.Text = "Exit"
$btnExit.Size = New-Object System.Drawing.Size($btnWidth, $btnHeight)
$btnExit.Location = New-Object System.Drawing.Point($exitX, $exitY)
Set-ButtonStyle $btnExit $redNormal $redHover $white
$form.Controls.Add($btnExit)
$btnExit.Add_Click({ $form.Close() })

# --- Check All Button ---
$btnCheckAll = New-Object System.Windows.Forms.Button
$btnCheckAll.Text = "Check All"
$btnCheckAll.Size = New-Object System.Drawing.Size($btnWidth, $btnHeight)
$btnCheckAll.Location = New-Object System.Drawing.Point($checkAllX, $checkAllY)
Set-ButtonStyle $btnCheckAll $normalDark $hoverDark $white
$form.Controls.Add($btnCheckAll)

# --- Uncheck All Button ---
$btnUncheckAll = New-Object System.Windows.Forms.Button
$btnUncheckAll.Text = "Uncheck All"
$btnUncheckAll.Size = New-Object System.Drawing.Size($btnWidth, $btnHeight)
$btnUncheckAll.Location = New-Object System.Drawing.Point($uncheckAllX, $uncheckAllY)
Set-ButtonStyle $btnUncheckAll $normalDark $hoverDark $white
$form.Controls.Add($btnUncheckAll)

# --- Run Selected Button ---
$btnRun = New-Object System.Windows.Forms.Button
$btnRun.Text = "Run Selected"
$btnRun.Size = New-Object System.Drawing.Size(150, $btnHeight)
$btnRun.Location = New-Object System.Drawing.Point($runX, $runY)
Set-ButtonStyle $btnRun $blueNormal $blueHover $white
$form.Controls.Add($btnRun)

# ------------------------------------------------------------
# 🔘 Section : Buttons Layout - End
# ------------------------------------------------------------





# ------------------------------------------------------------
# ⚙️ Section : Button Actions - Start
# ------------------------------------------------------------
$btnCheckAll.Add_Click({ foreach ($cb in $checkboxes) { $cb.Checked = $true } })
$btnUncheckAll.Add_Click({ foreach ($cb in $checkboxes) { $cb.Checked = $false } })

$btnRun.Add_Click({
    $selected = @()
    $appCount = $applications.Count
    $runtimeCount = $runtimes.Count

    # Run SETTINGS first
    for ($j = 0; $j -lt $settings.Count; $j++) {
        $idx = $appCount + $runtimeCount + $j
        if ($checkboxes[$idx].Checked) { $selected += $settings[$j] }
    }

    # Then APPLICATIONS
    for ($i = 0; $i -lt $appCount; $i++) {
        if ($checkboxes[$i].Checked) { $selected += $applications[$i] }
    }

    # Then RUNTIMES
    for ($r = 0; $r -lt $runtimeCount; $r++) {
        $idx = $appCount + $r
        if ($checkboxes[$idx].Checked) { $selected += $runtimes[$r] }
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

            $remainingOut = $process.StandardOutput.ReadToEnd()
            $remainingErr = $process.StandardError.ReadToEnd()
            if ($remainingOut) { $logBox.AppendText("$remainingOut`r`n") }
            if ($remainingErr) { $logBox.AppendText("⚠ Error:`r`n$remainingErr`r`n") }

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
# ------------------------------------------------------------
# ⚙️ Section : Button Actions - End
# ------------------------------------------------------------

# ------------------------------------------------------------
# 🧩 Section : Footer Line - Start
# ------------------------------------------------------------
[int]$footerLineY = 800       # vertical position from the top
[int]$footerLineWidth = 1220  # line width
[int]$footerLineHeight = 2    # line thickness
$footerLineColor = [System.Drawing.Color]::FromArgb(80, 80, 80)

$footerLine = New-Object System.Windows.Forms.Label
$footerLine.BackColor = $footerLineColor
$footerLine.Height = $footerLineHeight
$footerLine.Width = $footerLineWidth

# --- Center it horizontally and set its position ---
$footerLine.Location = New-Object System.Drawing.Point(
    [math]::Max(0, ($form.ClientSize.Width - $footerLine.Width) / 2),
    $footerLineY
)

# --- Recenter automatically when window resizes ---
$form.Add_Resize({
    $footerLine.Left = [math]::Max(0, ($form.ClientSize.Width - $footerLine.Width) / 2)
})

$form.Controls.Add($footerLine)
# ------------------------------------------------------------
# 🧩 Section : Footer Line - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# 🏷️ Section : Footer Label - Start
# ------------------------------------------------------------
[int]$footerLabelY = 808     # vertical position (adjust to move up/down)
[string]$footerText = "© 2025 Liang Automation Installer"
$footerFont  = New-Object System.Drawing.Font("Segoe UI", 9)
$footerColor = [System.Drawing.Color]::FromArgb(160, 160, 160)

$footerLabel = New-Object System.Windows.Forms.Label
$footerLabel.Text = $footerText
$footerLabel.ForeColor = $footerColor
$footerLabel.Font = $footerFont
$footerLabel.AutoSize = $true
$footerLabel.BackColor = [System.Drawing.Color]::Transparent

# Add label first, then center it after form loads
$form.Controls.Add($footerLabel)

$form.Add_Shown({
    $footerLabel.Left = [math]::Max(0, ($form.ClientSize.Width - $footerLabel.Width) / 2)
    $footerLabel.Top  = $footerLabelY
})

# Recenter automatically when window resizes
$form.Add_Resize({
    $footerLabel.Left = [math]::Max(0, ($form.ClientSize.Width - $footerLabel.Width) / 2)
})

# ------------------------------------------------------------
# 🏷️ Section : Footer Label - End
# ------------------------------------------------------------




# ------------------------------------------------------------
# ▶️ Section : Run Form - Start
# ------------------------------------------------------------
[void]$form.ShowDialog()
# ------------------------------------------------------------
# ▶️ Section : Run Form - End
# ------------------------------------------------------------



