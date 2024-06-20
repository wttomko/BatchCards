@echo off
setlocal enabledelayedexpansion

::ARGUMENTS
:: 1 - Game Log

set "gameLog=%~1"

call %gameLog%

break>%gameLog%
echo @echo off>>%gameLog%
echo.>>%gameLog%

echo set /a discardCounter=%discardCounter% >>%gameLog%
echo set /a deckCounter=%deckCounter% >>%gameLog%
echo set /a totalPlayers=%totalPlayers% >>%gameLog%
echo set /a deck.totalCards=%deck.totalCards% >>%gameLog%
echo.>>%gameLog%

for /l %%a in (1,1,%totalPlayers%) do echo set /a player%%a.cardAmount=!player%%a.cardAmount! >>%gameLog%

echo.>>%gameLog%

for /l %%a in (1,1,%totalPlayers%) do call :EachPlayer %%a
exit /b 0

:EachPlayer
set /a p=%~1

for /l %%b in (1,1,!player%p%.cardAmount!) do (
    echo set "player%p%.card%%b.name=!player%p%.card%%b.name!" >>%gameLog%
    echo set "player%p%.card%%b.id=!player%p%.card%%b.id!" >>%gameLog%
    echo set "player%p%.card%%b.suit=!player%p%.card%%b.suit!" >>%gameLog%
    echo set /a player%p%.card%%b.value=!player%p%.card%%b.value! >>%gameLog%
    echo set "player%p%.card%%b.power=!player%p%.card%%b.power!" >>%gameLog%
    echo.>>%gameLog%
)

exit /b 0
