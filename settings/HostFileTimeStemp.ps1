# ============================================================
# 🧱 HostFileTimeStemp - WPF Edition (by Liang) - Version 2.0
# ============================================================
# Description:
#   - Modern WPF window asks: "PC Setup By" → Hytec / Easy PC (vertical buttons)
#   - Writes/updates a small "SetupInfo" comment block in the Windows hosts file
#   - Prints the full hosts file content to the console afterward
#   - Dark gradient theme, rounded corners, smooth glow, © Liang footer
#   - PowerShell 7 only
# ============================================================

# ------------------------------------------------------------
# 🔗 Section : Configurable Shortcut Variables - Start
# ------------------------------------------------------------
# You can quickly change this footer label to your name or company
$FooterLabel = "© Liang"
# ------------------------------------------------------------
# 🔗 Section : Configurable Shortcut Variables - End
# ------------------------------------------------------------

# ------------------------------------------------------------
# ⚙️ Section : Script Setup - Start
# ------------------------------------------------------------
Write-Host "⚙️ Running in simplified mode (no version/admin checks)..." -ForegroundColor Cyan
Add-Type -AssemblyName PresentationCore, PresentationFramework, WindowsBase
# ------------------------------------------------------------
# ⚙️ Section : Script Setup - End
# ------------------------------------------------------------

# ------------------------------------------------------------
# 🪟 Section : Create WPF Window (XAML) - Start
# ------------------------------------------------------------
[xml]$xaml = @'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="PC Setup By" Height="350" Width="500"
        WindowStartupLocation="CenterScreen"
        Background="#00000000"
        AllowsTransparency="True"
        WindowStyle="None"
        Opacity="0"
        ShowInTaskbar="True">

  <Window.Resources>
    <!-- Primary Button (True Double Height) -->
    <Style TargetType="Button" x:Key="PrimaryButton">
      <Setter Property="Margin" Value="0,12,0,12"/>
      <Setter Property="Height" Value="70"/>           <!-- Taller fixed height -->
      <Setter Property="Width" Value="260"/>           <!-- Wider for balance -->
      <Setter Property="FontSize" Value="18"/>
      <Setter Property="Foreground" Value="White"/>
      <Setter Property="Background" Value="#2B6CB0"/>
      <Setter Property="Cursor" Value="Hand"/>
      <Setter Property="RenderTransformOrigin" Value="0.5,0.5"/>
      <Setter Property="RenderTransform">
        <Setter.Value>
          <ScaleTransform ScaleX="1" ScaleY="1"/>
        </Setter.Value>
      </Setter>
      <Setter Property="Template">
        <Setter.Value>
          <ControlTemplate TargetType="Button">
            <Border x:Name="bd" CornerRadius="14" Background="{TemplateBinding Background}">
              <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
            </Border>
            <ControlTemplate.Triggers>
              <Trigger Property="IsMouseOver" Value="True">
                <Setter TargetName="bd" Property="Background" Value="#357ED6"/>
              </Trigger>
              <Trigger Property="IsPressed" Value="True">
                <Setter TargetName="bd" Property="Background" Value="#235A96"/>
              </Trigger>
            </ControlTemplate.Triggers>
          </ControlTemplate>
        </Setter.Value>
      </Setter>
      <Setter Property="Effect">
        <Setter.Value>
          <DropShadowEffect ShadowDepth="0" BlurRadius="18" Opacity="0.4"/>
        </Setter.Value>
      </Setter>
    </Style>

    <!-- Gradient card container -->
    <Style TargetType="Border" x:Key="Card">
      <Setter Property="CornerRadius" Value="20"/>
      <Setter Property="Background">
        <Setter.Value>
          <LinearGradientBrush StartPoint="0,0" EndPoint="0,1">
            <GradientStop Color="#1A1F25" Offset="0"/>
            <GradientStop Color="#0E1115" Offset="1"/>
          </LinearGradientBrush>
        </Setter.Value>
      </Setter>
      <Setter Property="Padding" Value="30"/>
      <Setter Property="Effect">
        <Setter.Value>
          <DropShadowEffect ShadowDepth="0" BlurRadius="32" Opacity="0.3" Color="#2B6CB0"/>
        </Setter.Value>
      </Setter>
    </Style>
  </Window.Resources>

  <Grid Margin="16">
    <Border Style="{StaticResource Card}">
      <Grid>
        <Grid.RowDefinitions>
          <RowDefinition Height="Auto"/>
          <RowDefinition Height="*"/>
          <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>

        <!-- Title -->
        <TextBlock Text="PC Setup By" Foreground="White" FontSize="24" FontWeight="SemiBold"
                   Margin="4,0,4,16" HorizontalAlignment="Center"/>

        <!-- Buttons -->
        <StackPanel Grid.Row="1" VerticalAlignment="Center" HorizontalAlignment="Center">
          <Button x:Name="BtnHytec" Content="Hytec" Style="{StaticResource PrimaryButton}"/>
          <Button x:Name="BtnEasyPC" Content="Easy PC" Style="{StaticResource PrimaryButton}"/>
        </StackPanel>

        <!-- Footer -->
        <DockPanel Grid.Row="2" LastChildFill="True" Margin="0,18,0,0">
          <TextBlock x:Name="FooterLabelBlock" Text="" Foreground="#A0A8B0" FontSize="12"
                     HorizontalAlignment="Center"/>
        </DockPanel>
      </Grid>
    </Border>
  </Grid>

  <!-- Fade-in animation -->
  <Window.Triggers>
    <EventTrigger RoutedEvent="Window.Loaded">
      <BeginStoryboard>
        <Storyboard>
          <DoubleAnimation Storyboard.TargetProperty="Opacity" From="0" To="1" Duration="0:0:0.18"/>
        </Storyboard>
      </BeginStoryboard>
    </EventTrigger>
  </Window.Triggers>
</Window>
'@

# Load WPF window
$xmlReader = New-Object System.Xml.XmlNodeReader $xaml
$window = [Windows.Markup.XamlReader]::Load($xmlReader)

# Get controls
$BtnHytec  = $window.FindName('BtnHytec')
$BtnEasyPC = $window.FindName('BtnEasyPC')
$FooterLabelBlock = $window.FindName('FooterLabelBlock')
$FooterLabelBlock.Text = $FooterLabel

# Enable drag move
$Root_MouseDown = {
    param($sender, $e)
    if ($e.LeftButton -eq [System.Windows.Input.MouseButtonState]::Pressed) {
        try { $window.DragMove() } catch {}
    }
}
$window.Add_MouseDown($Root_MouseDown)
# ------------------------------------------------------------
# 🪟 Section : Create WPF Window (XAML) - End
# ------------------------------------------------------------

# ------------------------------------------------------------
# 🧠 Section : Button Actions & Result - Start
# ------------------------------------------------------------
$script:SetupBy = $null
$BtnHytec.Add_Click({ $script:SetupBy = 'Hytec'; $window.Close() })
$BtnEasyPC.Add_Click({ $script:SetupBy = 'Easy PC'; $window.Close() })
[void]$window.ShowDialog()

if (-not $script:SetupBy) {
    Write-Host "No selection made. Exiting without changes." -ForegroundColor Yellow
    return
}
# ------------------------------------------------------------
# 🧠 Section : Button Actions & Result - End
# ------------------------------------------------------------

# ------------------------------------------------------------
# 🧾 Section : Hosts File Update - Start
# ------------------------------------------------------------
$hostsPath = Join-Path $env:SystemRoot 'System32\drivers\etc\hosts'

# Prepare date & time
$now = Get-Date
$date = $now.ToString("dd-MM-yyyy")
$time = $now.ToString("hh:mm:ss tt")

# Read current hosts file
$content = Get-Content -Path $hostsPath -Raw -ErrorAction Stop

# Build new entry block
$newEntry = @"
# ============================================================
# This PC Set Up By : $($script:SetupBy)
# Date : $date
# Time : $time
# ============================================================
"@.Trim()

# Add line breaks for clarity and insert on top
$newBlock = "$newEntry`r`n`r`n"
$updated = $newBlock + $content.TrimStart()

# Write updated hosts file (ASCII encoding)
$updated | Out-File -FilePath $hostsPath -Encoding ASCII -Force
# ------------------------------------------------------------
# 🧾 Section : Hosts File Update - End
# ------------------------------------------------------------

# ------------------------------------------------------------
# 🖨️ Section : Console Output (Show Hosts Content) - Start
# ------------------------------------------------------------
Write-Host ""
Write-Host "==================== HOSTS FILE (AFTER UPDATE) ====================" -ForegroundColor Cyan
Get-Content -Path $hostsPath | ForEach-Object { Write-Host $_ }
Write-Host "===================================================================" -ForegroundColor Cyan
# ------------------------------------------------------------
# 🖨️ Section : Console Output (Show Hosts Content) - End
# ------------------------------------------------------------
