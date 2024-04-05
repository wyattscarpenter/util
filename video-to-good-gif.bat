REM someone else wrote this command and I could not tell you precisely what it does
ffmpeg -i %1 -vf "split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" %1.gif
