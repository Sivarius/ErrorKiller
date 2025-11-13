@echo off
setlocal enabledelayedexpansion
color 0
mode con cols=100 lines=40
title   ERROR KILLER - Elimination Tool

:: ================= INITIAL CONFIGURATION =================
set LOGFILE=%TEMP%\error_killer_%date:~-4,4%%date:~-7,2%%date:~-10,2%.txt
call :log "Session started: %date% %time%"

:menu
cls
echo.
echo  ================================================================
echo               ERROR KILLER - MAIN MENU
echo  ================================================================
echo.
echo  [1]  Restart system               - Force reboot
echo  [2]  DNS cleanup                   - Purge DNS cache
echo  [3]  Network diagnostics           - Full sweep
echo  [4]  Print fix                     - Eliminate errors
echo  [5]  Manage printers               - Control panel
echo  [6]  Windows repair                - System repairs
echo  [7]  Security                      - Advanced protection
echo  [8]  Network reset                 - Reset settings
echo  [9]  Registry backup               - Export registry hives
echo  [10] Process monitor               - Active management
echo  [11] Full diagnostics              - Complete scanner
echo  [12] Power optimization            - Performance tuning
echo  [13] Disable apps                  - Turn off unnecessary apps/services
echo  [14] System audit                  - Comprehensive analysis
echo.
echo  [S]  System settings               - Advanced utilities
echo  [0]  Exit
echo  ================================================================
echo.
set /p opcao= Command: 

if /i "%opcao%"=="1" goto reiniciar
if /i "%opcao%"=="2" goto flushdns
if /i "%opcao%"=="3" goto ipall
if /i "%opcao%"=="4" goto correcao_impressao
if /i "%opcao%"=="5" goto impressoras
if /i "%opcao%"=="6" goto correcao_windows
if /i "%opcao%"=="7" goto seguranca
if /i "%opcao%"=="8" goto resetnet
if /i "%opcao%"=="9" goto backupreg
if /i "%opcao%"=="10" goto processos
if /i "%opcao%"=="11" goto diagnostico
if /i "%opcao%"=="12" goto energia
if /i "%opcao%"=="13" goto desativarapps
if /i "%opcao%"=="14" goto auditoria
if /i "%opcao%"=="S" goto configuracoes
if /i "%opcao%"=="0" goto fim

echo.
echo  [ERROR] Invalid option! Use only the listed options.
timeout /t 2 >nul
goto menu

:: ================== PRINT ISSUE FIXES ==================
:correcao_impressao
:correcao_impressao_restart
cls
echo.
echo  ==================================
echo  [ PRINT ISSUE FIXES ]
echo  ==================================
echo.
echo  [1] Error 0x0000011b (RPC)
echo       - Fixes RPC communication with printers
echo.
echo  [2] Error 0x00000bcb (Drivers)
echo       - Resolves driver installation issues
echo.
echo  [3] Error 0x00000709 (NamedPipe)
echo       - Fixes communication protocol issue
echo.
echo  [4] Restart Print Spooler service
echo       - Restarts the print spooler
echo.
echo  [5] Apply all fixes
echo       - Runs all fixes above
echo.
echo  [0] Back to main menu
echo  ==================================
echo.
set /p escolha= Select a fix: 

if "%escolha%"=="1" goto erro11b
if "%escolha%"=="2" goto erro0bcb
if "%escolha%"=="3" goto erro709
if "%escolha%"=="4" goto reiniciar_spooler
if "%escolha%"=="5" goto todos_reparos_impressao
if "%escolha%"=="0" goto menu
goto correcao_impressao_restart

:reiniciar_spooler
net stop spooler /y
net start spooler
echo Print Spooler restarted successfully!
call :log "Print Spooler restarted"
pause
goto correcao_impressao_restart

:todos_reparos_impressao
cls
echo [*] APPLYING ALL PRINT FIXES...
echo.

echo [1/4] Fixing error 0x0000011b (RPC)...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Print" /v RpcAuthnLevelPrivacyEnabled /t REG_DWORD /d 0 /f >nul
echo [+] Error 0x0000011b fixed!
timeout /t 1 >nul

echo [2/4] Fixing error 0x00000bcb (Drivers)...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint" /v RestrictDriverInstallationToAdministrators /t REG_DWORD /d 0 /f >nul
echo [+] Error 0x00000bcb fixed!
timeout /t 1 >nul

echo [3/4] Fixing error 0x00000709 (NamedPipe)...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Printers\RPC" /v RpcUseNamedPipeProtocol /t REG_DWORD /d 1 /f >nul
echo [+] Error 0x00000709 fixed!
timeout /t 1 >nul

echo [4/4] Restarting Print Spooler...
net stop spooler /y >nul
net start spooler >nul
echo [+] Print Spooler restarted successfully!

call :log "All print fixes applied"
echo.
echo [*] ALL PRINT FIXES APPLIED SUCCESSFULLY!
echo.
echo [1] Back to print fixes menu
echo [2] Back to main menu
echo.
set /p opcao_final= Select an option: 

if "%opcao_final%"=="1" goto correcao_impressao_restart
if "%opcao_final%"=="2" goto menu
goto correcao_impressao_restart

:erro11b
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Print" /v RpcAuthnLevelPrivacyEnabled /t REG_DWORD /d 0 /f >nul
echo Error 0x0000011b fixed!
pause
goto correcao_impressao_restart

:erro0bcb
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint" /v RestrictDriverInstallationToAdministrators /t REG_DWORD /d 0 /f >nul
echo Error 0x00000bcb fixed!
pause
goto correcao_impressao_restart

:erro709
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Printers\RPC" /v RpcUseNamedPipeProtocol /t REG_DWORD /d 1 /f >nul
echo Error 0x00000709 fixed!
pause
goto correcao_impressao_restart

:: ================== WINDOWS REPAIR ==================
:correcao_windows
:correcao_windows_restart
cls
echo.
echo  ==================================
echo  [ WINDOWS REPAIR ]
echo  ==================================
echo.
echo  [1] Repair system files (SFC)
echo       - Checks and fixes corrupted system files
echo.
echo  [2] Repair Windows image (DISM)
echo       - Repairs the Windows image
echo.
echo  [3] Check disk integrity
echo       - Checks drive file system for errors
echo.
echo  [4] Repair Windows installation
echo       - Opens Windows Update settings
echo.
echo  [0] Back to main menu
echo  ==================================
echo.
set /p escolha= Select a repair: 

if "%escolha%"=="1" (
    echo Running SFC /scannow...
    sfc /scannow
    call :log "SFC executed"
    pause
    goto correcao_windows_restart
)
if "%escolha%"=="2" (
    echo Running DISM...
    DISM /Online /Cleanup-Image /RestoreHealth
    call :log "DISM executed"
    pause
    goto correcao_windows_restart
)
if "%escolha%"=="3" (
    echo Checking disks...
    chkdsk /scan
    call :log "Disk check executed"
    pause
    goto correcao_windows_restart
)
if "%escolha%"=="4" (
    echo Opening installation repair settings...
    start ms-settings:windowsupdate
    call :log "Installation repair started"
    timeout /t 3 >nul
    goto correcao_windows_restart
)
if "%escolha%"=="0" goto menu
goto correcao_windows_restart

:: ================== SECURITY AND PROTECTION ==================
:seguranca
:seguranca_restart
cls
echo.
echo  ==================================
echo  [ SECURITY AND PROTECTION ]
echo  ==================================
echo.
echo  [1] Check Windows Updates
echo       - Opens Windows Update settings
echo.
echo  [2] Check Firewall settings
echo       - Opens the Firewall control panel
echo.
echo  [3] Quick security audit
echo       - Checks essential security settings
echo.
echo  [4] Clear activity traces
echo       - Removes history and telemetry data
echo.
echo  [0] Back to main menu
echo  ==================================
echo.
set /p escolha= Select an action: 

if "%escolha%"=="1" (
    start ms-settings:windowsupdate
    call :log "Windows Update settings opened"
    timeout /t 2 >nul
    goto seguranca_restart
)

if "%escolha%"=="2" (
    start firewall.cpl
    call :log "Firewall settings opened"
    timeout /t 2 >nul
    goto seguranca_restart
)

if "%escolha%"=="3" (
    mode con: cols=120 lines=999
    echo [*] RUNNING SECURITY AUDIT...
    echo.
    
    echo [1/4] Checking pending updates...
    wmic qfe list brief /format:list
    echo.
    
    echo [2/4] Checking firewall status...
    netsh advfirewall show allprofiles
    echo.
    
    echo [3/4] Checking security services...
    sc query WinDefend
    sc query MpsSvc
    echo.
    
    echo [4/4] Checking execution policies...
    powershell -command "Get-ExecutionPolicy -List"
    
    call :log "Security audit executed"
    echo.
    echo [+] Audit completed! Review results above.
    pause
    goto seguranca_restart
)


if "%escolha%"=="4" (
    cls
    echo [*] CLEARING ACTIVITY TRACES...
    echo.
    
    echo [1/3] Clearing Windows history...
    del /f /s /q "%localappdata%\Microsoft\Windows\History\*" >nul 2>&1
    del /f /s /q "%localappdata%\Microsoft\Windows\Recent\*" >nul 2>&1
    
    echo [2/3] Clearing telemetry cache...
    del /f /s /q "%programdata%\Microsoft\Diagnosis\*" >nul 2>&1
    del /f /s /q "%windir%\Temp\*" >nul 2>&1
    
    echo [3/3] Resetting tracking services...
    sc stop DiagTrack >nul 2>&1
    sc stop dmwappushservice >nul 2>&1
    
    call :log "Activity traces cleared"
    echo.
    echo [+] Cleanup completed successfully!
    pause
    goto seguranca_restart
)

if "%escolha%"=="0" goto menu

echo.
echo  [ERROR] Invalid option! Use only the listed options.
timeout /t 2 >nul
goto seguranca_restart

:: ================== QUICK FUNCTIONS ==================
:flushdns
cls
echo [*] Running DNS cleanup...
ipconfig /flushdns >nul
ipconfig /registerdns >nul
echo [+] DNS cache flushed and records updated!
pause
goto menu

:ipall
cls
echo [*] COLLECTING NETWORK INFORMATION...
echo Please wait while a complete report is prepared...

:: Generate temporary file with all information
ipconfig /all > "%TEMP%\network_info.txt"
arp -a >> "%TEMP%\network_info.txt"
echo. >> "%TEMP%\network_info.txt"
echo === ROUTES === >> "%TEMP%\network_info.txt"
route print >> "%TEMP%\network_info.txt"

:: Open in Notepad
start notepad "%TEMP%\network_info.txt"
goto menu

:impressoras
start control printers
echo [*] Printers panel opened!
pause
goto menu

:resetnet
cls
echo [*] Resetting network settings...
netsh winsock reset >nul
netsh int ip reset >nul
ipconfig /release >nul
ipconfig /renew >nul
echo [+] Network reset successfully!
pause
goto menu

:: ================== FULL DIAGNOSTICS ==================
:diagnostico
:diagnostico_restart
cls
echo.
echo  ==================================
echo  [ FULL SYSTEM DIAGNOSTICS ]
echo  ==================================
echo.
echo  [1] Check system files (SFC)
echo       - Fix corrupted Windows files
echo.
echo  [2] Check Windows image (DISM)
echo       - Repair system image
echo.
echo  [3] Check disk integrity (CHKDSK)
echo       - Analyze drive for errors
echo.
echo  [4] FULL cleanup of temporary files
echo       - Remove junk from TEMP, Prefetch, SoftwareDistribution, etc.
echo.
echo  [5] Check and install updates
echo       - Uses PSWindowsUpdate to install updates
echo.
echo  [6] Network analysis
echo       - Check connections and configuration
echo.
echo  [7] Check problematic drivers
echo       - List drivers with issues
echo.
echo  [8] Run ALL diagnostics
echo       - Perform everything above
echo.
echo  [0] Back to main menu
echo  ==================================
echo.
set /p escolha= Select a diagnostic: 

if "%escolha%"=="1" goto diag_sfc
if "%escolha%"=="2" goto diag_dism
if "%escolha%"=="3" goto diag_chkdsk
if "%escolha%"=="4" goto diag_limpeza
if "%escolha%"=="5" goto diag_update
if "%escolha%"=="6" goto diag_rede
if "%escolha%"=="7" goto diag_drivers
if "%escolha%"=="8" goto diag_todos
if "%escolha%"=="0" goto menu

echo.
echo  [ERROR] Invalid option! Enter only numbers 0 to 8.
timeout /t 2 >nul
goto diagnostico_restart

:diag_sfc
cls
echo [*] Running SFC /scannow...
sfc /scannow
call :log "SFC executed"
pause
goto diagnostico_restart

:diag_dism
cls
echo [*] Running DISM...
DISM /Online /Cleanup-Image /RestoreHealth
call :log "DISM executed"
pause
goto diagnostico_restart

:diag_chkdsk
cls
echo [*] Checking disks (CHKDSK)...
chkdsk /scan
call :log "Disk check executed"
pause
goto diagnostico_restart

:diag_limpeza
cls
echo [*] FULL CLEANUP OF TEMPORARY FILES...
call :clean_temp
call :log "Temporary files cleanup performed"
echo [+] CLEANUP COMPLETED SUCCESSFULLY!
pause
goto diagnostico_restart

:diag_update
cls
echo [*] CHECKING AND INSTALLING UPDATES...
powershell -command "Install-Module PSWindowsUpdate -Force -Confirm:$false; Get-WindowsUpdate -Install -AcceptAll -IgnoreReboot"
call :log "Windows Updates processed"
pause
goto diagnostico_restart

:diag_rede
cls
echo [*] FULL NETWORK ANALYSIS...
ipconfig /all
netsh winsock reset
ipconfig /flushdns
call :log "Network diagnostic executed"
pause
goto diagnostico_restart

:diag_drivers
cls
echo [*] CHECKING PROBLEMATIC DRIVERS...
verifier /query
call :log "Driver verification"
pause
goto diagnostico_restart

:diag_todos
cls
echo [*] STARTING FULL DIAGNOSTIC...
echo This process may take several minutes!
echo.

echo [1/7] SFC (system files)...
sfc /scannow
call :log "SFC executed"
pause

echo [2/7] DISM (Windows image)...
DISM /Online /Cleanup-Image /RestoreHealth
call :log "DISM executed"
pause

echo [3/7] CHKDSK (disks)...
chkdsk /scan
call :log "CHKDSK executed"
pause

echo [4/7] Temporary files cleanup...
call :clean_temp
call :log "Cleanup executed"
pause

echo [5/7] Windows Update...
powershell -command "Install-Module PSWindowsUpdate -Force -Confirm:$false; Get-WindowsUpdate -Install -AcceptAll -IgnoreReboot"
call :log "Updates processed"
pause

echo [6/7] Network...
ipconfig /all
netsh winsock reset
ipconfig /flushdns
call :log "Network diagnostic"
pause

echo [7/7] Drivers...
verifier /query
call :log "Driver verification"
pause

echo.
echo [*] ALL DIAGNOSTICS COMPLETED!
call :log "Full diagnostic finished"
pause
goto diagnostico_restart

:: ================== OTHER FUNCTIONS ==================
:energia
cls
echo [*] Configuring power optimization...
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul
powercfg /change standby-timeout-ac 0 >nul
powercfg /change standby-timeout-dc 0 >nul
echo [+] Applied settings:
powercfg /getactivescheme
pause
goto menu

:desativarapps
cls
echo [*] Disabling unnecessary applications/services...
echo.

:: Disable Windows components
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f >nul
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul

:: Additional tweaks
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoCDBurning /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableActivityFeed /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v PublishUserActivities /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v DisabledByGroupPolicy /t REG_DWORD /d 1 /f >nul

:: Disable unnecessary services
sc config "DiagTrack" start= disabled >nul
sc config "dmwappushservice" start= disabled >nul
sc config "lfsvc" start= disabled >nul

echo [+] Disabled apps and services:
echo - Xbox Game Bar
echo - Cortana
echo - Windows Telemetry
echo - Windows Consumer Features
echo - CD/DVD Burning
echo - News and Interests
echo - Timeline/Activities
echo - Publish User Activities
echo - Advertising ID
echo - Service: DiagTrack (Telemetry)
echo - Service: dmwappushservice (Push)
echo - Service: lfsvc (Geolocation)
echo.

pause
goto menu

:auditoria
:auditoria_restart
cls
echo.
echo  ==================================
echo  [ SYSTEM AUDIT ]
echo  ==================================
echo.
echo  [1] View recent system errors
echo       - Shows latest system errors
echo.
echo  [2] View security events
echo       - Displays recent security events
echo.
echo  [3] Performance report
echo       - Generates a performance report
echo.
echo  [4] Check problematic drivers
echo       - Lists drivers with issues
echo.
echo  [0] Back to main menu
echo  ==================================
echo.
set /p escolha= Select an audit: 

if "%escolha%"=="1" goto errossistema
if "%escolha%"=="2" goto eventos_seguranca
if "%escolha%"=="3" goto relatorio_desempenho
if "%escolha%"=="4" goto drivers_problematicos
if "%escolha%"=="0" goto menu
goto auditoria_restart

:errossistema
cls
echo [*] Latest system errors:
echo ----------------------------------
wevtutil qe System /c:5 /f:text | findstr /i /C:"error" /C:"fail" /C:"critical"
echo ----------------------------------
pause
goto auditoria_restart

:eventos_seguranca
eventvwr /c:Security /f:"*[System[(Level=1 or Level=2)]]" /l:30
pause
goto auditoria_restart

:auditoria_restart
echo Returning to audit menu...
pause
goto auditoria

:relatorio_desempenho
start perfmon /report
echo [*] Performance report started!
timeout /t 2 >nul
goto auditoria_restart

:drivers_problematicos
verifier /query
pause
goto auditoria_restart

:: ================== SYSTEM SETTINGS ==================
:configuracoes
:configuracoes_restart
cls
echo.
echo  ==================================
echo  [ SYSTEM SETTINGS ]
echo  ==================================
echo.
echo  [1] Task Manager
echo       - Opens Task Manager
echo.
echo  [2] Windows Settings
echo       - Opens Windows Settings
echo.
echo  [3] Control Panel
echo       - Opens classic Control Panel
echo.
echo  [4] Device Manager
echo       - Opens Device Manager
echo.
echo  [5] Disk Management
echo       - Opens Disk Management
echo.
echo  [0] Back to main menu
echo  ==================================
echo.
set /p escolha= Select a tool: 

if "%escolha%"=="1" start taskmgr
if "%escolha%"=="2" start ms-settings:
if "%escolha%"=="3" start control
if "%escolha%"=="4" start devmgmt.msc
if "%escolha%"=="5" start diskmgmt.msc
if "%escolha%"=="0" goto menu
goto configuracoes_restart


:: ================== REGISTRY BACKUP ==================
:backupreg
set BACKUP_DIR=C:\RegBackup_%date:~-4,4%%date:~-7,2%%date:~-10,2%
mkdir "%BACKUP_DIR%" >nul 2>&1
reg export HKLM "%BACKUP_DIR%\HKLM.reg" /y
reg export HKCU "%BACKUP_DIR%\HKCU.reg" /y
reg export HKCR "%BACKUP_DIR%\HKCR.reg" /y
echo Registry backup saved to: %BACKUP_DIR%
call :log "Registry backup completed"
pause
goto menu

:: ================== PROCESS MONITOR ==================
:processos
:processos_restart
cls
echo.
echo  ==================================
echo  [ ADVANCED PROCESS MONITOR ]
echo  ==================================
echo.
echo  [1] Processes consuming CPU
echo       - List processes by CPU usage
echo.
echo  [2] Processes consuming memory
echo       - List processes by memory usage
echo.
echo  [3] Network processes
echo       - Show active network connections
echo.
echo  [4] Running services
echo       - List all active services
echo.
echo  [5] Terminate process
echo       - Kill a process by PID
echo.
echo  [0] Back to main menu
echo  ==================================
echo.
set /p escolha= Select an option: 

if "%escolha%"=="1" (
    tasklist
    call :log "Processes listed"
    pause
    goto processos_restart
)
if "%escolha%"=="2" (
    tasklist
    call :log "Processes listed"
    pause
    goto processos_restart
)
if "%escolha%"=="3" (
    netstat -ano | findstr "ESTABLISHED"
    call :log "Network processes listed"
    pause
    goto processos_restart
)
if "%escolha%"=="4" (
    tasklist /svc
    call :log "Services listed"
    pause
    goto processos_restart
)
if "%escolha%"=="5" (
    set /p pid= Enter the PID of the process to terminate: 
    taskkill /f /pid %pid%
    call :log "Process terminated: PID %pid%"
    pause
    goto processos_restart
)
if "%escolha%"=="0" goto menu
goto processos_restart

:: ================== SUPPORT FUNCTIONS ==================
:reiniciar
call :log "Rebooting system"
shutdown /r /t 5 /c "Restart initiated by Support Tool"
echo The system will restart in 5 seconds...
timeout /t 5
goto :eof

:clean_temp
echo Cleaning: %temp%
del /f /s /q "%temp%\*" >nul 2>&1
echo Cleaning: C:\Windows\Temp
del /f /s /q "C:\Windows\Temp\*" >nul 2>&1
echo Cleaning: C:\Windows\Prefetch
del /f /s /q "C:\Windows\Prefetch\*" >nul 2>&1
echo Cleaning: C:\Windows\SoftwareDistribution\Download
del /f /s /q "%SystemRoot%\SoftwareDistribution\Download\*" >nul 2>&1
echo Cleaning: C:\$Windows.~BT
del /f /s /q "C:\$Windows.~BT\*" >nul 2>&1
goto :eof

:log
echo [%date% %time%] %~1 >> "%LOGFILE%"
goto :eof

:fim
call :log "Session ended"
exit
