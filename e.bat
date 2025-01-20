@echo off
if "%*"=="" (
  explorer.exe .
) else (
  explorer.exe %*
)
