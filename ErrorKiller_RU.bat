@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
color 0
mode con: cols=120 lines=3000
title   ERROR KILLER - утилита устранения ошибок

:: ================= НАЧАЛЬНАЯ КОНФИГУРАЦИЯ =================
set LOGFILE=%TEMP%\error_killer_%date:~-4,4%%date:~-7,2%%date:~-10,2%.txt
call :log "Сеанс запущен: %date% %time%"

:menu
cls
echo.
echo  ================================================================
echo                   ERROR KILLER - ГЛАВНОЕ МЕНЮ
echo  ================================================================
echo.
echo  [1]  Работа с 1С                   - Очистка кэша
echo  [2]  Очистка DNS                   - Сброс кэша DNS
echo  [3]  Диагностика сети              - Полный комплекс
echo  [4]  Исправление печати            - Устранение ошибок
echo  [5]  Управление принтерами         - Панель управления
echo  [6]  Восстановление Windows        - Системные ремонты
echo  [7]  Безопасность                  - Расширенная защита
echo  [8]  Сброс сети                    - Сброс настроек
echo  [9]  Резервная копия реестра       - Экспорт ветвей
echo  [10] Монитор процессов             - Активное управление
echo  [11] Полная диагностика            - Комплексная проверка
echo  [12] Оптимизация питания           - Режим производительности
echo  [13] Отключение приложений         - Ненужные приложения/службы
echo  [14] Аудит системы                 - Всесторонний анализ
echo.
echo  [R]  Перезагрузка системы          - Принудительный рестарт
echo  [S]  Системные настройки           - Дополнительные утилиты
echo  [0]  Выход
echo  ================================================================
echo.
set /p opcao= Команда: 

if /i "%opcao%"=="1" goto onec
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
if /i "%opcao%"=="R" goto reiniciar
if /i "%opcao%"=="S" goto configuracoes
if /i "%opcao%"=="0" goto fim

echo.
echo  [ОШИБКА] Неверная опция! Используйте варианты из списка.
timeout /t 2 >nul
goto menu

:: ================== ИСПРАВЛЕНИЯ ПЕЧАТИ ==================
:correcao_impressao
:correcao_impressao_restart
cls
echo.
echo  ==================================
echo  [ ИСПРАВЛЕНИЕ ПРОБЛЕМ С ПЕЧАТЬЮ ]
echo  ==================================
echo.
echo  [1] Ошибка 0x0000011b (RPC)
echo       - Исправляет RPC-взаимодействие с принтерами
echo.
echo  [2] Ошибка 0x00000bcb (Драйверы)
echo       - Устраняет проблемы установки драйверов
echo.
echo  [3] Ошибка 0x00000709 (NamedPipe)
echo       - Исправляет проблему протокола связи
echo.
echo  [4] Перезапуск службы Диспетчер печати
echo       - Перезапускает Print Spooler
echo.
echo  [5] Применить все исправления
echo       - Выполнить все исправления выше
echo.
echo  [6] Очистка очереди печати
echo       - Очистить папку очереди и перезапустить службы
echo.
echo  [0] Назад в главное меню
echo  ==================================
echo.
set /p escolha= Выберите исправление: 

if "%escolha%"=="1" goto erro11b
if "%escolha%"=="2" goto erro0bcb
if "%escolha%"=="3" goto erro709
if "%escolha%"=="4" goto reiniciar_spooler
if "%escolha%"=="5" goto todos_reparos_impressao
if "%escolha%"=="6" goto limpar_fila_impressao
if "%escolha%"=="0" goto menu
goto correcao_impressao_restart

:reiniciar_spooler
net stop spooler /y
net start spooler
echo Служба Диспетчер печати успешно перезапущена!
call :log "Перезапущен Print Spooler"
pause
goto correcao_impressao_restart

:limpar_fila_impressao
net stop "LPDSVC"
net stop "spooler"
TIMEOUT /T 2
rmdir /S /Q "C:\Windows\System32\spool\PRINTERS"
TIMEOUT /T 1
net start "spooler"
net start "LPDSVC"
echo Очередь печати очищена!
call :log "Очищена очередь печати"
pause
goto correcao_impressao_restart

:todos_reparos_impressao
cls
echo [*] ПРИМЕНЕНИЕ ВСЕХ ИСПРАВЛЕНИЙ ПЕЧАТИ...
echo.

echo [1/5] Исправление ошибки 0x0000011b (RPC)...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Print" /v RpcAuthnLevelPrivacyEnabled /t REG_DWORD /d 0 /f >nul
echo [+] Ошибка 0x0000011b исправлена!
timeout /t 1 >nul

echo [2/5] Исправление ошибки 0x00000bcb (Драйверы)...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint" /v RestrictDriverInstallationToAdministrators /t REG_DWORD /d 0 /f >nul
echo [+] Ошибка 0x00000bcb исправлена!
timeout /t 1 >nul

echo [3/5] Исправление ошибки 0x00000709 (NamedPipe)...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Printers\RPC" /v RpcUseNamedPipeProtocol /t REG_DWORD /d 1 /f >nul
echo [+] Ошибка 0x00000709 исправлена!
timeout /t 1 >nul

echo [4/5] Очистка очереди печати...
net stop "LPDSVC" >nul 2>&1
net stop "spooler" >nul 2>&1
TIMEOUT /T 2 >nul
rmdir /S /Q "C:\Windows\System32\spool\PRINTERS"
TIMEOUT /T 1 >nul
net start "spooler" >nul 2>&1
net start "LPDSVC" >nul 2>&1
echo [+] Очередь печати очищена!

echo [5/5] Перезапуск Диспетчера печати...
net stop spooler /y >nul
net start spooler >nul
echo [+] Диспетчер печати перезапущен!

call :log "Применены все исправления печати"
echo.
echo [*] ВСЕ ИСПРАВЛЕНИЯ ДЛЯ ПЕЧАТИ УСПЕШНО ПРИМЕНЕНЫ!
echo.
echo [1] Вернуться в меню печати
echo [2] Вернуться в главное меню
echo.
set /p opcao_final= Выберите вариант: 

if "%opcao_final%"=="1" goto correcao_impressao_restart
if "%opcao_final%"=="2" goto menu
goto correcao_impressao_restart

:erro11b
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Print" /v RpcAuthnLevelPrivacyEnabled /t REG_DWORD /d 0 /f >nul
echo Ошибка 0x0000011b исправлена!
pause
goto correcao_impressao_restart

:erro0bcb
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint" /v RestrictDriverInstallationToAdministrators /t REG_DWORD /d 0 /f >nul
echo Ошибка 0x00000bcb исправлена!
pause
goto correcao_impressao_restart

:erro709
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Printers\RPC" /v RpcUseNamedPipeProtocol /t REG_DWORD /d 1 /f >nul
echo Ошибка 0x00000709 исправлена!
pause
goto correcao_impressao_restart

:: ================== ВОССТАНОВЛЕНИЕ WINDOWS ==================
:correcao_windows
:correcao_windows_restart
cls
echo.
echo  ==================================
echo  [ ВОССТАНОВЛЕНИЕ WINDOWS ]
echo  ==================================
echo.
echo  [1] Восстановление системных файлов (SFC)
echo       - Проверка и исправление поврежденных файлов
echo.
echo  [2] Восстановление образа Windows (DISM)
echo       - Ремонт образа Windows
echo.
echo  [3] Проверка целостности диска
echo       - Проверка файловой системы на ошибки
echo.
echo  [4] Восстановление установки Windows
echo       - Открыть настройки Центра обновления
echo.
echo  [0] Назад в главное меню
echo  ==================================
echo.
set /p escolha= Выберите действие: 

if "%escolha%"=="1" (
    echo Запуск SFC /scannow...
    sfc /scannow
    call :log "SFC выполнен"
    pause
    goto correcao_windows_restart
)
if "%escolha%"=="2" (
    echo Запуск DISM...
    DISM /Online /Cleanup-Image /RestoreHealth
    call :log "DISM выполнен"
    pause
    goto correcao_windows_restart
)
if "%escolha%"=="3" (
    echo Проверка дисков...
    chkdsk /scan
    call :log "Проверка диска выполнена"
    pause
    goto correcao_windows_restart
)
if "%escolha%"=="4" (
    echo Открытие настроек восстановления установки...
    start ms-settings:windowsupdate
    call :log "Начато восстановление установки"
    timeout /t 3 >nul
    goto correcao_windows_restart
)
if "%escolha%"=="0" goto menu
goto correcao_windows_restart

:: ================== БЕЗОПАСНОСТЬ ==================
:seguranca
:seguranca_restart
cls
echo.
echo  ==================================
echo  [ БЕЗОПАСНОСТЬ И ЗАЩИТА ]
echo  ==================================
echo.
echo  [1] Проверить обновления Windows
echo       - Открыть настройки Центра обновления
echo.
echo  [2] Проверить настройки Брандмауэра
echo       - Открыть панель управления Брандмауэром
echo.
echo  [3] Быстрый аудит безопасности
echo       - Проверка ключевых параметров безопасности
echo.
echo  [4] Очистить следы активности
echo       - Удаление истории и телеметрии
echo.
echo  [0] Назад в главное меню
echo  ==================================
echo.
set /p escolha= Выберите действие: 

if "%escolha%"=="1" (
    start ms-settings:windowsupdate
    call :log "Открыты настройки Windows Update"
    timeout /t 2 >nul
    goto seguranca_restart
)

if "%escolha%"=="2" (
    start firewall.cpl
    call :log "Открыты настройки Брандмауэра"
    timeout /t 2 >nul
    goto seguranca_restart
)

if "%escolha%"=="3" (
    mode con: cols=120 lines=999
    echo [*] ЗАПУСК АУДИТА БЕЗОПАСНОСТИ...
    echo.
    
    echo [1/4] Проверка установленных обновлений...
    wmic qfe list brief /format:list | more
    echo.
    
    echo [2/4] Проверка состояния брандмауэра...
    netsh advfirewall show allprofiles | more
    echo.
    
    echo [3/4] Проверка служб безопасности...
    sc query WinDefend
    sc query MpsSvc
    echo.
    
    echo [4/4] Проверка Execution Policy...
    powershell -command "Get-ExecutionPolicy -List"
    
    call :log "Выполнен аудит безопасности"
    echo.
    echo [+] Аудит завершён! Просмотрите результаты выше.
    pause
    goto seguranca_restart
)


if "%escolha%"=="4" (
    cls
    echo [*] ОЧИСТКА СЛЕДОВ АКТИВНОСТИ...
    echo.
    
    echo [1/3] Очистка истории Windows...
    del /f /s /q "%localappdata%\Microsoft\Windows\History\*" >nul 2>&1
    del /f /s /q "%localappdata%\Microsoft\Windows\Recent\*" >nul 2>&1
    
    echo [2/3] Очистка кэша телеметрии...
    del /f /s /q "%programdata%\Microsoft\Diagnosis\*" >nul 2>&1
    del /f /s /q "%windir%\Temp\*" >nul 2>&1
    
    echo [3/3] Остановка трекинг-служб...
    sc stop DiagTrack >nul 2>&1
    sc stop dmwappushservice >nul 2>&1
    
    call :log "Следы активности очищены"
    echo.
    echo [+] Очистка успешно завершена!
    pause
    goto seguranca_restart
)

if "%escolha%"=="0" goto menu

echo.
echo  [ОШИБКА] Неверная опция! Используйте варианты из списка.
timeout /t 2 >nul
goto seguranca_restart

:: ================== БЫСТРЫЕ ФУНКЦИИ ==================
:flushdns
cls
echo [*] Очистка DNS...
ipconfig /flushdns >nul
ipconfig /registerdns >nul
echo [+] Кэш DNS очищен и записи обновлены!
pause
goto menu

:ipall
cls
echo [*] СБОР СЕТЕВОЙ ИНФОРМАЦИИ...
echo Пожалуйста, подождите — формируется полный отчёт...

set "OUTPUT=%~dp0Network_Report.txt"
powershell -NoProfile -Command "cmd /c ipconfig /all | Out-File -FilePath '%OUTPUT%' -Encoding UTF8"
powershell -NoProfile -Command "cmd /c arp -a | Out-File -FilePath '%OUTPUT%' -Encoding UTF8 -Append"
powershell -NoProfile -Command "Add-Content -Path '%OUTPUT%' -Value ''"
powershell -NoProfile -Command "Add-Content -Path '%OUTPUT%' -Value '=== ROUTES ==='"
powershell -NoProfile -Command "cmd /c route print | Out-File -FilePath '%OUTPUT%' -Encoding UTF8 -Append"

start notepad "%OUTPUT%"
echo Сохранено в: %OUTPUT%
pause
goto menu

:impressoras
start control printers
echo [*] Открыта панель принтеров!
pause
goto menu

:resetnet
cls
echo [*] Сброс сетевых настроек...
netsh winsock reset >nul
netsh int ip reset >nul
ipconfig /release >nul
ipconfig /renew >nul
echo [+] Сетевые настройки сброшены!
pause
goto menu

:: ================== ПОЛНАЯ ДИАГНОСТИКА ==================
:diagnostico
:diagnostico_restart
cls
echo.
echo  ==================================
echo  [ ПОЛНАЯ ДИАГНОСТИКА СИСТЕМЫ ]
echo  ==================================
echo.
echo  [1] Проверить системные файлы (SFC)
echo       - Исправление повреждённых файлов Windows
echo.
echo  [2] Проверить образ Windows (DISM)
echo       - Восстановление системного образа
echo.
echo  [3] Проверить целостность диска (CHKDSK)
echo       - Анализ диска на ошибки
echo.
echo  [4] ПОЛНАЯ очистка временных файлов
echo       - Удаление мусора из TEMP, Prefetch, SoftwareDistribution и др.
echo.
echo  [5] Проверить и установить обновления
echo       - Модуль PSWindowsUpdate (при необходимости)
echo.
echo  [6] Анализ сети
echo       - Проверка соединений и конфигурации
echo.
echo  [7] Проверка проблемных драйверов
echo       - Список драйверов с проблемами
echo.
echo  [8] Выполнить ВСЕ проверки
echo       - Последовательно выполнить всё выше
echo.
echo  [0] Назад в главное меню
echo  ==================================
echo.
set /p escolha= Выберите проверку: 

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
echo  [ОШИБКА] Неверная опция! Введите число от 0 до 8.
timeout /t 2 >nul
goto diagnostico_restart

:diag_sfc
cls
echo [*] Запуск SFC /scannow...
sfc /scannow
call :log "SFC выполнен"
pause
goto diagnostico_restart

:diag_dism
cls
echo [*] Запуск DISM...
DISM /Online /Cleanup-Image /RestoreHealth
call :log "DISM выполнен"
pause
goto diagnostico_restart

:diag_chkdsk
cls
echo [*] Проверка дисков (CHKDSK)...
chkdsk /scan
call :log "CHKDSK выполнен"
pause
goto diagnostico_restart

:diag_limpeza
cls
echo [*] ПОЛНАЯ ОЧИСТКА ВРЕМЕННЫХ ФАЙЛОВ...
call :clean_temp
call :log "Очищены временные файлы"
echo [+] ОЧИСТКА УСПЕШНО ЗАВЕРШЕНА!
pause
goto diagnostico_restart

:diag_update
cls
echo [*] ПРОВЕРКА И УСТАНОВКА ОБНОВЛЕНИЙ...
powershell -command "Install-Module PSWindowsUpdate -Force -Confirm:$false; Get-WindowsUpdate -Install -AcceptAll -IgnoreReboot"
call :log "Обновления Windows обработаны"
pause
goto diagnostico_restart

:diag_rede
cls
echo [*] ПОЛНЫЙ АНАЛИЗ СЕТИ...
    ipconfig /all | more
netsh winsock reset
ipconfig /flushdns
call :log "Выполнена диагностика сети"
pause
goto diagnostico_restart

:diag_drivers
cls
echo [*] ПРОВЕРКА ПРОБЛЕМНЫХ ДРАЙВЕРОВ...
verifier /query
call :log "Проверка драйверов"
pause
goto diagnostico_restart

:diag_todos
cls
echo [*] СТАРТ ПОЛНОЙ ДИАГНОСТИКИ...
echo Процесс может занять несколько минут!
echo.

echo [1/7] SFC (системные файлы)...
sfc /scannow
call :log "SFC выполнен"
pause

echo [2/7] DISM (образ Windows)...
DISM /Online /Cleanup-Image /RestoreHealth
call :log "DISM выполнен"
pause

echo [3/7] CHKDSK (диски)...
chkdsk /scan
call :log "CHKDSK выполнен"
pause

echo [4/7] Очистка временных файлов...
call :clean_temp
call :log "Очистка выполнена"
pause

echo [5/7] Центр обновления Windows...
powershell -command "Install-Module PSWindowsUpdate -Force -Confirm:$false; Get-WindowsUpdate -Install -AcceptAll -IgnoreReboot"
call :log "Обновления обработаны"
pause

echo [6/7] Сеть...
ipconfig /all | more
netsh winsock reset
ipconfig /flushdns
call :log "Диагностика сети"
pause

echo [7/7] Драйверы...
verifier /query
call :log "Проверка драйверов"
pause

echo.
echo [*] ВСЕ ПРОВЕРКИ ЗАВЕРШЕНЫ!
call :log "Полная диагностика завершена"
pause
goto diagnostico_restart

:: ================== РАБОТА С 1С ==================
:onec
:onec_restart
cls
echo.
echo  ==================================
echo  [ РАБОТА С 1С ]
echo  ==================================
echo.
echo  [1] Очистка локального кэша пользователей
echo       - Удаляет локальный кэш 1Cv8/1Cv82 в LocalAppData для всех пользователей
echo.
echo  [2] Глубокая очистка кэша (ОСТОРОЖНО!!!)
echo       - Удаляет локальный и роуминговый кэш 1Cv8/1Cv82
echo         (будут затронуты настройки рабочего места и привязка оборудования)
echo.
echo  [3] Очистка серверного кэша 1С
echo       - Остановка агента, удаление snccntx* в srvinfo\reg_1541 и запуск агента
echo.
echo  [0] Назад в главное меню
echo  ==================================
echo.
set /p escolha1C= Выберите действие: 

if "%escolha1C%"=="1" goto onec_cache_local
if "%escolha1C%"=="2" goto onec_cache_deep
if "%escolha1C%"=="3" goto onec_cache_server
if "%escolha1C%"=="0" goto menu
goto onec_restart

:onec_cache_local
call :set_users "%USERPROFILE%"
FOR /D %%i in ("%Users%*") do (
  FOR /D %%j in ("%%i\AppData\Local\1C\1Cv82\????????-????-????-????-????????????") do rd /s /q "%%j"
  FOR /D %%j in ("%%i\AppData\Local\1C\1Cv8\????????-????-????-????-????????????") do rd /s /q "%%j"
)
echo [+] Локальный кэш 1С очищен.
call :log "1C: локальный кэш очищен"
timeout /t 5 >nul
goto onec_restart

:onec_cache_deep
cls
echo [ВНИМАНИЕ] Глубокая очистка кэша 1С!
echo Это затронет настройки рабочего места и привязку оборудования.
set /p confirm= Продолжить? (Введите ДА для подтверждения): 
if /I not "%confirm%"=="ДА" (
  echo Отменено пользователем.
  timeout /t 2 >nul
  goto onec_restart
)
call :set_users "%USERPROFILE%"
FOR /D %%i in ("%Users%*") do (
  FOR /D %%j in ("%%i\AppData\Local\1C\1Cv82\????????-????-????-????-????????????") do rd /s /q "%%j"
  FOR /D %%j in ("%%i\AppData\Roaming\1C\1Cv82\????????-????-????-????-????????????") do rd /s /q "%%j"
  FOR /D %%j in ("%%i\AppData\Local\1C\1Cv8\????????-????-????-????-????????????") do rd /s /q "%%j"
  FOR /D %%j in ("%%i\AppData\Roaming\1C\1Cv8\????????-????-????-????-????????????") do rd /s /q "%%j"
)
echo [+] Глубокая очистка кэша 1С выполнена.
call :log "1C: глубокая очистка кэша выполнена"
timeout /t 5 >nul
goto onec_restart

:onec_cache_server
echo [*] Очистка серверного кэша 1С...
set "AGENT_SVC="
rem Определяем имя службы по отображаемому имени (RU/EN варианты)
for %%N in ("1C:Enterprise 8.3 Server Agent (x86-64)" "Агент сервера 1С:Предприятия 8.3 (x86-64)" "1C:Enterprise 8.3 Server Agent" "Агент сервера 1С:Предприятия 8.3") do (
  for /f "tokens=2 delims=:" %%K in ('sc GetKeyName "%%~N" 2^>nul ^| findstr /I "SERVICE_NAME"') do (
    set "AGENT_SVC=%%K"
    set "AGENT_SVC=!AGENT_SVC:~1!"
  )
  if defined AGENT_SVC goto onec_cache_server_do
)
if not defined AGENT_SVC (
  echo [!] Служба агента 1С не найдена по известным именам.
  call :log "1C: служба агента не найдена"
  timeout /t 2 >nul
  goto onec_restart
)
:onec_cache_server_do
rem Остановка службы агента 1С по системному имени
net stop "!AGENT_SVC!" >nul 2>&1
set "FOUND_SRV=0"
if exist "%ProgramFiles%\1cv8\srvinfo" (
  call :_onec_clean_srv "%ProgramFiles%\1cv8\srvinfo"
  set "FOUND_SRV=1"
)
if defined ProgramFiles(x86) (
  if exist "%ProgramFiles(x86)%\1cv8\srvinfo" (
    call :_onec_clean_srv "%ProgramFiles(x86)%\1cv8\srvinfo"
    set "FOUND_SRV=1"
  )
)
if "!FOUND_SRV!"=="0" (
  echo [!] Стандартные каталоги не найдены. Укажите путь к srvinfo (например, D:\1cv8\srvinfo):
  set /p ONEC_SRV= Путь: 
  if exist "!ONEC_SRV!" (
    call :_onec_clean_srv "!ONEC_SRV!"
  ) else (
    echo [!] Путь не найден: !ONEC_SRV!
  )
)
rem Запуск службы обратно
net start "!AGENT_SVC!" >nul 2>&1
echo [+] Серверный кэш 1С очищен.
call :log "1C: серверный кэш очищен"
timeout /t 3 >nul
goto onec_restart

:: ================== ПРОЧЕЕ ==================
:energia
cls
echo [*] Настройка оптимизации электропитания...
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul
powercfg /change standby-timeout-ac 0 >nul
powercfg /change standby-timeout-dc 0 >nul
echo [+] Применён план и параметры:
powercfg /getactivescheme
pause
goto menu

:desativarapps
cls
echo [*] Отключение ненужных приложений/служб...
echo.

:: Отключение компонентов Windows
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f >nul
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul

:: Дополнительные твики
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoCDBurning /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableActivityFeed /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v PublishUserActivities /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v DisabledByGroupPolicy /t REG_DWORD /d 1 /f >nul

:: Отключение служб
sc config "DiagTrack" start= disabled >nul
sc config "dmwappushservice" start= disabled >nul
sc config "lfsvc" start= disabled >nul

echo [+] Отключены:
echo - Xbox Game Bar
echo - Cortana
echo - Телеметрия Windows
echo - Потребительские функции Windows
echo - Запись CD/DVD
echo - Новости и интересы
echo - Лента активности/Timeline
echo - Публикация пользовательской активности
echo - Advertising ID
echo - Службы: DiagTrack, dmwappushservice, lfsvc
echo.

pause
goto menu

:auditoria
:auditoria_restart
cls
echo.
echo  ==================================
echo  [ АУДИТ СИСТЕМЫ ]
echo  ==================================
echo.
echo  [1] Просмотр последних системных ошибок
echo       - Экспорт критических/ошибок из журнала System
echo.
echo  [2] Просмотр событий безопасности
echo       - Экспорт последних событий Security
echo.
echo  [3] Отчёт о производительности
echo       - Генерация подробного отчёта
echo.
echo  [4] Проверка проблемных драйверов
echo       - Список драйверов с проблемами
echo.
echo  [0] Назад в главное меню
echo  ==================================
echo.
set /p escolha= Выберите действие: 

if "%escolha%"=="1" goto errossistema
if "%escolha%"=="2" goto eventos_seguranca
if "%escolha%"=="3" goto relatorio_desempenho
if "%escolha%"=="4" goto drivers_problematicos
if "%escolha%"=="0" goto menu
goto auditoria_restart

:errossistema
cls
echo [*] Экспорт Critical/Error из журнала System в файл...
set "OUTPUT=%~dp0System_Log.txt"
powershell -NoProfile -Command "wevtutil qe System /q:'*[System[(Level=1 or Level=2)]]' /c:200 /f:text /rd:true | Out-File -FilePath '%OUTPUT%' -Encoding UTF8"
echo Сохранено в: %OUTPUT%
start notepad "%OUTPUT%"
pause
goto auditoria_restart

:eventos_seguranca
cls
echo [*] Экспорт последних записей журнала Security в файл...
set "OUTPUT=%~dp0Security_Log.txt"
powershell -NoProfile -Command "wevtutil qe Security /c:200 /f:text /rd:true | Out-File -FilePath '%OUTPUT%' -Encoding UTF8"
echo Сохранено в: %OUTPUT%
start notepad "%OUTPUT%"
pause
goto auditoria_restart

:auditoria_restart
echo Возврат в меню аудита...
pause
goto auditoria

:relatorio_desempenho
start perfmon /report
echo [*] Отчёт о производительности запущен!
timeout /t 2 >nul
goto auditoria_restart

:drivers_problematicos
verifier /query
pause
goto auditoria_restart

:: ================== СИСТЕМНЫЕ НАСТРОЙКИ ==================
:configuracoes
:configuracoes_restart
cls
echo.
echo  ==================================
echo  [ СИСТЕМНЫЕ НАСТРОЙКИ ]
echo  ==================================
echo.
echo  [1] Диспетчер задач
echo       - Открыть Task Manager
echo.
echo  [2] Параметры Windows
echo       - Открыть приложение Параметры
echo.
echo  [3] Панель управления
echo       - Открыть классическую Панель управления
echo.
echo  [4] Диспетчер устройств
echo       - Открыть Device Manager
echo.
echo  [5] Управление дисками
echo       - Открыть Disk Management
echo.
echo  [0] Назад в главное меню
echo  ==================================
echo.
set /p escolha= Выберите инструмент: 

if "%escolha%"=="1" start taskmgr
if "%escolha%"=="2" start ms-settings:
if "%escolha%"=="3" start control
if "%escolha%"=="4" start devmgmt.msc
if "%escolha%"=="5" start diskmgmt.msc
if "%escolha%"=="0" goto menu
goto configuracoes_restart


:: ================== РЕЗЕРВНАЯ КОПИЯ РЕЕСТРА ==================
:backupreg
set BACKUP_DIR=C:\RegBackup_%date:~-4,4%%date:~-7,2%%date:~-10,2%
mkdir "%BACKUP_DIR%" >nul 2>&1
reg export HKLM "%BACKUP_DIR%\HKLM.reg" /y
reg export HKCU "%BACKUP_DIR%\HKCU.reg" /y
reg export HKCR "%BACKUP_DIR%\HKCR.reg" /y
echo Резервная копия реестра сохранена в: %BACKUP_DIR%
call :log "Резервное копирование реестра завершено"
pause
goto menu

:: ================== МОНИТОР ПРОЦЕССОВ ==================
:processos
:processos_restart
cls
echo.
echo  ==================================
echo  [ РАСШИРЕННЫЙ МОНИТОР ПРОЦЕССОВ ]
echo  ==================================
echo.
echo  [1] Процессы по нагрузке на CPU
echo       - Показать процессы по использованию CPU
echo.
echo  [2] Процессы по потреблению памяти
echo       - Показать процессы по использованию памяти
echo.
echo  [3] Сетевые процессы
echo       - Активные сетевые соединения
echo.
echo  [4] Запущенные службы
echo       - Список активных служб
echo.
echo  [5] Завершить процесс
echo       - Завершить процесс по PID
echo.
echo  [0] Назад в главное меню
echo  ==================================
echo.
set /p escolha= Выберите вариант: 

if "%escolha%"=="1" (
    tasklist | more
    call :log "Выведен список процессов"
    pause
    goto processos_restart
)
if "%escolha%"=="2" (
    tasklist | more
    call :log "Выведен список процессов"
    pause
    goto processos_restart
)
if "%escolha%"=="3" (
    netstat -ano | findstr "ESTABLISHED" | more
    call :log "Показаны сетевые процессы"
    pause
    goto processos_restart
)
if "%escolha%"=="4" (
    tasklist /svc | more
    call :log "Показаны службы"
    pause
    goto processos_restart
)
if "%escolha%"=="5" (
    set /p pid= Введите PID процесса для завершения: 
    taskkill /f /pid %pid%
    call :log "Процесс завершён: PID %pid%"
    pause
    goto processos_restart
)
if "%escolha%"=="0" goto menu
goto processos_restart

:: ================== СЛУЖЕБНЫЕ ПОДПРОГРАММЫ ==================
:reiniciar
call :log "Перезагрузка системы"
shutdown /r /t 5 /c "Перезагрузка инициирована утилитой поддержки"
echo Система будет перезагружена через 5 секунд...
timeout /t 5
goto :eof

:clean_temp
echo Очистка: %temp%
del /f /s /q "%temp%\*" >nul 2>&1
echo Очистка: C:\Windows\Temp
del /f /s /q "C:\Windows\Temp\*" >nul 2>&1
echo Очистка: C:\Windows\Prefetch
del /f /s /q "C:\Windows\Prefetch\*" >nul 2>&1
echo Очистка: C:\Windows\SoftwareDistribution\Download
del /f /s /q "%SystemRoot%\SoftwareDistribution\Download\*" >nul 2>&1
echo Очистка: C:\$Windows.~BT
del /f /s /q "C:\$Windows.~BT\*" >nul 2>&1
goto :eof

:set_users
set "Users=%~dp1"
goto :eof

:_onec_clean_srv
set "SRV_BASE=%~1"
set "DELETED=0"
for /D %%R in ("%SRV_BASE%\reg_*") do (
  for /D %%d in ("%%~R\snccntx*") do (
    echo Удаление: %%d
    rd /s /q "%%d"
    set "DELETED=1"
  )
)
if "!DELETED!"=="0" echo [i] Не найдено каталогов snccntx* в "!SRV_BASE!"
goto :eof

:log
echo [%date% %time%] %~1 >> "%LOGFILE%"
goto :eof

:fim
call :log "Сеанс завершён"
exit
