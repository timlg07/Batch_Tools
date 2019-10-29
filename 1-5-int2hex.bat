@echo off
:main
    set "result="
    set /p "num_0=Dezimalzahl: >"

    call :deleteLeadingZero %num_0%
    set /a num_0  = %errorlevel%
    set /a number = %num_0%

    :do_while
        set /a n = number %% 16
        set /a number /= 16
        if %n% equ 10 set n=A
        if %n% equ 11 set n=B
        if %n% equ 12 set n=C
        if %n% equ 13 set n=D
        if %n% equ 14 set n=E
        if %n% equ 15 set n=F
        set "result=%n%%result%"
    if %number% NEQ 0 goto do_while


    echo %num_0% in hexadezimal: %result% &echo+
goto main

:deleteLeadingZero
exit /B %~1
