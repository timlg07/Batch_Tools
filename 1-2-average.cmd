@echo off & setlocal enableDelayedExpansion
title Durchschnitt Berechnen

::CONFIG::
set /a decimalPlaces=6

::MESSAGE1::
echo.
echo   Zahl eingeben und mit [enter] bestaetigen.
echo   Haben sie alle Zahlen eingegeben, erneut
echo   mit [enter] bestaetigen
echo.  

::INPUT::
set /a i=0
:input_while
	set "input=f"
	set /a "ip1=i+1"
	set /p "input=(%ip1%) > "
	if  /i "%input%"=="F" set /a i-=1 & goto calc
	call :isNumber "%input%"
	if %errorlevel% EQU 1 (
		call :deleteLeadingZero "%input%"
		set /a input=!errorlevel!
		set /a numbers[%i%]=input
	) else (
		call :onInputError "%input%" "input_while"
	)
	set /a i+=1
goto input_while

::CALCULATION::
:calc
	set /a length=i+1
	set /a sum=0
	for /L %%i in (0,1,%i%) do (
		set /a sum+=numbers[%%i]
	)

	call :divide "%sum%" "%length%" "%decimalPlaces%" "average"

	if %errorlevel% EQU 0 ( set "equSign==" ) else ( set "equSign=~" )
	
	echo.
	echo.   Durchschnitt %equSign% %average%
	echo.
	echo.   [Erneut ausfuehren]
pause >nul & cls & %0

::FUNCTIONS::
:divide
		set /a int=%~1/%~2
		set "result=%int%,"
		set /a remainder=%~1-(int*%~2)
		set /a decP=0
	:div_LOOP
		set /a intR=(remainder*10)/%~2
		set /a remainder=(remainder*10)-(intR*%~2)
		set result=%result%%intR%
		set /a decP+=1
		set "%~4=%result%"
		if %remainder% EQU 0 exit /b 0
		if %decP% GEQ %~3 exit /b 1
	goto div_LOOP
exit


::OTHER::FUNCTIONS::

:isNumber
	set   "string=%~1"
	call :trim string
	set /a number=string
	if %number% EQU 0 if not "%number%"=="%string%" exit /B -1
exit /B 1

:trim
	set "%~1=!%~1: =!"
exit /B

:onInputError
	set value="%~1"
	set "callback=:%~2"
	echo %value% ist keine gueltige Eingabe.
goto %callback%


:deleteLeadingZero
exit /B %~1