@echo off & setlocal enableDelayedExpansion
if "%1"=="" goto noArgs

echo.%* | find /I "/?" >nul && goto info
echo.%* | find /I "/HELP" >nul && goto info

for /F "tokens=1* delims=/" %%A in ("%~1") do (
	set "dividend=%%A"
	set "divisor=%%B"
)

if not defined dividend set dividend=NAN
if not defined divisor  set  divisor=NAN

if not "%~2"=="" ( set "decimalPlaces=%~2"    ) else ( set "decimalPlaces=6"    )
if not "%~3"=="" ( set "decimalSeperator=%~3" ) else ( set "decimalSeperator=." )


call :expand dividend
call :expand divisor

call :checkNumber dividend
call :checkNumber divisor
call :checkNumber decimalPlaces


call :division
echo %result%
exit /B

:expand
	set "%~1=!%~1:RANDOM=%random%!"
	set "%~1=!%~1:MAX=2147483647!"
	set "%~1=!%~1:PI=3!"&rem 3.141592654
	set "%~1=!%~1:E=3!" &rem 2.718281828
exit /B

:checkNumber
	call :trim "%~1"

	set "varName=%~1"
	set "varCont=!%~1!"
	set /a varContNumber=varCont

	if %varContNumber% EQU 0 (
		if not "%varCont:0=%"=="" (
			call :error NAN %varName% checkNumber
			set /a varCont=1
		)
	)
	call :deleteLeadingZero "%varCont%"
	set "%varName%=%errorlevel%"
exit /B

:trim
	set "%~1=!%~1: =!"
exit /B

:deleteLeadingZero
exit /B %~1

:error
	echo ERROR_%~1 at %~3:
	echo "!%~2!" is not a number.
exit /B


:division
	
	set /a int = dividend / divisor
	set "result=%int%%decimalSeperator%"
	set /a remainder = dividend - (int*divisor)
	set /a decP = 0
	:div_LOOP
		set /a intR      = (remainder*10) /       divisor
		set /a remainder = (remainder*10) - (intR*divisor)
		set result=%result%%intR%
		set /a decP += 1
		if %remainder% EQU 0 exit /b 0
		if %decP% GEQ %decimalPlaces% exit /b 1
	goto div_LOOP
exit /B

	
:noArgs
	echo Keine Argumente.
	echo weitere Infos: divide /?
goto checkName

:info
	echo.
	echo Syntax:
	echo.
	echo DIVIDE Integer/Integer [decimalPlaces [decimalSeperator]]
	echo.
	echo.
	echo Returns an float value with the given
	echo amount of decimal places. (Default:6)
	echo.
	echo The decimal seperator can be "." or "," 
	echo or any other character. (Default:".")
	echo.
	echo Following variables can be used:
	echo RANDOM ^| expands to a random integer
	echo MAX    ^| expands to the integer max value
	echo PI     ^| expands to the value of pi
	echo E      ^| expands to the value of e
	echo.
	echo (PI and E are both 3 because floats in input are not supported yet)
	echo.
exit /b

:checkName
	if /i not "%~n0"=="DIVIDE" copy "%~nx0" "divide%~x0" >nul
exit /B