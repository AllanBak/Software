
# InstallUpdates.ps1
# This script installs the PSWindowsUpdate module, accepts all Windows updates, and reboots automatically if needed.
# It includes logging and error handling.

# Define the log file path
$logFile = "C:\Windows\Temp\InstallUpdates.log"

# Function to log messages
function Log-Message {
    param (
        [string]$message
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "$timestamp - $message"
    Write-Output $logMessage
    Add-Content -Path $logFile -Value $logMessage
}

# Start logging
Log-Message "Starting Windows Update installation..."

# Install NuGet package provider if not already installed
if (-not (Get-PackageProvider -Name NuGet -ErrorAction SilentlyContinue)) {
    Log-Message "Installing NuGet package provider..."
    Install-PackageProvider -Name NuGet -Force -ErrorAction Stop
    Log-Message "NuGet package provider installed."
}

# Install PSWindowsUpdate module if not already installed
if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
    Log-Message "Installing PSWindowsUpdate module..."
    Install-Module -Name PSWindowsUpdate -Force -ErrorAction Stop
    Log-Message "PSWindowsUpdate module installed."
}

# Import the PSWindowsUpdate module
Import-Module PSWindowsUpdate

# Install all available Windows updates
try {
    Log-Message "Installing Windows updates..."
    Install-WindowsUpdate -AcceptAll -AutoReboot -ErrorAction Stop
    Log-Message "Windows updates installation complete."
} catch {
    Log-Message "Error during Windows updates installation: $_"
    throw $_
}

# End logging
Log-Message "Windows Update installation script completed."
