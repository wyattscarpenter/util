REM This batch script sets cmd autorun to use doskey to make // a macro for the REM (remark, ie comment) command. Note that it does this very poorly, because //foo doesn't work as a comment.

reg add "HKCU\Software\Microsoft\Command Processor" /v Autorun /d "doskey //=REM && doskey #=REM"

REM Alias REM and // to be comments in powershell (perhaps we could call this a pseudo-comment). I don't think side-effects in the commented expressions evaluate, which is nice. Also note that // must be followed by a space. The comment-ness will be terminated by ;, &&, etc, unfortunately.
powershell "echo 'Function // { }' >> $profile"
powershell "echo 'Function REM { }' >> $profile"
