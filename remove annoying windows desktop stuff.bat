REM This bat file removes the annoying auto-created files from the Windows 10 desktop. It does not delete anything that I think you need, even if that thing you need is still clutter. However, this is still based on my personal judgement that you don't need stuff like .lesshst. I keep this file in util, but put a shortcut to it on my desktop, so I can just click that. It should be run in administrator mode (TODO: a number of these still give "Access is denied." errors for apparently no reason). The "right" way to do this is to delete the files I know about, and then rmdir the folders, so that only known-bad files are and empty dirs deleted. Just in case. (TODO: I haven't been able to hone in on exactly the right things because I keep getting the Access denied errors.)
rmdir "%USERPROFILE%\Music"
rmdir "%USERPROFILE%\Searches"
rmdir "%USERPROFILE%\Favorites"
rmdir "%USERPROFILE%\.streamlit"
rmdir "%USERPROFILE%\.matplotlib"
del "%USERPROFILE%\.lesshst"
del "%USERPROFILE%\.python_history"
REM This occasionally has video captures in it but is normally just annoyingly emptily created:
rmdir "%USERPROFILE%\Videos"
del "%USERPROFILE%\.streamlit\credentials.toml"
rmdir "%USERPROFILE%\.streamlit"

pause
