REM splits audio into 10-minute chunks to optimize for listening to long audio on the particular phone I had when I wrote this script. (For example, your playhead control might be very small, making scrubbing and seeking in larger file difficult.)
ffmpeg -i "%1" -f segment -segment_time 600 -c copy -vn -metadata album="" "%%03d %1"
