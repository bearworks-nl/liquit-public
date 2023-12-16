@echo off

TITLE Install Liquit Workspace Agent

ECHO.
ECHO Install Liquit Workspace Agent

SETLOCAL

Set THISDIR=%~dp0

"%THISDIR%AgentBootstrapper-2.0.0.6.exe" /startDeployment /waitForDeployment