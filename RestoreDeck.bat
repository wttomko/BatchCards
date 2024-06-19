@echo off
setlocal enabledelayedexpansion

::Arguments
::1 deckLog
::2 discardPile
::3 gameLog

set "deckLog=%~1"
set "discardPile=%~2"
set "gameLog=%~3"

call %gameLog%
call %discardPile%

break>%deckLog%
echo @echo off >>%deckLog%
echo. >>%deckLog%

set /a ran=%random%
break>%path%%ran%AlreadyChosen.txt

set /a maxNum=%discardCounter%

for /l %%a in (1,1,%maxNum%) do call :loop %%a

:loop
set /a c=%~1

set /a count=%random% %% %maxNum%+1
set /a alreadyChosen=0

if exist %path%%ran%AlreadyChosen.txt for /f "delims=" %%a in (%path%%ran%AlreadyChosen.txt) do (if "%%a"=="%count%" set /a alreadyChosen=1)
if %alreadyChosen%==1 goto loop
if %alreadyChosen%==0 (
>> %path%%ran%AlreadyChosen.txt echo %count%
)

echo set "card%c%.name=!discardPile.card%count%.name!"
echo set "card%c%.id=!discardPile.card%count%.id!"
echo set "card%c%.suit=!discardPile.card%count%.suit!"
echo set /a card%c%.value=!discardPile.card%count%.value!
echo set "card%c%.power=!discardPile.card%count%.power!"

exit /b 0