<#
.SYNOPSIS
extracts icons
.DESCRIPTION
extract-icon extracts the icon images from files and saves them in the same directory. This works for file with embedded icons and also files with merely associated icons. The images will always be saved with the file extension "png", though perhaps this may sometimes be incorrect.
.PARAMETER name(s)
File names of the .exe files.
.EXAMPLE
extract-icon c:\exelocation\example.exe
.EXAMPLE
extract-icon c:\exelocation\example.exe c:\exelocation\wowyoucandomultipleexes.exe .\localpathsworktoo\foo.exe
#>
foreach ($arg in $args) {
    Write-Host "$arg.png";
    [System.Drawing.Icon]::ExtractAssociatedIcon($arg).ToBitmap().Save("$arg.png")
}