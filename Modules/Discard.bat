@echo off
setlocal enabledelayedexpansion

::ARGUMENTS
:: 1 - Player number who is descarding - Make this 0 to discard New Card
:: 2 - Card Number they are discarding
:: 3 - Game Log bat file
:: 4 - Amount of cards the player has
:: 5 - DiscardCounter
:: 6 - Discard bat file

set /a playerNumber=%~1
set /a cardNumber=%~2
set "gameLog=%~3"
set /a cardAmount=%~4
set /a disCounter=%~5
set "discardPile=%~6"

set /a disCounter+=1
echo set /a discardCounter+=1 >>%gameLog%
echo. >>%gameLog%

if %playerNumber%==0 (
    echo set "discard.card%disCounter%.name=!newCard.name!" >>%discardPile%
    echo set "discard.card%disCounter%.id=!newCard.id!" >>%discardPile%
    echo set "discard.card%disCounter%.suit=!newCard.suit!" >>%discardPile%
    echo set /a discard.card%disCounter%.value=!newCard.value! >>%discardPile%
    echo set "discard.card%disCounter%.power=!newCard.power!" >>%discardPile%
    echo. >>%discardPile%
)

if %playerNumber% NEQ 0 (
    echo set "discard.card%disCounter%.name=!player%playerNumber%.card%cardNumber%.name!" >>%discardPile%
    echo set "discard.card%disCounter%.id=!player%playerNumber%.card%cardNumber%.id!" >>%discardPile%
    echo set "discard.card%disCounter%.suit=!player%playerNumber%.card%cardNumber%.suit!" >>%discardPile%
    echo set /a discard.card%disCounter%.value=!player%playerNumber%.card%cardNumber%.value! >>%discardPile%
    echo set "discard.card%disCounter%.power=!player%playerNumber%.card%cardNumber%.power!" >>%discardPile%
    echo. >>%discardPile%
)

if %playerNumber% NEQ 0 (
    echo set "player%playerNumber%.card%cardNumber%.name=!player%playerNumber%.card%cardAmount%.name!" >>%gameLog%
    echo set "player%playerNumber%.card%cardNumber%.id=!player%playerNumber%.card%cardAmount%.id!" >>%gameLog%
    echo set "player%playerNumber%.card%cardNumber%.suit=!player%playerNumber%.card%cardAmount%.suit!" >>%gameLog%
    echo set /a player%playerNumber%.card%cardNumber%.value=!player%playerNumber%.card%cardAmount%.value! >>%gameLog%
    echo set "player%playerNumber%.card%cardNumber%.power=!player%playerNumber%.card%cardAmount%.power!" >>%gameLog%
    echo. >>%gameLog%
    echo set /a player%playerNumber%.cardAmount-=1 >>%gameLog%
)