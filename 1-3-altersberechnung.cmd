@echo off
set c_y=%date:~-4%
echo.Jahreszahl eingeben:
echo.(Fuer Jahre vor Christus negative Werte verwenden)
set /P y= ^> 
set /A r= c_y - y
echo.
echo.%r%
pause>nul