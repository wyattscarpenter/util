REM Rip playlist from youtube like a sane person might, with sensible defaults instead of garbage ones.
REM Takes one url as an argument; you have to quote it (batch eats ampersands).
REM If you like you can also insert your own flags to yt-dlp on the end.

yt-song -o "%%(autonumber)s %%(title)s %%(display_id)s (youtube rip).%%(ext)s" %*
