# Module : Content Definitions (Externalized from Section 5)
# Scope  : Dot-sourced into Main.ps1 (PowerShell 7 only)
# Note   : Keep variable names exactly the same as before.

# Section : 5 - Content Definitions (Manual Arrays) - Start
# Replace “dummy” entries with your real app scripts later.
$GamesBoxItems = @(
    @{ Name="Steam"; Content="Steam Client"; Script={ "irm https://raw.githubusercontent.com/yourrepo/install/Steam.ps1 | iex" } }
)
$LangInputBoxItems = @(
    @{ Name="KeyboardFix"; Content="Keyboard Fix - Set English (US) as Default and Remove English (My)"; Script={ "irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/settings/KeyboardLanguageCleanup.ps1 | iex" } },
    @{ Name="SogouPinyin"; Content="Sogou Pinyin"; Script={ "irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/SougouPinyin.ps1 | iex" } }
)
$AntiVirusBoxItems = @(@{ Name="Avira"; Content="Avira"; Script={ "irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/AviraAntivirus.ps1 | iex" } })
$WebBrowserBoxItems = @(
    @{ Name="GoogleChrome"; Content="Google Chrome"; Script={ "irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/GoogleChrome.ps1 | iex" } },
    @{ Name="FireFox"; Content="Mozilla Firefox"; Script={ "irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/FireFox.ps1 | iex" } }
)
$CompToolsBoxItems = @(
    @{ Name="WinRAR"; Content="WinRAR"; Script={ "irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/WinRAR.ps1 | iex" } },
    @{ Name="SevenZip"; Content="7 Zip"; Script={ "irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/7zip.ps1 | iex" } }
)
$PDFBoxItems = @(
    @{ Name="AdobeAcrobatReader64bit"; Content="Adobe Acrobat Reader DC 64-bit"; Script={ "irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/AdobeReader.ps1 | iex" } },
    @{ Name="doPDF11"; Content="doPDF 11"; Script={ "irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/doPDF.ps1 | iex" } }
)
$RDPBoxItems = @(
    @{ Name="Anydesk"; Content="AnyDesk"; Script={ "irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/AnyDesk.ps1 | iex" } },
    @{ Name="UltraViewer"; Content="UltraViewer"; Script={ "irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/UltraViewer.ps1 | iex" } }
)
$VideoBoxItems = @(
    @{ Name="VLCPlayer"; Content="VLC Player"; Script={ "irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/VLC-Player.ps1 | iex" } },
    @{ Name="KLiteFull"; Content="K-Lite Codec Pack Full"; Script={ "irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/K-LiteFull.ps1 | iex" } }
)
$PhotoBoxItems = @(@{ Name="IrfanView"; Content="IrfanView"; Script={ "irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/IrfanView.ps1 | iex" } })
$CommsBoxItems = @(@{ Name="Zoom"; Content="Zoom"; Script={ "irm https://raw.githubusercontent.com/cwlxxx/vault7/refs/heads/main/install/Zoom.ps1 | iex" } })
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
# ============================
# Preset Profiles
# ============================

# ⚙️ Hytec shop preset
$HytecPreset = @(
    "Steam",
    "GoogleChrome",
    "7Zip",
    "AnyDesk"
)

# ⚙️ Easy PC preset
$EasyPCPreset = @(
    "Steam",
    "MozillaFirefox",
    "WinRAR",
    "TeamViewer"
)
