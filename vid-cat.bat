(for %%i in (*.*) do @echo file '%%i') > vidlist.tmp
ffmpeg -safe 0 -f concat -i vidlist.tmp -c copy out.mkv

REM del vidlist.tmp
