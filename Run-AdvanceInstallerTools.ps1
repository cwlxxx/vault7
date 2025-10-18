# ============================================================
# 🪟 WPF GUI – Advance Installer Tools (PowerShell 7)
# ============================================================

Add-Type -AssemblyName PresentationFramework

# ------------------------------------------------------------
# 🧩 Section : Script Metadata - Start
# ------------------------------------------------------------
$ScriptName    = "Advance Installer Tools"
$ScriptVersion = "1.1"
$WindowWidth   = 900
$WindowHeight  = 600
# ------------------------------------------------------------
# 🧩 Section : Script Metadata - End
# ------------------------------------------------------------

# ------------------------------------------------------------
# ⚙️ Section : Setting Box Content - Start
# ------------------------------------------------------------
$SettingsBoxItems = @(
    @{
        Name    = "OpenUACSettings"
        Content = "Open User Account Control Settings"
        Script  = { Start-Process "UserAccountControlSettings.exe" }
    },
    @{
        Name    = "TimeStampHostFile"
        Content = "Add Time Stamp to Hosts File"
        Script  = { irm "https://github.com/cwlxxx/vault7/raw/refs/heads/main/Run-TimeStampHostFile.ps1" | iex }
    },
    @{
        Name    = "EnableIcon"
        Content = "Enable 'This PC' Icon etc."
        Script  = { irm "https://raw.githubusercontent.com/cwlxxx/vault7/main/Setting-EnableDesktopIcons.ps1" | iex }
    },
    @{
        Name    = "NeverSleep"
        Content = "Never Turn Off Monitor and Never Sleep"
        Script  = { irm "https://raw.githubusercontent.com/cwlxxx/vault7/main/Setting-NoSleepNoMonitorOff.ps1" | iex }
    },
    @{
        Name    = "NoFastStartup"
        Content = "Disable Windows Fast Startup"
        Script  = { irm "https://raw.githubusercontent.com/cwlxxx/vault7/main/Setting-DisableWindowsFastStartup.ps1" | iex }
    }
)
# ------------------------------------------------------------
# ⚙️ Section : Setting Box Content - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# 🪟 Section : XAML Layout - Start
# ------------------------------------------------------------
[xml]$XAML = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="$ScriptName (v$ScriptVersion)"
        Width="$WindowWidth" Height="$WindowHeight"
        Background="#202020"
        Foreground="White"
        WindowStartupLocation="CenterScreen"
        ResizeMode="NoResize"
        FontFamily="Segoe UI">

    <Grid Margin="10">
        <Grid.RowDefinitions>
            <RowDefinition Height="*" />
            <RowDefinition Height="Auto" />
            <RowDefinition Height="Auto" />
            <RowDefinition Height="Auto" />
        </Grid.RowDefinitions>

        <!-- Settings GroupBox -->
        <GroupBox Grid.Row="0"
                  Margin="10"
                  Padding="10"
                  Width="300"
                  Height="175"
                  Foreground="White"
                  BorderBrush="Gray"
                  VerticalAlignment="Top"
                  HorizontalAlignment="Left">
            <GroupBox.Header>
                <DockPanel LastChildFill="False">
                    <TextBlock Text="Settings"
                               FontWeight="SemiBold"
                               FontSize="16"
                               Foreground="White"
                               VerticalAlignment="Center"
                               Margin="0,0,10,0"/>
                    <Button x:Name="SelectAllButton"
                            Content="Select All"
                            Width="85"
                            Height="23"
                            FontSize="12"
                            Background="#404040"
                            Foreground="White"
                            BorderBrush="Gray"
                            DockPanel.Dock="Right"
                            VerticalAlignment="Center"/>
                </DockPanel>
            </GroupBox.Header>

            <StackPanel x:Name="SettingsStack"/>
        </GroupBox>

        <!-- Buttons -->
        <StackPanel Grid.Row="1"
                    Orientation="Horizontal"
                    HorizontalAlignment="Center"
                    Margin="0,10,0,10">
            <Button x:Name="ExitButton"
                    Content="Exit"
                    Width="120" Height="35"
                    Background="#C83232"
                    Foreground="White"
                    FontWeight="Bold"
                    Margin="0,0,40,0"/>
            <Button x:Name="RunButton"
                    Content="Run Selected"
                    Width="120" Height="35"
                    Background="#0078D7"
                    Foreground="White"
                    FontWeight="Bold"/>
        </StackPanel>

        <!-- Footer -->
        <Rectangle Grid.Row="2"
                   Fill="Gray"
                   Height="1"
                   HorizontalAlignment="Center"
                   Width="600"
                   Margin="0,0,0,5"/>

        <TextBlock Grid.Row="3"
                   Text="© Liang | PowerShell WPF GUI"
                   Foreground="Gray"
                   HorizontalAlignment="Center"
                   Margin="0,0,0,5"
                   FontSize="12"/>
    </Grid>
</Window>
"@
# ------------------------------------------------------------
# 🪟 Section : XAML Layout - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# 🧭 Section : Progress Window Function - Start
# ------------------------------------------------------------
function Show-ProgressWindow {
    param ([array]$Items, $ParentWindow)

    [xml]$ProgressXAML = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Running Tasks..."
        Width="400" Height="180"
        WindowStartupLocation="CenterScreen"
        ResizeMode="NoResize"
        Background="#202020"
        Foreground="White"
        FontFamily="Segoe UI">
    <Grid Margin="20">
        <TextBlock x:Name="ProgressLabel"
                   Text="Starting..."
                   FontSize="14"
                   Margin="0,0,0,10"
                   HorizontalAlignment="Center"/>
        <ProgressBar x:Name="ProgressBar"
                     Height="25"
                     Minimum="0"
                     Maximum="100"
                     Value="0"
                     Margin="0,40,0,0"/>
    </Grid>
</Window>
"@

    $reader = New-Object System.Xml.XmlNodeReader $ProgressXAML
    $ProgressWindow = [Windows.Markup.XamlReader]::Load($reader)
    $ProgressLabel  = $ProgressWindow.FindName("ProgressLabel")
    $ProgressBar    = $ProgressWindow.FindName("ProgressBar")

    # Hide parent window while running tasks
    $ParentWindow.Hide()
    $ProgressWindow.Show()

    $count = $Items.Count
    for ($i = 0; $i -lt $count; $i++) {
        $item = $Items[$i]

        # --- Update progress text BEFORE running ---
        $ProgressWindow.Dispatcher.Invoke([action]{
            $ProgressLabel.Text = "Running: $($item.Content)..."
            $ProgressBar.Value  = (($i + 1) / $count) * 100
        }, "Render")

        # ✅ Force GUI to refresh immediately
        $ProgressWindow.Dispatcher.Invoke([action]{}, "Render")

        # --- Run each script in a new PowerShell 7 window ---
        Start-Process pwsh -ArgumentList @(
            '-NoProfile',
            '-ExecutionPolicy', 'Bypass',
            '-Command', "& { $($item.Script) }"
        ) -Wait
    }

    # --- Show completion message ---
    $ProgressWindow.Dispatcher.Invoke([action]{
        $ProgressLabel.Text = "All tasks completed."
        $ProgressBar.Value  = 100
    }, "Render")

    Start-Sleep -Seconds 0.5

    # ✅ Show popup message box before closing
    [System.Windows.MessageBox]::Show("All selected tasks have completed successfully!", "Completed", "OK", "Information")

    $ProgressWindow.Close()
    $ParentWindow.Show()
}
# ------------------------------------------------------------
# 🧭 Section : Progress Window Function - End
# ------------------------------------------------------------





# ------------------------------------------------------------
# ⚙️ Section : Load and Show Window - Start
# ------------------------------------------------------------
$reader = New-Object System.Xml.XmlNodeReader $XAML
$window = [Windows.Markup.XamlReader]::Load($reader)

$ExitButton    = $window.FindName("ExitButton")
$RunButton     = $window.FindName("RunButton")
$SelectAllBtn  = $window.FindName("SelectAllButton")
$SettingsStack = $window.FindName("SettingsStack")

# --- Add Checkboxes ---
$AllCheckboxes = @()
foreach ($item in $SettingsBoxItems) {
    $cb = New-Object System.Windows.Controls.CheckBox
    $cb.Name = "CB_$($item.Name)"
    $cb.Content = $item.Content
    $cb.Margin = "5"
    $cb.Foreground = "White"
    $SettingsStack.Children.Add($cb) | Out-Null
    $AllCheckboxes += $cb
}

# --- Exit Button ---
$ExitButton.Add_Click({ $window.Close() })

# --- Run Button ---
$RunButton.Add_Click({
    $selected = for ($i = 0; $i -lt $AllCheckboxes.Count; $i++) {
        if ($AllCheckboxes[$i].IsChecked) { $SettingsBoxItems[$i] }
    }
    if (-not $selected) {
        [System.Windows.MessageBox]::Show("No items selected.", "Info", "OK", "Information")
        return
    }
    Show-ProgressWindow -Items $selected -ParentWindow $window
})

# --- Select All / Unselect All ---
$SelectAllBtn.Add_Click({
    $unchecked = $AllCheckboxes | Where-Object { -not $_.IsChecked }
    if ($unchecked.Count -eq 0) {
        $AllCheckboxes | ForEach-Object { $_.IsChecked = $false }
        $SelectAllBtn.Content = "Select All"
    } else {
        $AllCheckboxes | ForEach-Object { $_.IsChecked = $true }
        $SelectAllBtn.Content = "Unselect All"
    }
})
# ------------------------------------------------------------
# ⚙️ Section : Load and Show Window - End
# ------------------------------------------------------------

$window.ShowDialog() | Out-Null
