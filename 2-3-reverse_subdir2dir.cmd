for /F "tokens=1,2 delims=$MOVED_TO;" %%s in (changes.log) do (
    set "source=%%~s"
    set "target=%%~t"
    call :reverse
)
del changes.log
exit

:reverse

for /F "tokens=1* delims=\" %%E in ("%source%") do (
    set "dir=%%~E"
    set "fil=%%~nxF"
)

if not exist "%dir%" mkdir "%dir%"
MOVE /-Y "%target%" "%source%"
exit /B