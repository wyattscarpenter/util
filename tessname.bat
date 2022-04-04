REM this script currently does NOT work well.
REM TODO: redo in python? just to escape terrible batch quoting (etc) land?

SETLOCAL ENABLEDELAYEDEXPANSION
SET v=
ECHO %v%
FOR /F "tokens=* USEBACKQ" %%F IN (`tesseract %1 stdout`) DO (SET v=!v! %%F)
REM now try to strip out some invalid filename characters
SET v=%v:?><=%
SET v=%v:=%
SET v=%v:|=I%
REM before I tried to get cocky with character sanitization, this script worked sometimes. So, instead of that...
REM we might have to ask the user to get input the cleaned string since cleaning is so hard
set /p v=!v!
MOVE %1 "%v%%~x1"
set /p="did it work?"