@echo off
chcp 65001 >nul
title GODMODE LAUNCHER
color 0B

echo =========================================
echo        GODMODE GAME + STREAM MODE
echo =========================================
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] กรุณาเปิดไฟล์นี้แบบ Run as administrator
    pause
    exit /b
)

echo [1/8] ปิดโปรแกรมพื้นหลังที่กิน RAM...
taskkill /f /im OneDrive.exe >nul 2>&1
taskkill /f /im Microsoft.Teams.exe >nul 2>&1
taskkill /f /im msedge.exe >nul 2>&1
taskkill /f /im chrome.exe >nul 2>&1
taskkill /f /im brave.exe >nul 2>&1
taskkill /f /im opera.exe >nul 2>&1
taskkill /f /im SteamWebHelper.exe >nul 2>&1

echo [2/8] หยุด Windows Update service ชั่วคราว...
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1

echo [3/8] ตั้ง explorer เป็น priority ปกติ...
wmic process where name="explorer.exe" CALL setpriority "Normal" >nul 2>&1

echo [4/8] เปิด OBS...
start "" "%ProgramFiles%\obs-studio\bin\64bit\obs64.exe"

timeout /t 3 >nul

echo [5/8] เปิด Discord...
start "" "%LocalAppData%\Discord\Update.exe" --processStart Discord.exe

timeout /t 3 >nul

echo [6/8] พยายามลด priority Discord ให้เบาหน่อย...
wmic process where name="Discord.exe" CALL setpriority "Below Normal" >nul 2>&1

echo [7/8] ถ้าเปิดเกมแล้ว ค่อยแก้ชื่อ exe ตรง GAME_EXE ด้านล่าง
echo ตัวอย่าง: game.exe / javaw.exe / FiveM.exe / VALORANT-Win64-Shipping.exe
echo.

echo [8/8] เสร็จแล้ว
echo.
echo ===== คำแนะนำ =====
echo - เปิดเกมทีหลังจากนี้
echo - ตั้ง OBS ให้ Run as administrator
echo - ถ้าเกม/ไลฟ์กระตุก ให้ปิด Discord Hardware Acceleration
echo - ถ้าแชร์จอ Discord กระตุก ให้ลด quality/fps ของ Discord share
echo.
pause
exit /b
