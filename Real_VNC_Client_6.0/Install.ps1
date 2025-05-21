$Vendor = "RealVNC"
$Product = "Viewer_6.0"

$PackageName = "VNCViewer" # Insert filename for installation, without .EXE
$UnattendedArgs = '/Silent'

# ----- DO NOT EDIT BELOW THIS LINE -----

Write-Verbose "Setting Arguments" -Verbose

$StartDTM = (Get-Date)

$InstallerType = "EXE"

$LogPS = "${env:SystemRoot}" + "\Temp\$Vendor $Product PS Wrapper.log"

$LogApp = "${env:SystemRoot}" + "\Temp\$Vendor $Product $PackageName.log"

Start-Transcript $LogPS

Write-Verbose "Starting Installation of $Vendor $Product" -Verbose

change user /install

Try {
    #$ExitCode = (Start-Process "$PSScriptRoot\Files\$PackageName.$InstallerType" $UnattendedArgs -ErrorAction Stop -Wait -Passthru).ExitCode
    #$ExitCode 
} catch {
    #$ExitCode = 126
    #$ExitCode 
}

Write-Verbose "Customization" -Verbose

Write-Verbose "Copying Files" -Verbose
Copy-Item "$PSScriptRoot\FilesToCopy\*" "C:\" -Recurse -Container -ErrorAction SilentlyContinue

change user /execute

Write-Verbose "Stop logging" -Verbose

$EndDTM = (Get-Date)

Write-Verbose "Elapsed Time: $(($EndDTM-$StartDTM).TotalSeconds) Seconds" -Verbose

Write-Verbose "Elapsed Time: $(($EndDTM-$StartDTM).TotalMinutes) Minutes" -Verbose

Stop-Transcript
Exit $ExitCode