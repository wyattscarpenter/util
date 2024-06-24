REM this command lets you trigger a repl to issue powershell commands from within the cmd command line, which is faster than booting up the powershell command line (is it?), although it usually still takes a minute to execute the command the first time you use it.
:begin
set /p command="POWERSCHNELL REPL: type a command, or q to quit> "
if "%command%"=="q" goto :end
powershell -command %command%
if not "%command%"=="q" goto :begin
:end
