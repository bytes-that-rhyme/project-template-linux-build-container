call scripts\setup.cmd
call build
call sh < .github\workflows\input.txt || exit /b 1
