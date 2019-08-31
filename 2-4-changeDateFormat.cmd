for /D %%F in ("%~dp0*") do echo."%%~nxF"|find "." && for /F "tokens=1-3 delims=." %%d in ("%%~nxF") do (
	attrib +s "%%~fF"
	:: this is needed for rewriting all desktop.ini's after you made changes to this script
	:: attrib -s -h "%%~fF\desktop.ini"
	echo.[.ShellClassInfo]>"%%~fF\desktop.ini"
	echo.LocalizedResourceName=%%f-%%e-%%d>>"%%~fF\desktop.ini"
	echo.InfoTip=Dies sind alle Bilder, die am %%d.%%e.%%f aufgenommen wurden.>>"%%~fF\desktop.ini"
	attrib +s +h "%%~fF\desktop.ini"
)