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

set /a ran=%random%
break>%path%%ran%AlreadyChosen.txt

set /a maxNum=%discardCounter%

:loop

set /a count=%random% %% %maxNum%+1
set /a alreadyChosen=0

if exist %path%%ran%AlreadyChosen.txt for /f "delims=" %%a in (%path%%ran%AlreadyChosen.txt) do (if "%%a"=="%count%" set /a alreadyChosen=1)
if %alreadyChosen%==1 goto loop
if %alreadyChosen%==0 (
>> %path%%ran%AlreadyChosen.txt echo %count%
)