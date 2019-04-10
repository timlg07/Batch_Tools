@echo off & setlocal enableDelayedExpansion
goto main
:: BOGOSORT-DEMO [by Tim Greller]


:bogosort Array<int>
	call :isSorted "%~1" && exit /B 0
	call :randomElement n_0 "%~1"
	call :randomElement n_1 "%~1"
	
	set "tmp=!%~1[%n_0%]!"
	set "%~1[%n_0%]=!%~1[%n_1%]!"
	set "%~1[%n_1%]=%tmp%"

	cls
	echo:swapped(%n_0%;%n_1%)
	call:print list

	set /a swaps+=1
goto bogosort


:isSorted Array<int>
	set _last=-Infinity
	for /L %%i in (0 1 !%~1.lastIndex!) do (
		if not "!_last!"=="-Infinity" (
			if not "!_last!" LEQ "!%~1[%%i]!" (
				exit /B 1
			)
		)
		set "_last=!%~1[%%i]!"
	)
exit /B 0

:randomElement var Array
	set /a "%~1 = !%~2.length! * %random% / 32768"
exit /B !%~1!


:print Array<>
	for /L %%i in (0 1 !%~1.lastIndex!) do echo:%~1[%%i] = !%~1[%%i]!
exit /B

:main
	set /a "list.length=5"
	set /a "list.lastIndex=list.length-1"
	for /L %%i in (0 1 %list.lastIndex%) do set "list[%%i]=!random:~0,2!"
	set /a "swaps=0"

	call:print list
	echo:Press a key to start&pause>nul
	call:bogosort list
	echo:Wow. BogoSort did it^^! Only %swaps% swaps
	pause
exit