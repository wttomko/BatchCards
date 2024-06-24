@echo off 
setlocal enabledelayedexpansion

set "gameLog=Logs\TestFolder\gameLog.bat"
set "deckLog=Logs\TestFolder\Deck.bat"
set "discardLog=Logs\TestFolder\DiscardPile.bat"

break>%gameLog%
echo @echo off >>%gameLog%

echo 3 paths were created
echo GameLog - where all ingame changes are recorded
echo discard pile - all discard cards
echo deck, the entrire deck of cards
echo.
pause
echo.

call Modules\CreateDeck.bat Normal Logs\TestFolder\

cls
echo a deck was created and shuffled in the test folder \ Deck.bat file
echo.
pause
call Modules\Deal.bat 2 6 %gameLog% %deckLog%
echo.
echo 6 cards were dealt to 2 players. both of these numbers can be changed.
echo.
pause
call %gameLog%
cls
echo Player 1^:
echo.
call Modules\DisplayHand.bat 1 6 Name
echo.
pause
echo.
call Modules\DrawCard.bat 1 %gameLog% %deckCounter% %deckLog%
call %gameLog%
cls
echo Player 1 has drawn a card. Here are their cards now
echo.
call Modules\DisplayHand.bat 1 %player1.cardAmount% Name
echo.
pause
call Modules\Discard.bat 1 3 %gameLog% %player1.cardAmount% %discardCounter% %discardLog%
cls
call %gameLog%
cls
echo Player 1 has discarded their card 3. Here are their cards now
echo.
call Modules\DisplayHand.bat 1 %player1.cardAmount% Name
echo.
pause
call Modules\Swap.bat 1 2 3 3 %gameLog%
cls
echo Player 1 swaped their card 3 with player 2 card 3
echo. 
call Modules\DisplayHand.bat 1 %player1.cardAmount% Name
echo.
pause
cls 
echo restore deck will be called. this will take all cards in the discard
echo and put them back into the deck and shuffle it. The gameLog
echo will also be refreshed, getting rid of unnesserary code. 
pause
call Modules\RestoreDeck.bat %deckLog% %discardLog% %gameLog%
cls
echo you can now reopen the game log, discard pile and deck. all have changed
pause
echo Pressing enter agin will close this and erase all logs.
pause
break>%gameLog%
break>%deckLog%
break>%discardLog%
exit