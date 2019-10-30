@echo off
:main
    set "result="
    set "negative=0"
    set /p "num_0=Dezimalzahl: >"

    call :deleteLeadingZero %num_0%
    set /a num_0  = %errorlevel%
    set /a number = %num_0%

    if %number% lss 0 (
        set "negative=1"
        set /a number *= -1
        set /a number -= 1
    )

    :do_while
        set /a binary = %number% %% 2
        set /a number = %number% /  2
        if %negative% equ 1 (
            if %binary% equ 0 (
                set /a binary = 1
            ) else (
                set /a binary = 0
            )
        )
        set "result=%binary%%result%"
    if %number% NEQ 0 goto do_while

set "result=%negative%%result%"


    echo %num_0% in binaer: %result% &echo+
goto main

:deleteLeadingZero
exit /B %~1
