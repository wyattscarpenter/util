REM The equivalent findstr command is findstr /SPINA:0C todo * but unfortunately there's no easy way to ignore the .git folders with that, which is crucial.
rg -i "\btodo\b"
