@echo off
chcp 65001 >nul
title ULTIMATE GAMING + STREAMING OPTIMIZER
color 0A

echo =========================================
echo   ULTIMATE GAMING + STREAMING OPTIMIZER
echo =========================================
echo.

:: ขอสิทธิ์แอดมิน
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] กรุณาเปิดไฟล์นี้แบบ Run as administrator
    pause
    exit /b
)

echo [1/10] ปรับ Power Plan เป็น High Performance...
powercfg -setactive SCHEME_MIN

echo [2/10] ปิด hibernation เพื่อลดการจองพื้นที่/โอเวอร์เฮด...
powercfg -h off

echo [3/10] ปิด SysMain...
sc stop "SysMain" >nul 2>&1
sc config "SysMain" start= disabled >nul 2>&1

echo [4/10] ปิด Windows Search ชั่วคราว...
sc stop "WSearch" >nul 2>&1
sc config "WSearch" start= demand >nul 2>&1

echo [5/10] ปิด telemetry บางส่วน...
sc stop "DiagTrack" >nul 2>&1
sc config "DiagTrack" start= disabled >nul 2>&1

echo [6/10] ปรับ network baseline...
netsh int tcp set global autotuninglevel=normal >nul 2>&1
netsh int tcp set global rss=enabled >nul 2>&1
netsh int tcp set global ecncapability=disabled >nul 2>&1
netsh int tcp set global timestamps=disabled >nul 2>&1

echo [7/10] ล้างไฟล์ temp...
del /f /s /q "%temp%\*" >nul 2>&1
del /f /s /q "C:\Windows\Temp\*" >nul 2>&1

echo [8/10] ปิด Game DVR background capture ผ่าน registry...
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul

echo [9/10] ลด visual effects บางส่วน...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul

echo [10/10] ล้าง DNS cache...
ipconfig /flushdns >nul

echo.
echo =========================================
echo  DONE
echo =========================================
echo แนะนำให้รีสตาร์ต 1 รอบก่อนใช้งานจริง
pause
exit /b
