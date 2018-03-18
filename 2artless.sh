#a bash script to make the flac gooder
#removes embedded album art
#and is bit exact
for i in *.flac ; do
    ffmpeg.exe -i "$i" -acodec copy -fflags +bitexact -vn "$(basename "${i/.flac}")..flac"
done
for i in *.mp3 ; do
    ffmpeg.exe -i "$i" -acodec copy -fflags +bitexact -vn "$(basename "${i/.mp3}")..mp3"
done
for i in *.m4a ; do
    ffmpeg.exe -i "$i" -acodec copy -fflags +bitexact -vn "$(basename "${i/.m4a}")..m4a"
done
rename -f "s/\.\././" *