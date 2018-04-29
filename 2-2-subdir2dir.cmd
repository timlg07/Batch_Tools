for /D %%D in (*) do call :FOR_DIR "%%~D"
exit

:FOR_DIR
set "dirName=%~1"

for    %%F in ("%~1\*") do call :FOR_FILE "%%~F"
for /D %%D in ("%~1\*") do call :FOR_DIR2 "%%~nD"

rmdir %1
exit /B

:FOR_FILE
call :createUniqueName %1 newName
MOVE /-Y "%~f1" "%~dp0%newName%%~x1"

::Zeile zum Anfang der changes.log hinzufuegen
copy changes.log _changes.log
echo "%dirName%\%~nx1"$MOVED_TO;"%newName%%~x1">changes.log
copy /B changes.log + _changes.log changes.log
del _changes.log

exit /B

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
MOVE /-Y "%dirName%\%~1" "%~dp0%newName%"

::Zeile zum Anfang der changes.log hinzufuegen
copy changes.log _changes.log
echo "%dirName%\%~1"$MOVED_TO;"%newName%">changes.log
copy /B changes.log + _changes.log changes.log
del _changes.log

exit /B

:createUniqueFolderName
set "%~2=%~1"
if not exist "%~n1" exit /B 0
set /a i=0
:_createUniqueFolderName
set /a i+=1
if exist "%~1 (%i%)" goto _createUniqueFolderName
set "%~2=%~1 (%i%)"
exit /b %i%