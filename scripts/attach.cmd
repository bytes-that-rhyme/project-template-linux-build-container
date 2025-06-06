@echo off
set CONTAINER=%1
if "%CONTAINER%" equ "" (
  echo Missing container ID to attach to.
  echo Here are the active containers:
  podman ps
  exit /b 1
  )
pushd %~dp0
cd ..
podman exec --interactive --tty "%CONTAINER%" /bin/bash --login
popd
