REM This batch script sets cmd autorun to use doskey to make // a macro for the REM (remark, ie comment) command. Note that it does this very poorly, because //foo doesn't work as a comment.

reg add "HKCU\Software\Microsoft\Command Processor" /v Autorun /d "doskey //=REM"