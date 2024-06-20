@echo off
setlocal enabledelayedexpansion

set "gameLog=Logs\TestFolder\gameLog.bat"
set "deckLog=Logs\TestFolder\Deck.bat"
set "discardLog=Logs\TestFolder\DiscardPile.bat"

echo This test creates a normal deck of 52 cards,
echo and deals 7 cards to 2 players.
pause
echo.
echo the deck creation and deal features
echo can be altered outside this test BAT file.
echo.
pause

break>%gameLog%
break>%deckLog%
break>%discardLog%
echo @echo off >>%gameLog%

set "testPath=Logs\TestFolder\"

call Modules\CreateDeck.bat Normal %testPath%
call Modules\Deal.bat 2 7 %gameLog% %deckLog%

:MAIN_MENU
call %gameLog%
cls
for /l %%a in (1,1,%totalPlayers%) do (
    echo Player %%a
    echo.
    call Modules\DisplayHand.bat %%a !player%%a.cardAmount! Name
    echo.
)
echo -----------------------------------------
echo You are player 1 for testing purposes. 
echo Enter a number to test its function.
echo.
echo [1] Draw Card
echo [2] Discard a card
echo [3] Shuffle hand
echo [4] Swap card

choice /c 1234 /n

if %errorlevel%==4 call :SWAP && goto MAIN_MENU


:SWAP
echo.
echo Enter a card number of yours to Swap
set /p "choice="
set /a p1Num=%choice%
echo.
echo Enter a card to take from player 2
set /p "choice="
set /a p2Num=%choice%

if exist !player1.card%p1Num%.name! if exist !player2.card%p2Num%.name! call Modules\Swap.bat 1 2 %p1Num% %p2Num% %gameLog%


