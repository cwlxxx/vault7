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

# 🧩 Basic Software Installer Page Layout Controls
$GroupBoxSpacingY     = 20
$GroupBoxHeaderFont   = 20
$GroupBoxPadding      = 10
$CheckBoxFontSize     = 12
$CheckBoxSpacingY     = 10
$CheckButtonWidth     = 110
$CheckButtonHeight    = 24
$CheckButtonFontSize  = 12
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

# Section : 1.5 - Safe Path Handling - Start
# Ensure $PSScriptRoot is defined even when running via irm | iex
if (-not $PSScriptRoot -or [string]::IsNullOrWhiteSpace($PSScriptRoot)) {
    try {
        $global:PSScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
    } catch {
        $global:PSScriptRoot = (Get-Location).Path
    }
}
# Section : 1.5 - Safe Path Handling - End

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

                        <ToggleButton x:Name="BtnInstaller" Content="Basic Software"
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

                    <!-- 📦 Basic Software Installer Page -->
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


                            <!-- 📦 Fixed Install Button Group -->
                            <Border Grid.Row="1" CornerRadius="8" Margin="0,25,0,0" Background="Transparent">
                                <StackPanel Orientation="Horizontal"
                                            HorizontalAlignment="Center"
                                            VerticalAlignment="Center"
                                            Margin="0,0,50,10">

                                    <!-- Uncheck Everything -->
                                    <Button x:Name="BtnUncheckAllGlobal"
                                            Content="Uncheck All"
                                            Width="110" Height="32"
                                            FontSize="13"
                                            Foreground="{ColorText}"
                                            Background="{CheckButtonColor}"
                                            BorderThickness="0"
                                            Cursor="Hand"
                                            Margin="0,0,10,0">
                                        <Button.Template>
                                            <ControlTemplate TargetType="Button">
                                                <Border x:Name="bd" CornerRadius="6" Background="{TemplateBinding Background}">
                                                    <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                                                </Border>
                                                <ControlTemplate.Triggers>
                                                    <!-- hover color -->
                                                    <Trigger Property="IsMouseOver" Value="True">
                                                        <Setter TargetName="bd" Property="Background" Value="#47505A"/>
                                                    </Trigger>
                                                    <!-- pressed color -->
                                                    <Trigger Property="IsPressed" Value="True">
                                                        <Setter TargetName="bd" Property="Background" Value="#2F363E"/>
                                                    </Trigger>
                                                </ControlTemplate.Triggers>
                                            </ControlTemplate>
                                        </Button.Template>
                                    </Button>

                                    <!-- For Hytec -->
                                    <Button x:Name="BtnPresetHytec"
                                            Content="For Hytec"
                                            Width="110" Height="32"
                                            FontSize="13"
                                            Foreground="{ColorText}"
                                            Background="{CheckButtonColor}"
                                            BorderThickness="0"
                                            Cursor="Hand"
                                            Margin="0,0,10,0">
                                        <Button.Template>
                                            <ControlTemplate TargetType="Button">
                                                <Border x:Name="bd" CornerRadius="6" Background="{TemplateBinding Background}">
                                                    <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                                                </Border>
                                                <ControlTemplate.Triggers>
                                                    <!-- hover color -->
                                                    <Trigger Property="IsMouseOver" Value="True">
                                                        <Setter TargetName="bd" Property="Background" Value="#47505A"/>
                                                    </Trigger>
                                                    <!-- pressed color -->
                                                    <Trigger Property="IsPressed" Value="True">
                                                        <Setter TargetName="bd" Property="Background" Value="#2F363E"/>
                                                    </Trigger>
                                                </ControlTemplate.Triggers>
                                            </ControlTemplate>
                                        </Button.Template>
                                    </Button>

                                    <!-- For Easy PC -->
                                    <Button x:Name="BtnPresetEasyPC"
                                            Content="For Easy PC"
                                            Width="110" Height="32"
                                            FontSize="13"
                                            Foreground="{ColorText}"
                                            Background="{CheckButtonColor}"
                                            BorderThickness="0"
                                            Cursor="Hand"
                                            Margin="0,0,10,0">
                                        <Button.Template>
                                            <ControlTemplate TargetType="Button">
                                                <Border x:Name="bd" CornerRadius="6" Background="{TemplateBinding Background}">
                                                    <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                                                </Border>
                                                <ControlTemplate.Triggers>
                                                    <!-- hover color -->
                                                    <Trigger Property="IsMouseOver" Value="True">
                                                        <Setter TargetName="bd" Property="Background" Value="#47505A"/>
                                                    </Trigger>
                                                    <!-- pressed color -->
                                                    <Trigger Property="IsPressed" Value="True">
                                                        <Setter TargetName="bd" Property="Background" Value="#2F363E"/>
                                                    </Trigger>
                                                </ControlTemplate.Triggers>
                                            </ControlTemplate>
                                        </Button.Template>
                                    </Button>

                                    <!-- Install -->
                                    <Button x:Name="BtnRunInstall"
                                            Content="Install"
                                            Width="110" Height="32"
                                            FontSize="13"
                                            Foreground="{ColorText}"
                                            Background="#2B6CB0"
                                            BorderThickness="0"
                                            Cursor="Hand"
                                            ToolTip="Run all checked installations">
                                        <Button.Template>
                                            <ControlTemplate TargetType="Button">
                                                <Border x:Name="bd" CornerRadius="6" Background="{TemplateBinding Background}">
                                                    <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                                                </Border>
                                                <ControlTemplate.Triggers>
                                                    <!-- hover color -->
                                                    <Trigger Property="IsMouseOver" Value="True">
                                                        <Setter TargetName="bd" Property="Background" Value="#3C7DD8"/>
                                                    </Trigger>
                                                    <!-- pressed color -->
                                                    <Trigger Property="IsPressed" Value="True">
                                                        <Setter TargetName="bd" Property="Background" Value="#245C9E"/>
                                                    </Trigger>
                                                </ControlTemplate.Triggers>
                                            </ControlTemplate>
                                        </Button.Template>
                                    </Button>

                                </StackPanel>

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
    '{CheckButtonColor}'     = $CheckButtonColor
    '{CheckButtonTextColor}' = $CheckButtonTextColor

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



# Section : 5 - Content Definitions (Manual Arrays)

# ===========================================
# 🌐 Remote Module Loader Template (v3)
# ===========================================

# 🔧 Define the remote file location and name
$RemoteModuleURL_ContentDefinitions = 'https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/AdvanceSetupTools-PSVersion/Modules/ContentDefinitions.ps1'
$RemoteModuleName_ContentDefinitions = 'ContentDefinitions.ps1'
$LocalModulePath_ContentDefinitions  = Join-Path $PSScriptRoot "Modules\$RemoteModuleName_ContentDefinitions"

try {
    Write-Host "🌐 Loading $RemoteModuleName_ContentDefinitions from GitHub..." -ForegroundColor Cyan
    $scriptText_ContentDefinitions = Invoke-RestMethod -Uri $RemoteModuleURL_ContentDefinitions -UseBasicParsing -ErrorAction Stop

    if ([string]::IsNullOrWhiteSpace($scriptText_ContentDefinitions)) {
        throw "Empty or invalid script content from GitHub."
    }

    # ✅ Successfully loaded from GitHub
    Invoke-Expression $scriptText_ContentDefinitions
    Write-Host "✅ $RemoteModuleName_ContentDefinitions loaded successfully from GitHub." -ForegroundColor Green
}
catch {
    Write-Warning "⚠️ Failed to load ${RemoteModuleName_ContentDefinitions} from GitHub: $($_.Exception.Message)"
    
    # 🔁 Attempt local fallback
    if (Test-Path $LocalModulePath_ContentDefinitions) {
        Write-Host "📁 Attempting to load local copy: $LocalModulePath_ContentDefinitions" -ForegroundColor Yellow
        try {
            $scriptText_ContentDefinitions = Get-Content -Path $LocalModulePath_ContentDefinitions -Raw -ErrorAction Stop
            Invoke-Expression $scriptText_ContentDefinitions
            Write-Host "✅ Local copy of $RemoteModuleName_ContentDefinitions loaded successfully." -ForegroundColor Green
        }
        catch {
            Write-Error "❌ Failed to load local copy of ${RemoteModuleName_ContentDefinitions}: $($_.Exception.Message)"
            throw
        }
    }
    else {
        Write-Error "❌ Neither remote nor local copy of ${RemoteModuleName_ContentDefinitions} could be loaded."
        throw
    }
}

# ===========================================
# 🌐 End Remote Module Loader Template
# ===========================================


# Section : 5 - Content Definitions - End

# Section : 6 - Dynamic Installer Builder - Start


# ===========================================
# 🌐 Remote Module Loader Template (v3)
# ===========================================

# 🔧 Define the remote file location and name
$RemoteModuleURL_BasicSoftwarePage  = 'https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/AdvanceSetupTools-PSVersion/Modules/BasicSoftwarePage.ps1'
$RemoteModuleName_BasicSoftwarePage = 'BasicSoftwarePage.ps1'
$LocalModulePath_BasicSoftwarePage  = Join-Path $PSScriptRoot "Modules\$RemoteModuleName_BasicSoftwarePage"

try {
    Write-Host "🌐 Loading $RemoteModuleName_BasicSoftwarePage from GitHub..." -ForegroundColor Cyan
    $scriptText_BasicSoftwarePage = Invoke-RestMethod -Uri $RemoteModuleURL_BasicSoftwarePage -UseBasicParsing -ErrorAction Stop

    if ([string]::IsNullOrWhiteSpace($scriptText_BasicSoftwarePage)) {
        throw "Empty or invalid script content from GitHub."
    }

    # ✅ Successfully loaded from GitHub
    Invoke-Expression $scriptText_BasicSoftwarePage
    Write-Host "✅ $RemoteModuleName_BasicSoftwarePage loaded successfully from GitHub." -ForegroundColor Green
}
catch {
    Write-Warning "⚠️ Failed to load ${RemoteModuleName_BasicSoftwarePage} from GitHub: $($_.Exception.Message)"
    
    # 🔁 Attempt local fallback
    if (Test-Path $LocalModulePath_BasicSoftwarePage) {
        Write-Host "📁 Attempting to load local copy: $LocalModulePath_BasicSoftwarePage" -ForegroundColor Yellow
        try {
            $scriptText_BasicSoftwarePage = Get-Content -Path $LocalModulePath_BasicSoftwarePage -Raw -ErrorAction Stop
            Invoke-Expression $scriptText_BasicSoftwarePage
            Write-Host "✅ Local copy of $RemoteModuleName_BasicSoftwarePage loaded successfully." -ForegroundColor Green
        }
        catch {
            Write-Error "❌ Failed to load local copy of ${RemoteModuleName_BasicSoftwarePage}: $($_.Exception.Message)"
            throw
        }
    }
    else {
        Write-Error "❌ Neither remote nor local copy of ${RemoteModuleName_BasicSoftwarePage} could be loaded."
        throw
    }
}

# ===========================================
# 🌐 End Remote Module Loader Template
# ===========================================





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

