REM A simple alias for yt-dlp (or youtube-dl or any other project carrying the mantle — opaquely to the caller).
REM Things got complicated enough with cookies and js runtimes and "AI upscaling" and embedding metadata that I've just specified those here.

yt-dlp --cookies-from-browser firefox --js-runtime node --remote-components ejs:github -f "bv*[format_note!*=?AI-upscaled]+ba[format_note!*=?AI-upscaled]" --embed-subs --embed-thumbnail --embed-metadata --xattrs %*
