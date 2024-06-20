@echo off
setlocal enabledelayedexpansion

::Arguments
::1 Player num
::2 total cards
::3 Style - Name, Short

set /a player=%~1
set /a total=%~2
set "style=%~3"

if /i "%style%"=="Name" (
    for /l %%a in (1,1,%total%) do echo [%%a] !player%player%.card%%a.name!
)

if /i "%style%"=="Short" (
    for /l %%a in (1,2,%total%) do call :short %%a
)

exit /b 0

:Short
set /a y=%~1
set /a x=y+1
echo [%y%] !player%player%.card%y%.id:~0,1!!player%player%.card%y%.suit:~0,1!     [%x%] !player%player%.card%x%.id:~0,1!!player%player%.card%x%.suit:~0,1!
exit /b 0