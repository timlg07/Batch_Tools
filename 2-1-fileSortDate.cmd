color 0a & title sorting files
set  "year=%date:~6,4%"
set "month=%date:~3,2%"
set xfiles="%~nx0" "2-2-subdir2dir.cmd" "2-3-reverse_subdir2dir.cmd" "delMoff.cmd" "changes.log"
if not exist %year% md %year%
:LOOP
	call :isEmpty
	if %errorlevel% EQU 1 exit
	call :getDirName dirName %month%
	echo %year%\%dirName%
	if not exist %year%\%dirName% md %year%\%dirName%

	robocopy "%~dp0." "%~dp0%year%\%dirName%" *.* /MOV /MAXAGE:%year%%month%01 /XF %xfiles%

	dir /a-d /s "%year%\%dirName%\*" || rmdir %year%\%dirName%

	if %month% LEQ 1 (
		set /a year-=1
		set /a month=12
	) else (
		set /a month-=1
	)
	call :format month
goto LOOP

:isEmpty () {
	for %%F in (*) do (
		echo/%xfiles%|findstr /c:"%%~nxF">nul||exit/b 0
	)
	exit /b 1
}

:getDirName (String returnVar, int month) {
	set "map=01-January;02-February;03-March;04-April;05-Mai;06-June;07-July;08-August;09-September;10-October;11-November;12-December;"
	call set monthName=%%map:*%~2-=%%
	set right=%monthName:*;=%
	call set monthName=%%monthName:%right%=%%
	set %~1=%~2_%monthName%
	call set %~1=%%%~1:;=%%
	exit /B
}

:format (String varName) {
	setlocal enableDelayedExpansion
	set "newVal=!%~1!"
	endlocal & if "%newVal:~1%"=="" set "%~1=0%newVal%"
	exit /B 0
}