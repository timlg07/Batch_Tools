@echo off & setlocal enableDelayedExpansion & title BUBBLESORT & goto main 
:: BUBBLESORT-DEMO [by Tim Greller]


:bubblesort Array<Number>
	set /a "%~1.length_m_1=!%~1.length!-1"
	for /L %%C in (0,1,!%~1.length!) do (
		for /L %%i in (0,1,!%~1.length_m_1!) do (
			call :_bubblesort "%~1" %%i
		)
	)
exit /B

:_bubblesort
	set /a "i_p_1=%2+1"
	if !%~1[%2]! GTR !%~1[%i_p_1%]! (
		set "temp=!%~1[%2]!"
		set "%~1[%2]=!%~1[%i_p_1%]!"
		set "%~1[%i_p_1%]=!temp!"
	)
exit /B



:print Array<>
	for /L %%i in (0 1 !%~1.length!) do echo:%~1[%%i] = !%~1[%%i]!
exit /B



:main
	set "list.length=8"
	for /L %%i in (0 1 %list.length%) do set "list[%%i]=!random:~0,2!"

	call:print list
	echo:__________
	echo:
	echo:SORTING...
	echo:__________
	call:bubblesort list
	call:print list

	pause:nul
exit