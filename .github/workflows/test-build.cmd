echo build | call shell.cmd || exit /b 1
call shell.cmd < .github\workflows\input.txt || exit /b 1
