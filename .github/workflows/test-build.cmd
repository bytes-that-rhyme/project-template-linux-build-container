call scripts\setup.cmd || exit /b 1
call build || exit /b 1
mkdir src
echo success>src\test.txt
call sh < .github\workflows\input.txt || exit /b 1
