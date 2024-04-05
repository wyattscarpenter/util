# this command MUST be run in from the directory that contains your client_secrets.json, and probably your request.token
# if you don't have such files, follow the instructions on https://github.com/porjo/youtubeuploader
youtube-dl  "%*" -o - | youtubeuploader -filename -