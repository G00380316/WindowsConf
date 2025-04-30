Function Set-Wallpapers {
    Param (
        [string]$Source
    )

    $ErrorActionPreference = "Stop"

    # Set Registry path for Personalization
    $RegKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP"
    
    # Paths for the local copy of wallpaper images
    $DesktopImageValue = "C:\Windows\System32\Desktop.jpg"
    $LockScreenImageValue = "C:\Windows\System32\LockScreen.jpg"

    if (!(Test-Path $RegKeyPath)) {
        Write-Host "Creating registry path $($RegKeyPath)."
        New-Item -Path $RegKeyPath -Force | Out-Null
    }

    # Set lock screen image
    if ($Source) {
        Write-Host "Copying Lock Screen image from $($Source) to $($LockScreenImageValue)."
        Copy-Item $Source $LockScreenImageValue -Force
        Write-Host "Creating registry entries for Lock Screen"
        New-ItemProperty -Path $RegKeyPath -Name "LockScreenImageStatus" -Value 1 -PropertyType DWORD -Force | Out-Null
        New-ItemProperty -Path $RegKeyPath -Name "LockScreenImagePath" -Value $LockScreenImageValue -PropertyType STRING -Force | Out-Null
    }

    # Set desktop wallpaper image
    if ($Source) {
        if (Test-Path $Source) {
            Write-Host "Copying Desktop Background image from $($Source) to $($DesktopImageValue)." -ForegroundColor Green
            Copy-Item $Source $DesktopImageValue -Force
            Write-Host "Creating registry entries for Desktop Background" -ForegroundColor Green

            # Update the registry for Desktop Image
            New-ItemProperty -Path $RegKeyPath -Name "DesktopImageStatus" -Value 1 -PropertyType DWORD -Force | Out-Null
            New-ItemProperty -Path $RegKeyPath -Name "DesktopImagePath" -Value $DesktopImageValue -PropertyType STRING -Force | Out-Null
            New-ItemProperty -Path $RegKeyPath -Name "DesktopImageUrl" -Value $DesktopImageValue -PropertyType STRING -Force | Out-Null

            # Use RUNDLL32 to apply wallpaper immediately (can be faster)
            Start-Process rundll32.exe user32.dll,UpdatePerUserSystemParameters
        } else {
            Write-Host "Desktop background image not found at $Source." -ForegroundColor Red
        }
    }

    Write-Host "Wallpapers set successfully!"
}

# Handle drag-and-drop input (if passed as arguments)
if ($args.Length -gt 0) {
    $Source = $args[0]
    Set-Wallpapers -Source $Source
} else {
    Write-Host "No files dragged. Please input the file paths for the images."

    # Ask the user to input file paths for the lock screen and desktop images
    $Source = Read-Host "Enter the path to the image"

    # Call the function to set wallpapers
    Set-Wallpapers -Source $Source
}
