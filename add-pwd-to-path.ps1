# I haven't yet actually run this program to check if it works, for various reasons. I don't really know if this will persist between sessions, etc. Although I think it will. Ideally this would also work for cmd... so maybe I have to mess with some kind of .profile file for Windows? We'll see.
$env:path = $env:path + ';' + $pwd
[Environment]::SetEnvironmentVariable("Path", $env:Path, [System.EnvironmentVariableTarget]::Machine)
