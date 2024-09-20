REM this command lets you trigger a repl to issue powershell commands from within the cmd command line, which is faster than booting up the powershell command line (is it?), although it usually still takes a minute to execute the command the first time you use it.
REM this script seems obsolete to me because I'm not sure it actually works any faster than powershell itself (it "boots" faster, but then powershell takes a while on the first command, so it may be the same in the end). Powershell itself is fast enough again to me now that I've upgraded to an SSD. Furthermore, this script probably has unintuitive quoting behavior, although I've never tested that. But, this script is not 100% trivial (only about 90%) so I'm not outright deleting it.
:begin
set /p command="POWERSCHNELL REPL: type a command, or q to quit> "
if "%command%"=="q" goto :end
powershell -command %command%
if not "%command%"=="q" goto :begin
:end
