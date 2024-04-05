SET outfile=%1
IF "%outfile%"=="" (SET outfile=out.mkv)
(for %%i in (*.*) do @echo file '%%i') > vidlist.tmp.txt
ffmpeg -safe 0 -f concat -i vidlist.tmp.txt -c copy %outfile%
del vidlist.tmp.txt
