@echo off
REM This command shows you the text of a command that is on your path.
REM Please excuse the crazy hacks batch makes one do to use output as a parameter later...
for /F "usebackq delims=" %%N in (`where %1`) do type %%N
