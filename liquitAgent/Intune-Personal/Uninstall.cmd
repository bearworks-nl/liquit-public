@echo off

TITLE Uninstall Liquit Universal Agent

ECHO.
ECHO Uninstall Liquit Universal Agent

SETLOCAL

Set THISDIR=%~dp0

wmic product where "name like 'Liquit Universal Agent for Windows%%'" call uninstall /nointeractive

rmdir /S /Q "C:\Program Files (x86)\Liquit Workspace"

rmdir /S /Q "C:\ProgramData\Liquit"