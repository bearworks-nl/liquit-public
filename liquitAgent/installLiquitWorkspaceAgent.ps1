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

#Dynamic Variables

$Hostname = (Get-ComputerInfo).CsName

if ($Hostname -like 'AVDRAA*') {

    $HostPoolFolder = "RemoteApp-Acc"

    }

if ($Hostname -like 'AVDRAD*') {

    $HostPoolFolder = "RemoteApp-Dev"

    }

if ($Hostname -like 'AVDRAP*') {

    $HostPoolFolder = "RemoteApp-Prd"

    }

if ($Hostname -like 'AVDRAT*') {

    $HostPoolFolder = "RemoteApp-Tst"

    }

if ($Hostname -like 'AVDRDA*') {

    $HostPoolFolder = "RemoteDesktop-Acc"

    }

if ($Hostname -like 'AVDRDD*') {

    $HostPoolFolder = "RemoteDesktop-Dev"

    }
    
if ($Hostname -like 'AVDRDP*') {

    $HostPoolFolder = "RemoteDesktop-Prd"

    }

if ($Hostname -like 'AVDRDT*') {

    $HostPoolFolder = "RemoteDesktop-Tst"

    }

if ($Hostname -like 'AVDRVA*') {

    $HostPoolFolder = "RemoteVDI-Acc"

    }

if ($Hostname -like 'AVDRVD*') {

    $HostPoolFolder = "RemoteVDI-Dev"

    }

if ($Hostname -like 'AVDRVP*') {

    $HostPoolFolder = "RemoteVDI-Prd"

    }

if ($Hostname -like 'AVDRVT*') {

    $HostPoolFolder = "RemoteVDI-Tst"

    }

#Variables
$IncomingPath = "$env:ProgramData\Liquit\Agent\Downloads"

$AgentBootstrapperUrl = "https://download.liquit.com/extra/Bootstrapper/AgentBootstrapper-1.0.0.2.exe"

$AgentXMLUrl = "https://stcacfcustomscript.blob.core.windows.net/liquit/$HostPoolFolder/Agent.xml"

$ExeFile = $IncomingPath + "\" + $(Split-Path -Path $AgentBootstrapperUrl -Leaf) 

$XMLFile = $IncomingPath + "\" + $(Split-Path -Path $AgentXMLUrl -Leaf) 

#Create folder paths
If (!(Test-Path $IncomingPath)){

    New-Item -Path $IncomingPath -ItemType Directory
}


#Download files
Invoke-WebRequest $AgentBootstrapperUrl -OutFile $ExeFile -UseBasicParsing

Invoke-WebRequest $AgentXMLUrl -OutFile $XMLFile -UseBasicParsing


#Check if agent.xml exist and remove

if (Test-Path "${env:ProgramFiles(x86)}\Liquit Workspace\Agent\Agent.xml"){

    Remove-Item -Path "${env:ProgramFiles(x86)}\Liquit Workspace\Agent\Agent.xml" -Force

    }

#Install Liquit Agent
Set-Location -Path $IncomingPath

Start-Process -FilePath $ExeFile.Split('\')[-1] -ArgumentList "/startDeployment /waitForDeployment"
