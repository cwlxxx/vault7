# ============================================================
# 🧱 Office Installer Menu - GUI (Dark Mode)
# ============================================================

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# ------------------------------------------------------------
# 🪟 Section : Form Setup - Start
# ------------------------------------------------------------
$form = New-Object System.Windows.Forms.Form
$form.Text = "Office Installer Menu - Ver0.2"
$form.StartPosition = "CenterScreen"
$form.Size = New-Object System.Drawing.Size(800, 600)
$form.BackColor = [System.Drawing.Color]::FromArgb(30, 30, 30)
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
$form.MaximizeBox = $false
# ------------------------------------------------------------
# 🪟 Section : Form Setup - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# 🏷️ Section : Title Label - Start
# ------------------------------------------------------------
$titleLabel = New-Object System.Windows.Forms.Label
$titleLabel.Text = "Office Installer Menu"
$titleLabel.ForeColor = [System.Drawing.Color]::White
$titleLabel.Font = New-Object System.Drawing.Font("Segoe UI", 20, [System.Drawing.FontStyle]::Bold)
$titleLabel.AutoSize = $true
$form.Controls.Add($titleLabel)

# Align title in center
$form.Add_Shown({
    $titleX = [math]::Floor(($form.ClientSize.Width - $titleLabel.PreferredWidth) / 2)
    $titleLabel.Location = New-Object System.Drawing.Point($titleX, 40)
})
# ------------------------------------------------------------
# 🏷️ Section : Title Label - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# 🧾 Section : Footer Label + Line - Start
# ------------------------------------------------------------
# Footer bottom line (dark gray) - keep docked
$footerLine = New-Object System.Windows.Forms.Panel
$footerLine.Height = 1
$footerLine.Dock = [System.Windows.Forms.DockStyle]::Bottom
$footerLine.BackColor = [System.Drawing.Color]::FromArgb(64, 64, 64)
$form.Controls.Add($footerLine)

# Footer label
$FooterText = "© 2025 CWL Tools - Office Installer"
$footerLabel = New-Object System.Windows.Forms.Label
$footerLabel.Text = $FooterText
$footerLabel.ForeColor = [System.Drawing.Color]::Gray
$footerLabel.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Regular)
$footerLabel.AutoSize = $true
$form.Controls.Add($footerLabel)

# Upper footer line (shorter, above label)
$footerTopLine = New-Object System.Windows.Forms.Panel
$footerTopLine.Height = 1
$footerTopLine.BackColor = [System.Drawing.Color]::FromArgb(64, 64, 64)
$form.Controls.Add($footerTopLine)

# Alignment for footer label + top line
$form.Add_Shown({
    [int]$formWidth  = $form.ClientSize.Width
    [int]$formHeight = $form.ClientSize.Height

    # Footer label position
    [int]$footerX = [math]::Floor(($formWidth - $footerLabel.PreferredWidth) / 2)
    [int]$footerY = $formHeight - 40   # 🔹 Slightly higher for better spacing
    $footerLabel.Location = New-Object System.Drawing.Point($footerX, $footerY)

    # Top line width (80% of form width, centered)
    [int]$lineWidth = [math]::Floor($formWidth * 0.8)
    [int]$lineX = [math]::Floor(($formWidth - $lineWidth) / 2)

    # Position line 20px above label
    [int]$topLineY = [int]($footerY - 20)
    $footerTopLine.Size = New-Object System.Drawing.Size($lineWidth, 1)
    $footerTopLine.Location = New-Object System.Drawing.Point($lineX, $topLineY)
})
# ------------------------------------------------------------
# 🧾 Section : Footer Label + Line - End
# ------------------------------------------------------------




# ------------------------------------------------------------
# ▶️ Section : Run Form - Start
# ------------------------------------------------------------
[void] $form.ShowDialog()
# ------------------------------------------------------------
# ▶️ Section : Run Form - End
# ------------------------------------------------------------
