color 0a & title sorting files
set "year=%date:~6,4%"
set "month=%date:~3,2%"
if not exist %year% md %year%
:LOOP
	call :countfiles *
	if %errorlevel% EQU 1 exit
	call :getDirName dirName %month%
	echo %year%\%dirName%
	if not exist %year%\%dirName% md %year%\%dirName%

	robocopy "%~dp0." "%~dp0%year%\%dirName%" *.* /MOV /MAXAGE:%year%%month%01

	if %month% EQU 1 (
		set /a year-=1
		set /a month=12
	) else (
		set /a month-=1
	)
goto LOOP

:countfiles (String ext) {
	set /a return=0
	for %%F in (*.%~1) do set /a return+=1
	exit /b %return%
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