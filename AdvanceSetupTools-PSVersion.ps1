# ===========================================
# Project : AdvanceSetupTools-PSVersion
# File    : Main.ps1
# Target  : PowerShell 7 (Windows)
# Desc    : Frameless flat dark WPF UI with flat sidebar buttons + placeholders (Unified Text Color Edition)
# ===========================================

# Section : 0 - Shortcut Config - Start
# ⚙️ Quick tweak section
$AppTitle        = "Advance Setup Tools"
$AppSubtitle     = "PS Edition"
$AppVersion      = "v2.0"

$WinWidth        = 1000
$WinHeight       = 600
$AllowResize     = $false
$SidebarWidth    = 240
$CornerRadius    = 20

# 🎨 Colors (Core)
$ColorBase       = "#181C20"     # Background (Sidebar + Main base tone)
$ColorHover      = "#252A30"     # Hover
$ColorActive     = "#30363E"     # Active button
$ColorText       = "#E5E7EB"     # Universal text color
$ColorHoverExit  = "#4C2B2B"     # Exit hover
$ColorActiveExit = "#7F1D1D"     # Exit pressed

$PageBackgroundColor  = "#181C20"   # Match sidebar color (flat paper look)
$GroupBoxColor        = "#23292E"   # Default GroupBox background
$GroupBoxHoverColor   = "#2A3036"   # Slightly lighter hover tone (~5%)
$GroupBoxBorderColor  = "#2B3138"   # Soft border outline for definition

# 🧭 Sidebar settings
$SidebarPadding = 12
$ButtonSideGap  = 20

# 🎚️ Sidebar Button Settings
$BtnWidthRatio     = 0.83
$BtnHeight         = 50
$BtnCornerRadius   = 8
$BtnFontSize       = 18
$BtnSpacingY       = 10
$BtnIconSize       = 16

# 🧩 Installer Page Layout Controls
$GroupBoxSpacingY     = 20
$GroupBoxHeaderFont   = 16
$GroupBoxPadding      = 10
$CheckBoxFontSize     = 16
$CheckBoxSpacingY     = 10
$CheckButtonWidth     = 110
$CheckButtonHeight    = 32
$CheckButtonFontSize  = 13
$CheckButtonColor     = "#374151"
$CheckButtonTextColor = "#E5E7EB"
$CheckButtonCorner    = 6

# Section : 0 - Shortcut Config - End


# Section : 1 - Safety / Prereqs - Start
if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Error "This script requires PowerShell 7+."
    exit 1
}
Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase

$BtnWidth = [math]::Round($SidebarWidth * $BtnWidthRatio)
# Section : 1 - Safety / Prereqs - End


# Section : 2 - XAML UI Layout - Start
$XamlTemplate = @'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="{AppTitle}"
        Width="{WinWidth}" Height="{WinHeight}"
        WindowStartupLocation="CenterScreen"
        WindowStyle="None"
        AllowsTransparency="True"
        Background="Transparent"
        ResizeMode="{ResizeMode}">
        <!-- 🎨 Global Styles -->
    <Window.Resources>
        <!-- ✅ Perfect vertical centering for all checkboxes -->
        <Style TargetType="CheckBox">
            <Setter Property="VerticalAlignment" Value="Center"/>
            <Setter Property="VerticalContentAlignment" Value="Center"/>
            <Setter Property="Margin" Value="0,2,0,2"/> <!-- small spacing between rows -->
        </Style>
    </Window.Resources>


    <Border CornerRadius="{CornerRadius}" Background="{ColorBase}" Margin="12" SnapsToDevicePixels="True" ClipToBounds="True">
        <Border.Effect>
            <DropShadowEffect BlurRadius="30" ShadowDepth="0" Opacity="0.45" Color="#000000"/>
        </Border.Effect>

        <Grid>
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="{SidebarWidth}"/>
                <ColumnDefinition Width="*"/>
            </Grid.ColumnDefinitions>

            <!-- Sidebar -->
            <Border Grid.Column="0" Background="{ColorBase}" Padding="{SidebarPadding}" CornerRadius="8">
                <Grid>
                    <Grid.RowDefinitions>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="*"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>

                    <!-- App Info -->
                    <StackPanel Grid.Row="0" Margin="4,6,4,10">
                        <TextBlock Text="{AppTitle}" Foreground="{ColorText}" FontSize="20" FontWeight="SemiBold"/>
                        <TextBlock Text="{AppSubtitle} {AppVersion}" Foreground="{ColorText}" FontSize="13" Margin="0,2,0,0"/>
                    </StackPanel>

                    <!-- Navigation Buttons -->
                    <StackPanel Grid.Row="1" Margin="0,8,0,0" HorizontalAlignment="Center">
                        <ToggleButton x:Name="BtnHome" Content="Home" IsChecked="True"
                                      Width="{BtnWidth}" Height="{BtnHeight}"
                                      Foreground="{ColorText}" Background="Transparent"
                                      BorderThickness="0" FontSize="{BtnFontSize}"
                                      Cursor="Hand" Margin="0,{BtnSpacingY},0,0"
                                      HorizontalAlignment="Center">
                            <ToggleButton.Style>
                                <Style TargetType="ToggleButton">
                                    <Setter Property="Template">
                                        <Setter.Value>
                                            <ControlTemplate TargetType="ToggleButton">
                                                <Border x:Name="bd" CornerRadius="{BtnCornerRadius}" Background="{TemplateBinding Background}">
                                                    <ContentPresenter VerticalAlignment="Center" HorizontalAlignment="Center"/>
                                                </Border>
                                                <ControlTemplate.Triggers>
                                                    <Trigger Property="IsMouseOver" Value="True">
                                                        <Setter TargetName="bd" Property="Background" Value="{ColorHover}"/>
                                                    </Trigger>
                                                    <Trigger Property="IsChecked" Value="True">
                                                        <Setter TargetName="bd" Property="Background" Value="{ColorActive}"/>
                                                    </Trigger>
                                                </ControlTemplate.Triggers>
                                            </ControlTemplate>
                                        </Setter.Value>
                                    </Setter>
                                </Style>
                            </ToggleButton.Style>
                        </ToggleButton>

                        <ToggleButton x:Name="BtnInstaller" Content="Installer"
                                      Width="{BtnWidth}" Height="{BtnHeight}"
                                      Foreground="{ColorText}" Background="Transparent"
                                      BorderThickness="0" FontSize="{BtnFontSize}"
                                      Cursor="Hand" Margin="0,{BtnSpacingY},0,0"
                                      HorizontalAlignment="Center">
                            <ToggleButton.Style>
                                <Style TargetType="ToggleButton">
                                    <Setter Property="Template">
                                        <Setter.Value>
                                            <ControlTemplate TargetType="ToggleButton">
                                                <Border x:Name="bd" CornerRadius="{BtnCornerRadius}" Background="{TemplateBinding Background}">
                                                    <ContentPresenter VerticalAlignment="Center" HorizontalAlignment="Center"/>
                                                </Border>
                                                <ControlTemplate.Triggers>
                                                    <Trigger Property="IsMouseOver" Value="True">
                                                        <Setter TargetName="bd" Property="Background" Value="{ColorHover}"/>
                                                    </Trigger>
                                                    <Trigger Property="IsChecked" Value="True">
                                                        <Setter TargetName="bd" Property="Background" Value="{ColorActive}"/>
                                                    </Trigger>
                                                </ControlTemplate.Triggers>
                                            </ControlTemplate>
                                        </Setter.Value>
                                    </Setter>
                                </Style>
                            </ToggleButton.Style>
                        </ToggleButton>
                    </StackPanel>

                    <!-- Exit Button -->
                    <Button x:Name="BtnExit" Grid.Row="2" Content="Exit"
                            Width="{BtnWidth}" Height="{BtnHeight}"
                            Foreground="{ColorText}" Background="Transparent"
                            BorderThickness="0" FontSize="{BtnFontSize}"
                            Cursor="Hand" Margin="0,{BtnSpacingY},0,10"
                            HorizontalAlignment="Center">
                        <Button.Style>
                            <Style TargetType="Button">
                                <Setter Property="Template">
                                    <Setter.Value>
                                        <ControlTemplate TargetType="Button">
                                            <Border x:Name="bd" CornerRadius="{BtnCornerRadius}" Background="{TemplateBinding Background}">
                                                <ContentPresenter VerticalAlignment="Center" HorizontalAlignment="Center"/>
                                            </Border>
                                            <ControlTemplate.Triggers>
                                                <Trigger Property="IsMouseOver" Value="True">
                                                    <Setter TargetName="bd" Property="Background" Value="{ColorHoverExit}"/>
                                                </Trigger>
                                                <Trigger Property="IsPressed" Value="True">
                                                    <Setter TargetName="bd" Property="Background" Value="{ColorActiveExit}"/>
                                                </Trigger>
                                            </ControlTemplate.Triggers>
                                        </ControlTemplate>
                                    </Setter.Value>
                                </Setter>
                            </Style>
                        </Button.Style>
                    </Button>
                </Grid>
            </Border>

            <!-- Content Area -->
            <Border Grid.Column="1" Background="{ColorBase}" Padding="24" CornerRadius="8">
                <Grid x:Name="ContentHost">

                    <!-- 🏠 Home Page -->
                    <Grid x:Name="PageHome" Background="{PageBackgroundColor}">
                        <StackPanel VerticalAlignment="Center" HorizontalAlignment="Center">
                            <TextBlock Text="🏠 Home Page Placeholder"
                                       Foreground="{ColorText}"
                                       FontSize="20"
                                       FontWeight="SemiBold"
                                       TextAlignment="Center"/>
                            <TextBlock Text="This section is under development."
                                       Foreground="{ColorText}"
                                       FontSize="13"
                                       Margin="0,8,0,0"
                                       TextAlignment="Center"/>
                            <TextBlock Text="(Placeholder Chicken says hi 🐔)"
                                       Foreground="{ColorText}"
                                       FontSize="12"
                                       Margin="0,4,0,0"
                                       TextAlignment="Center"/>
                        </StackPanel>
                    </Grid>

                    <!-- 📦 Installer Page -->
                    <Grid x:Name="PageInstaller"
                        Background="{PageBackgroundColor}"
                        Visibility="Collapsed">

                        <Grid>
                            <Grid.RowDefinitions>
                                <RowDefinition Height="*"/>
                                <RowDefinition Height="Auto"/>
                            </Grid.RowDefinitions>

                            <!-- Scrollable installer content -->
                            <ScrollViewer VerticalScrollBarVisibility="Auto"
                                        HorizontalScrollBarVisibility="Disabled"
                                        Grid.Row="0"
                                        Margin="0,0,0,0">
                                <ScrollViewer.Resources>
                                    <!-- 🩶 Slim Dark ScrollBar -->
                                    <Style TargetType="ScrollBar">
                                        <Setter Property="Width" Value="8"/>
                                        <Setter Property="Background" Value="#1E2328"/>
                                        <Setter Property="Template">
                                            <Setter.Value>
                                                <ControlTemplate TargetType="ScrollBar">
                                                    <Grid Background="{TemplateBinding Background}">
                                                        <Track x:Name="PART_Track" Orientation="Vertical" IsDirectionReversed="True">
                                                            <Track.DecreaseRepeatButton>
                                                                <RepeatButton Height="0" IsEnabled="False"/>
                                                            </Track.DecreaseRepeatButton>
                                                            <Track.IncreaseRepeatButton>
                                                                <RepeatButton Height="0" IsEnabled="False"/>
                                                            </Track.IncreaseRepeatButton>
                                                            <Track.Thumb>
                                                                <Thumb Background="#3A3F45" BorderBrush="#4A4F55" BorderThickness="0.5">
                                                                    <Thumb.Style>
                                                                        <Style TargetType="Thumb">
                                                                            <Setter Property="Template">
                                                                                <Setter.Value>
                                                                                    <ControlTemplate TargetType="Thumb">
                                                                                        <Border CornerRadius="4"
                                                                                                Background="{TemplateBinding Background}"
                                                                                                BorderBrush="{TemplateBinding BorderBrush}"
                                                                                                BorderThickness="{TemplateBinding BorderThickness}"/>
                                                                                    </ControlTemplate>
                                                                                </Setter.Value>
                                                                            </Setter>
                                                                            <Style.Triggers>
                                                                                <Trigger Property="IsMouseOver" Value="True">
                                                                                    <Setter Property="Background" Value="#4A5056"/>
                                                                                    <Setter Property="BorderBrush" Value="#5A6066"/>
                                                                                </Trigger>
                                                                                <Trigger Property="IsDragging" Value="True">
                                                                                    <Setter Property="Background" Value="#5E656C"/>
                                                                                    <Setter Property="BorderBrush" Value="#6A7076"/>
                                                                                </Trigger>
                                                                            </Style.Triggers>
                                                                        </Style>
                                                                    </Thumb.Style>
                                                                </Thumb>
                                                            </Track.Thumb>
                                                        </Track>
                                                    </Grid>
                                                </ControlTemplate>
                                            </Setter.Value>
                                        </Setter>
                                    </Style>
                                </ScrollViewer.Resources>

                                <!-- 📋 Installer GroupBox Stack -->
                                <StackPanel x:Name="InstallerStack" Orientation="Vertical" Margin="0,0,0,20"/>
                            </ScrollViewer>

                            <!-- 📦 Fixed Install Button -->
                            <Border Grid.Row="1" CornerRadius="8" Margin="0,25,0,0" Background="Transparent">
                                <Button x:Name="BtnRunInstall"
                                        Content="Install"
                                        Width="220" Height="42"
                                        FontSize="16"
                                        Foreground="{ColorText}"
                                        Background="#2B6CB0"
                                        BorderThickness="0"
                                        Cursor="Hand"
                                        HorizontalAlignment="Center"
                                        VerticalAlignment="Center"
                                        ToolTip="Run all checked installations">
                                    <Button.Template>
                                        <ControlTemplate TargetType="Button">
                                            <!-- 🔹 Use x:Name to make triggers targetable -->
                                            <Border x:Name="border"
                                                    CornerRadius="8"
                                                    Background="{TemplateBinding Background}">
                                                <ContentPresenter VerticalAlignment="Center"
                                                                HorizontalAlignment="Center"/>
                                            </Border>
                                            <ControlTemplate.Triggers>
                                                <!-- Hover -->
                                                <Trigger Property="IsMouseOver" Value="True">
                                                    <Setter TargetName="border" Property="Background" Value="#3C7DD8"/>
                                                </Trigger>
                                                <!-- Pressed -->
                                                <Trigger Property="IsPressed" Value="True">
                                                    <Setter TargetName="border" Property="Background" Value="#245C9E"/>
                                                </Trigger>
                                            </ControlTemplate.Triggers>
                                        </ControlTemplate>
                                    </Button.Template>
                                </Button>
                            </Border>

                        </Grid>
                    </Grid> <!-- end PageInstaller -->


                </Grid> <!-- end ContentHost -->
            </Border> <!-- end Content Area -->
        </Grid> <!-- end Main Grid -->
    </Border> <!-- end Outer Border -->
</Window>
'@




# Inject replacements
$ResizeModeValue = if ($AllowResize) { 'CanResize' } else { 'NoResize' }
$replacements = @{
    '{AppTitle}'           = $AppTitle
    '{AppSubtitle}'        = $AppSubtitle
    '{AppVersion}'         = $AppVersion
    '{ColorBase}'          = $ColorBase
    '{ColorHover}'         = $ColorHover
    '{ColorActive}'        = $ColorActive
    '{ColorHoverExit}'     = $ColorHoverExit
    '{ColorActiveExit}'    = $ColorActiveExit
    '{SidebarWidth}'       = $SidebarWidth
    '{SidebarPadding}'     = $SidebarPadding
    '{CornerRadius}'       = $CornerRadius
    '{BtnWidth}'           = $BtnWidth
    '{WinWidth}'           = $WinWidth
    '{WinHeight}'          = $WinHeight
    '{ResizeMode}'         = $ResizeModeValue
    '{BtnHeight}'          = $BtnHeight
    '{BtnFontSize}'        = $BtnFontSize
    '{BtnSpacingY}'        = $BtnSpacingY
    '{BtnCornerRadius}'    = $BtnCornerRadius
    '{PageBackgroundColor}'= $PageBackgroundColor
    '{ColorText}'          = $ColorText
}
foreach ($key in $replacements.Keys) {
    $XamlTemplate = $XamlTemplate.Replace($key, [string]$replacements[$key])
}
# Section : 2 - XAML UI Layout - End



# Section : 3 - Build Window - Start
[xml]$xml = $XamlTemplate
$reader = (New-Object System.Xml.XmlNodeReader $xml)
$window = [Windows.Markup.XamlReader]::Load($reader)
# Section : 3 - Build Window - End


# Section : 4 - Window Behavior - Start
# Allow dragging anywhere
$window.Add_MouseLeftButtonDown({ try { $this.DragMove() } catch {} })

# Exit button event
$BtnExit = $window.FindName('BtnExit')
$BtnExit.Add_Click({ $window.Close() })
# Section : 4 - Window Behavior - End


# Section : 5 - Content Definitions (Manual Arrays) - Start
# Replace “dummy” entries with your real app scripts later.
$LangInputBoxItems = @(
    @{ Name="LangInput1"; Content="dummy 1"; Script={ "dummy 1" } },
    @{ Name="LangInput2"; Content="dummy 2"; Script={ "dummy 2" } }
)
$AntiVirusBoxItems = @(@{ Name="AntiVirus1"; Content="dummy 3"; Script={ "dummy 3" } })
$WebBrowserBoxItems = @(
    @{ Name="WebBrowser1"; Content="dummy 4"; Script={ "dummy 4" } },
    @{ Name="WebBrowser2"; Content="dummy 5"; Script={ "dummy 5" } }
)
$CompToolsBoxItems = @(
    @{ Name="CompTools1"; Content="dummy 6"; Script={ "dummy 6" } },
    @{ Name="CompTools2"; Content="dummy 7"; Script={ "dummy 7" } }
)
$PDFBoxItems = @(
    @{ Name="PDF1"; Content="dummy 8"; Script={ "dummy 8" } },
    @{ Name="PDF2"; Content="dummy 9"; Script={ "dummy 9" } }
)
$RDPBoxItems = @(
    @{ Name="RDP1"; Content="dummy 10"; Script={ "dummy 10" } },
    @{ Name="RDP2"; Content="dummy 11"; Script={ "dummy 11" } }
)
$VideoBoxItems = @(
    @{ Name="Video1"; Content="dummy 12"; Script={ "dummy 12" } },
    @{ Name="Video2"; Content="dummy 13"; Script={ "dummy 13" } }
)
$PhotoBoxItems = @(@{ Name="Photo1"; Content="dummy 14"; Script={ "dummy 14" } })
$CommsBoxItems = @(@{ Name="Comms1"; Content="dummy 15"; Script={ "dummy 15" } })
$JavaBoxItems = @(
    @{ Name="Java1"; Content="dummy 16"; Script={ "dummy 16" } },
    @{ Name="Java2"; Content="dummy 17"; Script={ "dummy 17" } }
)
$VCRedisBoxItems = @(
    @{ Name="VCRedist1"; Content="dummy 18"; Script={ "dummy 18" } },
    @{ Name="VCRedist2"; Content="dummy 19"; Script={ "dummy 19" } },
    @{ Name="VCRedist3"; Content="dummy 20"; Script={ "dummy 20" } },
    @{ Name="VCRedist4"; Content="dummy 21"; Script={ "dummy 21" } },
    @{ Name="VCRedist5"; Content="dummy 22"; Script={ "dummy 22" } },
    @{ Name="VCRedist6"; Content="dummy 23"; Script={ "dummy 23" } },
    @{ Name="VCRedist7"; Content="dummy 24"; Script={ "dummy 24" } },
    @{ Name="VCRedist8"; Content="dummy 25"; Script={ "dummy 25" } },
    @{ Name="VCRedist9"; Content="dummy 26"; Script={ "dummy 26" } },
    @{ Name="VCRedist10"; Content="dummy 27"; Script={ "dummy 27" } },
    @{ Name="VCRedist11"; Content="dummy 28"; Script={ "dummy 28" } },
    @{ Name="VCRedist12"; Content="dummy 29"; Script={ "dummy 29" } },
    @{ Name="VCRedist13"; Content="dummy 30"; Script={ "dummy 30" } },
    @{ Name="VCRedist14"; Content="dummy 31"; Script={ "dummy 31" } }
)
$DotNetBoxItems = @(@{ Name="DotNet1"; Content="dummy 32"; Script={ "dummy 32" } })
# Section : 5 - Content Definitions (Manual Arrays) - End


# Section : 6 - Dynamic Installer Builder - Start

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

# Build the Installer page groups
$InstallerStack = $window.FindName('InstallerStack')
if ($InstallerStack -ne $null) {
    $InstallerStack.Children.Add((New-GroupBox -groupKey 'LangInput'  -headerText 'Language & Input Tool'                            -items $LangInputBoxItems)) | Out-Null
    $InstallerStack.Children.Add((New-GroupBox -groupKey 'AntiVirus'  -headerText 'Anti-Virus'                                        -items $AntiVirusBoxItems)) | Out-Null
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
}
# Section : 6 - Dynamic Installer Builder - End


# Section : 7 - Navigation Logic - Start
function Set-ActivePage {
    param([string]$page)
    $PageHome = $window.FindName('PageHome')
    $PageInstaller = $window.FindName('PageInstaller')

    if (-not $PageHome -or -not $PageInstaller) {
        Write-Warning "⚠️ One or more pages (Home/Installer) not found in XAML."
        return
    }

    switch ($page) {
        'Home' {
            $PageHome.Visibility = 'Visible'
            $PageInstaller.Visibility = 'Collapsed'
            ($window.FindName('BtnHome')).IsChecked = $true
            ($window.FindName('BtnInstaller')).IsChecked = $false
        }
        'Installer' {
            $PageHome.Visibility = 'Collapsed'
            $PageInstaller.Visibility = 'Visible'
            ($window.FindName('BtnHome')).IsChecked = $false
            ($window.FindName('BtnInstaller')).IsChecked = $true
        }
    }
}


($window.FindName('BtnHome')).Add_Click({ Set-ActivePage 'Home' })
($window.FindName('BtnInstaller')).Add_Click({ Set-ActivePage 'Installer' })
# Section : 7 - Navigation Logic - End


# Section : 8 - Run - Start
Set-ActivePage 'Home'
$null = $window.ShowDialog()
# Section : 8 - Run - End

