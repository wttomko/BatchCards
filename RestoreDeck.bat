@echo off
setlocal enabledelayedexpansion

::Arguments
::1 deckLog
::2 discardPile
::3 gameLog
::4 discard counter

set "deckLog=%~1"
set "discardPile=%~2"
set "gameLog=%~3"
set /a maxNum=%~4

call %discardPile%

break>%deckLog%
echo @echo off >>%deckLog%
echo. >>%deckLog%

set /a ran=%random%
break>%ran%AlreadyChosen.txt

for /l %%a in (1,1,%maxNum%) do call :loop %%a
del %ran%AlreadyChosen.txt
break>%discardPile%
echo @echo off >>%discardPile%
echo. >>%discardPile%
echo set /a discardCounter=0 >>%gameLog%
exit /b 0

:loop
set /a c=%~1

set /a count=%random% %% %maxNum%+1
set /a alreadyChosen=0

if exist %ran%AlreadyChosen.txt for /f "delims=" %%a in (%ran%AlreadyChosen.txt) do (if "%%a"=="%count%" set /a alreadyChosen=1)
if %alreadyChosen%==1 goto loop
if %alreadyChosen%==0 (
>> %ran%AlreadyChosen.txt echo %count%
)

echo set "card%c%.name=!discard.card%count%.name!" >>%deckLog%
echo set "card%c%.id=!discard.card%count%.id!" >>%deckLog%
echo set "card%c%.suit=!discard.card%count%.suit!" >>%deckLog%
echo set /a card%c%.value=!discard.card%count%.value! >>%deckLog%
echo set "card%c%.power=!discard.card%count%.power!" >>%deckLog%
echo. >>%deckLog%

exit /b 0