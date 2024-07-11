@echo off
REM This script allows you to run git from windows through WSL if you have it installed in WSL but not on Windows. 95% of the time this works great, but it's bad practice because it will cause any tool that invokes git with an absolute path (C:\... on Windows, which obviously means nothing to the git that lives on WSL) to fail... which turns out to be quite a few of them.
wsl git %*
