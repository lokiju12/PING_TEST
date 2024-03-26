@echo off
setlocal enabledelayedexpansion
:Start
cls
echo.
set /p start_ip=시작 IP (예: 192.168.1.100) : 
for /f "tokens=1-4 delims=." %%a in ("!start_ip!") do (
    set start_ip_seg1=%%a
    set start_ip_seg2=%%b
    set start_ip_seg3=%%c
    set start_ip_dot=%%d
)
echo.
:input_last_ip
set /p last_ip=마지막 IP (예: 192.168.1.240) : 
for /f "tokens=1-4 delims=." %%a in ("!last_ip!") do (
    set last_ip_seg1=%%a
    set last_ip_seg2=%%b
    set last_ip_seg3=%%c
    set last_ip_dot=%%d
)
echo.
echo 시작 : %start_ip%
echo 종료 : %last_ip%
echo.
echo =============================================
echo.
:: 시작 IP와 마지막 IP 사이의 숫자 범위를 계산합니다.
set /a start_ip_dot=!start_ip_dot!
set /a last_ip_dot=!last_ip_dot!

:: 시작 IP부터 마지막 IP까지 테스트를 수행합니다.
for /L %%i in (!start_ip_dot!, 1, !last_ip_dot!) do (
    set ip=!start_ip_seg1!.!start_ip_seg2!.!start_ip_seg3!.%%i
    ping -n 1 !ip! | find "TTL=" >nul
    if errorlevel 1 (
        echo !ip! 미사용
    ) else (
        echo !ip! 사용
    )
)
echo.
echo =============================================
echo.
echo 다시 검색하려면 [Enter] 키를 누르세요.
pause>nul
goto :Start
