@echo off & setlocal enableDelayedExpansion & title BUBBLESORT 

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
