#====================================================
#   DEFINE VARIABLES AND PATHS
#====================================================
$DownloadUrl = "http://192.168.0.3/cmd/disable-windows-fast-startup.html"
$DownloadPath = "$env:TEMP\installer"
$BatchFilePath = Join-Path -Path $DownloadPath -ChildPath "disable-windows-fast-startup.bat"

#====================================================
#   PREPARE DIRECTORY
#====================================================
try {
    if (-not (Test-Path -Path $DownloadPath)) {
        Write-Host "Creating download directory: $DownloadPath"
        New-Item -Path $DownloadPath -ItemType Directory -Force | Out-Null
    }
}
catch {
    Write-Error "Failed to create directory. Error: $_"
    exit
}

#====================================================
#   DOWNLOAD THE FILE
#====================================================
Write-Host "Downloading content from $DownloadUrl..."
try {
    Invoke-WebRequest -Uri $DownloadUrl -OutFile $BatchFilePath -UseBasicParsing
    Write-Host "Download complete. File saved to: $BatchFilePath"
}
catch {
    Write-Error "Failed to download the file from $DownloadUrl. Error: $_"
    exit
}

#====================================================
#   EXECUTE THE BATCH FILE
#====================================================
Write-Host "Executing batch file: $BatchFilePath"
try {
    # Use Start-Process to run the batch file and wait for it to finish
    Start-Process -FilePath $BatchFilePath -Wait -NoNewWindow
    Write-Host "Batch file execution complete." -ForegroundColor Green
}
catch {
    Write-Error "An error occurred during batch file execution. Error: $_"
    exit
}

#====================================================
#   COMPLETION
#====================================================
Write-Host "Script finished."
