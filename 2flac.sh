for i in *.aif ; do
    ffmpeg.exe -i "$i" -compression_level 8 -fflags +bitexact -vn "$(basename "${i/.aif}").flac"
done

for i in *.aiff ; do
    ffmpeg.exe -i "$i" -compression_level 8 -fflags +bitexact -vn "$(basename "${i/.aiff}").flac"
done

for i in *.wav ; do
    ffmpeg.exe -i "$i" -compression_level 8 -fflags +bitexact -vn "$(basename "${i/.wav}").flac"
done