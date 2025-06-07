@echo on
pushd "%~dp0..\" || exit /b 1
set BASE=%CD%
call scripts\config.cmd
set CONTAINERS_STORAGE_DIR=%BASE%\podman-storage
set CONTAINERS_STORAGE_CONF=%BASE%\storage.conf

:: note: the trailing slash ensures that this path is a directory.
if not exist "%DEV_DIRECTORY%\" (
  echo Development path must be a directory: %DEV_DIRECTORY%
  echo Change DEV_DIRECTORY in setup.cmd, or ensure that the above directory exists.
  echo.
  )

setlocal enableextensions enabledelayedexpansion

if not exist "%CONTAINERS_STORAGE_DIR%" (
  mkdir "%CONTAINERS_STORAGE_DIR%" || exit /b 1
  )

if not exist "%CONTAINERS_STORAGE_CONF%" (
  echo [storage]>"%CONTAINERS_STORAGE_CONF%"
  echo driver = "overlay">>"%CONTAINERS_STORAGE_CONF%"
  :: the :\=\\ trick replaces single backslashes with double backslashes to
  :: escape them.
  echo graphroot = "%CONTAINERS_STORAGE_DIR:\=\\%">>"%CONTAINERS_STORAGE_CONF%"
  )

set PODMAN_URL=https://github.com/containers/podman/releases/download/v5.4.0/podman-remote-release-windows_amd64.zip

if not exist deps (
  mkdir deps || exit /b 1
  )

pushd deps || exit /b 1

if not exist podman-5.4.0 (
  if not exist podman.zip (
    curl -L -o podman_temp.zip "!PODMAN_URL!" || exit /b 1
    move podman_temp.zip podman.zip || exit /b 1
    )
  mkdir podman_temp || exit /b 1
  tar -C podman_temp -xzf podman.zip || exit /b 1
  move podman_temp/podman-5.4.0 . || exit /b 1
  rmdir podman_temp
  )

set PATH=%BASE%\deps\podman-5.4.0\usr\bin;%PATH%

where podman | find "%BASE%" > NUL 2> NUL || (
  echo Failed to find Podman
  exit /b 1
  )

podman machine init
podman machine start

popd || exit /b 1 :: leave %BASE%\deps dir
endlocal

popd || exit /b 1 :: leave %BASE% dir

set PATH=%BASE%\deps\podman-5.4.0\usr\bin;%BASE%\scripts;%PATH%

