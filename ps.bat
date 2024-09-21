REM this command lets you issue powershell command from the cmd command line; essentially it's an alias for `powershell`. If you input commands powershell will execute them and return control to you, like powershell -command; otherwise the powershell interactive session will begin. This is just literally how `powershell` works; I don't know why I'm documenting this as well.
powershell %*
