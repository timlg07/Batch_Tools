set "file=name.txt"
if not exist %file% echo. > %file%
copy "%file%" "_%file%"

::This line can be replaced by anything you want to add in the beginning of the file
echo sampleLine > %file%

copy /B "%file%" + "_%file%" "%file%"
del "_%file%"