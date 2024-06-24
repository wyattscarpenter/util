@echo off
REM This batch script does Legendary commands to launch a game you own on the Epic Games Store. See https://github.com/derrod/legendary#quickstart
REM This file would also be a valid bash script but it takes one argument, the game name, so I need the percent variables. Should be easy to change the percents to dollar signs to make it a bash script instead, if need be.

REM TODO: I'm not sure if we need/want any of the following Legendary commands: sync-saves; list-installed --check-updates; launch --offline; legendary -y egl-sync. This script should be my default workflow for readying a game, but I'm not sure which of those options are actually useful.

REM Early out if the game is already ready and can just be launched. Note that legendary just launches a process and then immediately terminates, so the code I added in to track time can fire after the game launch.
legendary launch --offline %1 && echo BEGINNING epic launch: %time%
if errorlevel 1 (
  REM This if statement triggers only if there was an exit code greater than 0 (ie, there was an error). This is very basic knowledge but who actually knows cmd syntax? Not me! See also: https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/if
  REM we && here just to suppress a large amount of inevitable and useless error information if we continued. legendary auth is idempotent if your stored credentials are still valid. If you don't have valid credentials, it will open a web browser to a page for you to get them. legendary list-games updates the game listing in case legendary doesn't know about a game we've just purchased which we are now trying to play. legendary install is idempotent if your game is already installed.
  legendary auth && legendary list-games && legendary install %1 && legendary launch %1 && echo BEGINNING backup epic launch: %time%
)
