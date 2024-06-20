@echo off
setlocal enabledelayedexpansion

::ARGUMENTS
:: 1 1st player in the swap
:: 2 2nd player in swap
:: 3 1st players card number to swap
:: 4 2nd players card number to swap
:: 3 gameLog

set /a p1=%~1
set /a p2=%~2
set /a c1=%~3
set /a c2=%~4
set "gameLog=%~5"

::TEMP CARD == PLAYER 1

set "tempCard.name=!player%p1%.card%c1%.name!"
set "tempCard.id=!player%p1%.card%c1%.id!"
set "tempCard.suit=!player%p1%.card%c1%.suit!"
set /a tempCard.value=!player%p1%.card%c1%.value!
set "tempCard.power=!player%p1%.card%c1%.power!"

:: PLAYER 1 == PLAYER 2

echo set "player%p1%.card%c1%.name=!player%p2%.card%c2%.name!" >>%gameLog%
echo set "player%p1%.card%c1%.id=!player%p2%.card%c2%.id!" >>%gameLog%
echo set "player%p1%.card%c1%.suit=!player%p2%.card%c2%.suit!" >>%gameLog%
echo set /a player%p1%.card%c1%.value=!player%p2%.card%c2%.value! >>%gameLog%
echo set "player%p1%.card%c1%.power=!player%p2%.card%c2%.power!" >>%gameLog%
echo. >>%gameLog%

::PLAYER 2 == TEMP

echo set "player%p2%.card%c2%.name=!tempCard.name!" >>%gameLog%
echo set "player%p2%.card%c2%.id=!tempCard.id!" >>%gameLog%
echo set "player%p2%.card%c2%.suit=!tempCard.suit!" >>%gameLog%
echo set /a player%p2%.card%c2%.value=!tempCard.value! >>%gameLog%
echo set "player%p2%.card%c2%.power=!tempCard.power!" >>%gameLog%
echo. >>%gameLog%

exit /b 0