@echo off
:main
    set "result="
    set /p "num_0=Dezimalzahl: >"

    call :deleteLeadingZero %num_0%
    set /a num_0  = %errorlevel%
    set /a number = %num_0%

    :do_while
        set /a number = %number% /  2
        set /a binary = %number% %% 2
        set   "result=%binary%%result%"
    if %number% NEQ 0 goto do_while

    echo %num_0% in binaer: %result% &echo+
goto main

:deleteLeadingZero
exit /B %~1
