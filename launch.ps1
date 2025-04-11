# Get the directory of the currently running PowerShell script
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Define the relative path to the directory containing your static HTML app
$relativeAppDir = "dist"  # Change this to the relative path of your app folder

# Combine the script directory with the relative app directory to get the full path
$directory = Join-Path -Path $scriptDir -ChildPath $relativeAppDir

# Change the working directory to the application directory
Set-Location -Path $directory

# Start the Python HTTP server in the background
$serverProcess = Start-Process -PassThru -NoNewWindow -FilePath "python" -ArgumentList "-m http.server 8000"

# Start Chrome in App mode, pointing to the local server (adjust the URL as needed)
$chromeProcess = Start-Process -PassThru -FilePath "chrome.exe" -ArgumentList "--app=http://localhost:8000"

# Wait until the Chrome process ends
$chromeProcess.WaitForExit()

# Once Chrome is closed, stop the web server
$serverProcess.Kill()

Write-Host "Server stopped, Chrome browser closed."
