@echo off
title Project Shell
cd %~dp0

echo Project
echo.

echo Setting up...
call scripts\setup.cmd && cls
@echo off
echo.

echo Commands:
echo.
echo build    Builds the image
echo sh       Opens a Bash shell using the image
echo.

cmd /K
