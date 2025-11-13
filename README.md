# ErrorKiller — English Fork

This repository is a fork of the original ErrorKiller tool with a full English localization. The tool is a Windows support utility implemented as a single Batch (BAT) script to automate maintenance, diagnostics, and repair tasks.

- Original script (Portuguese): `SuporteTecnico.bat`
- English-localized script: `ErrorKiller_EN.bat`

## Key Features

- Print troubleshooting
  - Fixes common Windows printing errors: 0x0000011b (RPC), 0x00000bcb (drivers), 0x00000709 (NamedPipe)
  - Restart Print Spooler or apply all fixes at once
- Windows repair
  - System File Checker: `sfc /scannow`
  - DISM image repair: `DISM /Online /Cleanup-Image /RestoreHealth`
  - Disk integrity check: `chkdsk /scan`
- Security and privacy
  - Open Windows Update and Firewall settings
  - Quick security audit (updates, firewall profiles, security services, PowerShell execution policies)
  - Clear activity traces and telemetry caches; stop tracking services
- Network tools
  - DNS flush/register, network reset (Winsock/IP), full network report saved to a temp file and opened in Notepad
- Full diagnostics suite
  - Run individual or all checks: SFC, DISM, CHKDSK, temp cleanup, Windows Update (via PSWindowsUpdate), network checks, driver verification
- System tweaks
  - Power optimization (High performance scheme and no sleep timeouts)
  - Disable unnecessary apps/services and telemetry-related features via registry and service config
- System audit
  - Recent system errors, security events, performance report, problematic drivers
- Registry backup
  - Export HKLM/HKCU/HKCR hives into `C:\RegBackup_YYYYMMDD`
- Advanced process monitor
  - List processes/services, show active connections, kill by PID

## Usage

Run from an elevated terminal for features that require admin rights (registry changes, DISM/SFC, services):

- Start (PowerShell, elevated):
  - `Start-Process -Verb RunAs -FilePath cmd.exe -ArgumentList '/k cd /d Z:\git\ErrorKiller && ErrorKiller_EN.bat'`
- View latest log (stored under `%TEMP%/error_killer_YYYYMMDD.txt`):
  - `Get-ChildItem "$env:TEMP" -Filter 'error_killer_*.txt' | Sort-Object LastWriteTime -Desc | Select-Object -First 1 | Get-Content -Tail 100`
