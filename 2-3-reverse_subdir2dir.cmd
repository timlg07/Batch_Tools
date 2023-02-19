color 0a & title reversing subdir 2 dir & set errors=0
for /F "tokens=*"  %%l in (changes.log) do (
    call :reverse "%%l"
)
if %errors% EQU 0 (del changes.log) else (ECHO.ERROR&pause>nul)
exit


:reverse
    set "line=%~1"
    set "source=%line:$MOVED_TO;="&set "target=%"

    for /F "tokens=*" %%D in (%source%) do (
        if not exist "%%~dpD" mkdir "%%~dpD"
    )
    MOVE /-Y %target% %source% || set /a errors+=1
exit /B