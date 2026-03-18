REM A simple alias for yt-dlp (or youtube-dl or any other project carrying the mantle — opqauely to the caller).
REM Things got complicated enough with cookies and js runtimes that I've just specified those here.

yt-dlp --cookies-from-browser firefox --js-runtime node --remote-components ejs:github %*
