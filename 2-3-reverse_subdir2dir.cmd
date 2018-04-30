color 0a & title reversing subdir 2 dir
for /F "tokens=1,2 delims=$MOVED_TO;" %%s in (changes.log) do (
    set "source=%%~s"
    set "target=%%~t"
    call :reverse
)
del changes.log
exit


:reverse
for /F "tokens=1 delims=\" %%D in ("%source%") do (
    if not exist "%%D" mkdir "%%D"
)
MOVE /-Y "%target%" "%source%"
exit /B