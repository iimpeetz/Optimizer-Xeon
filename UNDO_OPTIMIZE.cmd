@echo off
chcp 65001 >nul
title UNDO OPTIMIZE
color 0C

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] กรุณาเปิดไฟล์นี้แบบ Run as administrator
    pause
    exit /b
)

echo คืนค่าบางส่วน...

powercfg -h on

sc config "SysMain" start= auto >nul 2>&1
sc start "SysMain" >nul 2>&1

sc config "WSearch" start= delayed-auto >nul 2>&1
sc start "WSearch" >nul 2>&1

sc config "DiagTrack" start= demand >nul 2>&1

net start wuauserv >nul 2>&1
net start bits >nul 2>&1

reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 1 /f >nul

echo เสร็จแล้ว
pause
exit /b
