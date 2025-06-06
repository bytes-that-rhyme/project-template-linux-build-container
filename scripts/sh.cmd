@echo off
setlocal enabledelayedexpansion enableextensions
call config.cmd
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
pushd %~dp0 || exit /b 1
cd ..
if exist container.cid (
  for /f "delims=" %%x in (container.cid) do set CONTAINER_ID=%%x || exit /b 1
  podman container exists !CONTAINER_ID! && (
    echo Reusing existing running container ID !CONTAINER_ID!
    podman exec -it !CONTAINER_ID! /bin/bash --login || exit /b 1
    goto finish
  ) || (
    echo Deleting stale container file...
    del container.cid || exit /b 1
  )
)
echo Starting new container...
podman run --rm -it --cidfile "container.cid" -v "%DEV_DIRECTORY%:/src" "%MACHINE_NAME%" /bin/bash --login || exit /b 1

:finish
popd || exit /b 1
