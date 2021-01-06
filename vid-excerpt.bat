SET outfile=%4
IF "%outfile%"=="" (SET outfile=crop.%1)
ffmpeg  -i "%1" -ss "%2" -to "%3" -c copy %outfile%
