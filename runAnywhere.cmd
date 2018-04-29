@echo off & title run Batch_Tools
set /P "dir=directory:  > "
set /P "run=batch-file: > "
set "run=%~dp0%run%"
if exist "%dir%" ( cd /D "%dir%" &cls ) else ( echo.%dir% does not exist &pause&exit )
%run%