REM this batch script is designed to be placed on the desktop so image files can easily be dropped into it and then the ocred text copied out
tesseract %1 stdout --psm 1 --dpi 150
pause
