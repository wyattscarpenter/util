REM For some reason, the windows c compile, cl, is troublesome to run by itself
REM so we invoke this batch script that puts all the correct tools into scope
REM and then invoke the actual cl.
REM This script named cl is hidden by the actual cl after a single invocation,
REM so subsequent invocations of cl simply refer to the real cl.
REM This script is super path-dependent.
REM You can get the VS build tools from https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/?sku=BuildTools
"C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars64.bat" & cl %*