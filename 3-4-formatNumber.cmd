@echo off
:: //====// INIT MAKROS //====// ::
set "DelayedExpansion{=(setlocal enableDelayedExpansion&for /F "tokens=1* delims==" %%V in ('set @') do set "%%V=")>nul 2>&1"
set "{=(setlocal&for /F "tokens=1* delims==" %%V in ('set @') do set "%%V=")>nul 2>&1"
set "}=(for /F "tokens=1* delims==" %%V in ('set $^&set @') do endlocal&set "%%V=%%W")>nul 2>&1&exit/B "
:: //=========================// ::

call :formatNumberLength  2 10 "."
echo %@return%
call :formatNumberLength 34 10 "."
echo %@return%
call :formatNumberLength 987 10 "."
echo %@return%
pause&exit

:formatNumberLength <Number> <length> [<filler>="0"]
%DelayedExpansion{%
    set "@return=%~1"
    set "_f=0"
    if not "%~3"=="" set "_f=%~3"
    for /L %%i in (2,1,%~2) do (
        set "@return=%_f%!@return!"
    )
    set "@return=!@return:~-%~2!"
%}%
