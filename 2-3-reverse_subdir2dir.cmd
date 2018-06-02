color 0a & title reversing subdir 2 dir
for /F "delims=" %%l in (changes.log) do (
    call :reverse "%%l"
)
del changes.log
exit


:reverse
    set "line=%~1"
    set "source=%line:$MOVED_TO;=" & set "target=%"

    for /F "tokens=1 delims=\" %%D in (%source%) do (
        if not exist %%D mkdir %%D
    )
    MOVE /-Y %target% %source%
exit /B