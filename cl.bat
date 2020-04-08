REM For some reason, the windows c compile, cl, is troublesome to run by itself
REM so we invoke this batch script that puts all the correct tools into scope
REM and then invoke the actual cl.
REM This script named cl is hidden by the actual cl after a single invocation,
REM so subsequent invocations of cl simply refer to the real cl.
"C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\Common7\Tools\VsDevCmd.bat" & cl %*