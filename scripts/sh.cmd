@echo off
if "%DEV_DIRECTORY%" equ "" (
  echo The DEV_DIRECTORY environment variable needs to be set.
  echo Make sure you ran setup.cmd, or you are using a command prompt launched
  echo from shell.cmd.
  echo.
  exit /b 1
  )
if "%MACHINE_NAME%" equ "" (
  echo The MACHINE_NAME environment variable needs to be set.
  echo Make sure you ran setup.cmd, or you are using a command prompt launched
  echo from shell.cmd.
  echo.
  exit /b 1
  )
pushd %~dp0
cd ..
podman run --rm --interactive --tty -v "%DEV_DIRECTORY%:/src" "%MACHINE_NAME%" /bin/bash --login
popd
