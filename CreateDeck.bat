@echo off
setlocal enabledelayedexpansion

::Deck will be writting to a Deck.bat file in the following format...

:: set "card1.name=********"
:: set "card1.id=******"
:: set "card1.suit=******"
:: set "card1.value=******"
:: set "card1.power=******"

::Arguements Below (BOTH REQUIRED)
::1 - Modifier (Currently have Normal, War, Golf, Battle)
::2 - Path to folder for the deck to be installed

set "mod=%~1"
set "path=%~2"

set /a jokerCounter=0
set /a blankCounter=0

if /i "%mod%"=="Normal" (
	set /a maxNum=52
)

if /i "%mod%"=="War" (
	set /a maxNum=52
)

if /i "%mod%"=="Golf" (
	set /a maxNum=55
)

if /i "%mod%"=="Battle" (
	set /a maxNum=54
)

set /a ran=%random%
break>%path%%ran%AlreadyChosen.txt

break>%path%Deck.bat
break>%path%DiscardPile.bat

echo @echo off >>%path%Deck.bat
echo @echo off >>%path%DiscardPile.bat

echo. >>%path%Deck.bat
echo. >>%path%DiscardPile.bat

cls
echo ========================
echo Shuffling Cards
echo.
echo Game Mode^: %mod%
echo Amount of Cards^: %maxNum%
echo ========================

for %%a in (Hearts Clubs Spades Diamonds) do call :Create "%%a"
echo.  >>%path%Deck.bat
echo set /a discardCounter=0 >>%gameLog%
del %path%%ran%AlreadyChosen.txt
exit /b 0

:Create
set suitArg=%~1
goto %mod%

:Normal
for %%b in (2 3 4 5 6 7 8 9 10 Jack Queen King Ace) do call :Combine "%%b"
exit /b 0

:Golf 
for %%b in (2 3 4 5 6 7 8 9 10 Jack Queen King Ace Joker Blank) do call :Combine "%%b"
exit /b 0

:Battle
for %%b in (2 3 4 5 6 7 8 9 10 Jack Queen King Ace Joker) do call :Combine "%%b"
exit /b 0

:War
for %%b in (2 3 4 5 6 7 8 9 10 Jack Queen King Ace) do call :Combine "%%b"
exit /b 0

:Combine
set id=%~1

if "%id%"=="Joker" goto JokerCheck
if "%id%"=="Blank" goto BlankCheck

goto loop

:JokerCheck
	set /a jokerCounter+=1
	if "%jokerCounter%" GTR "2" goto EndCombine
goto loop

:BlankCheck
	set /a blankCounter+=1
	if "%blankCounter%" GTR "1" goto EndCombine
goto loop

:loop

set /a count=%random% %% %maxNum%+1
set /a alreadyChosen=0

if exist %path%%ran%AlreadyChosen.txt for /f "delims=" %%a in (%path%%ran%AlreadyChosen.txt) do (if "%%a"=="%count%" set /a alreadyChosen=1)
if %alreadyChosen%==1 goto loop
if %alreadyChosen%==0 (
>> %path%%ran%AlreadyChosen.txt echo %count%
)

if "%id%"=="Joker" (
	call :AddJoker
	goto EndCombine
)
if "%id%"=="Blank" (
	call :AddBlank
	goto EndCombine
)

echo set "card%count%.name=!id!_of_!suitArg!" >>%path%Deck.bat
echo set "card%count%.id=!id!" >>%path%Deck.bat
echo set "card%count%.suit=!suitArg!" >>%path%Deck.bat

if /i "%mod%"=="Normal" (

	if !id!==2 echo set /a card%count%.value=2 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==3 echo set /a card%count%.value=3 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==4 echo set /a card%count%.value=4 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==5 echo set /a card%count%.value=5 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==6 echo set /a card%count%.value=6 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==7 echo set /a card%count%.value=7 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==8 echo set /a card%count%.value=8 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==9 echo set /a card%count%.value=9 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==10 echo set /a card%count%.value=10 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==Jack echo set /a card%count%.value=10 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==Queen echo set /a card%count%.value=10 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==King echo set /a card%count%.value=10 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==Ace echo set /a card%count%.value=11 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat

)

if /i "%mod%"=="War" (

	if !id!==2 echo set /a card%count%.value=2 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==3 echo set /a card%count%.value=3 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==4 echo set /a card%count%.value=4 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==5 echo set /a card%count%.value=5 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==6 echo set /a card%count%.value=6 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==7 echo set /a card%count%.value=7 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==8 echo set /a card%count%.value=8 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==9 echo set /a card%count%.value=9 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==10 echo set /a card%count%.value=10 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==Jack echo set /a card%count%.value=11 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==Queen echo set /a card%count%.value=12 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==King echo set /a card%count%.value=13 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==Ace echo set /a card%count%.value=14 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat

)

if /i "%mod%"=="Golf" (

	if !id!==2 echo set /a card%count%.value=-2 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==3 echo set /a card%count%.value=3 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==4 echo set /a card%count%.value=4 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==5 echo set /a card%count%.value=5 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==6 echo set /a card%count%.value=6 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==7 echo set /a card%count%.value=7 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==8 echo set /a card%count%.value=8 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==9 echo set /a card%count%.value=9 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==10 echo set /a card%count%.value=10 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==Jack echo set /a card%count%.value=10 >>%path%Deck.bat && echo set "card%count%.power=peek" >>%path%Deck.bat
	if !id!==Queen echo set /a card%count%.value=10 >>%path%Deck.bat && echo set "card%count%.power=swap" >>%path%Deck.bat
	if !id!==King echo set /a card%count%.value=0 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==Ace echo set /a card%count%.value=1 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat

)

if /i "%mod%"=="Battle" (

	if !id!==2 echo set /a card%count%.value=-2 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==3 echo set /a card%count%.value=3 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==4 echo set /a card%count%.value=4 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==5 echo set /a card%count%.value=5 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==6 echo set /a card%count%.value=6 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==7 echo set /a card%count%.value=7 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==8 echo set /a card%count%.value=8 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==9 echo set /a card%count%.value=9 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==10 echo set /a card%count%.value=10 >>%path%Deck.bat && echo set "card%count%.power=n/a" >>%path%Deck.bat
	if !id!==Jack echo set /a card%count%.value=10 >>%path%Deck.bat && echo set "card%count%.power=counter" >>%path%Deck.bat
	if !id!==Queen echo set /a card%count%.value=10 >>%path%Deck.bat && echo set "card%count%.power=defense" >>%path%Deck.bat
	if !id!==King echo set /a card%count%.value=0 >>%path%Deck.bat && echo set "card%count%.power=attack" >>%path%Deck.bat
	if !id!==Ace echo set /a card%count%.value=1 >>%path%Deck.bat && echo set "card%count%.power=endurance" >>%path%Deck.bat

)

echo. >>%path%Deck.bat
:EndCombine
exit /b 0

::FUNCTIONS //////////////////////////////////////////////////////////////////

:AddJoker

	echo set "card%count%[NAME]=!id!" >>%path%Deck.bat
	echo set "card%count%[ID]=!id!" >>%path%Deck.bat
	echo set "card%count%[SUIT]=!id!" >>%path%Deck.bat
	echo set /a card%count%.value=0 >>%path%Deck.bat
	if /i "%mod%"=="Golf" echo set "card%count%.power=Shuffle" >>%path%Deck.bat
	if /i "%mod%"=="Battle" echo set "card%count%.power=extra" >>%path%Deck.bat
	echo. >>%path%Deck.bat

exit /b 0

:AddBlank

	echo set "card%count%[NAME]=!id!" >>%path%Deck.bat
	echo set "card%count%[ID]=!id!" >>%path%Deck.bat
	echo set "card%count%[SUIT]=!id!" >>%path%Deck.bat
	echo set /a card%count%.value=0 >>%path%Deck.bat
	if /i "%mod%"=="Golf" echo set "card%count%.power=EndGame" >>%path%Deck.bat
	echo. >>%path%Deck.bat

exit /b 0
