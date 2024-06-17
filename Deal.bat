@echo off
setlocal enabledelayedexpansion

::Arguments
:: 1 Amount of players
:: 2 Amount of cards to each player
:: 3 Path to gamelog to write the cards
:: 4 Path to the folder with the deck

set /a playerAmount=%~1
set /a cardAmount=%~2
set "path=%~3"
set "deck=%~4"

echo Now dealing %cardAmount% card^(s^) to %playerAmount% player^(s^)

call %deck%
set /a deckCounter=0

for /l %%a in (1,1,%cardAmount%) do call :ToPlayer %%a
for /l %%a in (1,1,%playerAmount%) do echo set /a player%%a.cardAmount=%cardAmount% >>%path%
echo set /a deckCounter=%deckCounter% >>%path%
exit /b 0

:ToPlayer
    set c=%~1
    for /l %%b in (1,1,%playerAmount%) do call :DealCard %%b
exit /b 0

:DealCard
    set p=%~1
    set /a deckCounter+=1
    echo set "player%p%.card%c%.name=!card%deckCounter%.name!" >>%path%
    echo set "player%p%.card%c%.id=!card%deckCounter%.id!" >>%path%
    echo set "player%p%.card%c%.suit=!card%deckCounter%.suit!" >>%path%
    echo set /a player%p%.card%c%.value=!card%deckCounter%.value! >>%path%
    echo set "player%p%.card%c%.power=!card%deckCounter%.power!" >>%path%
    echo. >>%path%
exit /b 0