@echo off
setlocal enabledelayedexpansion
color 0
mode con cols=100 lines=40
title   ERROR KILLER - Ferramenta de Exterminio

:: ================= CONFIGURACAO INICIAL =================
set LOGFILE=%TEMP%\error_killer_%date:~-4,4%%date:~-7,2%%date:~-10,2%.txt
call :log "Sessao iniciada: %date% %time%"

:menu
cls
echo.
echo  ================================================================
echo               ERROR KILLER - MENU PRINCIPAL
echo  ================================================================
echo.
echo  [1]  Reiniciar sistema            - Forcar reinicializacao
echo  [2]  Limpeza de DNS               - Purgar cache DNS
echo  [3]  Diagnostico de rede          - Varredura completa
echo  [4]  Correcao de impressao        - Eliminar erros
echo  [5]  Gerenciar impressoras        - Painel de controle
echo  [6]  Correcao do Windows          - Reparos do sistema
echo  [7]  Seguranca                    - Protecao avancada
echo  [8]  Reset de rede                - Reiniciar configuracoes
echo  [9]  Backup do registro           - Criar ponto de restauracao
echo  [10] Monitor de processos         - Gerenciamento ativo
echo  [11] Diagnostico completo         - Scanner total
echo  [12] Otimizacao de energia        - Ajuste de desempenho
echo  [13] Desativar apps               - Remover programas
echo  [14] Auditoria do sistema         - Analise completa
echo.
echo  [S]  Configuracoes do sistema     - Utilitarios avancados
echo  [0]  Sair
echo  ================================================================
echo.
set /p opcao= Comando: 

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
echo  [ERRO] Opcao invalida! Use apenas as opcoes listadas.
timeout /t 2 >nul
goto menu

:: ================== CORRECAO DE IMPRESSAO ==================
:correcao_impressao
:correcao_impressao_restart
cls
echo.
echo  ==================================
echo  [ CORRECAO DE PROBLEMAS DE IMPRESSAO ]
echo  ==================================
echo.
echo  [1] Erro 0x0000011b (RPC)
echo       - Corrige erro de comunicacao RPC com impressoras
echo.
echo  [2] Erro 0x00000bcb (Drivers)
echo       - Resolve problemas com drivers de impressao
echo.
echo  [3] Erro 0x00000709 (NamedPipe)
echo       - Corrige erro de protocolo de comunicacao
echo.
echo  [4] Reiniciar servico de impressao
echo       - Reinicia o spooler de impressao
echo.
echo  [5] Todos os reparos
echo       - Executa todas as correcoes acima
echo.
echo  [0] Voltar ao menu principal
echo  ==================================
echo.
set /p escolha= Selecione o tipo de correcao: 

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
echo Servico de impressao reiniciado com sucesso!
call :log "Servico de impressao reiniciado"
pause
goto correcao_impressao_restart

:todos_reparos_impressao
cls
echo [*] APLICANDO TODOS OS REPAROS DE IMPRESSAO...
echo.

echo [1/4] Corrigindo erro 0x0000011b (RPC)...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Print" /v RpcAuthnLevelPrivacyEnabled /t REG_DWORD /d 0 /f >nul
echo [+] Erro 0x0000011b corrigido!
timeout /t 1 >nul

echo [2/4] Corrigindo erro 0x00000bcb (Drivers)...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint" /v RestrictDriverInstallationToAdministrators /t REG_DWORD /d 0 /f >nul
echo [+] Erro 0x00000bcb corrigido!
timeout /t 1 >nul

echo [3/4] Corrigindo erro 0x00000709 (NamedPipe)...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Printers\RPC" /v RpcUseNamedPipeProtocol /t REG_DWORD /d 1 /f >nul
echo [+] Erro 0x00000709 corrigido!
timeout /t 1 >nul

echo [4/4] Reiniciando servico de impressao...
net stop spooler /y >nul
net start spooler >nul
echo [+] Servico de impressao reiniciado com sucesso!

call :log "Todos os reparos de impressao aplicados"
echo.
echo [*] TODOS OS REPAROS FORAM APLICADOS COM SUCESSO!
echo.
echo [1] Voltar ao menu de correcao
echo [2] Voltar ao menu principal
echo.
set /p opcao_final= Selecione uma opcao: 

if "%opcao_final%"=="1" goto correcao_impressao_restart
if "%opcao_final%"=="2" goto menu
goto correcao_impressao_restart

:erro11b
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Print" /v RpcAuthnLevelPrivacyEnabled /t REG_DWORD /d 0 /f >nul
echo Erro 0x0000011b corrigido!
pause
goto correcao_impressao_restart

:erro0bcb
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint" /v RestrictDriverInstallationToAdministrators /t REG_DWORD /d 0 /f >nul
echo Erro 0x00000bcb corrigido!
pause
goto correcao_impressao_restart

:erro709
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Printers\RPC" /v RpcUseNamedPipeProtocol /t REG_DWORD /d 1 /f >nul
echo Erro 0x00000709 corrigido!
pause
goto correcao_impressao_restart

:: ================== CORRECAO DO WINDOWS ==================
:correcao_windows
:correcao_windows_restart
cls
echo.
echo  ==================================
echo  [ CORRECAO DE ERROS DO WINDOWS ]
echo  ==================================
echo.
echo  [1] Reparar arquivos do sistema (SFC)
echo       - Verifica e corrige arquivos do sistema corrompidos
echo.
echo  [2] Reparar imagem do Windows (DISM)
echo       - Repara a imagem do Windows
echo.
echo  [3] Verificar integridade do disco
echo       - Verifica erros no disco rigido
echo.
echo  [4] Reparar instalacao do Windows
echo       - Abre configuracoes de atualizacao
echo.
echo  [0] Voltar ao menu principal
echo  ==================================
echo.
set /p escolha= Selecione o reparo: 

if "%escolha%"=="1" (
    echo Executando SFC /scannow...
    sfc /scannow
    call :log "SFC executado"
    pause
    goto correcao_windows_restart
)
if "%escolha%"=="2" (
    echo Executando DISM...
    DISM /Online /Cleanup-Image /RestoreHealth
    call :log "DISM executado"
    pause
    goto correcao_windows_restart
)
if "%escolha%"=="3" (
    echo Verificando discos...
    chkdsk /scan
    call :log "Verificacao de disco executada"
    pause
    goto correcao_windows_restart
)
if "%escolha%"=="4" (
    echo Iniciando reparo da instalacao...
    start ms-settings:windowsupdate
    call :log "Reparo de instalacao iniciado"
    timeout /t 3 >nul
    goto correcao_windows_restart
)
if "%escolha%"=="0" goto menu
goto correcao_windows_restart

:: ================== SEGURANCA E PROTECAO ==================
:seguranca
:seguranca_restart
cls
echo.
echo  ==================================
echo  [ SEGURANCA E PROTECAO ]
echo  ==================================
echo.
echo  [1] Verificar atualizacoes do Windows
echo       - Abre as configuracoes de atualizacao
echo.
echo  [2] Verificar configuracoes do firewall
echo       - Abre o painel de controle do firewall
echo.
echo  [3] Auditoria de seguranca rapida
echo       - Verifica configuracoes essenciais de seguranca
echo.
echo  [4] Limpar rastreamentos de atividades
echo       - Remove historico e dados de telemetria
echo.
echo  [0] Voltar ao menu principal
echo  ==================================
echo.
set /p escolha= Selecione a acao: 

if "%escolha%"=="1" (
    start ms-settings:windowsupdate
    call :log "Configuracoes de atualizacao abertas"
    timeout /t 2 >nul
    goto seguranca_restart
)

if "%escolha%"=="2" (
    start firewall.cpl
    call :log "Configuracoes do firewall abertas"
    timeout /t 2 >nul
    goto seguranca_restart
)

if "%escolha%"=="3" (
    mode con: cols=120 lines=999
    echo [*] EXECUTANDO AUDITORIA DE SEGURANCA...
    echo.
    
    echo [1/4] Verificando atualizacoes pendentes...
    wmic qfe list brief /format:list
    echo.
    
    echo [2/4] Verificando status do firewall...
    netsh advfirewall show allprofiles
    echo.
    
    echo [3/4] Verificando servicos de seguranca...
    sc query WinDefend
    sc query MpsSvc
    echo.
    
    echo [4/4] Verificando politicas de execucao...
    powershell -command "Get-ExecutionPolicy -List"
    
    call :log "Auditoria de seguranca executada"
    echo.
    echo [+] Auditoria concluida! Verifique os resultados acima.
    pause
    goto seguranca_restart
)


if "%escolha%"=="4" (
    cls
    echo [*] LIMPANDO RASTREAMENTOS DE ATIVIDADES...
    echo.
    
    echo [1/3] Limpando historico do Windows...
    del /f /s /q "%localappdata%\Microsoft\Windows\History\*" >nul 2>&1
    del /f /s /q "%localappdata%\Microsoft\Windows\Recent\*" >nul 2>&1
    
    echo [2/3] Limpando cache de telemetria...
    del /f /s /q "%programdata%\Microsoft\Diagnosis\*" >nul 2>&1
    del /f /s /q "%windir%\Temp\*" >nul 2>&1
    
    echo [3/3] Resetando servicos de rastreamento...
    sc stop DiagTrack >nul 2>&1
    sc stop dmwappushservice >nul 2>&1
    
    call :log "Rastreamentos de atividades limpos"
    echo.
    echo [+] Limpeza concluida com sucesso!
    pause
    goto seguranca_restart
)

if "%escolha%"=="0" goto menu

echo.
echo  [ERRO] Opcao invalida! Use apenas as opcoes listadas.
timeout /t 2 >nul
goto seguranca_restart

:: ================== FUNCOES RAPIDAS ==================
:flushdns
cls
echo [*] Executando limpeza de DNS...
ipconfig /flushdns >nul
ipconfig /registerdns >nul
echo [+] DNS limpo e registros atualizados!
pause
goto menu

:ipall
cls
echo [*] COLETANDO INFORMACOES DE REDE...
echo Aguarde enquanto preparo o relatorio completo...

:: Gerar arquivo temporario com todas as informacoes
ipconfig /all > "%TEMP%\rede_info.txt"
arp -a >> "%TEMP%\rede_info.txt"
echo. >> "%TEMP%\rede_info.txt"
echo === ROTAS DE REDE === >> "%TEMP%\rede_info.txt"
route print >> "%TEMP%\rede_info.txt"

:: Abrir no notepad com scroll livre
start notepad "%TEMP%\rede_info.txt"
goto menu

:impressoras
start control printers
echo [*] Painel de impressoras aberto!
pause
goto menu

:resetnet
cls
echo [*] Reiniciando configuracoes de rede...
netsh winsock reset >nul
netsh int ip reset >nul
ipconfig /release >nul
ipconfig /renew >nul
echo [+] Rede resetada com sucesso!
pause
goto menu

:: ================== DIAGNOSTICO COMPLETO ==================
:diagnostico
:diagnostico_restart
cls
echo.
echo  ==================================
echo  [ DIAGNOSTICO COMPLETO DO SISTEMA ]
echo  ==================================
echo.
echo  [1] Verificar arquivos do sistema (SFC)
echo       - Corrige arquivos corrompidos do Windows
echo.
echo  [2] Verificar imagem do Windows (DISM)
echo       - Repara a imagem do sistema
echo.
echo  [3] Verificar integridade do disco (CHKDSK)
echo       - Analisa erros no disco rigido
echo.
echo  [4] Limpeza COMPLETA de arquivos temporarios
echo       - Remove lixo de TEMP, Prefetch, SoftwareDistribution, etc.
echo.
echo  [5] Verificar e instalar atualizacoes
echo       - Verifica e instala atualizacoes do Windows
echo.
echo  [6] Analise de rede
echo       - Verifica conexoes e configuracoes
echo.
echo  [7] Verificar drivers problematicos
echo       - Lista drivers com erros
echo.
echo  [8] Executar TODOS os diagnosticos
echo       - Faz todas as verificacoes acima
echo.
echo  [0] Voltar ao menu principal
echo  ==================================
echo.
set /p escolha= Selecione o diagnostico: 

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
echo  [ERRO] Opcao invalida! Digite apenas numeros de 0 a 8.
timeout /t 2 >nul
goto diagnostico_restart

:diag_sfc
cls
echo [*] Executando SFC /scannow...
sfc /scannow
call :log "SFC executado"
pause
goto diagnostico_restart

:diag_dism
cls
echo [*] Executando DISM...
DISM /Online /Cleanup-Image /RestoreHealth
call :log "DISM executado"
pause
goto diagnostico_restart

:diag_chkdsk
cls
echo [*] Verificando discos (CHKDSK)...
chkdsk /scan
call :log "Verificacao de disco executada"
pause
goto diagnostico_restart

:diag_limpeza
cls
echo [*] LIMPEZA COMPLETA DE ARQUIVOS TEMPORARIOS...
call :clean_temp
call :log "Limpeza de temporarios realizada"
echo [+] LIMPEZA CONCLUIDA COM SUCESSO!
pause
goto diagnostico_restart

:diag_update
cls
echo [*] VERIFICANDO E INSTALANDO ATUALIZACOES...
powershell -command "Install-Module PSWindowsUpdate -Force -Confirm:$false; Get-WindowsUpdate -Install -AcceptAll -IgnoreReboot"
call :log "Atualizacoes do Windows verificadas"
pause
goto diagnostico_restart

:diag_rede
cls
echo [*] ANALISE COMPLETA DE REDE...
ipconfig /all
netsh winsock reset
ipconfig /flushdns
call :log "Diagnostico de rede executado"
pause
goto diagnostico_restart

:diag_drivers
cls
echo [*] VERIFICANDO DRIVERS PROBLEMATICOS...
verifier /query
call :log "Verificacao de drivers"
pause
goto diagnostico_restart

:diag_todos
cls
echo [*] INICIANDO DIAGNOSTICO COMPLETO...
echo Este processo pode levar varios minutos!
echo.

echo [1/7] SFC (arquivos do sistema)...
sfc /scannow
call :log "SFC executado"
pause

echo [2/7] DISM (imagem do Windows)...
DISM /Online /Cleanup-Image /RestoreHealth
call :log "DISM executado"
pause

echo [3/7] CHKDSK (discos)...
chkdsk /scan
call :log "CHKDSK executado"
pause

echo [4/7] Limpeza de temporarios...
call :clean_temp
call :log "Limpeza executada"
pause

echo [5/7] Windows Update...
powershell -command "Install-Module PSWindowsUpdate -Force -Confirm:$false; Get-WindowsUpdate -Install -AcceptAll -IgnoreReboot"
call :log "Atualizacoes processadas"
pause

echo [6/7] Rede...
ipconfig /all
netsh winsock reset
ipconfig /flushdns
call :log "Diagnostico rede"
pause

echo [7/7] Drivers...
verifier /query
call :log "Verificacao drivers"
pause

echo.
echo [*] TODOS OS DIAGNOSTICOS CONCLUIDOS!
call :log "Diagnostico completo finalizado"
pause
goto diagnostico_restart

:: ================== OUTRAS FUNCOES ==================
:energia
cls
echo [*] Configurando otimizacao de energia...
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul
powercfg /change standby-timeout-ac 0 >nul
powercfg /change standby-timeout-dc 0 >nul
echo [+] Configuracoes aplicadas:
powercfg /getactivescheme
pause
goto menu

:desativarapps
cls
echo [*] Desativando aplicativos desnecessarios...
echo.

:: Desativacao de componentes do Windows
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f >nul
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul

:: Novas desativacoes adicionadas
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoCDBurning /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableActivityFeed /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v PublishUserActivities /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v DisabledByGroupPolicy /t REG_DWORD /d 1 /f >nul

:: Desativa servicos desnecessarios
sc config "DiagTrack" start= disabled >nul
sc config "dmwappushservice" start= disabled >nul
sc config "lfsvc" start= disabled >nul

echo [+] Aplicativos e servicos desativados:
echo - Xbox Game Bar
echo - Cortana
echo - Telemetria do Windows
echo - Windows Consumer Features
echo - Gravacao de CD/DVD
echo - Noticias e Interesses
echo - Timeline/Atividades
echo - Publicacao de Atividades
echo - Publicidade ID
echo - Servico: DiagTrack (Telemetria)
echo - Servico: dmwappushservice (Push)
echo - Servico: lfsvc (Geolocalizacao)
echo.

pause
goto menu

:auditoria
:auditoria_restart
cls
echo.
echo  ==================================
echo  [ AUDITORIA DO SISTEMA ]
echo  ==================================
echo.
echo  [1] Verificar historico de erros
echo       - Mostra ultimos erros do sistema
echo.
echo  [2] Verificar eventos de seguranca
echo       - Exibe eventos de seguranca recentes
echo.
echo  [3] Relatorio de desempenho
echo       - Gera relatorio de desempenho
echo.
echo  [4] Verificar drivers problematicos
echo       - Lista drivers com problemas
echo.
echo  [0] Voltar ao menu principal
echo  ==================================
echo.
set /p escolha= Selecione a auditoria: 

if "%escolha%"=="1" goto errossistema
if "%escolha%"=="2" goto eventos_seguranca
if "%escolha%"=="3" goto relatorio_desempenho
if "%escolha%"=="4" goto drivers_problematicos
if "%escolha%"=="0" goto menu
goto auditoria_restart

:errossistema
cls
echo [*] Ultimos erros do sistema:
echo ----------------------------------
wevtutil qe System /c:5 /f:text | findstr /i /C:"erro" /C:"error" /C:"falha"
echo ----------------------------------
pause
goto auditoria_restart

:eventos_seguranca
eventvwr /c:Security /f:"*[System[(Level=1 or Level=2)]]" /l:30
pause
goto auditoria_restart

:auditoria_restart
echo Voltando ao menu de auditoria...
pause
goto menu_principal

:relatorio_desempenho
start perfmon /report
echo [*] Relatorio de desempenho iniciado!
timeout /t 2 >nul
goto auditoria_restart

:drivers_problematicos
verifier /query
pause
goto auditoria_restart

:: ================== CONFIGURACOES DO SISTEMA ==================
:configuracoes
:configuracoes_restart
cls
echo.
echo  ==================================
echo  [ CONFIGURACOES DO SISTEMA ]
echo  ==================================
echo.
echo  [1] Gerenciador de tarefas
echo       - Abre o gerenciador de tarefas
echo.
echo  [2] Configuracoes do Windows
echo       - Abre as configuracoes do Windows
echo.
echo  [3] Painel de controle
echo       - Abre o painel de controle classico
echo.
echo  [4] Gerenciador de dispositivos
echo       - Abre o gerenciador de dispositivos
echo.
echo  [5] Gerenciador de discos
echo       - Abre o gerenciador de discos
echo.
echo  [0] Voltar ao menu principal
echo  ==================================
echo.
set /p escolha= Selecione a ferramenta: 

if "%escolha%"=="1" start taskmgr
if "%escolha%"=="2" start ms-settings:
if "%escolha%"=="3" start control
if "%escolha%"=="4" start devmgmt.msc
if "%escolha%"=="5" start diskmgmt.msc
if "%escolha%"=="0" goto menu
goto configuracoes_restart


:: ================== BACKUP DO REGISTRO ==================
:backupreg
set BACKUP_DIR=C:\RegBackup_%date:~-4,4%%date:~-7,2%%date:~-10,2%
mkdir "%BACKUP_DIR%" >nul 2>&1
reg export HKLM "%BACKUP_DIR%\HKLM.reg" /y
reg export HKCU "%BACKUP_DIR%\HKCU.reg" /y
reg export HKCR "%BACKUP_DIR%\HKCR.reg" /y
echo Backup do registro salvo em: %BACKUP_DIR%
call :log "Backup do registro realizado"
pause
goto menu

:: ================== MONITOR DE PROCESSOS ==================
:processos
:processos_restart
cls
echo.
echo  ==================================
echo  [ MONITOR DE PROCESSOS AVANCADO ]
echo  ==================================
echo.
echo  [1] Processos consumindo CPU
echo       - Lista processos por uso de CPU
echo.
echo  [2] Processos consumindo memoria
echo       - Lista processos por uso de memoria
echo.
echo  [3] Processos de rede
echo       - Mostra conexoes de rede ativas
echo.
echo  [4] Servicos em execucao
echo       - Lista todos os servicos ativos
echo.
echo  [5] Finalizar processo
echo       - Finaliza um processo por PID
echo.
echo  [0] Voltar ao menu principal
echo  ==================================
echo.
set /p escolha= Selecione a opcao: 

if "%escolha%"=="1" (
    tasklist
    call :log "Processos listados"
    pause
    goto processos_restart
)
if "%escolha%"=="2" (
    tasklist
    call :log "Processos listados"
    pause
    goto processos_restart
)
if "%escolha%"=="3" (
    netstat -ano | findstr "ESTABLISHED"
    call :log "Processos de rede listados"
    pause
    goto processos_restart
)
if "%escolha%"=="4" (
    tasklist /svc
    call :log "Servicos listados"
    pause
    goto processos_restart
)
if "%escolha%"=="5" (
    set /p pid= Digite o PID do processo a finalizar: 
    taskkill /f /pid %pid%
    call :log "Processo finalizado: PID %pid%"
    pause
    goto processos_restart
)
if "%escolha%"=="0" goto menu
goto processos_restart

:: ================== FUNCOES DE SUPORTE ==================
:reiniciar
call :log "Reiniciando o sistema"
shutdown /r /t 5 /c "Reinicio iniciado pelo Suporte Tecnico"
echo O sistema reiniciara em 5 segundos...
timeout /t 5
goto :eof

:clean_temp
echo Limpando: %temp%
del /f /s /q "%temp%\*" >nul 2>&1
echo Limpando: C:\Windows\Temp
del /f /s /q "C:\Windows\Temp\*" >nul 2>&1
echo Limpando: C:\Windows\Prefetch
del /f /s /q "C:\Windows\Prefetch\*" >nul 2>&1
echo Limpando: C:\Windows\SoftwareDistribution\Download
del /f /s /q "%SystemRoot%\SoftwareDistribution\Download\*" >nul 2>&1
echo Limpando: C:\$Windows.~BT
del /f /s /q "C:\$Windows.~BT\*" >nul 2>&1
goto :eof

:log
echo [%date% %time%] %~1 >> "%LOGFILE%"
goto :eof

:fim
call :log "Sessao finalizada"
exit

