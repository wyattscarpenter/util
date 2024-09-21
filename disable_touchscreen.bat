REM this script must be run as admin (or whatever, however windows permissions work). I usually call it from the windows menu, so crtl+shift+enter there will launch with the required permissions. You can also right-click, run as administrator on the file.
pnputil /disable-device "HID\VID_03EB&PID_8A92&MI_01\7&17e068b7&0&0000"
REM If that doesn't work, your touchscreen might have a different ID than mine.
REM I found mine using pnputil /enum-devices | wsl grep "touch" --context 5

REM findstr would work in place of grep but there doesn't seem to be a way to get context in findstr, so instead do pnputil /enum-devices | findstr HID
REM and take the ID from the "Instance ID: " line right above the "Device Description:         HID-compliant touch screen" line.
REM If your touchscreen isn't HID-compliant, I guess can't help you. Look around your device manager and figure it out yourself.

REM You can also use, in PowerShell, pnputil /enum-devices | select-string touch -Context 5
