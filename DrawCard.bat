@echo off
setlocal enabledelayedexpansion

::Arguments
:: 1 player number - set this to 0 to not automatically assign the card
:: path to gamelog
:: path to deck

set /a player=%~1
set "gameLog=%~2"
set "deckLog=%~3"

call %deckLog%
call %gameLog%

set /a deckCounter+=1
echo set /a deckCounter+=1 >>%gameLog%

if %player% NEQ 0 (
    set /a player%player%.cardAmount+=1
    echo set "player%player%.card!player%player%.cardAmount!.name=!card%deckCounter%.name!" >>%gameLog%
    echo set "player%player%.card!player%player%.cardAmount!.id=!card%deckCounter%.id!" >>%gameLog%
    echo set "player%player%.card!player%player%.cardAmount!.suit=!card%deckCounter%.suit!" >>%gameLog%
    echo set /a player%player%.card!player%player%.cardAmount!.value=!card%deckCounter%.value >>%gameLog%
    echo set "player%player%.card!player%player%.cardAmount!.power=!card%deckCounter%.power!" >>%gameLog%
)

if %player%==0 (
    echo set "newCard.name=!card%deckCounter%.name!" >>%gameLog%
    echo set "newCard.id=!card%deckCounter%.id!" >>%gameLog%
    echo set "newCard.suit=!card%deckCounter%.suit!" >>%gameLog%
    echo set /a newCard.value=!card%deckCounter%.value >>%gameLog%
    echo set "newCard.power=!card%deckCounter%.power!" >>%gameLog%
)

echo. >>%gameLog%
exit /b 0