pushd %~dp0
call config.cmd
cd ..
if "%MACHINE_NAME%" equ "" (
  echo The MACHINE_NAME environment variable needs to be set.
  echo Make sure you ran setup.cmd, or you are using a command prompt launched
  echo from shell.cmd.
  echo.
  exit /b 1
  )
podman build container -t "%MACHINE_NAME%"
popd
