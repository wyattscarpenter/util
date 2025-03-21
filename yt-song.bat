REM I use this script to download songs from youtube (many obscure ones aren't offered anywhere else!).
REM If you like you can also insert your own flags to yt-dlp on the end.

yt-dlp --embed-thumbnail --add-metadata -f m4a %*
