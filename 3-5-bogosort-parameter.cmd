@echo off & setlocal enableDelayedExpansion
if "%~1"=="" echo.Bitte die zu sortierenden Integer als Parameter uebergeben.&exit /B 1
goto main

:bogosort Array<int>
	call :isSorted "%~1" && exit /B 0
	call :randomElement n_0 "%~1"
	call :randomElement n_1 "%~1"
	
	set "tmp=!%~1[%n_0%]!"
	set "%~1[%n_0%]=!%~1[%n_1%]!"
	set "%~1[%n_1%]=%tmp%"
goto bogosort


:isSorted Array<int>
	set _last=-Infinity
	for /L %%i in (0 1 !%~1.lastIndex!) do (
		if not "!_last!"=="-Infinity" (
			REM zur Uenterstuetzung anderer Datentypen muss dieser Vergleich angepasst werden:
			if not !_last! LEQ !%~1[%%i]! (
				exit /B 1
			)
		)
		set "_last=!%~1[%%i]!"
	)
exit /B 0

:randomElement var Array<>
	set /a "%~1 = !%~2.length! * %random% / 32768"
exit /B !%~1!


:print Array<>
	for /L %%i in (0 1 !%~1.lastIndex!) do echo+|set /p "=!%~1[%%i]! "
exit /B

:main
	set /a "list.length=0"

	:saveArgs
		set "list[%list.length%]=%~1"
		set /a "list.length+=1"
		shift
	if not "%~1"=="" goto saveArgs
	
	set /a "list.lastIndex=list.length-1"

	call:bogosort list
	call:print    list
exit /B 0