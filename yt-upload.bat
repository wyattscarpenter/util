REM this command MUST be run in from the directory that contains your client_secrets.json, and probably your request.token
REM if you don't have such files, follow the instructions on https://github.com/porjo/youtubeuploader
yt-dlp %* -o - | youtubeuploader -filename -
