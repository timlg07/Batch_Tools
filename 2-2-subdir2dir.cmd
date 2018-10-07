color 0a & title subdir 2 dir
	for /D %%D in (%cd%\*) do call :FOR_DIR "%%~D"
exit

:FOR_DIR
	set "dirName=%~1"

	:: TODO :: replace with dir
	:: (https://superuser.com/questions/475881/for-command-cannot-see-hidden-files)
	for /f "usebackq tokens=* delims=" %%F in (`dir "%~1\*" /b/a-d`) do call :FOR_FILE "%%~fF"
dir "%~1\*" /b/a-d&pause
	for /f "usebackq tokens=* delims=" %%D in (`dir "%~1\*" /b/ad `) do call :FOR_DIR2 "%%~fD"
dir "%~1\*" /b/ad&pause
	rmdir %1
exit /B

:FOR_FILE
	call :createUniqueName %1 newName
	MOVE /-Y "%~f1" "%cd%\%newName%%~x1" || (
            echo.MOVE "%~f1" "%cd%\%newName%%~x1" -- %errorlevel% > error.txt
            exit /B %errorlevel%
        )
	
	::Zeile zum Anfang der changes.log hinzufuegen
	copy changes.log _changes.log
	echo "%dirName%\%~nx1"$MOVED_TO;"%newName%%~x1">changes.log
	copy /B changes.log + _changes.log changes.log
	del _changes.log
exit /B 0

:createUniqueName
	set "%~2=%~n1"
	if not exist "%~nx1" exit /B 0
	set /a i=0
	:_createUniqueName
		set /a i+=1
	if exist "%~n1 (%i%)%~x1" goto _createUniqueName
	set "%~2=%~n1 (%i%)"
exit /b %i%


:FOR_DIR2
	call :createUniqueFolderName %1 newName

	MOVE /-Y "%dirName%\%~nx1" "%cd%\%newName%" || (
            echo.MOVE "%dirName%\%~nx1" "%cd%\%newName%" -- %errorlevel% > error.txt
            exit /B %errorlevel%
        )
	::robocopy "%cd%\%dirName%\%~nx1" "%cd%\%newName%" /MOVE 

	::Zeile zum Anfang der changes.log hinzufuegen
	copy changes.log _changes.log
	echo "%dirName%\%~nx1"$MOVED_TO;"%newName%">changes.log
	copy /B changes.log + _changes.log changes.log
	del _changes.log

exit /B 0

:createUniqueFolderName
	set "%~2=%~nx1"
	if not exist "%~nx1" exit /B 0
	set /a i=0
	:_createUniqueFolderName
		set /a i+=1
	if exist "%~nx1 (%i%)" goto _createUniqueFolderName
	set "%~2=%~1 (%i%)"
exit /b %i%
