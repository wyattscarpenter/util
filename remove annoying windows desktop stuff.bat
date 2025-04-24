REM This bat file removes the annoying auto-created files from the Windows 10 desktop. It does not delete anything that I think you need, even if that thing you need is still clutter. However, this is still based on my personal judgement that you don't need stuff like .lesshst
REM I keep this file here, but put a shortcut to it on my desktop, so I can just click that.
REM TODO: I think the "right" way to do this would be to delete the files I know about, and then rmdir the folders, so that if there are other files in here then they don't get accidentally deleted. Just in case. This would also let me add Videos/ to this list, which occasionally has video captures in it but is normally just annoyingly emptily created.
wsl rf Music .lesshst .matplotlib .streamlit Searches Favorites
REM so, things should be done like this:
del "%USERPROFILE%/.python_history"
pause
