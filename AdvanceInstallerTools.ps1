# ============================================================
# 🪟 WPF GUI – Advance Installer Tools (PowerShell 7)
# ============================================================
Add-Type -AssemblyName PresentationFramework
# ------------------------------------------------------------
# 🧩 Section : Script Metadata - Start
# ------------------------------------------------------------
$ScriptVersion = "5.0"
$ScriptName    = "Advance Installer Tools Ver. $($ScriptVersion)"
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
        Name    = "HostFileTimeStemp"
        Content = "Host File Time Stemp"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/settings/HostFileTimeStemp.ps1 | iex }
    },
    @{
        Name    = "DisableUAC"
        Content = "Disable UAC"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/settings/UAC-Disable.ps1 | iex }
    },
    @{
        Name    = "EnableIcon"
        Content = "Enable 'This PC' Icon etc.2"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/settings/EnableDesktopIcons.ps1 | iex }
    },
    @{
        Name    = "NeverSleep"
        Content = "Never Turn Off Monitor and Never Sleep"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/settings/TurnOffSleep.ps1 | iex }
    },
    @{
        Name    = "DisableWindowsFastStartup"
        Content = "Disable Windows Fast Startup"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/settings/DisableFastStartup.ps1 | iex }
    }
    )
# ------------------------------------------------------------
# ⚙️ Section : Setting Box Content - End
# ------------------------------------------------------------

# ------------------------------------------------------------
# ⚙️ Section : Visual C++ Redistributable Box Content - Start
# ------------------------------------------------------------
$VCRedisBoxItems = @(
    @{
        Name    = "VCRedist2015_2022-32"
        Content = "Microsoft Visual C++ Redistributable packages 2015-2022 x86"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/VisualStudio2015-2022-32bit.ps1 | iex }
    },
    @{
        Name    = "VCRedist2015_2022-64"
        Content = "Microsoft Visual C++ Redistributable packages 2015-2022 x64"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/VisualStudio2015-2022-32bit.ps1 | iex }
    },
    @{
        Name    = "VCRedist2013-86"
        Content = "Microsoft Visual C++ Redistributable packages 2013 x86"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/VisualStudio2013-32bit.ps1 | iex }
    },
    @{
        Name    = "VCRedist2013-64"
        Content = "Microsoft Visual C++ Redistributable packages 2013 x64"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/VisualStudio2013-64bit.ps1 | iex }
    },
    @{
        Name    = "VCRedist2012-86"
        Content = "Microsoft Visual C++ Redistributable packages 2012 x86"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/VisualStudio2012-32bit.ps1 | iex }
    },
    @{
        Name    = "VCRedist2012-64"
        Content = "Microsoft Visual C++ Redistributable packages 2012 x64"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/VisualStudio2012-64bit.ps1 | iex }
    },
        @{
        Name    = "VCRedist2010-86"
        Content = "Microsoft Visual C++ Redistributable packages 2010 x86"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/VisualStudio2010-32bit.ps1 | iex }
    },
    @{
        Name    = "VCRedist2010-64"
        Content = "Microsoft Visual C++ Redistributable packages 2010 x64"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/VisualStudio2010-64bit.ps1 | iex }
    },
    @{
        Name    = "VCRedist2008-86"
        Content = "Microsoft Visual C++ Redistributable packages 2008 x86"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/VisualStudio2008-32bit.ps1 | iex }
    },
    @{
        Name    = "VCRedist2008-64"
        Content = "Microsoft Visual C++ Redistributable packages 2008 x64"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/VisualStudio2008-64bit.ps1 | iex }
    },
    @{
        Name    = "VCRedist2008-86"
        Content = "Microsoft Visual C++ Redistributable packages 2008 x86"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/VisualStudio2008-32bit.ps1 | iex }
    },
    @{
        Name    = "VCRedist2008-64"
        Content = "Microsoft Visual C++ Redistributable packages 2008 x64"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/VisualStudio2008-64bit.ps1 | iex }
    },
    @{
        Name    = "VCRedist2005-86"
        Content = "Microsoft Visual C++ Redistributable packages 2005 x86"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/VisualStudio2005-32bit.ps1 | iex }
    },
    @{
        Name    = "VCRedist2005-64"
        Content = "Microsoft Visual C++ Redistributable packages 2005 x64"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/VisualStudio2005-64bit.ps1 | iex }
    }
)
# ------------------------------------------------------------
# ⚙️ Section : Visual C++ Redistributable Box Content - End
# ------------------------------------------------------------

# ------------------------------------------------------------
# ⚙️ Section : Web Browser Box Content - Start
# ------------------------------------------------------------
$BrowserBoxItems = @(
    @{
        Name    = "GoogleChrome"
        Content = "Google Chrome"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/GoogleChrome.ps1 | iex }
    },
    @{
        Name    = "FireFox"
        Content = "Mozilla FireFox"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/FireFox.ps1 | iex }
    }
)
# ------------------------------------------------------------
# ⚙️ Section : Web Browser Box Content - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# ⚙️ Section : Video Player Box Content - Start
# ------------------------------------------------------------

$VideoPlayerApps = @(
    @{
        Name    = "K-LiteFull"
        Content = "K-Lite Codec Pack Full"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/K-LiteFull.ps1 | iex }
    },
    @{
        Name    = "VLC-Player"
        Content = "VLC Player"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/VLC-Player.ps1 | iex }
    }
)

# ------------------------------------------------------------
# ⚙️ Section : Video Player Box Content - End
# ------------------------------------------------------------



# ------------------------------------------------------------
# ⚙️ Section : Photo Viewer Box Content - Start
# ------------------------------------------------------------

$PhotoViewerApps = @(
    @{
        Name    = "IrfanView"
        Content = "IrfanView graphic viewer"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/IrfanView.ps1 | iex }
    }
)

# ------------------------------------------------------------
# ⚙️ Section : Photo Viewer Box Content - End
# ------------------------------------------------------------



# ------------------------------------------------------------
# ⚙️ Section : Anti-Virus Box Content - Start
# ------------------------------------------------------------

$AntiVirusApps = @(
    @{
        Name    = "AviraAntivirus"
        Content = "Avira Free Antivirus"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/AviraAntivirus.ps1 | iex }
    }
)

# ------------------------------------------------------------
# ⚙️ Section : Anti-Virus Box Content - End
# ------------------------------------------------------------



# ------------------------------------------------------------
# ⚙️ Section : Remote Desktop Box Content - Start
# ------------------------------------------------------------

$RemoteDesktopApps = @(
    @{
        Name    = "AnyDesk "
        Content = "AnyDesk"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/AnyDesk.ps1 | iex }
    },
    @{
        Name    = "UltraViewer"
        Content = "UltraViewer"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/UltraViewer.ps1 | iex }
    }
)

# ------------------------------------------------------------
# ⚙️ Section : Remote Desktop Box Content - End
# ------------------------------------------------------------



# ------------------------------------------------------------
# ⚙️ Section : PDF Utility Box Content - Start
# ------------------------------------------------------------

$PDFUtilityApps = @(
    @{
        Name    = "AdobeReader"
        Content = "Adobe Acrobat Reader DC"
        Script  = { https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/AdobeReader.ps1 }
    },
    @{
        Name    = "doPDF"
        Content = "doPDF 11"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/doPDF.ps1 | iex }
    }
)

# ------------------------------------------------------------
# ⚙️ Section : PDF Utility Box Content - End
# ------------------------------------------------------------



# ------------------------------------------------------------
# ⚙️ Section : Language & Input Tools Box Content - Start
# ------------------------------------------------------------

$LanguageInputApps = @(
    @{
        Name    = "KeyboardLanguageFix"
        Content = "Keyboard Language Fix"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/settings/KeyboardLanguageCleanup.ps1 | iex }
    },
    @{
        Name    = "sogou.pinyin"
        Content = "Sogou Pinyin"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/SougouPinyin.ps1 | iex }
    }
)

# ------------------------------------------------------------
# ⚙️ Section : Language & Input Tools Box Content - End
# ------------------------------------------------------------



# ------------------------------------------------------------
# ⚙️ Section : Communication & Conferencing Box Content - Start
# ------------------------------------------------------------

$CommunicationApps = @(
    @{
        Name    = "zoom"
        Content = "Zoom"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/Zoom.ps1 | iex }
    }
)

# ------------------------------------------------------------
# ⚙️ Section : Communication & Conferencing Box Content - End
# ------------------------------------------------------------

# ------------------------------------------------------------
# ⚙️ Section : Compression Tools Box Content - Start
# ------------------------------------------------------------
$CompressionToolsApps = @(
    @{
        Name    = "WinRAR"
        Content = "WinRAR"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/WinRAR.ps1 | iex }
    },
    @{
        Name    = "7zip"
        Content = "7-Zip"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/7zip.ps1 | iex }
    }
)
# ------------------------------------------------------------
# ⚙️ Section : Compression Tools Box Content - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# ⚙️ Section : Java Runtime Box Content - Start
# ------------------------------------------------------------
$JavaRuntimeApps = @(
    @{
        Name    = "OrecleJavaRuntime"
        Content = "Orecle Java Runtime (JRE) - 32bit"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/OrecleJavaRuntime-32bit.ps1 | iex }
    },
    @{
        Name    = "OrecleJavaRuntime64"
        Content = "Orecle Java Runtime (JRE) - 64bit"
        Script  = { irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/OrecleJavaRuntime-64bit.ps1 | iex }
    }
)
# ------------------------------------------------------------
# ⚙️ Section : Java Runtime Box Content - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# ⚙️ Section : Visual C++ 1.1 Box Content - Start
# ------------------------------------------------------------
$DotNetLegacyApps = @(
    @{
        Name    = "VCRedistLegacy"
        Content = ".NET Framework 1.1"
        Script  = { ReplaceScriptHere }
    }
)
# ------------------------------------------------------------
# ⚙️ Section : Visual C++ 1.1 Box Content - End
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

    <!-- 🌙 Sub-Section : Global Button Style -->
    <Window.Resources>
        <!-- Shared style for all Check/Uncheck buttons -->
        <Style x:Key="CheckButtonStyle" TargetType="Button">
            <Setter Property="Background" Value="#3A3A3A" />
            <Setter Property="Foreground" Value="#EAEAEA" />
            <Setter Property="FontWeight" Value="SemiBold" />
            <Setter Property="Cursor" Value="Hand" />
            <Setter Property="BorderThickness" Value="0" />
            <Setter Property="Width" Value="110" />
            <Setter Property="Height" Value="30" />
            <Setter Property="Margin" Value="5,0" />
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}" CornerRadius="6">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center" />
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Background" Value="#4A4A4A" />
                            </Trigger>
                            <Trigger Property="IsPressed" Value="True">
                                <Setter Property="Background" Value="#2C2C2C" />
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>

    <Grid Margin="20">
        <Grid.RowDefinitions>
            <RowDefinition Height="*" />    <!-- Main Content -->
            <RowDefinition Height="Auto" /> <!-- Buttons -->
            <RowDefinition Height="Auto" /> <!-- Footer line -->
            <RowDefinition Height="Auto" /> <!-- Footer text -->
        </Grid.RowDefinitions>

        <!-- Scrollable layout area -->
        <ScrollViewer Grid.Row="0" VerticalScrollBarVisibility="Auto" HorizontalScrollBarVisibility="Disabled">
            <WrapPanel x:Name="MainPanel" Margin="10" Orientation="Horizontal" ItemHeight="Auto">

                <!-- Settings Group Card -->
                <Border Background="#2B2B2B" CornerRadius="12" Margin="15" Padding="20"
                        HorizontalAlignment="Left" VerticalAlignment="Top">
                    <StackPanel>
                        <TextBlock Text="Settings" FontWeight="SemiBold" Foreground="#EAEAEA"
                                   FontSize="18" Margin="0,0,0,10" />
                        <StackPanel x:Name="SettingsStack" />
                        <StackPanel Orientation="Horizontal" HorizontalAlignment="Center" Margin="0,10,0,0">
                            <Button x:Name="SettingsCheckAll" Content="Check All" Style="{StaticResource CheckButtonStyle}" />
                            <Button x:Name="SettingsUncheckAll" Content="Uncheck All" Style="{StaticResource CheckButtonStyle}" />
                        </StackPanel>
                    </StackPanel>
                </Border>

                <!-- Visual C++ Redistributable Group Card -->
                <Border Background="#2F2F2F" CornerRadius="12" Margin="15" Padding="20"
                        HorizontalAlignment="Left" VerticalAlignment="Top">
                    <StackPanel>
                        <TextBlock Text="Visual C++ Redistributable" FontWeight="SemiBold"
                                   Foreground="#EAEAEA" FontSize="18" Margin="0,0,0,10" />
                        <StackPanel x:Name="VCRedisStack" />
                        <StackPanel Orientation="Horizontal" HorizontalAlignment="Center" Margin="0,10,0,0">
                            <Button x:Name="VCRedisCheckAll" Content="Check All" Style="{StaticResource CheckButtonStyle}" />
                            <Button x:Name="VCRedisUncheckAll" Content="Uncheck All" Style="{StaticResource CheckButtonStyle}" />
                        </StackPanel>
                    </StackPanel>
                </Border>

                <!-- Language & Input Tools Group Card -->
                <Border Background="#2F2F2F" CornerRadius="12" Margin="15" Padding="20"
                        HorizontalAlignment="Left" VerticalAlignment="Top">
                    <StackPanel>
                        <TextBlock Text="Language &amp; Input Tools" FontWeight="SemiBold" Foreground="#E4EAEA"
                                   FontSize="18" Margin="0,0,0,10" />
                        <StackPanel x:Name="LanguageInputStack" />
                        <StackPanel Orientation="Horizontal" HorizontalAlignment="Center" Margin="0,10,0,0">
                            <Button x:Name="LanguageInputCheckAll" Content="Check All" Style="{StaticResource CheckButtonStyle}" />
                            <Button x:Name="LanguageInputUncheckAll" Content="Uncheck All" Style="{StaticResource CheckButtonStyle}" />
                        </StackPanel>
                    </StackPanel>
                </Border>


                <!-- Web Browser Group Card -->
                <Border Background="#333333" CornerRadius="12" Margin="15" Padding="20"
                        HorizontalAlignment="Left" VerticalAlignment="Top">
                    <StackPanel>
                        <TextBlock Text="Web Browser" FontWeight="SemiBold" Foreground="#EAEAEA"
                                   FontSize="18" Margin="0,0,0,10" />
                        <StackPanel x:Name="BrowserStack" />
                        <StackPanel Orientation="Horizontal" HorizontalAlignment="Center" Margin="0,10,0,0">
                            <Button x:Name="BrowserCheckAll" Content="Check All" Style="{StaticResource CheckButtonStyle}" />
                            <Button x:Name="BrowserUncheckAll" Content="Uncheck All" Style="{StaticResource CheckButtonStyle}" />
                        </StackPanel>
                    </StackPanel>
                </Border>

                <!-- Video Player Group Card -->
                <Border Background="#2B2B2B" CornerRadius="12" Margin="15" Padding="20"
                        HorizontalAlignment="Left" VerticalAlignment="Top">
                    <StackPanel>
                        <TextBlock Text="Video Player" FontWeight="SemiBold" Foreground="#E4EAEA"
                                   FontSize="18" Margin="0,0,0,10" />
                        <StackPanel x:Name="VideoPlayerStack" />
                        <StackPanel Orientation="Horizontal" HorizontalAlignment="Center" Margin="0,10,0,0">
                            <Button x:Name="VideoPlayerCheckAll" Content="Check All" Style="{StaticResource CheckButtonStyle}" />
                            <Button x:Name="VideoPlayerUncheckAll" Content="Uncheck All" Style="{StaticResource CheckButtonStyle}" />
                        </StackPanel>
                    </StackPanel>
                </Border>

                <!-- Photo Viewer Group Card -->
                <Border Background="#2F2F2F" CornerRadius="12" Margin="15" Padding="20"
                        HorizontalAlignment="Left" VerticalAlignment="Top">
                    <StackPanel>
                        <TextBlock Text="Photo Viewer" FontWeight="SemiBold" Foreground="#E4EAEA"
                                   FontSize="18" Margin="0,0,0,10" />
                        <StackPanel x:Name="PhotoViewerStack" />
                        <StackPanel Orientation="Horizontal" HorizontalAlignment="Center" Margin="0,10,0,0">
                            <Button x:Name="PhotoViewerCheckAll" Content="Check All" Style="{StaticResource CheckButtonStyle}" />
                            <Button x:Name="PhotoViewerUncheckAll" Content="Uncheck All" Style="{StaticResource CheckButtonStyle}" />
                        </StackPanel>
                    </StackPanel>
                </Border>

                <!-- Anti-Virus Group Card -->
                <Border Background="#2B2B2B" CornerRadius="12" Margin="15" Padding="20"
                        HorizontalAlignment="Left" VerticalAlignment="Top">
                    <StackPanel>
                        <TextBlock Text="Anti-Virus" FontWeight="SemiBold" Foreground="#E4EAEA"
                                   FontSize="18" Margin="0,0,0,10" />
                        <StackPanel x:Name="AntiVirusStack" />
                        <StackPanel Orientation="Horizontal" HorizontalAlignment="Center" Margin="0,10,0,0">
                            <Button x:Name="AntiVirusCheckAll" Content="Check All" Style="{StaticResource CheckButtonStyle}" />
                            <Button x:Name="AntiVirusUncheckAll" Content="Uncheck All" Style="{StaticResource CheckButtonStyle}" />
                        </StackPanel>
                    </StackPanel>
                </Border>

                <!-- Remote Desktop Group Card -->
                <Border Background="#2F2F2F" CornerRadius="12" Margin="15" Padding="20"
                        HorizontalAlignment="Left" VerticalAlignment="Top">
                    <StackPanel>
                        <TextBlock Text="Remote Desktop" FontWeight="SemiBold" Foreground="#E4EAEA"
                                   FontSize="18" Margin="0,0,0,10" />
                        <StackPanel x:Name="RemoteDesktopStack" />
                        <StackPanel Orientation="Horizontal" HorizontalAlignment="Center" Margin="0,10,0,0">
                            <Button x:Name="RemoteDesktopCheckAll" Content="Check All" Style="{StaticResource CheckButtonStyle}" />
                            <Button x:Name="RemoteDesktopUncheckAll" Content="Uncheck All" Style="{StaticResource CheckButtonStyle}" />
                        </StackPanel>
                    </StackPanel>
                </Border>

                <!-- PDF Utility Group Card -->
                <Border Background="#2B2B2B" CornerRadius="12" Margin="15" Padding="20"
                        HorizontalAlignment="Left" VerticalAlignment="Top">
                    <StackPanel>
                        <TextBlock Text="PDF Utility" FontWeight="SemiBold" Foreground="#E4EAEA"
                                   FontSize="18" Margin="0,0,0,10" />
                        <StackPanel x:Name="PDFUtilityStack" />
                        <StackPanel Orientation="Horizontal" HorizontalAlignment="Center" Margin="0,10,0,0">
                            <Button x:Name="PDFUtilityCheckAll" Content="Check All" Style="{StaticResource CheckButtonStyle}" />
                            <Button x:Name="PDFUtilityUncheckAll" Content="Uncheck All" Style="{StaticResource CheckButtonStyle}" />
                        </StackPanel>
                    </StackPanel>
                </Border>

                <!-- Communication & Conferencing Group Card -->
                <Border Background="#2B2B2B" CornerRadius="12" Margin="15" Padding="20"
                        HorizontalAlignment="Left" VerticalAlignment="Top">
                    <StackPanel>
                        <TextBlock Text="Communication &amp; Conferencing" FontWeight="SemiBold" Foreground="#E4EAEA"
                                   FontSize="18" Margin="0,0,0,10" />
                        <StackPanel x:Name="CommunicationStack" />
                        <StackPanel Orientation="Horizontal" HorizontalAlignment="Center" Margin="0,10,0,0">
                            <Button x:Name="CommunicationCheckAll" Content="Check All" Style="{StaticResource CheckButtonStyle}" />
                            <Button x:Name="CommunicationUncheckAll" Content="Uncheck All" Style="{StaticResource CheckButtonStyle}" />
                        </StackPanel>
                    </StackPanel>
                </Border>

                <!-- Compression Tools Group Card -->
                <Border Background="#2B2B2B" CornerRadius="12" Margin="15" Padding="20"
                        HorizontalAlignment="Left" VerticalAlignment="Top">
                    <StackPanel>
                        <TextBlock Text="Compression Tools" FontWeight="SemiBold" Foreground="#E4EAEA"
                                   FontSize="18" Margin="0,0,0,10" />
                        <StackPanel x:Name="CompressionToolsStack" />
                        <StackPanel Orientation="Horizontal" HorizontalAlignment="Center" Margin="0,10,0,0">
                            <Button x:Name="CompressionToolsCheckAll" Content="Check All" Style="{StaticResource CheckButtonStyle}" />
                            <Button x:Name="CompressionToolsUncheckAll" Content="Uncheck All" Style="{StaticResource CheckButtonStyle}" />
                        </StackPanel>
                    </StackPanel>
                </Border>

                <!-- Java Runtime Group Card -->
                <Border Background="#2F2F2F" CornerRadius="12" Margin="15" Padding="20"
                        HorizontalAlignment="Left" VerticalAlignment="Top">
                    <StackPanel>
                        <TextBlock Text="Java Runtime" FontWeight="SemiBold" Foreground="#E4EAEA"
                                   FontSize="18" Margin="0,0,0,10" />
                        <StackPanel x:Name="JavaRuntimeStack" />
                        <StackPanel Orientation="Horizontal" HorizontalAlignment="Center" Margin="0,10,0,0">
                            <Button x:Name="JavaRuntimeCheckAll" Content="Check All" Style="{StaticResource CheckButtonStyle}" />
                            <Button x:Name="JavaRuntimeUncheckAll" Content="Uncheck All" Style="{StaticResource CheckButtonStyle}" />
                        </StackPanel>
                    </StackPanel>
                </Border>

                <!-- Visual C++ 1.1 Group Card -->
                <Border Background="#A34242"
                        CornerRadius="12"
                        Margin="15"
                        Padding="20"
                        HorizontalAlignment="Left"
                        VerticalAlignment="Top">
                    <StackPanel>
                        <TextBlock Text="Visual C++ 1.1"
                                   FontWeight="SemiBold"
                                   Foreground="#FAFAFA"
                                   FontSize="18"
                                   Margin="0,0,0,10" />
                        <StackPanel x:Name="VCRedisLegacyStack" />
                    </StackPanel>
                </Border>


            </WrapPanel>
        </ScrollViewer>

        <!-- Button Row -->
        <StackPanel Grid.Row="1" Orientation="Horizontal" HorizontalAlignment="Center" Margin="0,20,0,15">
            <!-- Exit Button -->
            <Button x:Name="ExitButton"
                    Content="Exit"
                    Width="120"
                    Height="38"
                    Margin="10,0"
                    Foreground="White"
                    FontWeight="SemiBold"
                    Cursor="Hand"
                    BorderThickness="0"
                    Padding="5">
                <Button.Template>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="ButtonBorder"
                                Background="#C0392B"
                                CornerRadius="6">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="ButtonBorder" Property="Background" Value="#E74C3C"/>
                            </Trigger>
                            <Trigger Property="IsPressed" Value="True">
                                <Setter TargetName="ButtonBorder" Property="Background" Value="#A93226"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Button.Template>
            </Button>

            <!-- Install Button -->
            <Button x:Name="RunButton"
                    Content="Install"
                    Width="120"
                    Height="38"
                    Margin="10,0"
                    Foreground="White"
                    FontWeight="SemiBold"
                    Cursor="Hand"
                    BorderThickness="0"
                    Padding="5">
                <Button.Template>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="ButtonBorder"
                                Background="#2B6CB0"
                                CornerRadius="6">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="ButtonBorder" Property="Background" Value="#3C8DFF"/>
                            </Trigger>
                            <Trigger Property="IsPressed" Value="True">
                                <Setter TargetName="ButtonBorder" Property="Background" Value="#1A4A8A"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Button.Template>
            </Button>
        </StackPanel>


        <!-- Footer -->
        <Grid Grid.Row="2" HorizontalAlignment="Center" Margin="0,0,0,5">
            <Rectangle x:Name="FooterLine" Fill="Gray" Height="1" Width="700"
                       HorizontalAlignment="Center" Margin="0,0,0,5" />
        </Grid>

        <TextBlock Grid.Row="3" Text="© Liang | Advance Setup Tools"
                   Foreground="Gray" HorizontalAlignment="Center"
                   Margin="0,0,0,5" FontSize="12" />
    </Grid>
</Window>
"@
# ------------------------------------------------------------
# 🪟 Section : XAML Layout - End
# ------------------------------------------------------------




# ------------------------------------------------------------
# ⚙️ Section : Load and Initialize Window - Start
# ------------------------------------------------------------
$reader = New-Object System.Xml.XmlNodeReader $XAML
$window = [Windows.Markup.XamlReader]::Load($reader)
$window.Title = $ScriptName

# Retrieve UI elements
$ExitButton     = $window.FindName("ExitButton")
$RunButton      = $window.FindName("RunButton")
$SettingsStack  = $window.FindName("SettingsStack")
$BrowserStack   = $window.FindName("BrowserStack")
$VCRedisStack   = $window.FindName("VCRedisStack")
$VideoPlayerStack = $window.FindName("VideoPlayerStack")
$PhotoViewerStack = $window.FindName("PhotoViewerStack")
$AntiVirusStack   = $window.FindName("AntiVirusStack")
$RemoteDesktopStack = $window.FindName("RemoteDesktopStack")
$PDFUtilityStack  = $window.FindName("PDFUtilityStack")
$LanguageInputStack = $window.FindName("LanguageInputStack")
$CommunicationStack = $window.FindName("CommunicationStack")
$FooterLine     = $window.FindName("FooterLine")
$CompressionToolsStack = $window.FindName("CompressionToolsStack")
$JavaRuntimeStack      = $window.FindName("JavaRuntimeStack")
$VCRedisLegacyStack    = $window.FindName("VCRedisLegacyStack")

# --- Add checkboxes for each group ---
$AllCheckboxes = @()

$AllGroups = @{
    Settings           = $SettingsBoxItems, $SettingsStack
    Browser            = $BrowserBoxItems, $BrowserStack
    VCRedis            = $VCRedisBoxItems, $VCRedisStack
    VideoPlayer        = $VideoPlayerApps, $VideoPlayerStack
    PhotoViewer        = $PhotoViewerApps, $PhotoViewerStack
    AntiVirus          = $AntiVirusApps, $AntiVirusStack
    RemoteDesktop      = $RemoteDesktopApps, $RemoteDesktopStack
    PDFUtility         = $PDFUtilityApps, $PDFUtilityStack
    LanguageInput      = $LanguageInputApps, $LanguageInputStack
    Communication      = $CommunicationApps, $CommunicationStack
    CompressionTools   = $CompressionToolsApps, $CompressionToolsStack
    JavaRuntime        = $JavaRuntimeApps, $JavaRuntimeStack
    VCRedisLegacy      = $DotNetLegacyApps, $VCRedisLegacyStack
}

foreach ($group in $AllGroups.GetEnumerator()) {
    $items = $group.Value[0]
    $stack = $group.Value[1]

    foreach ($item in $items) {
        $cb = New-Object System.Windows.Controls.CheckBox
        $cb.Name = "CB_$($item.Name -replace '[^a-zA-Z0-9_]', '_')"
        $cb.Content = $item.Content
        $cb.Margin = "5,4,5,4"
        $cb.Foreground = "White"
        $cb.FontSize = 14
        $cb.FontFamily = "Segoe UI"
        $cb.Cursor = "Hand"
        $stack.Children.Add($cb) | Out-Null
        $AllCheckboxes += $cb
    }
}

# --- Dynamic Equal Width for All Group Boxes ---
# Finds the widest group box and keeps all other boxes synced as you resize
$groupBordersNames = @(
    "Settings", "Browser", "VCRedis", "VideoPlayer", "PhotoViewer",
    "AntiVirus", "RemoteDesktop", "PDFUtility", "LanguageInput",
    "Communication", "CompressionTools", "JavaRuntime", "VCRedisLegacy"
)

$UpdateGroupWidths = {
    $borderObjects = @()
    foreach ($name in $groupBordersNames) {
        try {
            $border = $window.FindName("${name}Stack").Parent
            if ($border) { $borderObjects += $border }
        } catch {}
    }

    if ($borderObjects.Count -gt 0) {
        $maxWidth = ($borderObjects | ForEach-Object { $_.ActualWidth } | Measure-Object -Maximum).Maximum
        foreach ($b in $borderObjects) {
            if ($maxWidth -gt 0) { $b.Width = $maxWidth }
        }
    }
}

# Initial equalization after render
$window.Add_ContentRendered({
    Start-Sleep -Milliseconds 250
    & $UpdateGroupWidths
})

# Keep boxes equalized on resize
$window.Add_SizeChanged({
    & $UpdateGroupWidths
})

# ------------------------------------------------------------
# ⚙️ Section : Load and Initialize Window - End
# ------------------------------------------------------------




# ------------------------------------------------------------
# ⚙️ Section : UI Event Handlers - Start
# ------------------------------------------------------------
# --- Exit Button ---
$ExitButton.Add_Click({
    $window.Close()
})

# --- Run (Install) Button ---
$RunButton.Add_Click({
    $SelectedScripts = @()

    # Collect checked boxes and match scripts
    foreach ($cb in $AllCheckboxes) {
        if ($cb.IsChecked) {
            $cleanName = ($cb.Name -replace '^CB_', '') -replace '[^a-zA-Z0-9_]', '_'

            $item = ($SettingsBoxItems + $BrowserBoxItems + $VCRedisBoxItems + 
                     $VideoPlayerApps + $PhotoViewerApps + $AntiVirusApps +
                     $RemoteDesktopApps + $PDFUtilityApps + $LanguageInputApps +
                     $CommunicationApps) |
                Where-Object { ($_).Name -replace '[^a-zA-Z0-9_]', '_' -eq $cleanName }

            if ($item) {
                $SelectedScripts += $item.Script
            }
        }
    }

    if ($SelectedScripts.Count -eq 0) {
        [System.Windows.MessageBox]::Show("Please select at least one item to install.", "No Selection", "OK", "Warning")
        return
    }

    # Convert all script blocks to strings safely
    $ScriptCommands = $SelectedScripts | ForEach-Object {
        ($_ | Out-String).Trim() -replace '^\{|\}$', ''
    }

    # Join all scripts with semicolons
    $CombinedScript = $ScriptCommands -join '; '

    # Add the closing prompt and exit
    $CloseMessage = 'Write-Host "`nAll selected installations finished." -ForegroundColor Green; Write-Host "Press Enter to close..." -ForegroundColor Yellow; Read-Host | Out-Null; exit'

    # Build final command (no -NoExit)
    $Command = "-Command `"Write-Host '--- Advance Installer Running ---' -ForegroundColor Cyan; $CombinedScript; $CloseMessage`""

    try {
        Start-Process "pwsh.exe" -ArgumentList $Command -WindowStyle Normal
    }
    catch {
        [System.Windows.MessageBox]::Show("Failed to launch PowerShell 7 console.`nEnsure PowerShell 7 is installed and in PATH.", "Error", "OK", "Error")
    }
})

# --- Group Box: Settings - Check/Uncheck All ---
$SettingsCheckAll = $window.FindName("SettingsCheckAll")
$SettingsUncheckAll = $window.FindName("SettingsUncheckAll")

$SettingsCheckAll.Add_Click({
    foreach ($cb in $AllCheckboxes) {
        if ($cb.Parent -eq $SettingsStack) { $cb.IsChecked = $true }
    }
})
$SettingsUncheckAll.Add_Click({
    foreach ($cb in $AllCheckboxes) {
        if ($cb.Parent -eq $SettingsStack) { $cb.IsChecked = $false }
    }
})

# --- Group Box: Visual C++ Redistributable - Check/Uncheck All ---
$VCRedisCheckAll = $window.FindName("VCRedisCheckAll")
$VCRedisUncheckAll = $window.FindName("VCRedisUncheckAll")

$VCRedisCheckAll.Add_Click({
    foreach ($cb in $AllCheckboxes) {
        if ($cb.Parent -eq $VCRedisStack) { $cb.IsChecked = $true }
    }
})
$VCRedisUncheckAll.Add_Click({
    foreach ($cb in $AllCheckboxes) {
        if ($cb.Parent -eq $VCRedisStack) { $cb.IsChecked = $false }
    }
})

# --- Group Box: Web Browser - Check/Uncheck All ---
$BrowserCheckAll = $window.FindName("BrowserCheckAll")
$BrowserUncheckAll = $window.FindName("BrowserUncheckAll")

$BrowserCheckAll.Add_Click({
    foreach ($cb in $AllCheckboxes) {
        if ($cb.Parent -eq $BrowserStack) { $cb.IsChecked = $true }
    }
})
$BrowserUncheckAll.Add_Click({
    foreach ($cb in $AllCheckboxes) {
        if ($cb.Parent -eq $BrowserStack) { $cb.IsChecked = $false }
    }
})

# --- Group Box: Video Player - Check/Uncheck All ---
$VideoPlayerCheckAll = $window.FindName("VideoPlayerCheckAll")
$VideoPlayerUncheckAll = $window.FindName("VideoPlayerUncheckAll")

$VideoPlayerCheckAll.Add_Click({
    foreach ($cb in $AllCheckboxes) {
        if ($cb.Parent -eq $VideoPlayerStack) { $cb.IsChecked = $true }
    }
})
$VideoPlayerUncheckAll.Add_Click({
    foreach ($cb in $AllCheckboxes) {
        if ($cb.Parent -eq $VideoPlayerStack) { $cb.IsChecked = $false }
    }
})

# --- Group Box: Photo Viewer - Check/Uncheck All ---
$PhotoViewerCheckAll = $window.FindName("PhotoViewerCheckAll")
$PhotoViewerUncheckAll = $window.FindName("PhotoViewerUncheckAll")

$PhotoViewerCheckAll.Add_Click({
    foreach ($cb in $AllCheckboxes) {
        if ($cb.Parent -eq $PhotoViewerStack) { $cb.IsChecked = $true }
    }
})
$PhotoViewerUncheckAll.Add_Click({
    foreach ($cb in $AllCheckboxes) {
        if ($cb.Parent -eq $PhotoViewerStack) { $cb.IsChecked = $false }
    }
})

# --- Group Box: Anti-Virus - Check/Uncheck All ---
$AntiVirusCheckAll = $window.FindName("AntiVirusCheckAll")
$AntiVirusUncheckAll = $window.FindName("AntiVirusUncheckAll")

$AntiVirusCheckAll.Add_Click({
    foreach ($cb in $AllCheckboxes) {
        if ($cb.Parent -eq $AntiVirusStack) { $cb.IsChecked = $true }
    }
})
$AntiVirusUncheckAll.Add_Click({
    foreach ($cb in $AllCheckboxes) {
        if ($cb.Parent -eq $AntiVirusStack) { $cb.IsChecked = $false }
    }
})

# --- Group Box: Remote Desktop - Check/Uncheck All ---
$RemoteDesktopCheckAll = $window.FindName("RemoteDesktopCheckAll")
$RemoteDesktopUncheckAll = $window.FindName("RemoteDesktopUncheckAll")

$RemoteDesktopCheckAll.Add_Click({
    foreach ($cb in $AllCheckboxes) {
        if ($cb.Parent -eq $RemoteDesktopStack) { $cb.IsChecked = $true }
    }
})
$RemoteDesktopUncheckAll.Add_Click({
    foreach ($cb in $AllCheckboxes) {
        if ($cb.Parent -eq $RemoteDesktopStack) { $cb.IsChecked = $false }
    }
})

# --- Group Box: PDF Utility - Check/Uncheck All ---
$PDFUtilityCheckAll = $window.FindName("PDFUtilityCheckAll")
$PDFUtilityUncheckAll = $window.FindName("PDFUtilityUncheckAll")

$PDFUtilityCheckAll.Add_Click({
    foreach ($cb in $AllCheckboxes) {
        if ($cb.Parent -eq $PDFUtilityStack) { $cb.IsChecked = $true }
    }
})
$PDFUtilityUncheckAll.Add_Click({
    foreach ($cb in $AllCheckboxes) {
        if ($cb.Parent -eq $PDFUtilityStack) { $cb.IsChecked = $false }
    }
})

# --- Group Box: Language & Input Tools - Check/Uncheck All ---
$LanguageInputCheckAll = $window.FindName("LanguageInputCheckAll")
$LanguageInputUncheckAll = $window.FindName("LanguageInputUncheckAll")

$LanguageInputCheckAll.Add_Click({
    foreach ($cb in $AllCheckboxes) {
        if ($cb.Parent -eq $LanguageInputStack) { $cb.IsChecked = $true }
    }
})
$LanguageInputUncheckAll.Add_Click({
    foreach ($cb in $AllCheckboxes) {
        if ($cb.Parent -eq $LanguageInputStack) { $cb.IsChecked = $false }
    }
})

# --- Group Box: Communication & Conferencing - Check/Uncheck All ---
$CommunicationCheckAll = $window.FindName("CommunicationCheckAll")
$CommunicationUncheckAll = $window.FindName("CommunicationUncheckAll")

$CommunicationCheckAll.Add_Click({
    foreach ($cb in $AllCheckboxes) {
        if ($cb.Parent -eq $CommunicationStack) { $cb.IsChecked = $true }
    }
})
$CommunicationUncheckAll.Add_Click({
    foreach ($cb in $AllCheckboxes) {
        if ($cb.Parent -eq $CommunicationStack) { $cb.IsChecked = $false }
    }
})

# --- Group Box: Compression Tools - Check/Uncheck All ---
$CompressionToolsCheckAll = $window.FindName("CompressionToolsCheckAll")
$CompressionToolsUncheckAll = $window.FindName("CompressionToolsUncheckAll")

$CompressionToolsCheckAll.Add_Click({
    foreach ($cb in $AllCheckboxes) {
        if ($cb.Parent -eq $CompressionToolsStack) {
            $cb.IsChecked = $true
        }
    }
})
$CompressionToolsUncheckAll.Add_Click({
    foreach ($cb in $AllCheckboxes) {
        if ($cb.Parent -eq $CompressionToolsStack) {
            $cb.IsChecked = $false
        }
    }
})


# --- Group Box: Java Runtime - Check/Uncheck All ---
$JavaRuntimeCheckAll = $window.FindName("JavaRuntimeCheckAll")
$JavaRuntimeUncheckAll = $window.FindName("JavaRuntimeUncheckAll")

$JavaRuntimeCheckAll.Add_Click({
    foreach ($cb in $AllCheckboxes) {
        if ($cb.Parent -eq $JavaRuntimeStack) {
            $cb.IsChecked = $true
        }
    }
})
$JavaRuntimeUncheckAll.Add_Click({
    foreach ($cb in $AllCheckboxes) {
        if ($cb.Parent -eq $JavaRuntimeStack) {
            $cb.IsChecked = $false
        }
    }
})


# --- Group Box: Visual C++ 1.1 (No Check/Uncheck Buttons) ---
# This group intentionally has no Check/Uncheck buttons
# Just loads checkboxes as-is when items exist in $DotNetLegacyApps


# --- Dynamically resize footer line width (80% of window width) ---
$window.Add_SourceInitialized({
    if ($FooterLine) { $FooterLine.Width = $window.ActualWidth * 0.8 }
})

$window.Add_SizeChanged({
    if ($FooterLine) { $FooterLine.Width = $window.ActualWidth * 0.8 }
})
# ------------------------------------------------------------
# ⚙️ Section : UI Event Handlers - End
# ------------------------------------------------------------


# ------------------------------------------------------------
# ⚙️ Section : Show Window - Start
# ------------------------------------------------------------
$window.ShowDialog() | Out-Null
# ------------------------------------------------------------
# ⚙️ Section : Show Window - End
# ------------------------------------------------------------
