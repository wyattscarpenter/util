# This batch script does legendary commands to launch a game.
# It would also be a bash script but it takes one argument, the game name.
# (These hash marks just are unfound commands.)

legendary launch %1 && exit
legendary auth #this is idempotent if your stored credentials are still valid
legendary list-game #this updates the game listing in case legendary doesn't know about a game we just purchased
legendary install %1 #this is idempotent if your game is already install
legendary launch %1