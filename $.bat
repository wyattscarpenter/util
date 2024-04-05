@echo off
REM Tired of example shell scripts with $ at the beginning of each line ruining your ability to just run them? Well now you can! Unless they try to cd or something.
REM Note that this file doesn't have a shebang, because it should be supported natively by most shells, so the transition is seamless if we omit the shebang.
REM Surprisingly, most of the times I've run into initial-$ commands when I'm on windows (and thus this batch file would trigger), still work best when the command is interpreted as a windows command, and not a unix command. But, you know, this is just luck of the draw.
%*
