@echo off

echo Welcome to Batch Cards. Pressing Enter will setup the paths and .BAT files for card games.
echo Path to view these files will be in Logs\TestFolder
pause > nul

set "gameLog=Logs\TestFolder\gameLog.bat"
set "deckLog=Logs\TestFolder\Deck.bat"
set "discardLog=Logs\TestFolder\DiscardPile.bat"

break>%gameLog%
echo @echo off >>%gameLog%
cls
echo For now, just the game log should be visible.
echo Pressing enter now will create and shuffle the deck. 
echo You will then have the deck and discard pile .BAT files

pause > nul

call Modules\CreateDeck.bat Normal Logs\TestFolder\
pause

cls 
echo With the deck created, Modules\Deal.bat will be called,
echo dealing 7 cards to 2 players.
echo.
echo These cards will be recorded in the gamelog .BAT file
pause > nul

call Modules\Deal.bat 2 7 %gameLog% %deckLog%
pause

cls 
echo Lets display both players hands,
echo Feel free to double check the cards in the gamelog
echo.
pause
call %gameLog%
cls
echo Player 1
echo.
call Modules\DisplayHand.bat 1 %player1.cardAmount% Name
echo.
echo Player 2
echo.
call Modules\DisplayHand.bat 2 %player2.cardAmount% Name
echo.
pause

cls 
echo Lets have player 1 draw a card, then discard their card 4
echo.
pause

call Modules\DrawCard.bat 1 %gameLog% %deckCounter% %deckLog%
echo.
echo Card was drawn...
echo.
call %gameLog%
pause
call Modules\Discard.bat 1 4 %gameLog% %player1.cardAmount% %discardCounter% %discardLog%
echo.
echo card was discarded.
echo.
pause
call %gameLog%
cls
echo Player 1 cards now..
echo.
call Modules\DisplayHand.bat 1 %player1.cardAmount% Name
echo.
pause

cls
echo Pressing enter will swap player 1 card 5 with player 2 card 3
echo.
pause
cls
call Modules\Swap.bat 1 2 5 3 %gameLog%
echo.
echo Swapped. 
echo.
pause
call %gameLog%
cls
echo Player 1 cards now..
echo.
call Modules\DisplayHand.bat 1 %player1.cardAmount% Name
echo.
echo Player 2 cards now..
echo.
call Modules\DisplayHand.bat 2 %player2.cardAmount% Name
echo.
pause

cls 
echo Using a loop, player 2 is going to draw a card, 
echo and discard their card 2 into the discard pile until 
echo the deck runs out. 
echo.
pause


set /a counter=%deckCounter%+1
for /l %%a in (%counter%,1,%deck.totalCards%) do call :DrawCard && call :Discard

echo.
echo Check the game log
pause

cls 
echo the discard pile has 38 cards. and heave player has 7.
echo total of still 52 cards.
pause > nul
cls
echo Pressing enter again will restore the deck and also 
echo refresh the game log, getting rid of unnecessary lines.
echo.
echo It is recommended you open all 3 bat files now in edit mode
echo to see a before/after
echo.
pause

call Modules\RestoreDeck.bat %deckLog% %discardLog% %gameLog%

echo.
echo Restored. Check the logs to compare
echo.
pause

del Logs\TestFolder\*.bat
exit /b 0

::FUNCTIONS //////////////////////////////////////////////////////////////////////

:DrawCard
call %gameLog%
call Modules\DrawCard.bat 2 %gameLog% %deckCounter% %deckLog%
exit /b 0

:Discard
call %gameLog%
call Modules\Discard.bat 2 2 %gameLog% %player2.cardAmount% %discardCounter% %discardLog%
exit /b 0