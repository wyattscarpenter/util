REM rip playlist from youtube like a sane person might
REM with sensible defaults instead of garbage ones
REM takes one url as an argument, you have to quote it (batch eats ampersands)
REM but if you like you can also insert your own modifcations on the end since the arguments are unquoted

yt-song -o "%%(autonumber)s %%(title)s %%(display_id)s (youtube rip).%%(ext)s" %*
