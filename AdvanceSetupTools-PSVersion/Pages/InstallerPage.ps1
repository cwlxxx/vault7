# InstallerPage.ps1
Add-Type -AssemblyName PresentationFramework

# Create a black Border with centered text
$page = New-Object System.Windows.Controls.Border
$page.Background = [Windows.Media.Brushes]::Black
$page.Margin = '20'
$page.CornerRadius = '8'

$text = New-Object System.Windows.Controls.TextBlock
$text.Text = "This is InstallerPage.ps1 file"
$text.Foreground = [Windows.Media.Brushes]::White
$text.FontSize = 22
$text.HorizontalAlignment = 'Center'
$text.VerticalAlignment = 'Center'

$page.Child = $text
return $page
