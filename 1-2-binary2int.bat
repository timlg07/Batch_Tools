@echo off
:main
    set /p "binary=Binaerzahl: > "
    set /a  mul = 1
    set /a  sum = 0
    set "bin=%binary%"

    :do_while
        set "cur=%bin:~-1,1%"
        set "bin=%bin:~0,-1%"

        if "%cur%"=="-" (
            set /a sum *= -1
        ) else (
            set /a sum += cur * mul
        )

        set /a mul *= 2
    if "%bin%" NEQ "" goto do_while

    echo.%binary% in dezimal: %sum% &echo+
goto main
