<# 
.SYNOPSIS 
   Install the Liquit Workspace Agent
 
.DESCRIPTION 
   This script will download the installer package from Liquit and install the Liquit Workspace Agent package.
   The script is created for deployment via a Custom Script Extension (CSE) during the deployment of a Azure Virtual Desktop host.
        
.NOTES 
    Author: brummens
    Website: http://www.loginconsultants.com
    Last Updated: 16/05/2022
    Version 1.0

    #DISCLAIMER
    The script is provided AS IS without warranty of any kind.

#>

#Get Variables

$AgentBootstrapperUrl = "https://download.liquit.com/extra/Bootstrapper/AgentBootstrapper-2.0.0.6.exe"

$AgentJSONUrl = "https://stcacfcustomscript.blob.core.windows.net/liquit/$HostPoolFolder/Agent.xml"


#Variables
$DownloadPath = "$env:ProgramData\Liquit\Agent\Downloads"

$ExeFile = $DownloadPath + "\" + $(Split-Path -Path $AgentBootstrapperUrl -Leaf) 

$AgentJSONUrl = $DownloadPath + "\" + $(Split-Path -Path $AgentJSONUrl -Leaf) 

#Create folder paths
If (!(Test-Path $DownloadPath)){

    New-Item -Path $DownloadPath -ItemType Directory
}


#Download files
Invoke-WebRequest $AgentBootstrapperUrl -OutFile $ExeFile -UseBasicParsing

Invoke-WebRequest $AgentJSONUrl -OutFile $JSONFile -UseBasicParsing


#Check if agent.xml exist and remove

if (Test-Path "${env:ProgramFiles(x86)}\Liquit Workspace\Agent\Agent.xml"){

    Remove-Item -Path "${env:ProgramFiles(x86)}\Liquit Workspace\Agent\Agent.xml" -Force

    }

#Install Liquit Agent
Set-Location -Path $DownloadPath

Start-Process -FilePath $ExeFile.Split('\')[-1] -ArgumentList "/startDeployment /waitForDeployment"
