color 0a & title sorting files
set "year=%date:~6,4%"
set "month=%date:~3,2%"
if not exist %year% md %year%
:LOOP
	call :isEmpty
	if %errorlevel% EQU 1 exit
	call :getDirName dirName %month%
	echo %year%\%dirName%
	if not exist %year%\%dirName% md %year%\%dirName%

	robocopy "%~dp0." "%~dp0%year%\%dirName%" *.* /MOV /MAXAGE:%year%%month%01 /XF "%~nx0"

	dir /a-d /s "%year%\%dirName%\*" || rmdir %year%\%dirName%

	if %month% EQU 1 (
		set /a year-=1
		set /a month=12
	) else (
		set /a month-=1
	)
	call :format month
goto LOOP

:isEmpty () {
	setlocal enableDelayedExpansion
	for %%F in (*) do (
		set /a i+=1
		if !i! GTR 1 endlocal & exit /b 0
	)
	endlocal & exit /b 1
}

:getDirName (String returnVar, int month) {
	set "map=01-January;02-February;03-March;04-April;05-Mai;06-June;07-July;08-August;09-September;10-October;11-November;12-December;"
	call set monthName=%%map:*%~2-=%%
	set right=%monthName:*;=%
	call set monthName=%%monthName:%right%=%%
	set %~1=%~2_%monthName%
	set %~1=%dirName:;=%
	exit /B
}

:format (String varName) {
	setlocal enableDelayedExpansion
	set "length=0"
    	set "_s=!%~1!#"
    	for %%i in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
      		if "!_s:~%%i,1!" NEQ "" ( 
       	     		set /a "length+=%%i"
       	     		set "_s=!_s:~%%i!"
       	 	)
   	)
	set "alternVal=0!%~1!"
	endlocal & if %length% LSS 2 set "%~1=%alternVal%"
	exit /B
}