# ============================================================
# 🪟 WPF GUI – Advance Installer Tools (PowerShell 7)
# ============================================================

Add-Type -AssemblyName PresentationFramework

# ------------------------------------------------------------
# 🧩 Section : Script Metadata - Start
# ------------------------------------------------------------
$ScriptName    = "Advance Installer Tools"
$ScriptVersion = "3.2"
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
        Name    = "ReplaceNameHere"
        Content = "Replace Name Here"
        Script  = { ReplaceCmdInHere }
    },
    @{
        Name    = "ReplaceNameHere2"
        Content = "Replace Name Here2"
        Script  = { ReplaceCmdInHere2 }
    }
    )
# ------------------------------------------------------------
# ⚙️ Section : Setting Box Content - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# ⚙️ Section : Web Browser Box Content - Start
# ------------------------------------------------------------
$BrowserBoxItems = @(
    @{
        Name    = "ReplaceNameHere3"
        Content = "Replace Name Here3"
        Script  = { ReplaceCmdInHere3 }
    },
    @{
        Name    = "ReplaceNameHere4"
        Content = "Replace Name Here4"
        Script  = { ReplaceCmdInHere4 }
    }
)
# ------------------------------------------------------------
# ⚙️ Section : Web Browser Box Content - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# 🪟 Section : XAML Layout - Start
# ------------------------------------------------------------
[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Advance Installer Tools"
        Width="1300" Height="850"
        MinWidth="900" MinHeight="600"
        WindowStartupLocation="CenterScreen"
        Background="#1E1E1E"
        FontFamily="Segoe UI"
        FontSize="14"
        WindowStyle="SingleBorderWindow"
        ResizeMode="CanResize">

    <Grid Margin="20">
        <Grid.RowDefinitions>
            <RowDefinition Height="*" />        <!-- Main Content -->
            <RowDefinition Height="Auto" />     <!-- Buttons -->
            <RowDefinition Height="Auto" />     <!-- Footer line -->
            <RowDefinition Height="Auto" />     <!-- Footer text -->
        </Grid.RowDefinitions>

        <!-- Scrollable layout area -->
        <ScrollViewer Grid.Row="0"
                      VerticalScrollBarVisibility="Auto"
                      HorizontalScrollBarVisibility="Disabled">
            <WrapPanel x:Name="MainPanel"
                       Margin="10"
                       Orientation="Horizontal"
                       ItemHeight="Auto">

                <!-- Settings Group Card -->
                <Border Background="#2B2B2B"
                        CornerRadius="12"
                        Margin="15"
                        Padding="20"
                        HorizontalAlignment="Left"
                        VerticalAlignment="Top">
                    <StackPanel>
                        <TextBlock Text="Settings"
                                   FontWeight="SemiBold"
                                   Foreground="#EAEAEA"
                                   FontSize="18"
                                   Margin="0,0,0,10" />
                        <StackPanel x:Name="SettingsStack" />
                    </StackPanel>
                </Border>

                <!-- Web Browser Group Card -->
                <Border Background="#333333"
                        CornerRadius="12"
                        Margin="15"
                        Padding="20"
                        HorizontalAlignment="Left"
                        VerticalAlignment="Top">
                    <StackPanel>
                        <TextBlock Text="Web Browser"
                                   FontWeight="SemiBold"
                                   Foreground="#EAEAEA"
                                   FontSize="18"
                                   Margin="0,0,0,10" />
                        <StackPanel x:Name="BrowserStack" />
                    </StackPanel>
                </Border>

            </WrapPanel>
        </ScrollViewer>

        <!-- Button Row -->
        <StackPanel Grid.Row="1"
                    Orientation="Horizontal"
                    HorizontalAlignment="Center"
                    Margin="0,20,0,15">
            <Button x:Name="ExitButton"
                    Content="Exit"
                    Width="120"
                    Height="38"
                    Margin="10,0"
                    Background="#C0392B"
                    Foreground="White"
                    FontWeight="Bold"
                    BorderThickness="0"
                    Cursor="Hand"
                    Padding="5" />
            <Button x:Name="RunButton"
                    Content="Install"
                    Width="120"
                    Height="38"
                    Margin="10,0"
                    Background="#2B6CB0"
                    Foreground="White"
                    FontWeight="Bold"
                    BorderThickness="0"
                    Cursor="Hand"
                    Padding="5" />
        </StackPanel>

        <!-- Footer -->
        <Grid Grid.Row="2"
              HorizontalAlignment="Center"
              Margin="0,0,0,5">
            <Rectangle x:Name="FooterLine"
                       Fill="Gray"
                       Height="1"
                       Width="700"
                       HorizontalAlignment="Center"
                       Margin="0,0,0,5" />
        </Grid>

        <TextBlock Grid.Row="3"
                   Text="© Liang | Advance Setup Tools"
                   Foreground="Gray"
                   HorizontalAlignment="Center"
                   Margin="0,0,0,5"
                   FontSize="12" />
    </Grid>
</Window>
"@
# ------------------------------------------------------------
# 🪟 Section : XAML Layout - End
# ------------------------------------------------------------




# ------------------------------------------------------------
# ⚙️ Section : Load and Show Window - Start
# ------------------------------------------------------------
$reader = New-Object System.Xml.XmlNodeReader $XAML
$window = [Windows.Markup.XamlReader]::Load($reader)

# Retrieve UI elements
$ExitButton    = $window.FindName("ExitButton")
$RunButton     = $window.FindName("RunButton")
$SettingsStack = $window.FindName("SettingsStack")
$BrowserStack  = $window.FindName("BrowserStack")
$FooterLine    = $window.FindName("FooterLine")

# --- Add fake checkboxes for each group temporarily ---
$AllCheckboxes = @()

foreach ($item in $SettingsBoxItems) {
    $cb = New-Object System.Windows.Controls.CheckBox
    $cb.Name = "CB_$($item.Name -replace '[^a-zA-Z0-9_]', '_')"
    $cb.Content = $item.Content
    $cb.Margin = "5,4,5,4"
    $cb.Foreground = "White"
    $cb.FontSize = 14
    $cb.FontFamily = "Segoe UI"
    $cb.Cursor = "Hand"
    $SettingsStack.Children.Add($cb) | Out-Null
    $AllCheckboxes += $cb
}

foreach ($item in $BrowserBoxItems) {
    $cb = New-Object System.Windows.Controls.CheckBox
    $cb.Name = "CB_$($item.Name -replace '[^a-zA-Z0-9_]', '_')"
    $cb.Content = $item.Content
    $cb.Margin = "5,4,5,4"
    $cb.Foreground = "White"
    $cb.FontSize = 14
    $cb.FontFamily = "Segoe UI"
    $cb.Cursor = "Hand"
    $BrowserStack.Children.Add($cb) | Out-Null
    $AllCheckboxes += $cb
}

# --- Exit Button ---
$ExitButton.Add_Click({
    $window.Close()
})

# --- Run (Install) Button ---
$RunButton.Add_Click({
    [System.Windows.MessageBox]::Show("Running selected installations...", "Installer", "OK", "Information")
})

# --- Dynamically resize footer line width (80% of window width) ---
$window.Add_SourceInitialized({
    if ($FooterLine) {
        $FooterLine.Width = $window.ActualWidth * 0.8
    }
})
$window.Add_SizeChanged({
    if ($FooterLine) {
        $FooterLine.Width = $window.ActualWidth * 0.8
    }
})

# --- Show the window ---
$window.ShowDialog() | Out-Null
# ------------------------------------------------------------
# ⚙️ Section : Load and Show Window - End
# ------------------------------------------------------------
