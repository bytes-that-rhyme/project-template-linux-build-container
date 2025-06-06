@echo off
title Project Shell
cd %~dp0

echo Project
echo.

echo Setting up...
call scripts\setup.cmd
@echo off
echo.

echo Commands:
echo.
echo build    Builds the image
echo sh       Opens a Bash shell
echo code     Launch Visual Studio Code with dev container (not working right now)
echo attach   Attaches to existing container
echo.

cmd /K
