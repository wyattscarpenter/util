REM This script will tell you what processes on your machine are holding on to files or directories that match the argument you give this script. This can be very useful if a file refuses to delete because another process is using it.

REM IMPORTANT This next line turns local files enabled, which is somehow crucial to the functionality of this command yet not on by default. Usually, this line will be redundant, because you've already run this script before. But if you're new, this line is necessary, and also you will have to restart your computer before the rest of the script will work. Furthermore, you will have to run this line in a cmd window that is running as Administrator, such as with the usual right-clickery or runas /user:administrator "openfiles /local on" 

REM openfiles /local on

openfiles /query /fo table | find /I "%1"

if not errorlevel 0 echo Didn't work? See remarks above this in the script.