# Module : Content Definitions (Externalized from Section 5)
# Scope  : Dot-sourced into Main.ps1 (PowerShell 7 only)
# Note   : Keep variable names exactly the same as before.

# Section : 5 - Content Definitions (Manual Arrays) - Start
# Replace “dummy” entries with your real app scripts later.
$GamesBoxItems = @(
    @{ Name="Steam"; Content="Steam Client"; Script="irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/steam.ps1 | iex" }
)
$LangInputBoxItems = @(
    @{ Name="KeyboardFix"; Content="Keyboard Fix - Set English (US) as Default and Remove English (My)"; Script="irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/settings/keyboard-RemoveEnglishMY.ps1 | iex" },
    @{ Name="SogouPinyin"; Content="Sogou Pinyin"; Script="irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/SogouPinyin.ps1 | iex" },
    @{ Name="mspinyin"; Content="Microsoft Pinyin Chinese (Simplified)"; Script="irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/settings/Keyboard-AddChineseSimplified.ps1 | iex" }
)
$AntiVirusBoxItems = @(@{ Name="Avira"; Content="Avira"; Script="irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/AviraAntivirus.ps1 | iex" })
$WebBrowserBoxItems = @(
    @{ Name="GoogleChrome"; Content="Google Chrome"; Script="irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/GoogleChrome.ps1 | iex" },
    @{ Name="FireFox"; Content="Mozilla Firefox"; Script="irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/FireFox.ps1 | iex" }
)
$CompToolsBoxItems = @(
    @{ Name="WinRAR"; Content="WinRAR"; Script="irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/WinRAR.ps1 | iex" },
    @{ Name="SevenZip"; Content="7 Zip"; Script="irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/7zip.ps1 | iex" }
)
$PDFBoxItems = @(
    @{ Name="AdobeAcrobatReader64bit"; Content="Adobe Acrobat Reader DC 64-bit"; Script="irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/AdobeReader.ps1 | iex" },
    @{ Name="doPDF11"; Content="doPDF 11"; Script="irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/doPDF.ps1 | iex" }
)
$RDPBoxItems = @(
    @{ Name="Anydesk"; Content="AnyDesk"; Script="irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/AnyDesk.ps1 | iex" },
    @{ Name="UltraViewer"; Content="UltraViewer"; Script="irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/UltraViewer.ps1 | iex" }
)
$VideoBoxItems = @(
    @{ Name="VLCPlayer"; Content="VLC Player"; Script="irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/VLC-Player.ps1 | iex" },
    @{ Name="KLiteFull"; Content="K-Lite Codec Pack Full"; Script="irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/K-LiteFull.ps1 | iex" }
)
$PhotoBoxItems = @(@{ Name="IrfanView"; Content="IrfanView"; Script="irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/IrfanView.ps1 | iex" })
$CommsBoxItems = @(@{ Name="Zoom"; Content="Zoom"; Script="irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/Zoom.ps1 | iex" })
$JavaBoxItems = @(
    @{ Name="java32"; Content="Orecle Java Runtime 32bit - Download From https://javadl.oracle.com"; Script="irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/OrecleJavaRuntime-32bit.ps1 | iex" },
    @{ Name="java64"; Content="Oricle Java Runtime 64bit - Download From https://javadl.oracle.com"; Script="irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/OrecleJavaRuntime-64bit.ps1 | iex" }
)
$VCRedisBoxItems = @(
    @{ Name="VCRedist2015_2022_32bit"; Content="Microsoft VCRedist 2015-2022 32bit"; Script="irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/VisualStudio2015-2022-32bit.ps1 | iex" },
    @{ Name="VCRedist2015_2022_64bit"; Content="Microsoft VCRedist 2015-2022 64bit"; Script="irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/VisualStudio2015-2022-64bit.ps1 | iex" },
    @{ Name="VCRedist2013_32bit"; Content="Microsoft VCRedist 2013 32bit"; Script="irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/VisualStudio2013-32bit.ps1 | iex" },
    @{ Name="VCRedist2013_64bit"; Content="Microsoft VCRedist 2013 64bit"; Script="irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/VisualStudio2013-64bit.ps1 | iex" },
    @{ Name="VCRedist2012_32bit"; Content="Microsoft VCRedist 2012 32bit"; Script="irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/VisualStudio2012-32bit.ps1 | iex" },
    @{ Name="VCRedist2012_64bit"; Content="Microsoft VCRedist 2012 64bit"; Script="irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/VisualStudio2012-64bit.ps1 | iex" },
    @{ Name="VCRedist2010_32bit"; Content="Microsoft VCRedist 2010 32bit"; Script="irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/VisualStudio2010-32bit.ps1 | iex" },
    @{ Name="VCRedist2010_64bit"; Content="Microsoft VCRedist 2010 64bit"; Script="irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/VisualStudio2010-64bit.ps1 | iex" },
    @{ Name="VCRedist2008_32bit"; Content="Microsoft VCRedist 2008 32bit"; Script="irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/VisualStudio2008-32bit.ps1 | iex" },
    @{ Name="VCRedist2008_64bit"; Content="Microsoft VCRedist 2008 64bit"; Script="irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/VisualStudio2008-64bit.ps1 | iex" },
    @{ Name="VCRedist2005_32bit"; Content="Microsoft VCRedist 2005 32bit"; Script="irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/VisualStudio2005-32bit.ps1 | iex" },
    @{ Name="VCRedist2005_64bit"; Content="Microsoft VCRedist 2005 64bit"; Script="irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/VisualStudio2005-64bit.ps1 | iex" }
)
$DotNetBoxItems = @(@{ Name="DotNet1"; Content="dummy 32"; Script={ "dummy 32" } })
# Section : 5 - Content Definitions (Manual Arrays) - End
# ============================
# Preset Profiles
# ============================

# ⚙️ Hytec shop preset
$HytecPreset = @(
    "Steam",
    "GoogleChrome",
    "SevenZip",
    "AnyDesk"
)

# ⚙️ Easy PC preset
$EasyPCPreset = @(
    "Steam",
    "FireFox",
    "WinRAR",
    "GoogleChrome",
    "VLCPlayer",
    "AdobeAcrobatReader64bit"
    
)
