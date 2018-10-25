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

set /a sign = +1

call :expand dividend
call :expand divisor

call :toNumber dividend      ||( echo script execution stopped due to an error & exit /B 1 )
call :toNumber divisor       ||( echo script execution stopped due to an error & exit /B 1 )
call :toNumber decimalPlaces ||( echo script execution stopped due to an error & exit /B 1 )

call :toPositive dividend sign
call :toPositive divisor  sign
call :toPositive decimalPlaces

call :division
echo %result%
exit /B 0

:expand
	set "%~1=!%~1:RANDOM=%random%!"
	set "%~1=!%~1:MAX=2147483647!"
	set "%~1=!%~1:PI=3!"&rem 3.141592654
	set "%~1=!%~1:E=3!" &rem 2.718281828
exit /B

:toNumber <Var>
    setlocal enableDelayedExpansion
        call :getNumber "!%~1!" "_return" || exit /B 1
    endlocal & set "%~1=%_return%"
exit /B 0


:checkNumber <String>
    setlocal enableDelayedExpansion
        set "_number=%~1"
        set "_number=%_number: =%"
        cmd /c "exit /B %_number%" && if not "%_number:0=%"=="" (
            set /a "_number=%_number%"
            if !_number! NEQ 0 exit /B 1
            exit /B 2
        )
    endlocal
exit /B 0


:getNumber <String> <return-var>
    setlocal
        set "_number=%~1"
        set "_number=%_number: =%"  
        call :checkNumber %1
        if errorlevel 2 endlocal&call :error NaN "%~1" getNumber&set "%~2=NaN"&exit /B 1
        if errorlevel 1 set /a "_number=%_number%"
        cmd /c "exit /B %_number%"
    endlocal&set "%~2=%errorlevel%"
exit /B 0

:error
	echo ERROR_%~1 at %~3:
	echo "%~2" is not a number.
	set /a errorlevel_%~1 += 1
exit /B 1


:toPositive
	if "!%~1:~0,1!"=="-" ( 
		if not "%~2"=="" set /a %~2 *= -1 
		set "%~1=!%~1:~1!"
	)
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
	echo No arguments provided.
	echo more information: divide/?
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
        echo Integer has to be a number or, when surrounded with brackets, an 
        echo arithmetic expression. Integer can contain following variables:
	echo RANDOM ^| expands to a random integer
	echo MAX    ^| expands to the integer max value
	echo PI     ^| expands to the value of pi
	echo E      ^| expands to the value of e
	echo (PI and E are both 3 because floats in input are not supported yet)
	echo.
        echo Examples:
        echo divide random/32768     ^| gives you a random number between 0 and 1
        echo divide (RANDOM*6)/32768 ^| gives you a random number between 0 and 6
        echo divide (8-1)/10         ^| calculates 8-1 first, then divides with 10
        echo.
        echo Note: the arithmetic expression can not be zero.
exit /b

:checkName
	if /i not "%~n0"=="DIVIDE" copy "%~nx0" "divide%~x0" >nul
exit /B