Add-Type -AssemblyName "System.Windows.Forms"

# Function to select an image file
Function Select-ImageFile {
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.Filter = "Image Files|*.jpg;*.jpeg;*.png;*.bmp;*.gif"  # Filter for image files
    $OpenFileDialog.Title = "Select an Image File"
    
    # Show dialog and return selected file path
    if ($OpenFileDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        return $OpenFileDialog.FileName
    } else {
        Write-Host "No file selected" -ForegroundColor Red
        return $null
    }
}

# Function to set lock screen and desktop wallpapers
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

            # Update registry for Desktop Image
            New-ItemProperty -Path $RegKeyPath -Name "DesktopImageStatus" -Value 1 -PropertyType DWORD -Force | Out-Null
            New-ItemProperty -Path $RegKeyPath -Name "DesktopImagePath" -Value $DesktopImageValue -PropertyType STRING -Force | Out-Null
            New-ItemProperty -Path $RegKeyPath -Name "DesktopImageUrl" -Value $DesktopImageValue -PropertyType STRING -Force | Out-Null

            # Apply wallpaper change immediately
            Start-Sleep -Seconds 2  # Add a small delay for the system to process the update
            Start-Process rundll32.exe user32.dll,UpdatePerUserSystemParameters
        } else {
            Write-Host "Desktop background image not found at $Source." -ForegroundColor Red
        }
            Start-Process rundll32.exe user32.dll,UpdatePerUserSystemParameters
    }

    Write-Host "Wallpapers set successfully!"
}

# Prompt user to select the image for wallpaper
$Source = Select-ImageFile

# If user selects an image, set the wallpaper
if ($Source) {
    Set-Wallpapers -Source $Source
} else {
    Write-Host "No image selected. Exiting."
}
