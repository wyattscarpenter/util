#a bash script to make the flac gooder
#removes embedded album art
#re-encodes to the highest-compression subset flac
#and is bit exact
for i in *.flac ; do
    ffmpeg.exe -i "$i" -compression_level 8 -fflags +bitexact -vn "$(basename "${i/.flac}")..flac"
done