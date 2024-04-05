REM This batch script does Legendary commands to launch a game you own on the Epic Games Store. See https://github.com/derrod/legendary#quickstart
REM This file would also be a valid bash script but it takes one argument, the game name, so I need the percent variables. Should be easy to change the percents to dollar signs to make it a bash script instead, if need be.

REM TODO: I'm not sure if we need/want any of the following Legendary commands: sync-saves; list-installed --check-updates; launch --offline; legendary -y egl-sync. This script should be my default workflow for readying a game, but I'm not sure which of those options are actually useful.

REM Early out if the game is already ready and can just be launched:
legendary launch %1 && exit
REM This is idempotent if your stored credentials are still valid. If you don't have valid credentials, it will open a web browser to a page for you to get them:
legendary auth
REM This updates the game listing in case legendary doesn't know about a game we just purchased:
legendary list-games
REM This is idempotent if your game is already installed:
legendary install %1
legendary launch %1
