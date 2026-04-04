REM This bat file removes the annoying auto-created files from the Windows 10 desktop. It does not delete anything that I think you need, even if that thing you need is still clutter. However, this is still based on my personal judgement that you don't need stuff like .lesshst. I keep this file in util, but put a shortcut to it on my desktop, so I can just click that. It should be run in administrator mode (a number of these still give "Access is denied." errors for apparently no reason).
REM The "right" way to do this, which we do, is to delete the files I know about, and then rmdir the folders. That way that only known-bad files and empty dirs are deleted. Just in case.
REM you can fix the problem of windows automatically creating some of these with approaches along the lines described in https://superuser.com/a/1936287 — for instance, to stop it from automatically creating Searches, you would also delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d1d3a04-debb-4115-95cf-2f29da2920da}, and so on.
rmdir "%USERPROFILE%\Music\"
rmdir "%USERPROFILE%\Searches\"
rmdir "%USERPROFILE%\Favorites\"
rmdir "%USERPROFILE%\Saved Games\"
del "%USERPROFILE%\.streamlit\credentials.toml"
rmdir "%USERPROFILE%\.streamlit\"
del "%USERPROFILE%\.matplotlib\fontlist-v390.json"
rmdir "%USERPROFILE%\.matplotlib\"
del "%USERPROFILE%\.lesshst"
del "%USERPROFILE%\.python_history"
del "%USERPROFILE%\.idlerc\recent-files.lst"
del "%USERPROFILE%\.idlerc\breakpoints.lst"
del "%USERPROFILE%\.node_repl_history"
rmdir "%USERPROFILE%\.idlerc\"
rmdir "%USERPROFILE%\Videos\NVIDIA\"
rmdir "%USERPROFILE%\Videos\Captures\"
rmdir "%USERPROFILE%\Videos\"

pause
