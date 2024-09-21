REM this script must be run as admin (or whatever, however windows permissions work)
REM see disable_touchscreen.bat for more info on how to find this device ID.
pnputil /enable-device "HID\VID_03EB&PID_8A92&MI_01\7&17e068b7&0&0000"
