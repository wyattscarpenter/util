#/bin/bash
#CR: CR REPLACE
#applies regexes... the way I think it should be done
#apologies:
#deletes all CR (0x0D) characters from the file
# this is inelegant, and the script is named cr to remind you of this limitation
#also, you have to use \r instead of \n in your regexes
#also typing cr \r foo won't work, because the \ will escape in bash
# and therefore be a regular r by the time it gets to the program
#arguments:
#$1 is what is to be found
#$2 is what to replace $1 with
#$3 is the file on which to perform the operation
#outputs the modified file contents to stdout, you might want to pipe to sponge
cat "$3" | tr -d '\r' | tr '\n' '\r' | sed "s/$1/$2/g" | tr '\r' '\n'
