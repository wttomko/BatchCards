@echo off
setlocal enabledelayedexpansion

::Arguments
::1 Player number - set this to 0 if discarding the new card
::2 Card Number - also set to 0 if discarding the new card
::3 game log path
::4 discard bat file
::5 Total player cards - 0 if discarding new card

set /a player=%~1
set /a cardNum=%~2
set "gameLog=%~3"
set "discardPile=%~4"
set /a totalPlayerCards=%~5

call %gameLog%
call %discardPile%

set /a discardCounter+=1
echo set /a discardCounter+=1 >>%gameLog%

if %player%==0 (
    echo set "discardPile.card%discardCounter%.name=!newCard.name!" >>%discardPile%
    echo set "discardPile.card%discardCounter%.id=!newCard.id!" >>%discardPile%
    echo set "discardPile.card%discardCounter%.suit=!newCard.suit!" >>%discardPile%
    echo set /a discardPile.card%discardCounter%.value=!newCard.value! >>%discardPile%
    echo set "discardPile.card%discardCounter%.power=!newCard.power!" >>%discardPile%
)

if %player% NEQ 0 (
    echo set "discardPile.card%discardCounter%.name=!player%player%.card%cardNum%.name!" >>%discardPile%
    echo set "discardPile.card%discardCounter%.id=!player%player%.card%cardNum%.id!" >>%discardPile%
    echo set "discardPile.card%discardCounter%.suit=!player%player%.card%cardNum%.suit!" >>%discardPile%
    echo set /a discardPile.card%discardCounter%.value=!player%player%.card%cardNum%.value! >>%discardPile%
    echo set "discardPile.card%discardCounter%.power=!player%player%.card%cardNum%.power!" >>%discardPile%

    echo set "player%player%.card%cardNum%.name=!player%player%.card%totalPlayerCards%.name!" >>%gameLog%
    echo set "player%player%.card%cardNum%.id=!player%player%.card%totalPlayerCards%.id!" >>%gameLog%
    echo set "player%player%.card%cardNum%.suit=!player%player%.card%totalPlayerCards%.suit!" >>%gameLog%
    echo set /a player%player%.card%cardNum%.value=!player%player%.card%totalPlayerCards%.value! >>%gameLog%
    echo set "player%player%.card%cardNum%.power=!player%player%.card%totalPlayerCards%.power!" >>%gameLog%
    echo. >>%gameLog%
    echo set /a player%player%.cardAmount-=1 >>%gameLog%
)

echo. >>%discardPile%
exit /b 0