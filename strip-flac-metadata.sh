#a bash script to make the flac gooder
#removes embedded album art
#and is bit exact
for i in *.flac ; do
    ffmpeg.exe -i "$i" -acodec copy -fflags +bitexact -vn -map_metadata -1 "$(basename "${i/.flac}")..flac"
done
rename -f "s/\.\././" *