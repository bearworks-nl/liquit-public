<# 
.SYNOPSIS 
   Install the Liquit Workspace Agent
 
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

#Define variables


    param (
        [string] $AgentBootstrapperUrl, # https://github.com/bearworks-nl/liquit-public/raw/main/liquitAgent/Intune-Personal/AgentBootstrapper-2.0.0.6.exe
        [string] $AgentJSONUrl # https://github.com/bearworks-nl/liquit-public/raw/main/liquitAgent/Intune-Personal/Agent.json
    )


#Variables
$DownloadPath = "$env:ProgramData\Liquit\Agent\Downloads"

$ExeFile = $DownloadPath + "\" + $(Split-Path -Path $AgentBootstrapperUrl -Leaf) 

$JSONFile = $DownloadPath + "\" + $(Split-Path -Path $AgentJSONUrl -Leaf) 

#Create folder paths
If (!(Test-Path $DownloadPath)){

    New-Item -Path $DownloadPath -ItemType Directory
}


#Download files
Invoke-WebRequest $AgentBootstrapperUrl -OutFile $ExeFile -UseBasicParsing

Invoke-WebRequest $AgentJSONUrl -OutFile $JSONFile -UseBasicParsing


#Check if agent.xml exist and remove

if (Test-Path "${$env:ProgramData}\Liquit\Agent\Agent.json") {

    Remove-Item -Path "${$env:ProgramData}\Liquit\Agent\Agent.json" -Force

    }


#Install Liquit Agent
Set-Location -Path $DownloadPath

Start-Process -FilePath $ExeFile.Split('\')[-1] -ArgumentList "/startDeployment /waitForDeployment"
