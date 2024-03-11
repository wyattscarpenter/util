REM This is my script to force good defaults running mpv.
REM I'm not sure if sid=1 is always a good idea, or if maybe sid=auto just failed on my test file because its subtitles are  "English [SDH]".
mpv.exe --profile=fast --sid=1 %*
