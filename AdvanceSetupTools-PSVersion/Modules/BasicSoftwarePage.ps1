function New-SolidColorBrush {
    param([string]$Hex)
    $color = [Windows.Media.ColorConverter]::ConvertFromString($Hex)
    $brush = New-Object Windows.Media.SolidColorBrush $color
    $brush
}

function New-StandardButton {
    param(
        [string]$Text
    )
    $btn = New-Object System.Windows.Controls.Button
    $btn.Content    = $Text
    $btn.Width      = $CheckButtonWidth
    $btn.Height     = $CheckButtonHeight
    $btn.FontSize   = $CheckButtonFontSize
    $btn.Margin     = '6,0,0,0'
    $btn.Cursor     = 'Hand'
    $btn.Foreground = (New-SolidColorBrush -Hex $CheckButtonTextColor)
    $btn.Background = (New-SolidColorBrush -Hex $CheckButtonColor)

    # Double-quoted here-string so PS interpolates $CheckButtonCorner / $ColorHover / $ColorActive
    $template = @"
<ControlTemplate xmlns='http://schemas.microsoft.com/winfx/2006/xaml/presentation' TargetType='Button'>
  <Border Name='bd' CornerRadius='$CheckButtonCorner' Background='{TemplateBinding Background}'>
    <ContentPresenter HorizontalAlignment='Center' VerticalAlignment='Center'/>
  </Border>
  <ControlTemplate.Triggers>
    <Trigger Property='IsMouseOver' Value='True'>
      <Setter TargetName='bd' Property='Background' Value='$ColorHover'/>
    </Trigger>
    <Trigger Property='IsPressed' Value='True'>
      <Setter TargetName='bd' Property='Background' Value='$ColorActive'/>
    </Trigger>
    <Trigger Property='IsEnabled' Value='False'>
      <Setter TargetName='bd' Property='Opacity' Value='0.6'/>
    </Trigger>
  </ControlTemplate.Triggers>
</ControlTemplate>
"@
    $btn.Template = [Windows.Markup.XamlReader]::Parse($template)
    return $btn
}



function New-CheckBoxItem {
    param([hashtable]$Item)
    $cb = New-Object System.Windows.Controls.CheckBox
    $cb.Name      = $Item.Name
    $cb.Content   = $Item.Content
    $cb.Margin    = "0,$CheckBoxSpacingY,0,0"
    $cb.FontSize  = $CheckBoxFontSize
    $cb.Foreground = (New-SolidColorBrush -Hex $ColorText)
    return $cb
}

function New-GroupBox {
    param(
        [string]$groupKey,
        [string]$headerText,
        [array]$items
    )
    $outer = New-Object System.Windows.Controls.Border
    $outer.Background   = (New-SolidColorBrush -Hex $GroupBoxColor)
    $outer.BorderBrush  = (New-SolidColorBrush -Hex $GroupBoxBorderColor)
    $outer.BorderThickness = 1
    $outer.CornerRadius = 6
    $outer.Padding      = $GroupBoxPadding
    $outer.Margin       = "0,0,40,$GroupBoxSpacingY"
    $outer.HorizontalAlignment = 'Stretch'
    $outer.Width = [Double]::NaN

    # Simple hover feedback — change background on mouse enter/leave
    $outer.Add_MouseEnter({
        $this.Background = New-SolidColorBrush -Hex $GroupBoxHoverColor
    })
    $outer.Add_MouseLeave({
        $this.Background = New-SolidColorBrush -Hex $GroupBoxColor
    })


    $stack = New-Object System.Windows.Controls.StackPanel
    $stack.Orientation = 'Vertical'
    $outer.Child = $stack

    $headerGrid = New-Object System.Windows.Controls.Grid
    $col1 = New-Object System.Windows.Controls.ColumnDefinition; $col1.Width = '3*'
    $col2 = New-Object System.Windows.Controls.ColumnDefinition; $col2.Width = '2*'
    $headerGrid.ColumnDefinitions.Add($col1)
    $headerGrid.ColumnDefinitions.Add($col2)

    $title = New-Object System.Windows.Controls.TextBlock
    $title.Text = $headerText
    $title.FontSize = $GroupBoxHeaderFont
    $title.FontWeight = 'SemiBold'
    $title.VerticalAlignment = 'Center'
    $title.Margin = '2,0,0,6'
    $title.Foreground = (New-SolidColorBrush -Hex $ColorText)
    [System.Windows.Controls.Grid]::SetColumn($title, 0)

    $btnPanel = New-Object System.Windows.Controls.StackPanel
    $btnPanel.Orientation = 'Horizontal'
    $btnPanel.HorizontalAlignment = 'Right'
    [System.Windows.Controls.Grid]::SetColumn($btnPanel, 1)

    $checkContainer = New-Object System.Windows.Controls.StackPanel
    $checkContainer.Orientation = 'Vertical'
    $checkContainer.Margin = '0,6,0,0'

    # Create buttons (Check All / Uncheck All) with reliable event handlers
    $btnCheckAll   = New-StandardButton -Text 'Check All'
    $btnUncheckAll = New-StandardButton -Text 'Uncheck All'

    # Store reference to the current checkbox container (avoids closure issue)
    $btnCheckAll.Tag   = $checkContainer
    $btnUncheckAll.Tag = $checkContainer

    # Add functional click events using RoutedEventHandler (PowerShell 7 safe)
    $btnCheckAll.AddHandler(
        [System.Windows.Controls.Button]::ClickEvent,
        [System.Windows.RoutedEventHandler]{ param($s,$e)
            $panel = $s.Tag
            if ($panel -ne $null) {
                foreach ($child in $panel.Children) {
                    if ($child -is [System.Windows.Controls.CheckBox]) { $child.IsChecked = $true }
                }
            }
        }
    )

    $btnUncheckAll.AddHandler(
        [System.Windows.Controls.Button]::ClickEvent,
        [System.Windows.RoutedEventHandler]{ param($s,$e)
            $panel = $s.Tag
            if ($panel -ne $null) {
                foreach ($child in $panel.Children) {
                    if ($child -is [System.Windows.Controls.CheckBox]) { $child.IsChecked = $false }
                }
            }
        }
    )

    # Add the buttons into the header panel
    $btnPanel.Children.Add($btnCheckAll)   | Out-Null
    $btnPanel.Children.Add($btnUncheckAll) | Out-Null

    # Build the header row
    $headerGrid.Children.Add($title) | Out-Null
    $headerGrid.Children.Add($btnPanel) | Out-Null
    $stack.Children.Add($headerGrid) | Out-Null

    # Add all checkbox items under this group
    foreach ($it in $items) {
        $cb = New-CheckBoxItem -Item $it
        $checkContainer.Children.Add($cb) | Out-Null
    }
    $stack.Children.Add($checkContainer) | Out-Null

    # Return the completed group container
    return $outer
}

# Build the Basic Software Installer Page groups
$InstallerStack = $window.FindName('InstallerStack')
if ($InstallerStack -ne $null) {
    $InstallerStack.Children.Add((New-GroupBox -groupKey 'LangInput'  -headerText 'Language & Input Tool'                             -items $LangInputBoxItems)) | Out-Null
    $InstallerStack.Children.Add((New-GroupBox -groupKey 'AntiVirus'  -headerText 'Anti-Virus'                                        -items $AntiVirusBoxItems)) | Out-Null
    $InstallerStack.Children.Add((New-GroupBox -groupKey 'Games'      -headerText 'Games'                                             -items $GamesBoxItems)) | Out-Null
    $InstallerStack.Children.Add((New-GroupBox -groupKey 'WebBrowser' -headerText 'Web Browser'                                       -items $WebBrowserBoxItems)) | Out-Null
    $InstallerStack.Children.Add((New-GroupBox -groupKey 'CompTools'  -headerText 'Compression Tools'                                 -items $CompToolsBoxItems)) | Out-Null
    $InstallerStack.Children.Add((New-GroupBox -groupKey 'PDF'        -headerText 'PDF Utility'                                       -items $PDFBoxItems)) | Out-Null
    $InstallerStack.Children.Add((New-GroupBox -groupKey 'Remote'     -headerText 'Remote Desktop'                                    -items $RDPBoxItems)) | Out-Null
    $InstallerStack.Children.Add((New-GroupBox -groupKey 'Video'      -headerText 'Video Player'                                      -items $VideoBoxItems)) | Out-Null
    $InstallerStack.Children.Add((New-GroupBox -groupKey 'Photo'      -headerText 'Photo Viewer'                                      -items $PhotoBoxItems)) | Out-Null
    $InstallerStack.Children.Add((New-GroupBox -groupKey 'Comms'      -headerText 'Communication & Conferencing'                      -items $CommsBoxItems)) | Out-Null
    $InstallerStack.Children.Add((New-GroupBox -groupKey 'Java'       -headerText 'Java Runtime'                                      -items $JavaBoxItems)) | Out-Null
    $InstallerStack.Children.Add((New-GroupBox -groupKey 'VC'         -headerText 'Microsoft Visual C++ Redistributable Packages'     -items $VCRedisBoxItems)) | Out-Null
    $InstallerStack.Children.Add((New-GroupBox -groupKey 'DotNet'     -headerText '.NET Framework'                                    -items $DotNetBoxItems)) | Out-Null
    $InstallerStack.Children.Add((New-GroupBox -groupKey 'OtherTools' -headerText 'Other Tools'                                   -items $$OtherToolsBoxItems)) | Out-Null
}
# Section : 6 - Dynamic Installer Builder - End

# -------------------------------------------
# Section : 6.1 - Preset & Install Button Logic
# -------------------------------------------

# Find buttons from XAML
$BtnPresetHytec  = $window.FindName('BtnPresetHytec')
$BtnPresetEasyPC = $window.FindName('BtnPresetEasyPC')
$BtnRunInstall   = $window.FindName('BtnRunInstall')

# 🔹 Helper function: Apply preset profile (exclusive check)
function Apply-PresetProfile {
    param([string[]]$PresetNames)

    $InstallerStack = $window.FindName('InstallerStack')
    if ($InstallerStack -eq $null) { return }

    foreach ($child in $InstallerStack.Children) {
        if ($child -is [System.Windows.Controls.Border]) {
            $stackPanel = $child.Child
            if ($stackPanel -and $stackPanel.Children.Count -gt 0) {
                foreach ($sub in $stackPanel.Children) {
                    if ($sub -is [System.Windows.Controls.StackPanel]) {
                        foreach ($cb in $sub.Children) {
                            if ($cb -is [System.Windows.Controls.CheckBox]) {
                                # If checkbox Name matches preset list → check it
                                # Otherwise → uncheck it
                                $cb.IsChecked = ($PresetNames -contains $cb.Name)
                            }
                        }
                    }
                }
            }
        }
    }
}

# 🔹 Click events for Preset buttons
if ($BtnPresetHytec) {
    $BtnPresetHytec.Add_Click({
        Apply-PresetProfile -PresetNames $HytecPreset
    })
}

if ($BtnPresetEasyPC) {
    $BtnPresetEasyPC.Add_Click({
        Apply-PresetProfile -PresetNames $EasyPCPreset
    })
}

# 🔹 Click event for Install button
if ($BtnRunInstall) {
    $BtnRunInstall.Add_Click({
        $InstallerStack = $window.FindName('InstallerStack')
        if ($InstallerStack -eq $null) { return }

        $checkedScripts = @()

        foreach ($child in $InstallerStack.Children) {
            if ($child -is [System.Windows.Controls.Border]) {
                $stackPanel = $child.Child
                if ($stackPanel -and $stackPanel.Children.Count -gt 0) {
                    foreach ($sub in $stackPanel.Children) {
                        if ($sub -is [System.Windows.Controls.StackPanel]) {
                            foreach ($cb in $sub.Children) {
                                if ($cb -is [System.Windows.Controls.CheckBox] -and $cb.IsChecked) {
                                    $cbName = $cb.Name
                                    foreach ($box in Get-Variable -Scope Script | Where-Object { $_.Name -like '*BoxItems' }) {
                                        $found = $box.Value | Where-Object { $_.Name -eq $cbName }
                                        if ($found) { $checkedScripts += $found }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        if ($checkedScripts.Count -eq 0) {
            [System.Windows.MessageBox]::Show("No items selected for installation.", "Installer", "OK", "Information") | Out-Null
            return
        }

        # ---------------------------------------------
        # 🧩 Custom Install Sequence (order priority)
        # ---------------------------------------------
        $InstallOrder = @(
            # 1️⃣ .NET first
            "DotNet1",

            # 2️⃣ Visual C++ Redistributables (dependency order)
            "VCRedist2005_32bit", "VCRedist2005_64bit",
            "VCRedist2008_32bit", "VCRedist2008_64bit",
            "VCRedist2010_32bit", "VCRedist2010_64bit",
            "VCRedist2012_32bit", "VCRedist2012_64bit",
            "VCRedist2013_32bit", "VCRedist2013_64bit",
            "VCRedist2015_2022_32bit", "VCRedist2015_2022_64bit"
        )

        # Sort checked scripts by custom priority
        $checkedScripts = $checkedScripts | Sort-Object {
            $index = $InstallOrder.IndexOf($_.Name)
            if ($index -ge 0) { $index } else { [int]::MaxValue }
        }

        # ---------------------------------------------
        # 🪟 Build command sequence for new PowerShell window
        # ---------------------------------------------
        $commands = @()

        foreach ($item in $checkedScripts) {
            $commands += "Write-Host 'Installing: $($item.Content)' -ForegroundColor Cyan"
            $commands += "try {"
            $commands += "    Write-Host 'Running command...' -ForegroundColor DarkGray"
            $commands += "    Invoke-Expression '$($item.Script)'"
            $commands += "} catch {"
            $commands += "    Write-Host '⚠️ Failed: $($item.Content) - ' + \$_.Exception.Message -ForegroundColor Red"
            $commands += "}"
        }

        $commands += "Write-Host '`n==========================================' -ForegroundColor DarkGray"
        $commands += "Write-Host '✅ All selected installations have finished.' -ForegroundColor Green"
        $commands += "Write-Host 'Press Enter to exit...' -ForegroundColor Yellow"
        $commands += "Read-Host | Out-Null"
        $commands += "exit"

        # ---------------------------------------------
        # 🧩 Save and launch in new PowerShell 7 console
        # ---------------------------------------------
        $tempScriptPath = [IO.Path]::Combine([IO.Path]::GetTempPath(), 'InstallBatch_' + (Get-Random) + '.ps1')
        Set-Content -Path $tempScriptPath -Value ($commands -join [Environment]::NewLine) -Encoding UTF8

        Start-Process 'pwsh.exe' -ArgumentList '-ExecutionPolicy Bypass', '-File', "`"$tempScriptPath`"" -Wait


    })
}
# 🔹 Click event for Uncheck Everything button
$BtnUncheckAllGlobal = $window.FindName('BtnUncheckAllGlobal')
if ($BtnUncheckAllGlobal) {
    $BtnUncheckAllGlobal.Add_Click({
        $InstallerStack = $window.FindName('InstallerStack')
        if ($InstallerStack -eq $null) { return }

        # Loop through every group and uncheck all checkboxes
        foreach ($child in $InstallerStack.Children) {
            if ($child -is [System.Windows.Controls.Border]) {
                $stackPanel = $child.Child
                if ($stackPanel -and $stackPanel.Children.Count -gt 0) {
                    foreach ($sub in $stackPanel.Children) {
                        if ($sub -is [System.Windows.Controls.StackPanel]) {
                            foreach ($cb in $sub.Children) {
                                if ($cb -is [System.Windows.Controls.CheckBox]) {
                                    $cb.IsChecked = $false
                                }
                            }
                        }
                    }
                }
            }
        }

        Write-Host "🧹 All checkboxes have been unchecked (global action)." -ForegroundColor Yellow
    })
}

