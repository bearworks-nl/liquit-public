<# 
.SYNOPSIS 
   Uninstall the Liquit Workspace Agent
 
.DESCRIPTION 
   This script will download the installer package and install the Liquit Workspace Agent package.
   The script is created for deployment via a Custom Script Extension (CSE) during the deployment of a Azure Virtual Desktop host or during the autopilot fase of an Intune deployment.
        
.NOTES 
    Author: Benno Rummens
    Website: https://www.linkedin.com/in/bennorummens
    Last Updated: 16/05/2022
    Version 1.0

    #DISCLAIMER
    The script is provided AS IS without warranty of any kind.

#>

#Uninstall Liquit Agent

$Package = Get-WmiObject Win32_Product | Where-Object {$_.name -like 'Liquit Universal Agent for Windows*'}).PackageCode
Set-Location -Path $DownloadPath

Start-Process msiexec -ArgumentList "/quiet /norestart /uninstall ${$Identi"
