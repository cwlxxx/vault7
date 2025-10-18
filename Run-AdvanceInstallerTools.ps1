# ============================================================
# 🪟 Blank WPF Window with Footer Line (PowerShell 7)
# ============================================================

Add-Type -AssemblyName PresentationFramework

# ------------------------------------------------------------
# 🧩 Section : Script Metadata - Start
# ------------------------------------------------------------
$ScriptName    = "Blank WPF GUI"
$ScriptVersion = "1.1"

# 🪟 Window Config (Shortcut)
$GUIWidth      = 900
$GUIHeight     = 800
$GUIResizeMode = "NoResize"     # Options: NoResize, CanResize, CanMinimize
$GUIBackColor  = "#202020"
$GUITextColor  = "White"
$GUIFont       = "Segoe UI"
# ------------------------------------------------------------
# 🧩 Section : Script Metadata - End
# ------------------------------------------------------------

# ------------------------------------------------------------
# 🪟 Section : XAML Layout - Start
# ------------------------------------------------------------
[xml]$XAML = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="$ScriptName (v$ScriptVersion)"
        Width="$GUIWidth" Height="$GUIHeight"
        Background="$GUIBackColor"
        Foreground="$GUITextColor"
        WindowStartupLocation="CenterScreen"
        ResizeMode="$GUIResizeMode"
        FontFamily="$GUIFont">

    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="*" />
            <RowDefinition Height="Auto" />
            <RowDefinition Height="Auto" />
        </Grid.RowDefinitions>

        <!-- Footer Line -->
        <Rectangle x:Name="FooterLine"
                   Grid.Row="1"
                   Fill="Gray"
                   HorizontalAlignment="Center"
                   Height="1"
                   Width="720"
                   Margin="0,0,0,5"/>

        <!-- Footer Label -->
        <TextBlock x:Name="FooterLabel"
                   Grid.Row="2"
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
# ⚙️ Section : Load and Show Window - Start
# ------------------------------------------------------------
$reader = New-Object System.Xml.XmlNodeReader($XAML)
$window = [Windows.Markup.XamlReader]::Load($reader)

# Make footer line responsive (80% of window width)
$window.Add_SourceInitialized({
    $footerLine = $window.FindName("FooterLine")
    $window.Add_SizeChanged({
        param($s, $e)
        $footerLine.Width = $s.ActualWidth * 0.8
    })
})

$null = $window.ShowDialog()
# ------------------------------------------------------------
# ⚙️ Section : Load and Show Window - End
# ------------------------------------------------------------
