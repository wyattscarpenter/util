REM This batch script sets cmd autorun to use doskey to make the character produced by crtl w () (represented on the command line as ^W or ↨ if echoed) into the name of a macro that expands to exit. Therefore, if you input ctrl+w into a cmd window expecting to kill the window, you can hit enter to make it so.
REM Why doskey? Ideally, we would make a batch script called .bat for this command. Unfortunately, the character produced by ctrl w is not a valid filename in windows, I guess, so it can't be the name of a batch script, and so we have to use doskey macros.
REM Why autorun? Doskey macro setup does not persist between sessions so we have to tell the computer to set it up each time.
REM (Note that I tried, instead of the autorun method, putting this batch script in shell:startup, and that did not work.)

reg add "HKCU\Software\Microsoft\Command Processor" /v Autorun /d "doskey  =exit"
