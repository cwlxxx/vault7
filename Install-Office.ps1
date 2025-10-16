# ============================================================
# 🧱 Office Installer Menu - GUI (Dark Mode)
# ============================================================

# ------------------------------------------------------------
# ⚙️ Section : Configuration - Start
# ------------------------------------------------------------
# 🔹 Change these values anytime without touching the rest of the script
$WindowTitle   = "Office Installer Menu"      # Window title bar text
$AppTitleText  = "Office Installer Menu"    # Main title label text
$FooterText    = "© 2025 CWL Tools - Office Installer"    # Footer text
# ------------------------------------------------------------
# ⚙️ Section : Configuration - End
# ------------------------------------------------------------


Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# ------------------------------------------------------------
# 🪟 Section : Form Setup - Start
# ------------------------------------------------------------
$form = New-Object System.Windows.Forms.Form
$form.Text = $WindowTitle
$form.StartPosition = "CenterScreen"

# Set client size to 800x800 and make non-resizable
$form.ClientSize = New-Object System.Drawing.Size(800, 800)
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
$form.MaximizeBox = $false
$form.MinimizeBox = $false

$form.BackColor = [System.Drawing.Color]::FromArgb(30, 30, 30)
$form.ForeColor = [System.Drawing.Color]::White
# ------------------------------------------------------------
# 🪟 Section : Form Setup - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# 🏷️ Section : Title Label - Start
# ------------------------------------------------------------
$titleLabel = New-Object System.Windows.Forms.Label
$titleLabel.Text = $AppTitleText
$titleLabel.AutoSize = $true
$titleLabel.Font = New-Object System.Drawing.Font("Segoe UI", 18, [System.Drawing.FontStyle]::Bold)
$titleLabel.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($titleLabel)
# ------------------------------------------------------------
# 🏷️ Section : Title Label - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# 🔘 Section : Exit Button - Start
# ------------------------------------------------------------
$btnExit = New-Object System.Windows.Forms.Button
$btnExit.Text = "Exit"
$btnExit.Width = 140
$btnExit.Height = 44
$btnExit.BackColor = [System.Drawing.Color]::FromArgb(60, 60, 60)
$btnExit.ForeColor = [System.Drawing.Color]::White
$btnExit.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$btnExit.FlatAppearance.BorderColor = [System.Drawing.Color]::Gray
$btnExit.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Regular)
$form.Controls.Add($btnExit)
# ------------------------------------------------------------
# 🔘 Section : Exit Button - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# 🧾 Section : Footer Label - Start
# ------------------------------------------------------------
$footerLabel = New-Object System.Windows.Forms.Label
$footerLabel.Text = $FooterText
$footerLabel.AutoSize = $true
$footerLabel.ForeColor = [System.Drawing.Color]::Gray
$footerLabel.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$form.Controls.Add($footerLabel)
# ------------------------------------------------------------
# 🧾 Section : Footer Label - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# 🧩 Section : Layout Alignment on Shown - Start
# ------------------------------------------------------------
$form.Add_Shown({
    # Center title at top
    $titleX = [math]::Floor(($form.ClientSize.Width - $titleLabel.PreferredWidth) / 2)
    $titleLabel.Location = New-Object System.Drawing.Point($titleX, 40)

    # Center footer at bottom
    $footerX = [math]::Floor(($form.ClientSize.Width - $footerLabel.PreferredWidth) / 2)
    $footerY = $form.ClientSize.Height - 36
    $footerLabel.Location = New-Object System.Drawing.Point($footerX, $footerY)

    # Center Exit button just above the footer
    $btnX = [math]::Floor(($form.ClientSize.Width - $btnExit.Width) / 2)
    $btnY = $footerY - $btnExit.Height - 12
    $btnExit.Location = New-Object System.Drawing.Point($btnX, $btnY)
})
# ------------------------------------------------------------
# 🧩 Section : Layout Alignment on Shown - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# 🚪 Section : Button Action - Start
# ------------------------------------------------------------
$btnExit.Add_Click({
    $form.Close()
})
# ------------------------------------------------------------
# 🚪 Section : Button Action - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# ▶️ Section : Show Form - Start
# ------------------------------------------------------------
[void]$form.ShowDialog()
# ------------------------------------------------------------
# ▶️ Section : Show Form - End
# ------------------------------------------------------------
