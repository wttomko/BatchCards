@echo off
setlocal enabledelayedexpansion

::Arguments
::1 deckLog bat file
::2 discardPile bat file
::3 gameLog bat file

set "deckLog=%~1"
set "discardPile=%~2"
set "gameLog=%~3"

call %gameLog%
call %discardPile%
call %deckLog%

set /a startingPoint=%deckCounter%+1
set /a counter=0

break>%deckLog%
echo @echo off >>%deckLog%
echo. >>%deckLog%

for /l %%a in (%startingPoint%,1,%deck.totalCards%) do (
    set /a counter+=1
    set "card!counter!.name=!card%%a.name!"
    set "card!counter!.id=!card%%a.id!"
    set "card!counter!.suit=!card%%a.suit!"
    set /a card!counter!.value=!card%%a.value!
    set "card!counter!.power=!card%%a.power!"
)

for /l %%a in (1,1,%discardCounter%) do (
    set /a counter+=1
    set "card!counter!.name=!discard.card%%a.name!"
    set "card!counter!.id=!discard.card%%a.id!"
    set "card!counter!.suit=!discard.card%%a.suit!"
    set /a card!counter!.value=!discard.card%%a.value!
    set "card!counter!.power=!discard.card%%a.power!"
)

echo set /a deck.totalCards=%counter% >>%gameLog%
set /a maxNum=%counter%
set /a ran=%random%
break>%ran%AlreadyChosen.txt

for /l %%a in (1,1,%counter%) do call :loop %%a
del %ran%AlreadyChosen.txt
break>%discardPile%
echo @echo off >>%discardPile%
echo. >>%discardPile%
echo set /a discardCounter=0 >>%gameLog%
echo set /a deckCounter=0 >>%gameLog%

call %~dp0RefreshGameLog.bat %gameLog%
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

echo set "card%c%.name=!card%count%.name!" >>%deckLog%
echo set "card%c%.id=!card%count%.id!" >>%deckLog%
echo set "card%c%.suit=!card%count%.suit!" >>%deckLog%
echo set /a card%c%.value=!card%count%.value! >>%deckLog%
echo set "card%c%.power=!card%count%.power!" >>%deckLog%
echo. >>%deckLog%

exit /b 0