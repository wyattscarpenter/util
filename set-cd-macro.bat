REM This batch script sets cmd autorun to use doskey to make .. a macro for cd ..

reg add "HKCU\Software\Microsoft\Command Processor" /v Autorun /d "doskey ..=cd.."
