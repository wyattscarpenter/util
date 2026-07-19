# This script is untested. The first argument is the file name. The second argument must be given as a string of hex digits (no prefix like 0x), although apparently case doesn't matter.
(Get-FileHash -Algorithm "SHA256" $args[0]).Hash -eq $args[1]
