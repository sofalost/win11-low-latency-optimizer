@echo off
chcp 1252 >nul
title win11-low-latency-optimizer  -  ALL-IN-ONE  v4.0
setlocal EnableExtensions EnableDelayedExpansion
set "SCRIPT_VER=v4.0"

rem ====================================================================
rem   LOW LATENCY GAMING SCRIPT
rem   Single bilingual script (EN / FR). Self-elevating. Reversible.
rem   Tweaks: CPU/RAM, GPU, mouse/keyboard, network, per-game
rem   priority + fullscreen optimizations + high-performance GPU,
rem   telemetry/ads off, services, appearance, power plan, 0.5 ms timer.
rem   No restore point and no registry backup are created.
rem   Secure Boot, TPM and core isolation are never touched.
rem ====================================================================

rem ============ [0] ELEVATION ADMINISTRATEUR ============
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Relance automatique en administrateur...
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)
set "DIR=%~dp0"
reg add "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%~f0" /t REG_SZ /d "~ RUNASADMIN" /f >nul 2>&1
rem Couleurs ANSI (journal temps reel) + console noire
for /f %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"
set "C0=!ESC![0m!ESC![38;5;252m"
set "CG=!ESC![92m"
set "CC=!ESC![96m"
set "CY=!ESC![93m"
set "CR=!ESC![91m"
set "CW=!ESC![97m"
set "CM=!ESC![95m"
set "CK=!ESC![90m"
set "CB=!ESC![94m"
set "CO=!ESC![38;5;208m"
set "CTHEME=!CC!"
set "CL=!ESC![38;5;117m"
set "CO2=!ESC![38;5;214m"
set "CT=!ESC![38;5;43m"
set "CG2=!ESC![38;5;82m"
set "CB1=!ESC![38;5;39m"
set "CB2=!ESC![38;5;75m"
set "CO3=!ESC![38;5;202m"
set "CBG1=!ESC![38;5;117m"
set "CBG2=!ESC![38;5;75m"
set "CBG3=!ESC![38;5;63m"
set "CBG4=!ESC![38;5;61m"
set "CGE=!ESC![38;5;48m"
set "CJ=!ESC![38;5;226m"
set "OK=!CG![!CW!OK!CG!]!C0!"
color 0F
set "TRPSB64=JEVycm9yQWN0aW9uUHJlZmVyZW5jZT0nU2lsZW50bHlDb250aW51ZScKJG10eD1OZXctT2JqZWN0IFN5c3RlbS5UaHJlYWRpbmcuTXV0ZXgoJGZhbHNlLCdHbG9iYWxcTG93TGF0VGltZXJSZXMwNScpCiRhYmFuZG9uZWQ9JGZhbHNlCnRyeXsKICBpZigtbm90ICRtdHguV2FpdE9uZSgwKSl7ZXhpdH0KfWNhdGNoIFtTeXN0ZW0uVGhyZWFkaW5nLkFiYW5kb25lZE11dGV4RXhjZXB0aW9uXXsKICAjIE11dGV4IGFiYW5kb25uZSBwYXIgdW4gcHJlY2VkZW50IHByb2Nlc3MgbW9ydCBlbiBsZSB0ZW5hbnQuCiAgIyBTZW1hbnRpcXVlbWVudCA9IGFjcXVpc2l0aW9uIHJldXNzaWUgKG9uIGxlIHBvc3NlZGUpLiBPbiBjb250aW51ZS4KICAkYWJhbmRvbmVkPSR0cnVlCn0KU3RhcnQtU2xlZXAgLVNlY29uZHMgNQokc2lnPUAnCltEbGxJbXBvcnQoIm50ZGxsLmRsbCIpXSBwdWJsaWMgc3RhdGljIGV4dGVybiBpbnQgTnRTZXRUaW1lclJlc29sdXRpb24odWludCBEZXNpcmVkUmVzb2x1dGlvbiwgYm9vbCBTZXRSZXNvbHV0aW9uLCBvdXQgdWludCBDdXJyZW50UmVzb2x1dGlvbik7CltEbGxJbXBvcnQoIm50ZGxsLmRsbCIpXSBwdWJsaWMgc3RhdGljIGV4dGVybiBpbnQgTnRRdWVyeVRpbWVyUmVzb2x1dGlvbihvdXQgdWludCBNaW5SZXMsIG91dCB1aW50IE1heFJlcywgb3V0IHVpbnQgQ3VyUmVzKTsKW0RsbEltcG9ydCgia2VybmVsMzIuZGxsIildIHB1YmxpYyBzdGF0aWMgZXh0ZXJuIGJvb2wgR2V0U3lzdGVtUG93ZXJTdGF0dXMob3V0IFNQUyBzKTsKW1N0cnVjdExheW91dChMYXlvdXRLaW5kLlNlcXVlbnRpYWwpXSBwdWJsaWMgc3RydWN0IFNQUyB7IHB1YmxpYyBieXRlIEFDTGluZVN0YXR1czsgcHVibGljIGJ5dGUgQmF0dGVyeUZsYWc7IHB1YmxpYyBieXRlIEJhdHRlcnlMaWZlUGVyY2VudDsgcHVibGljIGJ5dGUgU3lzdGVtU3RhdHVzRmxhZzsgcHVibGljIGludCBCYXR0ZXJ5TGlmZVRpbWU7IHB1YmxpYyBpbnQgQmF0dGVyeUZ1bGxMaWZlVGltZTsgfQonQAokVFI9JG51bGwKJG49MAp3aGlsZSgkbnVsbCAtZXEgJFRSIC1hbmQgJG4gLWx0IDEyMCl7CiAgIyBBZGQtVHlwZSAtUGFzc1RocnUgcmVudm9pZSBVTiBUQUJMRUFVIChsZSB0eXBlICsgbGEgc3RydWN0IFNQUyBpbWJyaXF1ZWUpLg0KICAjIFNhbnMgY2UgV2hlcmUtT2JqZWN0LCAkVFIgdmF1dCBPYmplY3RbXSBldCBUT1VUIGFwcGVsICRUUjo6WHh4IGVjaG91ZS4NCiAgdHJ5eyRyPUFkZC1UeXBlIC1OYW1lIFRycyAtTmFtZXNwYWNlIExsIC1NZW1iZXJEZWZpbml0aW9uICRzaWcgLVBhc3NUaHJ1IC1FcnJvckFjdGlvbiBTdG9wOyAkVFI9QCgkcikgfCBXaGVyZS1PYmplY3QgeyAkXy5OYW1lIC1lcSAnVHJzJyB9IHwgU2VsZWN0LU9iamVjdCAtRmlyc3QgMX1jYXRjaHtTdGFydC1TbGVlcCAtU2Vjb25kcyAyfQogICRuKysKfQppZigkbnVsbCAtZXEgJFRSKXtleGl0IDF9CiRyZWc9J0hLTE06XFNPRlRXQVJFXExvd0xhdE9wdGltaXplcicKdHJ5e2lmKC1ub3QoVGVzdC1QYXRoICRyZWcpKXtOZXctSXRlbSAtUGF0aCAkcmVnIC1Gb3JjZXxPdXQtTnVsbH19Y2F0Y2h7fQpmdW5jdGlvbiBMb2dUaW1lcigkc3RhdGUpewogIHRyeXsKICAgICRtaW49W3VpbnQzMl0wOyRtYXg9W3VpbnQzMl0wOyRjdXI9W3VpbnQzMl0wCiAgICBbdm9pZF0kVFI6Ok50UXVlcnlUaW1lclJlc29sdXRpb24oW3JlZl0kbWluLFtyZWZdJG1heCxbcmVmXSRjdXIpCiAgICBTZXQtSXRlbVByb3BlcnR5IC1QYXRoICRyZWcgLU5hbWUgJ1RpbWVyQ3VyJyAtVmFsdWUgJGN1ciAtVHlwZSBEV29yZCAtRm9yY2UKICAgIFNldC1JdGVtUHJvcGVydHkgLVBhdGggJHJlZyAtTmFtZSAnVGltZXJTdGF0ZScgLVZhbHVlICRzdGF0ZSAtVHlwZSBTdHJpbmcgLUZvcmNlCiAgICBTZXQtSXRlbVByb3BlcnR5IC1QYXRoICRyZWcgLU5hbWUgJ1RpbWVyQWJhbmRvbmVkJyAtVmFsdWUgJGFiYW5kb25lZCAtVHlwZSBEV29yZCAtRm9yY2UKICB9Y2F0Y2h7fQp9CiRjPTAKd2hpbGUoJHRydWUpewogICRob2xkPSR0cnVlCiAgdHJ5ewogICAgJHM9TmV3LU9iamVjdCAnTGwuVHJzK1NQUycKICAgIGlmKCRUUjo6R2V0U3lzdGVtUG93ZXJTdGF0dXMoW3JlZl0kcykpewogICAgICAjIEJhdHRlcnlGbGFnIGVzdCB1biBiaXRmaWVsZCA7IGJpdCAxMjggPSAibm8gc3lzdGVtIGJhdHRlcnkiIChkZXNrdG9wKS4KICAgICAgIyBPbiByZWxhY2hlIChob2xkPWZhbHNlKSBVTklRVUVNRU5UIHNpIGJhdHRlcmllIHByZXNlbnRlIEVUIHN1ciBzZWN0ZXVyIGRlY29ubmVjdGUuCiAgICAgIGlmKCgoJHMuQmF0dGVyeUZsYWcgLWJhbmQgMTI4KSAtZXEgMCkgLWFuZCAkcy5BQ0xpbmVTdGF0dXMgLWVxIDApeyRob2xkPSRmYWxzZX0KICAgIH0KICB9Y2F0Y2h7JGhvbGQ9JHRydWV9CiAgdHJ5ewogICAgaWYoJGhvbGQpewogICAgICAkVFI6Ok50U2V0VGltZXJSZXNvbHV0aW9uKDUwMDAsJHRydWUsW3JlZl0kYyl8T3V0LU51bGwKICAgICAgTG9nVGltZXIgJ2hlbGQnCiAgICB9ZWxzZXsKICAgICAgJFRSOjpOdFNldFRpbWVyUmVzb2x1dGlvbig1MDAwLCRmYWxzZSxbcmVmXSRjKXxPdXQtTnVsbAogICAgICBMb2dUaW1lciAncmVsZWFzZWQnCiAgICB9CiAgfWNhdGNoewogICAgdHJ5e1NldC1JdGVtUHJvcGVydHkgLVBhdGggJHJlZyAtTmFtZSAnVGltZXJTdGF0ZScgLVZhbHVlICgnZXJyb3I6ICcrJF8uRXhjZXB0aW9uLk1lc3NhZ2UpIC1UeXBlIFN0cmluZyAtRm9yY2V9Y2F0Y2h7fQogICAgU3RhcnQtU2xlZXAgLVNlY29uZHMgMzAKICB9CiAgU3RhcnQtU2xlZXAgLVNlY29uZHMgNQp9Cg=="
set "TASKB64=JEVycm9yQWN0aW9uUHJlZmVyZW5jZT0nU2lsZW50bHlDb250aW51ZScKJHRuPSdUaW1lclJlcyAwLjVtcycKJHBzPSRlbnY6U3lzdGVtUm9vdCsnXHRpbWVycmVzLnBzMScKJGE9TmV3LVNjaGVkdWxlZFRhc2tBY3Rpb24gLUV4ZWN1dGUgJ3Bvd2Vyc2hlbGwuZXhlJyAtQXJndW1lbnQgKCctTm9Qcm9maWxlIC1XaW5kb3dTdHlsZSBIaWRkZW4gLUV4ZWN1dGlvblBvbGljeSBCeXBhc3MgLUZpbGUgIicrJHBzKyciJykKJHQxPU5ldy1TY2hlZHVsZWRUYXNrVHJpZ2dlciAtQXRTdGFydHVwCiR0Mj1OZXctU2NoZWR1bGVkVGFza1RyaWdnZXIgLUF0TG9nT24KJHA9TmV3LVNjaGVkdWxlZFRhc2tQcmluY2lwYWwgLVVzZXJJZCAnTlQgQVVUSE9SSVRZXFNZU1RFTScgLUxvZ29uVHlwZSBTZXJ2aWNlQWNjb3VudCAtUnVuTGV2ZWwgSGlnaGVzdAokcz1OZXctU2NoZWR1bGVkVGFza1NldHRpbmdzU2V0IC1BbGxvd1N0YXJ0SWZPbkJhdHRlcmllcyAtRG9udFN0b3BJZkdvaW5nT25CYXR0ZXJpZXMgLUV4ZWN1dGlvblRpbWVMaW1pdCAoW1RpbWVTcGFuXTo6WmVybykgLVJlc3RhcnRDb3VudCAzIC1SZXN0YXJ0SW50ZXJ2YWwgKE5ldy1UaW1lU3BhbiAtTWludXRlcyAxKSAtTXVsdGlwbGVJbnN0YW5jZXMgSWdub3JlTmV3IC1TdGFydFdoZW5BdmFpbGFibGUKUmVnaXN0ZXItU2NoZWR1bGVkVGFzayAtVGFza05hbWUgJHRuIC1BY3Rpb24gJGEgLVRyaWdnZXIgJHQxLCR0MiAtUHJpbmNpcGFsICRwIC1TZXR0aW5ncyAkcyAtRm9yY2UgfCBPdXQtTnVsbApTdGFydC1TY2hlZHVsZWRUYXNrIC1UYXNrTmFtZSAkdG4K"

rem ---- Detection automatique de la langue (FR si Windows/region FR, sinon EN) ----
set "L=EN"
powershell -NoProfile -Command "if((Get-UICulture).Name -like 'fr*' -or (Get-Culture).Name -like 'fr*'){'FR'}else{'EN'}" > "%TEMP%\_lllang.txt" 2>nul
for /f "usebackq delims=" %%i in ("%TEMP%\_lllang.txt") do set "L=%%i"
del /q "%TEMP%\_lllang.txt" >nul 2>&1
set "BSUB=Less input lag, more reactivity"
if /i "!L!"=="FR" set "BSUB=Moins de lag, plus de réactivité"
cls
echo  !CM!================================================================!C0!
echo  !CW!                   LOW LATENCY GAMING SCRIPT!C0!
echo  !CB!                !BSUB!!C0!
echo  !CM!================================================================!C0!
echo.
if /i "!L!"=="FR" goto _strfr
set "M0=!CW!CPU/RAM!C0!: svchost grouped, foreground quantum, SysMain on"
set "M2=!CW!MMCSS!C0! Games profile: GPU and CPU priority !CG!maxed!C0!"
set "M3L=High CPU and I/O priority on !CW!CS2, LoL, Brawlhalla, R6, Valorant, Apex, Fortnite, Warframe, Roblox!C0!"
set "M3S=Per-game CPU/IO priority: !CG!default (soft)!C0!"
set "M4=!CW!NVIDIA!C0! GPU: old sharpening method !CG!restored!C0!, MSI mode !CG!on!C0!"
set "M5=!CW!AMD!C0! GPU: ULPS !CR!off!C0!, MSI mode !CG!on!C0!"
set "MDLOCK=AMD 25.9.1 -> GPU driver updates !CR!blocked!C0! (Windows Update)"
set "MDFREE=GPU driver updates !CG!left unblocked!C0!"
set "M6=Mouse !CG!1:1!C0! (acceleration !CR!off!C0!), keyboard fast, sticky keys !CR!off!C0!, PrtScn opens !CW!Snipping Tool!C0!"
set "M7=!CW!Network!C0!: RSC !CR!off!C0!, RSS !CG!on!C0!, NIC power saving and moderation !CR!off!C0!"
set "M8=Boot timers tuned, NTFS 8.3 names !CR!off!C0!"
set "M9=Telemetry, ads, !CW!Recall, Widgets!C0! !CR!off!C0!"
set "M10=!CW!Ad and telemetry blocklist!C0!: !CC!215 domains!C0! via hosts"
set "M11=Telemetry scheduled tasks !CR!disabled!C0!"
set "M12=Useless services !CR!disabled!C0! (!CW!anticheats!C0! and drivers untouched)"
set "M13=Windows indexing !CG!on!C0! (file search)"
set "M14=Exclusive fullscreen !CG!forced!C0!, high-performance GPU on all !CC!7!C0! games"
set "M15=!CW!GameDVR!C0! !CR!off!C0!, !CW!Game Mode!C0! !CG!on!C0!, windowed-game optimizations !CG!on!C0!"
set "M16=!CW!Defender!C0!: games !CG!excluded!C0!, scheduled scan !CR!off!C0!, scans throttled"
set "M16NT=!CW!Real-time protection left ON!C0! (never disabled: it triggers a Defender alert)"
set "M17=Debloat !CG!done!C0! (!CW!Store, Security, Snipping, Calculator, Paint, Spotify!C0! kept)"
set "M19=New !CW!Outlook!C0! !CR!removed!C0!"
set "M20=!CW!Privacy!C0!: app access !CR!off!C0! except !CG!microphone!C0!; background apps !CR!off!C0!"
set "M72=!CW!Typing insights!C0! + !CW!suggestions!C0! + spotlight/speech/clipboard suggestions !CR!OFF!C0!"
set "M73=!CW!MSI mode!C0! on GPU (Message Signaled Interrupts): !CG!ON!C0! (reboot)"
set "M74=Clipboard history, Chat button, Explorer recents, Cortana, system sounds, lockscreen/screensaver !CR!OFF!C0!"
set "M75=!CW!OOBE nag!C0!, update auto-reboot, feedback, auto-maintenance wake, first-logon anim !CR!OFF!C0!"
set "M21=!CW!Camera!C0! !CG!kept active!C0! (apps allowed)"
set "M22=!CW!Camera!C0! !CR!disabled!C0! (device and app access off)"
set "M23=!CW!Camera!C0! !CG!restored!C0! (device re-enabled)"
set "M24=!CW!Wi-Fi + Ethernet!C0!: left unchanged"
set "M25=!CW!Wi-Fi!C0! !CR!disabled!C0! (service and adapters)"
set "M26=!CW!Wi-Fi!C0! !CG!restored!C0! (service and adapters)"
set "M25E=!CW!Ethernet!C0! !CR!disabled!C0! (adapter)"
set "M26E=!CW!Ethernet!C0! !CG!restored!C0! (adapter)"
set "M27=!CW!Bluetooth!C0!: left unchanged"
set "M28=!CW!Bluetooth!C0! !CR!disabled!C0! (services and radios)"
set "M29=!CW!Bluetooth!C0! !CG!restored!C0! (services and radios)"
set "M30=!CW!Printer!C0!: left unchanged"
set "M31=!CW!Printer!C0! !CR!disabled!C0! (spooler off)"
set "M32=!CW!Printer!C0! !CG!restored!C0! (spooler on)"
set "M33=!CW!Xbox!C0!: left unchanged"
set "M34=!CW!Xbox!C0! !CR!removed!C0! (apps, services, task)"
set "M35=!CW!Xbox!C0! !CG!restored!C0! (services back to manual)"
set "M36=!CW!OneDrive!C0! !CR!uninstalled!C0!"
set "M40=!CW!Appearance!C0!: transparency, grey accent, black wallpaper, !CW!dark theme!C0!"
set "M40L=!CW!Appearance!C0!: visual effects !CR!off!C0! (small GPU / RAM <= 16 GB), !CW!font smoothing!C0! + !CW!translucent selection!C0! kept, !CW!dark theme!C0!"
set "M43=Taskbar cleaned (search hidden, combined, !CW!Widgets!C0! !CR!off!C0!, !CW!Task View!C0! !CR!off!C0!, End task !CG!on!C0!)"
set "M44=!CW!Start menu!C0!: no recommendations, no recent apps, notifications !CR!off!C0!"
set "M45=!CW!File Explorer!C0!: hidden items shown, extensions !CG!on!C0!, opens to !CW!This PC!C0!"
set "M46=!CW!Security warnings!C0! !CR!off!C0!"
set "M47=Snap and multitasking !CG!on!C0!, Aero Shake !CR!off!C0!"
set "M48=!CW!UAC!C0!: !CY!never prompts!C0! (silent elevation)"
set "M49=Remote Desktop and Remote Assistance !CR!off!C0!"
set "M50=Memory integrity (core isolation) !CG!kept on!C0! - required by some !CW!anticheats!C0!"
set "M50OFF=Memory integrity + VBS + hypervisor !CR!OFF!C0! (no-anticheat, max perf)"
set "M51=!CW!Boot!C0!: no GUI, OS not shown, !CC!0 second!C0! delay"
set "M52=Ghost (unplugged) devices !CR!removed!C0!"
set "M53=!CW!Extras!C0!: FTH !CR!off!C0!, app startup delay !CC!0!C0!, faster shutdown"
set "M54L=!CW!Ultimate Performance!C0!: USB suspend !CR!off!C0!, ASPM !CR!off!C0!, never sleeps; parking/C-states per CPU"
set "M54S=!CW!High Performance!C0!: USB suspend !CR!off!C0!, ASPM !CR!off!C0!; parking/C-states per CPU"
set "M55=!CW!HAGS!C0! supported: !CG!enabled!C0! (takes effect after reboot)"
set "M56=!CW!HAGS!C0! not exposed by the platform: !CY!not enabled!C0!"
set "M57=!CW!Fast Startup!C0! !CG!enabled!C0!"
set "M58=!CW!Startup tray icons hidden!C0!: !CW!Vanguard + Defender!C0! (services keep running)"
set "M59=Drivers kept !CG!up to date!C0! via Windows Update"
set "M60=!CW!Disk optimization!C0!: native !CW!Windows!C0! task !CG!on!C0! (silent, daily)"
set "M61=!CW!Storage Sense!C0! !CG!on!C0!: temp + recycle 1d, daily (!CW!Downloads untouched!C0!)"
set "M62=!CW!Cleanup!C0!: temp, !CW!Discord/Steam!C0! cache, WinSxS, Windows.old, recycle bin"
set "M63=!CW!Windows Update!C0! !CY!running!C0! (incl. !CW!optional!C0! updates)... can take a while, do not close"
set "M64=!CW!Windows Update!C0! !CG!finished!C0!"
set "M66=Updating apps via !CW!winget!C0!... can take a while"
set "M67=!CW!winget!C0! !CG!finished!C0!"
set "M69=Windows timer forced to !CC!0.5 ms!C0! at startup (no external tool)"
set "M69NG=!CR!Timer task did NOT register!C0! - run again as admin, then reboot"
set "M71=Settings re-applied !CG!only after a Windows update!C0!; safe cleanup temp + DNS !CG!every session!C0!"
set "RJRN=Restored: !CW!original values!C0! put back, count:"
set "R0=Restored: !CW!CPU/RAM core!C0! to default"
set "R1=Restored: !CW!network!C0! to default"
set "R2=Restored: !CW!per-game priorities and fullscreen!C0! to default"
set "R3=Restored: !CW!GameDVR and NVIDIA sharpening!C0! to default"
set "R4=Restored: !CW!timers, boot and NTFS!C0! to default"
set "R5=Restored: !CW!services!C0! to default"
set "R6=Restored: !CW!UAC, remote, SmartScreen, power, telemetry!C0!; !CW!AMD!C0! lock removed"
set "R7=Restored: !CW!custom tasks!C0! removed"
set "QMODE_HEAD=CHOOSE YOUR OPTIMIZATION MODE"
set "QVBS_HEAD=KEEP KERNEL SECURITY + VIRTUALIZATION ?"
set "QVBS_YES_NAME=YES - keep ON (anticheat / VM / WSL2 / AI)"
set "QVBS_YES_DESC=Keeps VBS / HVCI / hypervisor ON - needs: Vanguard / FACEIT,"
set "QVBS_YES_DESC2=WSL2 / Hyper-V / VMs, Copilot and Recall"
set "QVBS_NO_NAME=NO - turn OFF for max performance"
set "QVBS_NO_DESC=Turns VBS / HVCI / hypervisor OFF + Copilot / Recall OFF - pure perf,"
set "QVBS_NO_DESC2=no anticheat, no VM, no AI"
set "M9A_AI_KEPT=AI / Copilot / Recall kept ON - VBS kept for anticheat/VM/AI"
set "M9A_AI_OFF=AI / Copilot / Recall turned OFF - VBS off for max performance"
set "QMODE_S_NAME=SOFT MODE"
set "QMODE_S_DESC=Strong latency gains, every safety feature stays on. Safe pick if unsure."
set "QMODE_L_NAME=LOWEST LATENCY"
set "QMODE_L_DESC=All of Soft, plus per-game priority and GPU timeout. Runs warmer."
set "MODE_ACTIVE=ACTIVE MODE"
set "PROMPT=Your choice: "
set "DET_GPU=Graphics card"
set "DET_RAM=Memory       "
set "DET_CPU=Processor    "
set "DET_CORES=cores"
set "DET_TYPE=Machine type "
set "TYPEFIXE=Desktop"
set "TYPEPORT=Laptop"
set "DET_THRESH=svchost threshold"
set "DET_GB=GB"
set "DET_KB=KB"
set "Q_INTRO=Answer the questions below (one key each; press 0 to go back):"
set "QH_CAM=CAMERA"
set "QH_WIFI=NETWORK ADAPTERS (WI-FI / ETHERNET)"
set "QH_BT=BLUETOOTH"
set "QH_PRINT=PRINTER"
set "QH_XBOX=XBOX"
set "QO_YESNO=!CG![1] Yes!C0!  !CR![2] No!C0!"
set "CFM_KEEP=unchanged"
set "CFM_OFF=disabled"
set "CFM_RST=restored"
set "QO_CAM=!CL![1] Keep active!C0!  !CR![2] Disable!C0!  !CG![3] Restore default!C0!"
set "QO_NDR=!CL![1] Leave as is!C0!  !CR![2] Disable!C0!  !CG![3] Restore default!C0!"
set "QO_NET=!CL![1] Keep!C0!  !CR![2] Disable Wi-Fi!C0!  !CR![3] Disable Ethernet!C0!"
set "QO_NET2=!CG![4] Restore Wi-Fi!C0!  !CG![5] Restore Ethernet!C0!"
set "QO_XBOX=!CL![1] Leave as is!C0!  !CR![2] Remove all!C0!  !CG![3] Restore services!C0!"
set "APPLYING=Applying optimizations, please wait..."
set "DONE_APPLY=ALL DONE"
set "SUMMARY_HEAD=SUMMARY"
set "SUM02=Foreground game gets !CG!top priority!C0!."
set "SUM03=CPU fully !CG!unparked!C0!, no power saving, no sleep."
set "SUM03L=CPU parking left !CG!default!C0!, C-states kept (battery-friendly)."
set "M5LAP=!CW!ULPS!C0! kept ON for battery"
set "LAPDET=Laptop detected -> battery + thermal-safe settings forced over the chosen mode."
set "SUMLAP=Laptop overrides: timer on AC only, ULPS kept, default CPU parking, High Perf plan, dynamic tick on, Wi-Fi eco on battery."
set "SUM04=Mouse !CG!1:1!C0!, zero Windows acceleration."
set "SUM05=Network tuned for minimal lag."
set "SUM06=Trackers, telemetry and useless services !CR!off!C0!."
set "SUM07=Ad + MS telemetry blocking via hosts (!CC!215 domains!C0! + Defender exclusion)."
set "SUM08=!CW!Widgets, new Outlook, Task View!C0! !CR!removed!C0!."
set "SUM09=Exclusive fullscreen + high-performance GPU on the games."
set "SUM11=Memory integrity !CG!kept on!C0!, !CW!UAC!C0! never prompts."
set "SUM12=Remote Desktop !CR!off!C0!, file indexing !CG!on!C0!."
set "SUM13=Appearance: transparency, grey accent, black wallpaper, seconds."
set "SUM14=Disks optimized by the native task + !CW!Storage Sense!C0!."
set "SUM15=Temp, cache and !CW!Windows.old!C0! cleanup done."
set "SUM16=Timer forced to !CC!0.5 ms!C0! at startup (no external tool)."
set "SUM17=Key tweaks re-applied after updates; safe cleanup !CG!every session!C0!."
set "SUM18=Typing insights, suggestions, lockscreen spotlight, online speech, suggested actions: OFF"
set "SUM_DEV=Devices & Xbox (!CW!camera, Wi-Fi, Bluetooth, printer!C0!): as you chose."
set "Q_RESTART=Restart the PC now to apply everything?"
set "RESTARTING=Restarting in 5 seconds..."
set "RESTART_LATER=OK - remember to restart later to apply everything."
set "REST_INTRO=Restoring Windows default values..."
set "REST_DONE_HEAD=RESTORE COMPLETE"
set "REST_NOTE1=Default Windows values restored."
set "REST_NOTE2=Not auto-reverted: debloated apps, OneDrive, unpinned items."
set "REST_NOTE3=Core isolation was NOT touched by this script."
set "SIGN_BY=by"
set "SIGN_TAIL=made with Claude.ai"
set "BAN_A=Core engine: CPU, scheduler, GPU, mouse, network"
set "BAN_B=Privacy, telemetry and game mode"
set "BAN_C=Devices & Xbox (your choices)"
set "BAN_D=Apps, appearance and interface"
set "BAN_E=Power plan and boot"
set "BAN_F=Disks and maintenance"
set "BAN_G=Updates"
set "BAN_H=Real-time latency"
set "BACK=Back"
set "PHEAD=PERIPHERALS - disable or restore"
set "PH1=Camera"
set "PH2=Network adapters (Wi-Fi / Ethernet)"
set "PH3=Bluetooth"
set "PH4=Printer"
set "PH5=Xbox"
set "PDONE=Done."
goto _strdone
:_strfr
if /i "!L!"=="FR" set "M0=!CW!CPU/RAM!C0! : svchost regroupé, quantum premier plan, SysMain on"
if /i "!L!"=="FR" set "M2=!CW!MMCSS!C0! profil Games : priorité GPU et CPU !CG!maximale!C0!"
if /i "!L!"=="FR" set "M3L=Priorité CPU et E/S élevée sur !CW!CS2, LoL, Brawlhalla, R6, Valorant, Apex, Fortnite, Warframe, Roblox!C0!"
if /i "!L!"=="FR" set "M3S=Priorité CPU/E-S par jeu : !CG!défaut (soft)!C0!"
if /i "!L!"=="FR" set "M4=GPU !CW!NVIDIA!C0! : ancienne méthode de sharpening !CG!restaurée!C0!, mode MSI !CG!activé!C0!"
if /i "!L!"=="FR" set "M5=GPU !CW!AMD!C0! : ULPS !CR!off!C0!, mode MSI !CG!on!C0!"
if /i "!L!"=="FR" set "MDLOCK=AMD 25.9.1 -> MAJ pilote GPU !CR!bloquées!C0! (Windows Update)"
if /i "!L!"=="FR" set "MDFREE=MAJ pilote GPU !CG!laissées débloquées!C0!"
if /i "!L!"=="FR" set "M6=Souris !CG!1:1!C0! (accélération !CR!off!C0!), clavier rapide, touches rémanentes !CR!off!C0!, Impr écran ouvre !CW!Capture!C0!"
if /i "!L!"=="FR" set "M7=!CW!Réseau!C0! : RSC !CR!off!C0!, RSS !CG!on!C0!, économie et modération carte réseau !CR!off!C0!"
if /i "!L!"=="FR" set "M8=Timers de démarrage réglés, noms courts 8.3 NTFS !CR!off!C0!"
if /i "!L!"=="FR" set "M9=Télémétrie, publicité, !CW!Recall, Widgets!C0! !CR!off!C0!"
if /i "!L!"=="FR" set "M10=!CW!Liste de blocage pub et télémétrie!C0! : !CC!215 domaines!C0! via hosts"
if /i "!L!"=="FR" set "M11=Tâches planifiées de télémétrie !CR!désactivées!C0!"
if /i "!L!"=="FR" set "M12=Services inutiles !CR!désactivés!C0! (!CW!anticheats!C0! et pilotes intacts)"
if /i "!L!"=="FR" set "M13=Indexation Windows !CG!activée!C0! (recherche de fichiers)"
if /i "!L!"=="FR" set "M14=Plein écran exclusif !CG!forcé!C0!, GPU hautes performances sur les !CC!7!C0! jeux"
if /i "!L!"=="FR" set "M15=!CW!GameDVR!C0! !CR!off!C0!, !CW!Mode Jeu!C0! !CG!on!C0!, optimisations jeux fenêtrés !CG!on!C0!"
if /i "!L!"=="FR" set "M16=!CW!Defender!C0! : jeux !CG!exclus!C0!, analyse planifiée !CR!off!C0!, analyses bridées"
if /i "!L!"=="FR" set "M16NT=!CW!Protection temps réel laissée ON!C0! (jamais coupée : Defender lève une alerte)"
if /i "!L!"=="FR" set "M17=Debloat !CG!effectué!C0! (!CW!Store, Sécurité, Capture, Calculatrice, Paint, Spotify!C0! gardés)"
if /i "!L!"=="FR" set "M19=!CW!Outlook!C0! (nouveau) !CR!retiré!C0!"
if /i "!L!"=="FR" set "M20=!CW!Confidentialité!C0! : accès applis !CR!off!C0! sauf !CG!microphone!C0! ; applis en arrière-plan !CR!off!C0!"
if /i "!L!"=="FR" set "M72=!CW!Infos de saisie!C0! + !CW!suggestions!C0! + spotlight/voix/presse-papier !CR!OFF!C0!"
if /i "!L!"=="FR" set "M73=!CW!MSI mode!C0! sur le GPU (interruptions signalées) : !CG!ON!C0! (au reboot)"
if /i "!L!"=="FR" set "M74=Historique presse-papier, bouton Chat, récents Explorateur, Cortana, sons, verrouillage/veille !CR!OFF!C0!"
if /i "!L!"=="FR" set "M75=!CW!nag OOBE!C0!, redémarrage auto MAJ, feedback, réveil maintenance, animation 1re connexion !CR!OFF!C0!"
if /i "!L!"=="FR" set "M21=!CW!Caméra!C0! !CG!gardée active!C0! (applis autorisées)"
if /i "!L!"=="FR" set "M22=!CW!Caméra!C0! !CR!désactivée!C0! (périphérique et accès applis off)"
if /i "!L!"=="FR" set "M23=!CW!Caméra!C0! !CG!restaurée!C0! (périphérique réactivé)"
if /i "!L!"=="FR" set "M24=!CW!Wi-Fi + Ethernet!C0! : inchangé"
if /i "!L!"=="FR" set "M25=!CW!Wi-Fi!C0! !CR!désactivé!C0! (service et adaptateurs)"
if /i "!L!"=="FR" set "M26=!CW!Wi-Fi!C0! !CG!restauré!C0! (service et adaptateurs)"
if /i "!L!"=="FR" set "M25E=!CW!Ethernet!C0! !CR!désactivé!C0! (adaptateur)"
if /i "!L!"=="FR" set "M26E=!CW!Ethernet!C0! !CG!restauré!C0! (adaptateur)"
if /i "!L!"=="FR" set "M27=!CW!Bluetooth!C0! : inchangé"
if /i "!L!"=="FR" set "M28=!CW!Bluetooth!C0! !CR!désactivé!C0! (services et radios)"
if /i "!L!"=="FR" set "M29=!CW!Bluetooth!C0! !CG!restauré!C0! (services et radios)"
if /i "!L!"=="FR" set "M30=!CW!Imprimante!C0! : inchangée"
if /i "!L!"=="FR" set "M31=!CW!Imprimante!C0! !CR!désactivée!C0! (spouleur off)"
if /i "!L!"=="FR" set "M32=!CW!Imprimante!C0! !CG!restaurée!C0! (spouleur on)"
if /i "!L!"=="FR" set "M33=!CW!Xbox!C0! : inchangé"
if /i "!L!"=="FR" set "M34=!CW!Xbox!C0! !CR!supprimé!C0! (apps, services, tâche)"
if /i "!L!"=="FR" set "M35=!CW!Xbox!C0! !CG!restauré!C0! (services en manuel)"
if /i "!L!"=="FR" set "M36=!CW!OneDrive!C0! !CR!désinstallé!C0!"
if /i "!L!"=="FR" set "M40=!CW!Apparence!C0! : transparence, accent gris, fond noir, !CW!thème sombre!C0!"
if /i "!L!"=="FR" set "M40L=!CW!Apparence!C0! : effets visuels !CR!off!C0! (petit GPU / RAM <= 16 Go), !CW!lissage des polices!C0! + !CW!sélection translucide!C0! gardés, !CW!thème sombre!C0!"
if /i "!L!"=="FR" set "M43=Barre des tâches épurée (recherche masquée, combinée, !CW!Widgets!C0! !CR!off!C0!, !CW!Task View!C0! !CR!off!C0!, Terminer la tâche !CG!on!C0!)"
if /i "!L!"=="FR" set "M44=!CW!Menu Démarrer!C0! : pas de reco, pas d'applis récentes, notifs !CR!off!C0!"
if /i "!L!"=="FR" set "M45=!CW!Explorateur!C0! : éléments masqués visibles, extensions !CG!on!C0!, ouvre sur !CW!Ce PC!C0!"
if /i "!L!"=="FR" set "M46=!CW!Avertissements de sécurité!C0! !CR!off!C0!"
if /i "!L!"=="FR" set "M47=Ancrage et multitâche !CG!on!C0!, Aero Shake !CR!off!C0!"
if /i "!L!"=="FR" set "M48=!CW!UAC!C0! : !CY!ne prévient jamais!C0! (élévation silencieuse)"
if /i "!L!"=="FR" set "M49=Bureau à distance et Assistance à distance !CR!off!C0!"
if /i "!L!"=="FR" set "M50=Intégrité mémoire (core isolation) !CG!gardée on!C0! - requise par certains !CW!anticheats!C0!"
if /i "!L!"=="FR" set "M50OFF=Intégrité mémoire + VBS + hyperviseur !CR!OFF!C0! (sans anticheat, perf max)"
if /i "!L!"=="FR" set "M51=!CW!Démarrage!C0! : pas d'interface, OS non affiché, délai !CC!0 seconde!C0!"
if /i "!L!"=="FR" set "M52=Périphériques fantômes (débranchés) !CR!supprimés!C0!"
if /i "!L!"=="FR" set "M53=!CW!Extras!C0! : FTH !CR!off!C0!, délai de démarrage des applis !CC!0!C0!, arrêt accéléré"
if /i "!L!"=="FR" set "M54L=!CW!Performances optimales!C0! : USB suspend !CR!off!C0!, ASPM !CR!off!C0!, jamais de veille; parking/C-states selon le CPU"
if /i "!L!"=="FR" set "M54S=!CW!Performances élevées!C0! : USB suspend !CR!off!C0!, ASPM !CR!off!C0! ; parking/C-states selon le CPU"
if /i "!L!"=="FR" set "M55=!CW!HAGS!C0! supporté : !CG!activé!C0! (effet au redémarrage)"
if /i "!L!"=="FR" set "M56=!CW!HAGS!C0! non exposé par la plateforme : !CY!non activé!C0!"
if /i "!L!"=="FR" set "M57=!CW!Démarrage rapide!C0! !CG!activé!C0!"
if /i "!L!"=="FR" set "M58=!CW!Icônes au démarrage masquées!C0! : !CW!Vanguard + Defender!C0! (services actifs)"
if /i "!L!"=="FR" set "M59=Pilotes maintenus !CG!à jour!C0! via Windows Update"
if /i "!L!"=="FR" set "M60=!CW!Optimisation des disques!C0! : tâche !CW!Windows!C0! native !CG!on!C0! (silencieuse, quotidienne)"
if /i "!L!"=="FR" set "M61=!CW!Assistant de stockage!C0! !CG!on!C0! : temp + corbeille 1j, chaque jour (!CW!Téléchargements non touchés!C0!)"
if /i "!L!"=="FR" set "M62=!CW!Nettoyage!C0! : temp, cache !CW!Discord/Steam!C0!, WinSxS, Windows.old, corbeille"
if /i "!L!"=="FR" set "M63=!CW!Windows Update!C0! !CY!en cours!C0! (y compris les !CW!facultatives!C0!)... peut être long, ne ferme pas"
if /i "!L!"=="FR" set "M64=!CW!Windows Update!C0! !CG!terminé!C0!"
if /i "!L!"=="FR" set "M66=Mise à jour des applis via !CW!winget!C0!... peut être long"
if /i "!L!"=="FR" set "M67=!CW!winget!C0! !CG!terminé!C0!"
if /i "!L!"=="FR" set "M69=Timer Windows forcé à !CC!0.5 ms!C0! au démarrage (aucun outil externe)"
if /i "!L!"=="FR" set "M69NG=!CR!Tâche timer NON enregistrée!C0! - relance en admin, puis reboot"
if /i "!L!"=="FR" set "M71=Réglages ré-appliqués !CG!seulement après une MAJ Windows!C0! ; nettoyage sûr temp + DNS !CG!à chaque session!C0!"
if /i "!L!"=="FR" set "RJRN=Restauré : !CW!valeurs d'origine!C0! rendues, nombre :"
if /i "!L!"=="FR" set "R0=Restauré : !CW!noyau CPU/RAM!C0! par défaut"
if /i "!L!"=="FR" set "R1=Restauré : !CW!réseau!C0! par défaut"
if /i "!L!"=="FR" set "R2=Restauré : !CW!priorités par jeu et plein écran!C0! par défaut"
if /i "!L!"=="FR" set "R3=Restauré : !CW!GameDVR et affûtage NVIDIA!C0! par défaut"
if /i "!L!"=="FR" set "R4=Restauré : !CW!timers, démarrage et NTFS!C0! par défaut"
if /i "!L!"=="FR" set "R5=Restauré : !CW!services!C0! par défaut"
if /i "!L!"=="FR" set "R6=Restauré : !CW!UAC, distance, SmartScreen, alimentation, télémétrie!C0! ; blocage !CW!AMD!C0! retiré"
if /i "!L!"=="FR" set "R7=Restauré : !CW!tâches personnalisées!C0! retirées"
if /i "!L!"=="FR" set "QMODE_HEAD=CHOISIS TON MODE D'OPTIMISATION"
if /i "!L!"=="FR" set "QVBS_HEAD=GARDER LA SéCURITé NOYAU + VIRTUALISATION ?"
if /i "!L!"=="FR" set "QVBS_YES_NAME=OUI - garder ON (anticheat / VM / WSL2 / IA)"
if /i "!L!"=="FR" set "QVBS_YES_DESC=Garde VBS / HVCI / hyperviseur ON - nécessite : Vanguard / FACEIT,"
if /i "!L!"=="FR" set "QVBS_YES_DESC2=WSL2 / Hyper-V / VM, Copilot et Recall"
if /i "!L!"=="FR" set "QVBS_NO_NAME=NON - couper pour la perf max"
if /i "!L!"=="FR" set "QVBS_NO_DESC=Coupe VBS / HVCI / hyperviseur OFF + Copilot / Recall OFF - perf pure,"
if /i "!L!"=="FR" set "QVBS_NO_DESC2=pas d'anticheat, pas de VM, pas d'IA"
if /i "!L!"=="FR" set "M9A_AI_KEPT=IA / Copilot / Recall gardés ON - VBS gardé pour anticheat/VM/IA"
if /i "!L!"=="FR" set "M9A_AI_OFF=IA / Copilot / Recall coupés OFF - VBS off pour la perf max"
if /i "!L!"=="FR" set "QMODE_S_NAME=MODE SOUPLE"
if /i "!L!"=="FR" set "QMODE_S_DESC=Gros gain de latence, toutes les protections restent actives. Sûr si tu hésites."
if /i "!L!"=="FR" set "QMODE_L_NAME=LATENCE MINIMALE"
if /i "!L!"=="FR" set "QMODE_L_DESC=Tout ce que Souple fait, plus priorité par jeu et timeout GPU. Chauffe plus."
if /i "!L!"=="FR" set "MODE_ACTIVE=MODE ACTIF"
if /i "!L!"=="FR" set "PROMPT=Ton choix : "
if /i "!L!"=="FR" set "DET_GPU=Carte graphique"
if /i "!L!"=="FR" set "DET_RAM=Mémoire vive "
if /i "!L!"=="FR" set "DET_CPU=Processeur   "
if /i "!L!"=="FR" set "DET_CORES=coeurs"
if /i "!L!"=="FR" set "DET_TYPE=Type machine "
if /i "!L!"=="FR" set "TYPEFIXE=PC fixe"
if /i "!L!"=="FR" set "TYPEPORT=Portable"
if /i "!L!"=="FR" set "DET_THRESH=seuil svchost"
if /i "!L!"=="FR" set "DET_GB=Go"
if /i "!L!"=="FR" set "DET_KB=Ko"
if /i "!L!"=="FR" set "Q_INTRO=Réponds aux questions ci-dessous (une touche; tape 0 pour revenir) :"
if /i "!L!"=="FR" set "QH_CAM=CAMÉRA"
if /i "!L!"=="FR" set "QH_WIFI=CARTES RÉSEAU (WI-FI / ETHERNET)"
if /i "!L!"=="FR" set "QH_BT=BLUETOOTH"
if /i "!L!"=="FR" set "QH_PRINT=IMPRIMANTE"
if /i "!L!"=="FR" set "QH_XBOX=XBOX"
if /i "!L!"=="FR" set "QO_YESNO=!CG![1] Oui!C0!  !CR![2] Non!C0!"
if /i "!L!"=="FR" set "CFM_KEEP=inchangé"
if /i "!L!"=="FR" set "CFM_OFF=désactivé"
if /i "!L!"=="FR" set "CFM_RST=restauré"
if /i "!L!"=="FR" set "QO_CAM=!CL![1] Garder active!C0!  !CR![2] Désactiver!C0!  !CG![3] Restaurer défaut!C0!"
if /i "!L!"=="FR" set "QO_NDR=!CL![1] Ne rien faire!C0!  !CR![2] Désactiver!C0!  !CG![3] Restaurer défaut!C0!"
if /i "!L!"=="FR" set "QO_NET=!CL![1] Garder!C0!  !CR![2] Désactiver Wi-Fi!C0!  !CR![3] Désactiver Ethernet!C0!"
if /i "!L!"=="FR" set "QO_NET2=!CG![4] Restaurer Wi-Fi!C0!  !CG![5] Restaurer Ethernet!C0!"
if /i "!L!"=="FR" set "QO_XBOX=!CL![1] Ne rien faire!C0!  !CR![2] Tout supprimer!C0!  !CG![3] Restaurer services!C0!"
if /i "!L!"=="FR" set "APPLYING=Application des optimisations, patiente..."
if /i "!L!"=="FR" set "DONE_APPLY=TERMINÉ"
if /i "!L!"=="FR" set "SUMMARY_HEAD=RÉSUMÉ"
if /i "!L!"=="FR" set "SUM02=Le jeu au premier plan a la !CG!priorité maximale!C0!."
if /i "!L!"=="FR" set "SUM03=CPU totalement !CG!déparké!C0!, aucun économiseur, pas de veille."
if /i "!L!"=="FR" set "SUM03L=Parking CPU laissé par !CG!défaut!C0!, C-states gardés (batterie)."
if /i "!L!"=="FR" set "M5LAP=!CW!ULPS!C0! gardé ON pour la batterie"
if /i "!L!"=="FR" set "LAPDET=Portable détecté -> réglages batterie + thermiques forcés par-dessus le mode choisi."
if /i "!L!"=="FR" set "SUMLAP=Réglages portable : timer sur secteur seulement, ULPS gardé, parking CPU par défaut, plan Perf élevées, dynamic tick on, éco Wi-Fi sur batterie."
if /i "!L!"=="FR" set "SUM04=Souris !CG!1:1!C0!, zéro accélération Windows."
if /i "!L!"=="FR" set "SUM05=Réseau réglé pour le minimum de lag."
if /i "!L!"=="FR" set "SUM06=Mouchards, télémétrie et services inutiles !CR!coupés!C0!."
if /i "!L!"=="FR" set "SUM07=Blocage pub + télémétrie MS via hosts (!CC!215 domaines!C0! + exclusion Defender)."
if /i "!L!"=="FR" set "SUM08=!CW!Widgets, Outlook (nouveau), Task View!C0! !CR!retirés!C0!."
if /i "!L!"=="FR" set "SUM09=Plein écran exclusif + GPU hautes performances sur les jeux."
if /i "!L!"=="FR" set "SUM11=Intégrité mémoire !CG!gardée on!C0!, !CW!UAC!C0! ne prévient jamais."
if /i "!L!"=="FR" set "SUM12=Bureau à distance !CR!off!C0!, indexation !CG!activée!C0!."
if /i "!L!"=="FR" set "SUM13=Apparence : transparence, accent gris, fond noir, secondes."
if /i "!L!"=="FR" set "SUM14=Disques optimisés par la tâche native + !CW!Assistant de stockage!C0!."
if /i "!L!"=="FR" set "SUM15=Nettoyage temp, cache et !CW!Windows.old!C0! effectué."
if /i "!L!"=="FR" set "SUM16=Timer forcé à !CC!0.5 ms!C0! au démarrage (aucun outil externe)."
if /i "!L!"=="FR" set "SUM17=Réglages clés ré-appliqués après les MAJ ; nettoyage sûr !CG!à chaque session!C0!."
if /i "!L!"=="FR" set "SUM18=Infos de saisie, suggestions, spotlight écran verrouillé, voix en ligne, actions suggérées : OFF"
if /i "!L!"=="FR" set "SUM_DEV=Périphériques & Xbox (!CW!caméra, Wi-Fi, Bluetooth, imprimante!C0!) : selon tes choix."
if /i "!L!"=="FR" set "Q_RESTART=Redémarrer le PC maintenant pour tout appliquer ?"
if /i "!L!"=="FR" set "RESTARTING=Redémarrage dans 5 secondes..."
if /i "!L!"=="FR" set "RESTART_LATER=OK - pense à redémarrer plus tard pour tout appliquer."
if /i "!L!"=="FR" set "REST_INTRO=Restauration des valeurs par défaut Windows..."
if /i "!L!"=="FR" set "REST_DONE_HEAD=RESTAURATION TERMINÉE"
if /i "!L!"=="FR" set "REST_NOTE1=Valeurs par défaut Windows restaurées."
if /i "!L!"=="FR" set "REST_NOTE2=Non auto-restauré : applis debloatées, OneDrive, épingles."
if /i "!L!"=="FR" set "REST_NOTE3=L'isolation du noyau n'a PAS été touchée par ce script."
if /i "!L!"=="FR" set "SIGN_BY=par"
if /i "!L!"=="FR" set "SIGN_TAIL=réalisé avec Claude.ai"
if /i "!L!"=="FR" set "BAN_A=Moteur système : CPU, planificateur, GPU, souris, réseau"
if /i "!L!"=="FR" set "BAN_B=Confidentialité, télémétrie et mode jeu"
if /i "!L!"=="FR" set "BAN_C=Périphériques & Xbox (selon tes choix)"
if /i "!L!"=="FR" set "BAN_D=Applis, apparence et interface"
if /i "!L!"=="FR" set "BAN_E=Alimentation et démarrage"
if /i "!L!"=="FR" set "BAN_F=Disques et maintenance"
if /i "!L!"=="FR" set "BAN_G=Mises à jour"
if /i "!L!"=="FR" set "BAN_H=Latence temps réel"
if /i "!L!"=="FR" set "BACK=Retour"
if /i "!L!"=="FR" set "PHEAD=PÉRIPHÉRIQUES - désactiver ou restaurer"
if /i "!L!"=="FR" set "PH1=Caméra"
if /i "!L!"=="FR" set "PH2=Cartes réseau (Wi-Fi / Ethernet)"
if /i "!L!"=="FR" set "PH3=Bluetooth"
if /i "!L!"=="FR" set "PH4=Imprimante"
if /i "!L!"=="FR" set "PH5=Xbox"
if /i "!L!"=="FR" set "PDONE=Terminé."
:_strdone
rem ============ LISTE DES JEUX (source unique) ============
rem Elle etait ecrite a quatre endroits en v3.9 et avait deja diverge :
rem la tache de re-application n en connaissait que 10 sur 13.
set "GAMES="cs2.exe" "League of Legends.exe" "Brawlhalla.exe" "RainbowSix.exe" "RainbowSix_DX11.exe" "VALORANT-Win64-Shipping.exe" "VALORANT.exe" "r5apex.exe" "r5apex_dx12.exe" "FortniteClient-Win64-Shipping.exe" "Warframe.x64.exe" "Warframe.exe" "RobloxPlayerBeta.exe""
rem Meme liste pour le regex PowerShell (FSO / preference GPU)
set "GAMESRX=cs2\.exe|League of Legends\.exe|Brawlhalla\.exe|RainbowSix|VALORANT|r5apex|FortniteClient|Warframe|RobloxPlayerBeta"

rem ============ MENU AIO ============
set "AHEAD=Choose an action:"
set "AO1=Apply optimizations   (full: tweaks + cleanup + updates)"
set "AO2=Apply optimizations   (fast: no questions, tweaks only)"
set "AO3=0.5 ms timer + NVIDIA tweak (old sharpening method)"
set "AO4=QWERTY keyboard layout"
set "AO5=Restore all Windows defaults"
set "AO6=Restore Spectre/Meltdown mitigations"
set "AO7=Restore Defender real-time protection"
set "AO8=Peripherals: disable / restore  (Wi-Fi, printer, Xbox, BT, camera)"
set "AO9=Verification / debug tool"
set "AO0=Quit"
if /i "!L!"=="FR" set "AHEAD=Choisis une action :"
if /i "!L!"=="FR" set "AO1=Appliquer les optimisations   (complet : tweaks + nettoyage + MAJ)"
if /i "!L!"=="FR" set "AO2=Appliquer les optimisations   (rapide : sans questions)"
if /i "!L!"=="FR" set "AO3=Timer 0.5 ms + tweak NVIDIA (ancienne méthode de sharpening)"
if /i "!L!"=="FR" set "AO4=Disposition clavier QWERTY"

if /i "!L!"=="FR" set "AO5=Restaurer les valeurs Windows"
if /i "!L!"=="FR" set "AO6=Restaurer les mitigations Spectre/Meltdown"
if /i "!L!"=="FR" set "AO7=Restaurer la protection temps réel Defender"
if /i "!L!"=="FR" set "AO8=Périphériques : désactiver / restaurer  (Wi-Fi, imprimante, Xbox, BT, caméra)"
if /i "!L!"=="FR" set "AO9=Outil de vérification / debug"
if /i "!L!"=="FR" set "AO0=Quitter"
set "MOPT=OPTIMIZER"
set "MCAT1=optimize"
set "MCAT2=standalone tweaks"
set "MCAT3=system"
if /i "!L!"=="FR" set "MOPT=OPTIMISEUR"
if /i "!L!"=="FR" set "MCAT1=optimisation"
if /i "!L!"=="FR" set "MCAT2=réglages indépendants"
if /i "!L!"=="FR" set "MCAT3=système"
set "SIG_MW=Made with "
if /i "!L!"=="FR" set "SIG_MW=Fait avec "

:MENU
rem -- Override defensive : force les strings du menu (ecrase tout heritage cmd/environnement) --
set "AHEAD=Choose an action:"
set "AO1=Apply optimizations   (full: tweaks + cleanup + updates)"
set "AO2=Apply optimizations   (fast: no questions, tweaks only)"
set "AO3=0.5 ms timer + NVIDIA tweak (old sharpening method)"
set "AO4=QWERTY keyboard layout"
set "AO5=Restore all Windows defaults"
set "AO6=Restore Spectre/Meltdown mitigations"
set "AO7=Restore Defender real-time protection"
set "AO8=Peripherals: disable / restore  (Wi-Fi, printer, Xbox, BT, camera)"
set "AO9=Verification / debug tool"
set "AO0=Quit"
if /i "!L!"=="FR" set "AHEAD=Choisis une action :"
if /i "!L!"=="FR" set "AO1=Appliquer les optimisations   (complet : tweaks + nettoyage + MAJ)"
if /i "!L!"=="FR" set "AO2=Appliquer les optimisations   (rapide : sans questions)"
if /i "!L!"=="FR" set "AO3=Timer 0.5 ms + tweak NVIDIA (ancienne méthode de sharpening)"
if /i "!L!"=="FR" set "AO4=Disposition clavier QWERTY"
if /i "!L!"=="FR" set "AO5=Restaurer les valeurs Windows"
if /i "!L!"=="FR" set "AO6=Restaurer les mitigations Spectre/Meltdown"
if /i "!L!"=="FR" set "AO7=Restaurer la protection temps réel Defender"
if /i "!L!"=="FR" set "AO8=Périphériques : désactiver / restaurer  (Wi-Fi, imprimante, Xbox, BT, caméra)"
if /i "!L!"=="FR" set "AO9=Outil de vérification / debug"
if /i "!L!"=="FR" set "AO0=Quitter"
cls
echo.
echo   !CB2!===============================================================!C0!
echo.
echo        !CO!WIN11!C0!  !CW!LOW-LATENCY!C0!  !CG2!!MOPT!!C0!   !CK!:!C0!   !CT!ALL-IN-ONE!C0!
echo                              !CK!- !SCRIPT_VER! -!C0!
echo.
echo   !CB2!===============================================================!C0!
echo.
echo   !ESC![38;5;228m@!ESC![38;5;227ms!ESC![38;5;226mo!ESC![38;5;220mf!ESC![38;5;214ma!ESC![38;5;208ml!ESC![38;5;202mo!ESC![38;5;166ms!ESC![38;5;130mt!C0!                         !CK!!SIG_MW!!CB1!Claude!CK!.!CW!ai!C0!
echo.
echo   !CY!!AHEAD!!C0!
echo.
echo   !CK!   !MCAT1!!C0!
echo       !CO![1]!C0!   !AO1!
echo       !CO2![2]!C0!   !AO2!
echo.
echo   !CK!   !MCAT2!!C0!
echo       !CG2![3]!C0!   !AO3!
if /i "!L!"=="FR" echo       !CGE![4]!C0!   !AO4!
echo.
echo   !CK!   !MCAT3!!C0!
echo       !CBG1![5]!C0!   !AO5!
echo       !CBG2![6]!C0!   !AO6!
echo       !CBG3![7]!C0!   !AO7!
echo       !CBG4![8]!C0!   !AO8!
echo.
echo       !CJ![9]!C0!   !AO9!
echo       !CK![0]!C0!   !AO0!
echo.
choice /C 1234567890 /N /M "   !PROMPT!"
set "CH=!errorlevel!"
if "!CH!"=="1" set "FASTMODE=0"
if "!CH!"=="1" goto _aiofast
if "!CH!"=="2" set "FASTMODE=1"
if "!CH!"=="2" goto _aiofast
if "!CH!"=="3" goto TIMERNV
if "!CH!"=="4" if /i "!L!"=="FR" goto QWMENU
if "!CH!"=="5" goto RESTORE
if "!CH!"=="6" goto SPECREVERT
if "!CH!"=="7" goto RTREVERT
if "!CH!"=="8" goto PERIPH
if "!CH!"=="9" goto DEBUGRUN
if "!CH!"=="10" goto AIOEND
goto MENU
:_aiofast
powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; Add-MpPreference -ExclusionPath '%~f0'" >nul 2>&1
rem ============ DETECTION ============
set "GPUVENDOR=OTHER"
for /f "usebackq delims=" %%g in (`powershell -NoProfile -Command "$v=(Get-CimInstance Win32_VideoController).Name -join ' '; if($v -match 'NVIDIA'){'NVIDIA'}elseif($v -match 'AMD|Radeon'){'AMD'}else{'OTHER'}"`) do set "GPUVENDOR=%%g"
set "RAMGB=0"
for /f "usebackq delims=" %%g in (`powershell -NoProfile -Command "[math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory/1GB)"`) do set "RAMGB=%%g"
set "ISIGPU=0"
for /f "usebackq delims=" %%g in (`powershell -NoProfile -Command "$n=@(Get-CimInstance Win32_VideoController -EA SilentlyContinue | Where-Object{$_.Name}); $i=@($n | Where-Object{$_.Name -match 'UHD Graphics|Iris|HD Graphics [0-9]|Vega [0-9]+ Graphics|Radeon\(TM\) Graphics|Radeon Graphics'}); if($i.Count -ge 1 -and $i.Count -eq $n.Count){'1'}else{'0'}"`) do set "ISIGPU=%%g"
set "LIGHTFX=0"
if "!ISIGPU!"=="1" set "LIGHTFX=1"
if !RAMGB! GEQ 1 if !RAMGB! LEQ 16 set "LIGHTFX=1"
set "CPUVENDOR=OTHER"
for /f "usebackq delims=" %%g in (`powershell -NoProfile -Command "$c=(Get-CimInstance Win32_Processor).Name -join ' '; if($c -match 'Intel'){'Intel'}elseif($c -match 'AMD|Ryzen'){'AMD'}else{'OTHER'}"`) do set "CPUVENDOR=%%g"
set "ISX3D=0"
for /f "usebackq delims=" %%g in (`powershell -NoProfile -Command "$c=(Get-CimInstance Win32_Processor).Name -join ' '; if($c -match 'X3D'){'1'}else{'0'}"`) do set "ISX3D=%%g"
set "CPUCORES=?"
for /f "usebackq delims=" %%g in (`powershell -NoProfile -Command "(Get-CimInstance Win32_Processor | Measure-Object -Property NumberOfCores -Sum).Sum"`) do set "CPUCORES=%%g"
set "X3DMULTI=0"
set "_CORES=0"
set /a "_CORES=!CPUCORES!" >nul 2>&1
if "!ISX3D!"=="1" if /i "!CPUVENDOR!"=="AMD" if !_CORES! GTR 8 set "X3DMULTI=1"
set /a SVCKB=!RAMGB! * 1048576 2>nul
if not defined SVCKB set "SVCKB=33554432"
if "!SVCKB!"=="0" set "SVCKB=33554432"
set "STEAMPATH="
for /f "tokens=2,*" %%a in ('reg query "HKCU\Software\Valve\Steam" /v SteamPath 2^>nul ^| find /i "SteamPath"') do set "STEAMPATH=%%b"
if defined STEAMPATH set "STEAMPATH=!STEAMPATH:/=\!"
set "ISLAPTOP=0"
for /f "usebackq delims=" %%g in (`powershell -NoProfile -Command "$b=@(Get-CimInstance Win32_Battery -EA SilentlyContinue).Count; $c=@((Get-CimInstance Win32_SystemEnclosure -EA SilentlyContinue).ChassisTypes); if(($b -ge 1) -or (($c | Where-Object{$_ -in @(8,9,10,11,12,14,30,31,32)}).Count -gt 0)){'1'}else{'0'}"`) do set "ISLAPTOP=%%g"
set "HASWIFI=0"
for /f "usebackq delims=" %%g in (`powershell -NoProfile -Command "if(Get-NetAdapter -Physical -EA SilentlyContinue | Where-Object{$_.PhysicalMediaType -like '*802.11*' -or $_.InterfaceDescription -like '*Wireless*' -or $_.Name -like '*Wi-Fi*'}){'1'}else{'0'}"`) do set "HASWIFI=%%g"
set "PCTYPE=!TYPEFIXE!"
if "!ISLAPTOP!"=="1" set "PCTYPE=!TYPEPORT!"
set "AMDLOCK=0"
for /f "usebackq delims=" %%g in (`powershell -NoProfile -Command "$v=(Get-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Video\*\0000' -Name RadeonSoftwareVersion -EA SilentlyContinue | Select-Object -First 1).RadeonSoftwareVersion; if($v -like '25.9.1*'){'1'}else{'0'}"`) do set "AMDLOCK=%%g"
echo.
echo   !CC!  !DET_GPU!  !CK!....!C0!  !CW!!GPUVENDOR!!C0!
echo   !CC!  !DET_RAM!  !CK!....!C0!  !CW!!RAMGB! !DET_GB!!C0!   !CK!(!DET_THRESH! = !SVCKB! !DET_KB!)!C0!
set "CPUDISP=!CPUVENDOR!"
if "!ISX3D!"=="1" set "CPUDISP=!CPUVENDOR! X3D mono-CCD"
if "!X3DMULTI!"=="1" set "CPUDISP=!CPUVENDOR! X3D bi-CCD"
echo   !CC!  !DET_CPU!  !CK!....!C0!  !CW!!CPUDISP!, !CPUCORES! !DET_CORES!!C0!
echo   !CC!  !DET_TYPE!  !CK!....!C0!  !CW!!PCTYPE!!C0!
if "!ISLAPTOP!"=="1" echo.
if "!ISLAPTOP!"=="1" echo   !CO!  [ // ]  !LAPDET!!C0!
echo.

rem ============ QUESTIONS ============
rem -- Mode rapide [2] : aucune question. On relit les reponses du dernier
rem    passage complet dans HKLM\SOFTWARE\LowLatOptimizer ; a defaut on prend
rem    le choix neutre 1 = ne rien changer, jamais 2 = desactiver. Un mode
rem    rapide ne doit couper aucun peripherique que l utilisateur n a pas
rem    explicitement demande de couper. --
if not "!FASTMODE!"=="1" goto QQ_VBS
set "NOVBS=0"
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\LowLatOptimizer" /v NoVBS 2^>nul ^| findstr /i /c:"REG_"') do set "NOVBS=%%a"
if not "!NOVBS!"=="1" set "NOVBS=0"
set "MM=1"
for /f "tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\LowLatOptimizer" /v Mode 2^>nul ^| findstr /i /c:"REG_SZ"') do set "FMODE=%%b"
if /i "!FMODE!"=="lowest" set "MM=2"
for %%Q in ("QCam CAM" "QWifi WIFI" "QBt BT" "QPrint PRINT" "QXbox XBOX") do (
    for /f "tokens=1,2" %%x in ("%%~Q") do (
        set "%%y=1"
        for /f "tokens=3" %%v in ('reg query "HKLM\SOFTWARE\LowLatOptimizer" /v %%x 2^>nul ^| findstr /i /c:"REG_"') do set /a %%y=%%v 2>nul
        if not defined %%y set "%%y=1"
    )
)
if not defined CAM set "CAM=1"
if not defined WIFI set "WIFI=1"
if not defined BT set "BT=1"
if not defined PRINT set "PRINT=1"
if not defined XBOX set "XBOX=1"
goto _qmode_apply
:QQ_VBS
echo.
echo   !CC!=============================================================!C0!
echo                !CW!!QVBS_HEAD!!C0!
echo   !CC!=============================================================!C0!
echo.
echo     !CG![1]   [ + ]   !CW!!QVBS_YES_NAME!!C0!
echo            !CK!!QVBS_YES_DESC!!C0!  !CK!!QVBS_YES_DESC2!!C0!
echo.
echo     !CO3![2]   [ - ]   !CW!!QVBS_NO_NAME!!C0!
echo            !CK!!QVBS_NO_DESC!!C0!  !CK!!QVBS_NO_DESC2!!C0!
echo.
echo     !CK![0]   !BACK!!C0!
echo.
choice /C 120 /N /M "        !PROMPT!"
set "QVBSR=!errorlevel!"
if "!QVBSR!"=="3" goto MENU
set "NOVBS=0"
if "!QVBSR!"=="2" set "NOVBS=1"
:QQ_MODE
echo.
echo   !CC!=============================================================!C0!
echo                !CW!!QMODE_HEAD!!C0!
echo   !CC!=============================================================!C0!
echo.
echo     !CG![1]   [~~]   !CW!!QMODE_S_NAME!!C0!
echo            !CK!!QMODE_S_DESC!!C0!
echo.
echo     !CO![2]   [//]   !CW!!QMODE_L_NAME!!C0!
echo            !CK!!QMODE_L_DESC!!C0!
echo.
echo     !CK![0]   !BACK!!C0!
echo.
choice /C 120 /N /M "        !PROMPT!"
set "MM=!errorlevel!"
if "!MM!"=="3" goto MENU
:_qmode_apply
if "!MM!"=="2" (
    set "PRIOSEP=42"
    set "SYSRESP=0"
    set "DYNTICK=yes"
    set "CTHEME=!CO!"
    set "MODENAME=!QMODE_L_NAME!"
    set "MODEMARK=lowest"
) else (
    set "PRIOSEP=38"
    set "SYSRESP=10"
    set "DYNTICK=no"
    set "CTHEME=!CG!"
    set "MODENAME=!QMODE_S_NAME!"
    set "MODEMARK=soft"
)
set "M3=!M3L!"
set "M54=!M54L!"
if "!MODEMARK!"=="soft" set "M3=!M3S!"
if "!MODEMARK!"=="soft" set "M54=!M54S!"
if "!ISLAPTOP!"=="1" set "DYNTICK=no"
if "!ISLAPTOP!"=="1" set "M54=!M54S!"
if "!ISLAPTOP!"=="1" set "SUM03=!SUM03L!"
echo.
echo      !CW!  [*] !MODE_ACTIVE! :!C0!  !CTHEME!!MODENAME!!C0!
echo.
echo  !CY!!Q_INTRO!!C0!
echo.
if "!FASTMODE!"=="1" goto _qq_done
:QQ_CAM
echo   !CY![ ? ]!C0!  !CW!!QH_CAM!!C0!
echo.
echo        !QO_CAM!!C0!
echo        !CK![0] !BACK!!C0!
echo.
<nul set /p "=        !PROMPT!"
choice /C 1230 /N >nul
set "CAM=!errorlevel!"
if "!CAM!"=="1" echo !CL!!QH_CAM! : !CFM_KEEP!!C0!
if "!CAM!"=="2" echo !CR!!QH_CAM! : !CFM_OFF!!C0!
if "!CAM!"=="3" echo !CG!!QH_CAM! : !CFM_RST!!C0!
if "!CAM!"=="4" goto :QQ_MODE
echo.
:QQ_WIFI
echo   !CY![ ? ]!C0!  !CW!!QH_WIFI!!C0!
echo.
echo        !QO_NET!!C0!
echo        !QO_NET2!!C0!
echo        !CK![0] !BACK!!C0!
echo.
<nul set /p "=        !PROMPT!"
choice /C 123450 /N >nul
set "ANS=!errorlevel!"
if "!ANS!"=="6" echo.
if "!ANS!"=="6" goto QQ_CAM
set "WIFI=!ANS!"
if "!WIFI!"=="1" echo !CL!!CFM_KEEP!!C0!
if "!WIFI!"=="2" echo !CR!Wi-Fi : !CFM_OFF!!C0!
if "!WIFI!"=="3" echo !CR!Ethernet : !CFM_OFF!!C0!
if "!WIFI!"=="4" echo !CG!Wi-Fi : !CFM_RST!!C0!
if "!WIFI!"=="5" echo !CG!Ethernet : !CFM_RST!!C0!
echo.
:QQ_BT
echo   !CY![ ? ]!C0!  !CW!!QH_BT!!C0!
echo.
echo        !QO_NDR!!C0!
echo        !CK![0] !BACK!!C0!
echo.
<nul set /p "=        !PROMPT!"
choice /C 1230 /N >nul
set "ANS=!errorlevel!"
if "!ANS!"=="4" echo.
if "!ANS!"=="4" goto QQ_WIFI
set "BT=!ANS!"
if "!BT!"=="1" echo !CL!!QH_BT! : !CFM_KEEP!!C0!
if "!BT!"=="2" echo !CR!!QH_BT! : !CFM_OFF!!C0!
if "!BT!"=="3" echo !CG!!QH_BT! : !CFM_RST!!C0!
echo.
:QQ_PRINT
echo   !CY![ ? ]!C0!  !CW!!QH_PRINT!!C0!
echo.
echo        !QO_NDR!!C0!
echo        !CK![0] !BACK!!C0!
echo.
<nul set /p "=        !PROMPT!"
choice /C 1230 /N >nul
set "ANS=!errorlevel!"
if "!ANS!"=="4" echo.
if "!ANS!"=="4" goto QQ_BT
set "PRINT=!ANS!"
if "!PRINT!"=="1" echo !CL!!QH_PRINT! : !CFM_KEEP!!C0!
if "!PRINT!"=="2" echo !CR!!QH_PRINT! : !CFM_OFF!!C0!
if "!PRINT!"=="3" echo !CG!!QH_PRINT! : !CFM_RST!!C0!
echo.
:QQ_XBOX
echo   !CY![ ? ]!C0!  !CW!!QH_XBOX!!C0!
echo.
echo        !QO_XBOX!!C0!
echo        !CK![0] !BACK!!C0!
echo.
<nul set /p "=        !PROMPT!"
choice /C 1230 /N >nul
set "ANS=!errorlevel!"
if "!ANS!"=="4" echo.
if "!ANS!"=="4" goto QQ_PRINT
set "XBOX=!ANS!"
if "!XBOX!"=="1" echo !CL!!QH_XBOX! : !CFM_KEEP!!C0!
if "!XBOX!"=="2" echo !CR!!QH_XBOX! : !CFM_OFF!!C0!
if "!XBOX!"=="3" echo !CG!!QH_XBOX! : !CFM_RST!!C0!
echo.


:_qq_done
set "CAMALLOW=1"
if "!CAM!"=="2" set "CAMALLOW=0"

echo.
echo  !CC!============================================================!C0!
echo    !CG!Application en cours - chaque etape s'affiche en direct ci-dessous!C0!
echo  !CC!============================================================!C0!
echo.
cls
echo  !CC!================================================================!C0!
echo  !CW!                   LOW LATENCY GAMING SCRIPT!C0!
echo  !CB!                !BSUB!!C0!
echo  !CC!================================================================!C0!
echo.
echo   !CY!!APPLYING!!C0!
echo.
echo   !CK!------------------------------------------------------------!C0!
echo.
echo   !CC!::!C0!  !CM!!BAN_A!!C0!
echo.
rem ============ JOURNAL DE RESTAURATION ============
rem Chaque ecriture passe par :T, qui note d'abord la valeur que la machine
rem avait AVANT. :RESTORE rejoue ce journal : la restauration rend l'etat
rem d'origine reel de cette machine, pas un defaut suppose.
set "JRNDIR=%ProgramData%\LowLatOptimizer"
set "JRN=!JRNDIR!\restore-journal.csv"
if not exist "!JRNDIR!" md "!JRNDIR!" >nul 2>&1
if not exist "!JRN!" type nul >"!JRN!" 2>nul

rem ============ [01] NOYAU CPU / RAM ============
call :T "HKLM\SYSTEM\CurrentControlSet\Control" "SvcHostSplitThresholdInKB" REG_DWORD "!SVCKB!"
call :T "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" "Win32PrioritySeparation" REG_DWORD "!PRIOSEP!"
reg add "HKLM\SOFTWARE\LowLatOptimizer" /v Mode /t REG_SZ /d !MODEMARK! /f >nul 2>&1
reg add "HKLM\SOFTWARE\LowLatOptimizer" /v NoVBS /t REG_SZ /d !NOVBS! /f >nul 2>&1
reg add "HKLM\SOFTWARE\LowLatOptimizer" /v IsLaptop /t REG_SZ /d !ISLAPTOP! /f >nul 2>&1
reg add "HKLM\SOFTWARE\LowLatOptimizer" /v IsX3D /t REG_DWORD /d !ISX3D! /f >nul 2>&1
reg add "HKLM\SOFTWARE\LowLatOptimizer" /v X3DMulti /t REG_DWORD /d !X3DMULTI! /f >nul 2>&1
reg add "HKLM\SOFTWARE\LowLatOptimizer" /v SvcKB /t REG_DWORD /d !SVCKB! /f >nul 2>&1
reg add "HKLM\SOFTWARE\LowLatOptimizer" /v QCam /t REG_DWORD /d !CAM! /f >nul 2>&1
reg add "HKLM\SOFTWARE\LowLatOptimizer" /v QWifi /t REG_DWORD /d !WIFI! /f >nul 2>&1
reg add "HKLM\SOFTWARE\LowLatOptimizer" /v QBt /t REG_DWORD /d !BT! /f >nul 2>&1
reg add "HKLM\SOFTWARE\LowLatOptimizer" /v QPrint /t REG_DWORD /d !PRINT! /f >nul 2>&1
reg add "HKLM\SOFTWARE\LowLatOptimizer" /v QXbox /t REG_DWORD /d !XBOX! /f >nul 2>&1
reg add "HKLM\SOFTWARE\LowLatOptimizer" /v GpuVendor /t REG_SZ /d !GPUVENDOR! /f >nul 2>&1
reg add "HKLM\SOFTWARE\LowLatOptimizer" /v LightFX /t REG_DWORD /d !LIGHTFX! /f >nul 2>&1
call :T "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" "GlobalTimerResolutionRequests" REG_DWORD "1"
call :T "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" "PowerThrottlingOff" REG_DWORD "1"
call :T "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" "EnablePrefetcher" REG_DWORD "3"
call :T "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" "EnableSuperfetch" REG_DWORD "3"
sc config SysMain start= auto >nul 2>&1
sc start SysMain >nul 2>&1
if "!MODEMARK!"=="lowest" goto _spec_off
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /f >nul 2>&1
goto _spec_done
:_spec_off
call :T "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" "FeatureSettingsOverride" REG_DWORD "3"
call :T "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" "FeatureSettingsOverrideMask" REG_DWORD "3"
:_spec_done
echo   !OK! !CC![01]!C0! !M0!

rem ============ [02] MMCSS (planificateur jeux) ============
call :T "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" "SystemResponsiveness" REG_DWORD "!SYSRESP!"
call :T "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" "NetworkThrottlingIndex" REG_DWORD "10"
call :T "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" "GPU Priority" REG_DWORD "8"
call :T "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" "Priority" REG_DWORD "6"
call :T "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" "Scheduling Category" REG_SZ "High"
call :T "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" "SFIO Priority" REG_SZ "High"
rem -- neutralise d'anciens tweaks Nagle (placebo en UDP), retour au defaut
for /f "delims=" %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" 2^>nul') do (
    reg delete "%%i" /v TcpAckFrequency /f >nul 2>&1
    reg delete "%%i" /v TCPNoDelay /f >nul 2>&1
)
echo   !OK! !CC![02]!C0! !M2!

rem ============ [03] PRIORITES PAR JEU (IFEO) ============
if "!MODEMARK!"=="soft" goto _ifeoDef
for %%E in (!GAMES!) do (
    call :T "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%~E\PerfOptions" "CpuPriorityClass" REG_DWORD "3"
    call :T "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%~E\PerfOptions" "IoPriority" REG_DWORD "3"
)
goto _ifeoEnd
:_ifeoDef
for %%E in (!GAMES!) do reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%~E\PerfOptions" /f >nul 2>&1
:_ifeoEnd
echo   !OK! !CC![03]!C0! !M3!

rem ============ [04] GPU (selon detection) ============
if /i "!GPUVENDOR!"=="NVIDIA" (
    call :T "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" "EnableGR535" REG_DWORD "0"
    call :T "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters\FTS" "EnableGR535" REG_DWORD "0"
    echo   !OK! !CC![04]!C0! !M4!
)
if /i "!GPUVENDOR!"=="AMD" (
    if not "!ISLAPTOP!"=="1" powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='SilentlyContinue'; $base='HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}'; Get-ChildItem $base | Where-Object { $_.PSChildName -match '^[0-9]{4}$' } | ForEach-Object { $k=$_.PSPath; $d=(Get-ItemProperty $k -Name DriverDesc -EA SilentlyContinue).DriverDesc; if($d -match 'AMD|Radeon'){ Set-ItemProperty $k 'EnableUlps' 0 -Type DWord -Force } }" >nul 2>&1
    if not "!ISLAPTOP!"=="1" echo   !OK! !CC![04]!C0! !M5!
    if "!ISLAPTOP!"=="1" echo   !OK! !CC![04]!C0! !M5LAP!
)
if "!MODEMARK!"=="lowest" call :T "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" "TdrDelay" REG_DWORD "8"
if "!MODEMARK!"=="soft" reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v TdrDelay /f >nul 2>&1
rem -- MSI mode (Message Signaled Interrupts) sur le GPU : ON - reduit la latence d interruption (effet au reboot) --
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='SilentlyContinue'; Get-PnpDevice -Class Display | ForEach-Object { $p='HKLM:\SYSTEM\CurrentControlSet\Enum\'+$_.InstanceId+'\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties'; New-Item -Path $p -Force | Out-Null; New-ItemProperty -Path $p -Name MSISupported -PropertyType DWord -Value 1 -Force | Out-Null }" >nul 2>&1
echo   !OK! !CC![04]!C0! !M73!
if /i "!GPUVENDOR!"=="AMD" if "!AMDLOCK!"=="1" powershell -NoProfile -ExecutionPolicy Bypass -Command "$rk='HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Restrictions'; $d=Get-PnpDevice -Class Display -EA SilentlyContinue | Where-Object{$_.InstanceId -like 'PCI\VEN_1002*'} | Select-Object -First 1; if($d){$p=($d.InstanceId -split '\\')[1] -split '&'; $id='PCI\'+$p[0]+'&'+$p[1]; New-Item $rk -Force | Out-Null; New-Item ($rk+'\DenyDeviceIDs') -Force | Out-Null; Set-ItemProperty $rk -Name DenyDeviceIDs -Type DWord -Value 1; Set-ItemProperty $rk -Name DenyDeviceIDsRetroactive -Type DWord -Value 0; Set-ItemProperty ($rk+'\DenyDeviceIDs') -Name '1' -Type String -Value $id}" >nul 2>&1
if /i "!GPUVENDOR!"=="AMD" if not "!AMDLOCK!"=="1" powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-ItemProperty 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Restrictions' -Name DenyDeviceIDs -Type DWord -Value 0 -EA SilentlyContinue" >nul 2>&1
if /i "!GPUVENDOR!"=="AMD" if "!AMDLOCK!"=="1" echo   !OK! !CC![04]!C0! !MDLOCK!
if /i "!GPUVENDOR!"=="AMD" if not "!AMDLOCK!"=="1" echo   !OK! !CC![04]!C0! !MDFREE!

rem ============ [05] SOURIS 1:1 + CLAVIER + ANTI POP-UP ============
call :T "HKCU\Control Panel\Mouse" "MouseSpeed" REG_SZ "0"
call :T "HKCU\Control Panel\Mouse" "MouseThreshold1" REG_SZ "0"
call :T "HKCU\Control Panel\Mouse" "MouseThreshold2" REG_SZ "0"
rem -- MarkC : sensibilite 6/11 (aucun multiplicateur) + accel OFF aussi sur l ecran de connexion --
call :T "HKCU\Control Panel\Mouse" "MouseSensitivity" REG_SZ "10"
call :T "HKU\.DEFAULT\Control Panel\Mouse" "MouseSpeed" REG_SZ "0"
call :T "HKU\.DEFAULT\Control Panel\Mouse" "MouseThreshold1" REG_SZ "0"
call :T "HKU\.DEFAULT\Control Panel\Mouse" "MouseThreshold2" REG_SZ "0"
call :T "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" "MouseDataQueueSize" REG_DWORD "128"
call :T "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" "KeyboardDataQueueSize" REG_DWORD "128"
call :T "HKCU\Control Panel\Keyboard" "KeyboardDelay" REG_SZ "0"
rem -- NumLock active des le demarrage (valeur qui prime sur l etat memorise par Fast Startup) --
call :T "HKU\.DEFAULT\Control Panel\Keyboard" "InitialKeyboardIndicators" REG_SZ "2147483650"
call :T "HKCU\Control Panel\Keyboard" "InitialKeyboardIndicators" REG_SZ "2147483650"
rem -- N : repetition clavier au maximum --
call :T "HKCU\Control Panel\Keyboard" "KeyboardSpeed" REG_SZ "31"
call :T "HKCU\Control Panel\Accessibility\StickyKeys" "Flags" REG_SZ "506"
call :T "HKCU\Control Panel\Accessibility\Keyboard Response" "Flags" REG_SZ "122"
call :T "HKCU\Control Panel\Accessibility\ToggleKeys" "Flags" REG_SZ "58"
call :T "HKCU\Control Panel\Keyboard" "PrintScreenKeyForSnippingEnabled" REG_DWORD "1"
call :T "HKCU\Control Panel\Desktop" "MenuShowDelay" REG_SZ "0"
call :T "HKCU\Control Panel\Desktop" "AutoEndTasks" REG_SZ "1"
rem -- Anti pop-up ms-gamebar / ms-gamingoverlay (appli Xbox, overlay) : handler neutre
for %%P in (ms-gamingoverlay ms-gamebar ms-gamebarservices ms-xbox ms-xboxlive ms-yourphone ms-getstarted ms-feedback ms-retaildemo) do (
reg add "HKCU\Software\Classes\%%P" /f /ve /d "URL:%%P" >nul 2>&1
reg add "HKCU\Software\Classes\%%P" /f /v "URL Protocol" /d "" >nul 2>&1
reg add "HKCU\Software\Classes\%%P\shell\open\command" /f /ve /d "systray.exe" >nul 2>&1
)
call :T "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" "NoUseStoreOpenWith" REG_DWORD "1"
echo   !OK! !CC![05]!C0! !M6!

rem ============ [06] RESEAU + QoS ============
netsh int tcp set global rss=enabled >nul 2>&1
netsh int tcp set global rsc=disabled >nul 2>&1
netsh int tcp set heuristics disabled >nul 2>&1
call :T "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" "NonBestEffortLimit" REG_DWORD "0"
powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; Get-NetAdapter -Physical | Where-Object {$_.Status -eq 'Up' -and $_.InterfaceDescription -notmatch 'Wireless|Wi-?Fi|802\.11'} | ForEach-Object { $n=$_.Name; Disable-NetAdapterPowerManagement -Name $n -EA SilentlyContinue; Set-NetAdapterAdvancedProperty -Name $n -RegistryKeyword '*InterruptModeration' -RegistryValue 0 -NoRestart -EA SilentlyContinue; Set-NetAdapterAdvancedProperty -Name $n -RegistryKeyword '*FlowControl' -RegistryValue 0 -NoRestart -EA SilentlyContinue; Set-NetAdapterAdvancedProperty -Name $n -RegistryKeyword '*EEE' -RegistryValue 0 -NoRestart -EA SilentlyContinue }" >nul 2>&1
call :T "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" "DODownloadMode" REG_DWORD "0"
ipconfig /flushdns >nul 2>&1
echo   !OK! !CC![06]!C0! !M7!

rem ============ [07] TIMERS BCDEDIT + NTFS ============
bcdedit /set disabledynamictick !DYNTICK! >nul 2>&1
if "!X3DMULTI!"=="1" bcdedit /set tscsyncpolicy enhanced >nul 2>&1
if not "!X3DMULTI!"=="1" bcdedit /deletevalue tscsyncpolicy >nul 2>&1
bcdedit /deletevalue useplatformclock >nul 2>&1
fsutil behavior set disable8dot3 1 >nul 2>&1
echo   !OK! !CC![07]!C0! !M8!

echo.
echo   !CK!------------------------------------------------------------!C0!
echo.
echo   !CC!::!C0!  !CM!!BAN_B!!C0!
echo.
rem ============ [08] TELEMETRIE / PUB / IA ============
call :T "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "AllowTelemetry" REG_DWORD "0"
call :T "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" "AllowTelemetry" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" "Enabled" REG_DWORD "0"
call :T "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" "DisableWindowsConsumerFeatures" REG_DWORD "1"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SystemPaneSuggestionsEnabled" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-338388Enabled" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" "BingSearchEnabled" REG_DWORD "0"
rem -- IA (Copilot / Recall / WindowsAI) : OFF sauf si VM/IA conservee --
if "!NOVBS!"=="0" goto _ia_kept
call :T "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" "DisableAIDataAnalysis" REG_DWORD "1"
call :T "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" "TurnOffWindowsCopilot" REG_DWORD "1"
call :T "HKCU\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" "TurnOffWindowsCopilot" REG_DWORD "1"
goto _ia_done
:_ia_kept
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v DisableAIDataAnalysis /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v TurnOffWindowsCopilot /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v TurnOffWindowsCopilot /f >nul 2>&1
:_ia_done
call :T "HKLM\SOFTWARE\Policies\Microsoft\Dsh" "AllowNewsAndInterests" REG_DWORD "0"
call :T "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" "EnableFeeds" REG_DWORD "0"
call :T "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" "Disabled" REG_DWORD "1"
call :T "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" "LetAppsRunInBackground" REG_DWORD "2"
call :T "HKLM\SOFTWARE\Policies\Microsoft\Edge" "StartupBoostEnabled" REG_DWORD "0"
echo   !OK! !CC![08]!C0! !M9!
if "!NOVBS!"=="0" ( echo   !OK! !CC![08]!C0! !M9A_AI_KEPT! ) else ( echo   !OK! !CC![08]!C0! !M9A_AI_OFF! )

rem ============ [09b] BLOCAGE PUB / TELEMETRIE via le fichier HOSTS ============
attrib -r "%SystemRoot%\System32\drivers\etc\hosts" >nul 2>&1
rem -- Exclusion posee AVANT d ecrire hosts : sinon Defender leve
rem    SettingsModifier:Win32/PossibleHostsFileHijack pendant l ecriture. --
powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; Add-MpPreference -ExclusionPath ($env:SystemRoot+'\System32\drivers\etc\hosts')" >nul 2>&1
ping -n 2 127.0.0.1 >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='SilentlyContinue'; $h=$env:SystemRoot+'\System32\drivers\etc\hosts'; $nl=[char]13+[char]10; $doms='doubleclick.net www.doubleclick.net googleadservices.com pagead2.googlesyndication.com googlesyndication.com pubads.g.doubleclick.net securepubads.g.doubleclick.net stats.g.doubleclick.net ad.doubleclick.net adservice.google.com www.googletagservices.com partner.googleadservices.com www.googletagmanager.com www.google-analytics.com google-analytics.com ssl.google-analytics.com adnxs.com ib.adnxs.com secure.adnxs.com prebid.adnxs.com advertising.com ads.yahoo.com analytics.yahoo.com scorecardresearch.com b.scorecardresearch.com sb.scorecardresearch.com quantserve.com pixel.quantserve.com criteo.com static.criteo.net gum.criteo.com bidder.criteo.com taboola.com cdn.taboola.com trc.taboola.com outbrain.com mab.outbrain.com tr.outbrain.com mgid.com jsc.mgid.com servicer.mgid.com revcontent.com trends.revcontent.com cdn.revcontent.com adskeeper.com moatads.com z.moatads.com applovin.com adcolony.com amazon-adsystem.com aax.amazon-adsystem.com c.amazon-adsystem.com s.amazon-adsystem.com pubmatic.com ads.pubmatic.com image6.pubmatic.com rubiconproject.com fastlane.rubiconproject.com pixel.rubiconproject.com openx.net us-u.openx.net rtb.openx.net casalemedia.com dsum.casalemedia.com as.casalemedia.com indexww.com 3lift.com eb2.3lift.com tlx.3lift.com sharethrough.com btlr.sharethrough.com sovrn.com ap.lijit.com lijit.com gumgum.com g2.gumgum.com adform.net adx.adform.net track.adform.net smartadserver.com ww1.smartadserver.com diff.smartadserver.com spotxchange.com spotx.tv search.spotxchange.com teads.tv t.teads.tv sync.teads.tv adsrvr.org match.adsrvr.org insight.adsrvr.org bidswitch.net x.bidswitch.net contextweb.com tag.contextweb.com yieldmo.com ads.yieldmo.com 33across.com ssc.33across.com media.net contextual.media.net static.media.net innovid.com rtr.innovid.com hotjar.com static.hotjar.com script.hotjar.com api.mixpanel.com cdn.mxpnl.com api.segment.io cdn.segment.com api.amplitude.com cdn.amplitude.com api2.branch.io mc.yandex.ru adsterra.com propellerads.com bat.bing.com clarity.ms ads.linkedin.com px.ads.linkedin.com ads.tiktok.com analytics.tiktok.com business-api.tiktok.com ads-twitter.com static.ads-twitter.com analytics.twitter.com adroll.com d.adroll.com demdex.net omtrdc.net 2o7.net everesttech.net krxd.net nr-data.net chartbeat.com mktoresp.com hsadspixel.net mouseflow.com fullstory.com smartlook.com doubleverify.com adsafeprotected.com crwdcntrl.net rlcdn.com agkn.com mathtag.com eyeota.net tapad.com adsymptotic.com bidr.io onetag-sys.com yieldlab.net stickyadstv.com smartclip.net xiti.com ati-host.net weborama.fr weborama.com adverline.com adyoulike.com omnitagjs.com themoneytizer.com sublime.xyz ayads.co tradedoubler.com hubvisor.io 1rx.io adition.com ligatus.com plista.com gemius.pl vortex.data.microsoft.com vortex-win.data.microsoft.com v10.vortex-win.data.microsoft.com us.vortex-win.data.microsoft.com settings-win.data.microsoft.com telemetry.microsoft.com df.telemetry.microsoft.com oca.telemetry.microsoft.com sqm.telemetry.microsoft.com telecommand.telemetry.microsoft.com watson.telemetry.microsoft.com watson.ppe.telemetry.microsoft.com telemetry.urs.microsoft.com telemetry.appex.bing.net watson.live.com watson.microsoft.com choice.microsoft.com reports.wes.df.telemetry.microsoft.com services.wes.df.telemetry.microsoft.com v10.events.data.microsoft.com v20.events.data.microsoft.com us-v10.events.data.microsoft.com eu-v20.events.data.microsoft.com self.events.data.microsoft.com umwatson.events.data.microsoft.com vortex-sandbox.data.microsoft.com settings-sandbox.data.microsoft.com i1.services.social.microsoft.com redir.metaservices.microsoft.com functional.events.data.microsoft.com browser.events.data.microsoft.com eu-v10.events.data.microsoft.com eu-mobile.events.data.microsoft.com mobile.events.data.microsoft.com v10c.events.data.microsoft.com sqm.df.telemetry.microsoft.com statsfe2.ws.microsoft.com statsfe1.ws.microsoft.com watson.events.data.microsoft.com feedback.windows.com feedback.search.microsoft.com survey.watson.microsoft.com tile-service.weather.microsoft.com'; if(Test-Path $h){ $c=[IO.File]::ReadAllText($h) } else { $c='' }; $c=[regex]::Replace($c,'(?s)# (?:ULTRA|WIN11)-ADBLOCK START.*?# (?:ULTRA|WIN11)-ADBLOCK END[\r\n]*',''); $b='# WIN11-ADBLOCK START'+$nl; foreach($d in $doms.Split(' ')){ if($d){ $b=$b+'0.0.0.0 '+$d+$nl } }; $b=$b+'# WIN11-ADBLOCK END'+$nl; [IO.File]::WriteAllText($h,$c.TrimEnd()+$nl+$nl+$b,[Text.Encoding]::ASCII)" >nul 2>&1
ipconfig /flushdns >nul 2>&1
rem -- L exclusion hosts ne sert que le temps de l ecriture : la garder
rem desarmerait la detection d un VRAI detournement de hosts par un malware.
powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; Remove-MpPreference -ExclusionPath ($env:SystemRoot+'\System32\drivers\etc\hosts')" >nul 2>&1
echo   !OK! !CC![09b]!C0! !M10!

rem ============ [09] TACHES PLANIFIEES TELEMETRIE OFF ============
for %%T in (
 "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
 "\Microsoft\Windows\Application Experience\ProgramDataUpdater"
 "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
 "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
 "\Microsoft\Windows\Feedback\Siuf\DmClient"
 "\Microsoft\Windows\Windows Error Reporting\QueueReporting"
 "\Microsoft\Windows\Maps\MapsUpdateTask"
 "\Microsoft\Windows\Application Experience\MareBackup"
 "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask"
 "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload"
 "\Microsoft\Windows\Maps\MapsToastTask"
 "\Microsoft\Windows\Autochk\Proxy"
 "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
 "\Microsoft\Windows\Retail Demo\CleanupOfflineContent"
 "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask"
 "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem"
) do schtasks /Change /TN "%%~T" /Disable >nul 2>&1
echo   !OK! !CC![09]!C0! !M11!

rem ============ [10] SERVICES INUTILES OFF ============
rem -- services inutiles desactives en une passe PowerShell (SysMain garde l etat ON de [01]) --
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='SilentlyContinue'; foreach($s in @('DiagTrack','dmwappushservice','diagsvc','Fax','RemoteRegistry','RemoteAccess','WerSvc','MapsBroker','lfsvc','PhoneSvc','SmsRouter','TapiSrv','autotimesvc','tzautoupdate','SCardSvr','ScDeviceEnum','SCPolicySvc','CertPropSvc','SensorService','SensrSvc','SensorDataService','TrkWks','WpcMonSvc','RetailDemo','wisvc','WalletService','SEMgrSvc','FDResPub','fdPHost','lltdsvc','NetTcpPortSharing','StiSvc','AJRouter','WMPNetworkSvc','diagnosticshub.standardcollector.service','p2pimsvc','p2psvc','PNRPsvc','PNRPAutoReg')){ Stop-Service -Name $s -EA SilentlyContinue; Set-Service -Name $s -StartupType Disabled -EA SilentlyContinue }" >nul 2>&1
echo   !OK! !CC![10]!C0! !M12!

rem ============ [11] INDEXATION WINDOWS REACTIVEE ============
sc config WSearch start= delayed-auto >nul 2>&1
sc start WSearch >nul 2>&1
echo   !OK! !CC![11]!C0! !M13!

rem ============ [12] FSO (plein ecran) OFF par-jeu ============
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='SilentlyContinue'; $q=[char]34; $steam=(Get-ItemProperty 'HKCU:\Software\Valve\Steam' -Name SteamPath).SteamPath; if(-not $steam){ $steam=(Get-ItemProperty 'HKLM:\SOFTWARE\WOW6432Node\Valve\Steam' -Name InstallPath).InstallPath }; $libs=@(); if($steam){ $libs+=$steam; $vdf=Join-Path $steam 'steamapps\libraryfolders.vdf'; if(Test-Path $vdf){ Get-Content $vdf | Select-String ($q+'path'+$q) | ForEach-Object { $libs += (($_ -split $q)[3]).Replace('\\','\') } } }; $rel=@('steamapps\common\Counter-Strike Global Offensive\game\bin\win64\cs2.exe','steamapps\common\Brawlhalla\Brawlhalla.exe','steamapps\common\Tom Clancy''s Rainbow Six Siege\RainbowSix.exe','steamapps\common\Tom Clancy''s Rainbow Six Siege\RainbowSix_DX11.exe','steamapps\common\Apex Legends\r5apex.exe','steamapps\common\Apex Legends\r5apex_dx12.exe','steamapps\common\Warframe\Warframe.x64.exe','steamapps\common\Warframe\Warframe.exe'); $lay='HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers'; if(-not(Test-Path $lay)){New-Item $lay -Force|Out-Null}; $gpu='HKCU:\Software\Microsoft\DirectX\UserGpuPreferences'; if(-not(Test-Path $gpu)){New-Item $gpu -Force|Out-Null}; foreach($lib in ($libs | Select-Object -Unique)){ foreach($r in $rel){ $full=Join-Path $lib $r; if(Test-Path $full){ New-ItemProperty $lay $full -Value '~ DISABLEDXMAXIMIZEDWINDOWEDMODE' -PropertyType String -Force|Out-Null; New-ItemProperty $gpu $full -Value 'GpuPreference=2;' -PropertyType String -Force|Out-Null } } }; $abs=@(($env:ProgramFiles+'\Epic Games\Fortnite\FortniteGame\Binaries\Win64\FortniteClient-Win64-Shipping.exe'),'C:\Riot Games\VALORANT\live\ShooterGame\Binaries\Win64\VALORANT-Win64-Shipping.exe','C:\Riot Games\League of Legends\Game\League of Legends.exe',($env:ProgramFiles+'\Epic Games\Warframe\Downloaded\Warframe.x64.exe'),($env:ProgramFiles+'\Epic Games\Warframe\Warframe.exe'),($env:LOCALAPPDATA+'\Warframe\Downloaded\Public\Warframe.x64.exe'),'C:\XboxGames\Roblox\Content\RobloxPlayerBeta.exe'); foreach($f in $abs){ if(Test-Path $f){ New-ItemProperty $lay $f -Value '~ DISABLEDXMAXIMIZEDWINDOWEDMODE' -PropertyType String -Force|Out-Null; New-ItemProperty $gpu $f -Value 'GpuPreference=2;' -PropertyType String -Force|Out-Null } }" >nul 2>&1
echo   !OK! !CC![12]!C0! !M14!

rem ============ [13] GAMEDVR OFF + MODE JEU FORCE ON ============
call :T "HKCU\System\GameConfigStore" "GameDVR_Enabled" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" "AppCaptureEnabled" REG_DWORD "0"
call :T "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" "AllowGameDVR" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\GameBar" "AutoGameModeEnabled" REG_DWORD "1"
call :T "HKCU\SOFTWARE\Microsoft\GameBar" "AllowAutoGameMode" REG_DWORD "1"
call :T "HKCU\SOFTWARE\Microsoft\DirectX\UserGpuPreferences" "DirectXUserGlobalSettings" REG_SZ "SwapEffectUpgradeEnable=1;"
echo   !OK! !CC![13]!C0! !M15!

rem ============ [14] DEFENDER : exclusions jeux + analyses bridees ============
if defined STEAMPATH (
    powershell -NoProfile -Command "Add-MpPreference -ExclusionPath '!STEAMPATH!\steamapps\common\Counter-Strike Global Offensive' -EA SilentlyContinue; Add-MpPreference -ExclusionPath '!STEAMPATH!\steamapps\common\Brawlhalla' -EA SilentlyContinue; Add-MpPreference -ExclusionPath '!STEAMPATH!\steamapps\common\Tom Clancy''s Rainbow Six Siege' -EA SilentlyContinue; Add-MpPreference -ExclusionPath '!STEAMPATH!\steamapps\common\Warframe' -EA SilentlyContinue" >nul 2>&1
)
powershell -NoProfile -Command "Add-MpPreference -ExclusionPath 'C:\Riot Games' -EA SilentlyContinue; Add-MpPreference -ExclusionPath ($env:ProgramFiles+'\Epic Games\Warframe') -EA SilentlyContinue; Add-MpPreference -ExclusionPath 'C:\XboxGames\Roblox' -EA SilentlyContinue; Add-MpPreference -ExclusionProcess 'cs2.exe','Brawlhalla.exe','League of Legends.exe','RiotClientServices.exe','RainbowSix.exe','RainbowSix_DX11.exe','VALORANT.exe','VALORANT-Win64-Shipping.exe','r5apex.exe','r5apex_dx12.exe','FortniteClient-Win64-Shipping.exe','Warframe.x64.exe','Warframe.exe','RobloxPlayerBeta.exe' -EA SilentlyContinue" >nul 2>&1
powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; Set-MpPreference -ScanAvgCPULoadFactor 20 -DisableScanningNetworkFiles $true -DisableArchiveScanning $true" >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /Disable >nul 2>&1
rem -- La protection temps reel n est PLUS jamais coupee (v3.9). Couper Defender
rem    declenchait VirTool:Win32/DefenderTamperingRestore a chaque passage, et le
rem    gain de latence ne justifie pas de laisser la machine sans antivirus. Le
rem    script remet au contraire en etat ce qu une version precedente avait coupe. --
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableBehaviorMonitoring /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v SpynetReporting /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v SubmitSamplesConsent /f >nul 2>&1
powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; Set-MpPreference -DisableRealtimeMonitoring $false -DisableBehaviorMonitoring $false -DisableIOAVProtection $false -DisableScriptScanning $false" >nul 2>&1
echo   !OK! !CC![14]!C0! !M16!
echo   !CK!  -^> !C0!!M16NT!
rem ============ [15] DEBLOAT (toujours) ============
echo.
set "RTI=Removing preinstalled bloatware..."
if /i "!L!"=="FR" set "RTI=Suppression des applications preinstallees inutiles..."
echo   !CK!  -^> !C0!!RTI!
powershell -NoProfile -ExecutionPolicy Bypass -Command "$a=@('*Microsoft.YourPhone*','*MicrosoftWindows.CrossDevice*','*WindowsBackup*','*Microsoft.Getstarted*','*Microsoft.GetHelp*','*PowerAutomate*','*Microsoft.BingNews*','*Microsoft.BingWeather*','*Microsoft.BingFinance*','*Microsoft.BingSports*','*Microsoft.News*','*Microsoft.3DBuilder*','*Microsoft.Microsoft3DViewer*','*Microsoft.MicrosoftOfficeHub*','*Microsoft.OutlookForWindows*','*Microsoft.SkypeApp*','*MicrosoftTeams*','*Microsoft.People*','*Microsoft.WindowsFeedbackHub*','*Microsoft.WindowsMaps*','*Microsoft.MixedReality.Portal*','*Microsoft.MicrosoftSolitaireCollection*','*Microsoft.Todos*','*Clipchamp.Clipchamp*','*Microsoft.Windows.DevHome*','*Microsoft.549981C3F5F10*','*Microsoft.QuickAssist*','*Microsoft.Whiteboard*','*CandyCrush*','*Disney*','*TikTok*','*Netflix*','*Facebook*','*Twitter*','*Duolingo*','*MicrosoftCorporationII.QuickAssist*','*Microsoft.RemoteDesktop*','*microsoft.windowscommunicationsapps*','*LanguageExperiencePacken-US*','*Microsoft.WindowsSoundRecorder*','*MicrosoftCorporationII.MicrosoftFamily*','*Microsoft.ZuneVideo*','*Microsoft.OneConnect*','*LinkedIn*','*Microsoft.BingSearch*','*Microsoft.MicrosoftEdge.GameAssist*','*Microsoft.Office.OneNote*','*Microsoft.MicrosoftStickyNotes*','*WhatsApp*'); foreach($x in $a){ Get-AppxPackage -AllUsers -Name $x -EA SilentlyContinue | Remove-AppxPackage -AllUsers -EA SilentlyContinue; Get-AppxProvisionedPackage -Online -EA SilentlyContinue | Where-Object {$_.DisplayName -like $x} | Remove-AppxProvisionedPackage -Online -EA SilentlyContinue | Out-Null }" >nul 2>&1
winget uninstall --id WhatsApp.WhatsApp -e --accept-source-agreements --disable-interactivity >nul 2>&1
echo   !OK! !CC![15]!C0! !M17!

rem ============ [16b] OUTLOOK (nouveau) retire (toujours) ============
set "RTI=Removing Outlook (new)..."
if /i "!L!"=="FR" set "RTI=Retrait d'Outlook (new)..."
echo   !CK!  -^> !C0!!RTI!
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='SilentlyContinue'; foreach($x in @('*Microsoft.OutlookForWindows*')){ Get-AppxPackage -AllUsers -Name $x | Remove-AppxPackage -AllUsers; Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -like $x } | Remove-AppxProvisionedPackage -Online | Out-Null }" >nul 2>&1
echo   !OK! !CC![16b]!C0! !M19!

rem ============ [16] CONFIDENTIALITE : acces applis OFF sauf MICRO ============
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='SilentlyContinue'; $base='HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore'; function S($c,$v){ $p=Join-Path $base $c; if(-not(Test-Path $p)){New-Item $p -Force|Out-Null}; New-ItemProperty $p 'Value' -Value $v -PropertyType String -Force|Out-Null; $np=Join-Path $p 'NonPackaged'; if(-not(Test-Path $np)){New-Item $np -Force|Out-Null}; New-ItemProperty $np 'Value' -Value $v -PropertyType String -Force|Out-Null }; foreach($c in @('location','contacts','appointments','phoneCallHistory','email','userDataTasks','chat','phoneCall','radios','bluetoothSync','appDiagnostics','documentsLibrary','picturesLibrary','videosLibrary','broadFileSystemAccess','userAccountInformation','userNotificationListener','activity','cellularData','gazeInput','graphicsCaptureProgrammatic','graphicsCaptureWithoutBorder','humanPresence')){ S $c 'Deny' }; S 'microphone' 'Allow'; $cam='Deny'; if('!CAMALLOW!' -eq '1'){$cam='Allow'}; S 'webcam' $cam" >nul 2>&1
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" "GlobalUserDisabled" REG_DWORD "1"
call :T "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" "EnableActivityFeed" REG_DWORD "0"
call :T "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" "PublishUserActivities" REG_DWORD "0"
call :T "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" "UploadUserActivities" REG_DWORD "0"
for %%V in (LetAppsAccessLocation LetAppsAccessContacts LetAppsAccessCalendar LetAppsAccessCallHistory LetAppsAccessEmail LetAppsAccessMessaging LetAppsAccessTasks LetAppsAccessAccountInfo LetAppsAccessPhone LetAppsAccessRadios LetAppsAccessTrustedDevices LetAppsAccessMotion LetAppsAccessNotifications LetAppsSyncWithDevices LetAppsAccessCellularData LetAppsAccessGraphicsCaptureProgrammatic LetAppsAccessGraphicsCaptureWithoutBorder LetAppsAccessHumanPresence LetAppsAccessBackgroundSpatialPerception LetAppsGetDiagnosticInfo) do reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v %%V /t REG_DWORD /d 2 /f >nul 2>&1
if "!CAMALLOW!"=="0" call :T "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" "LetAppsAccessCamera" REG_DWORD "2"
echo   !OK! !CC![16]!C0! !M20!
rem ============ [17b] SAISIE / SUGGESTIONS / FEATURES INUTILES OFF ============
rem -- Information sur la saisie (typing insights) + personnalisation entree --
call :T "HKCU\SOFTWARE\Microsoft\Input\TIPC" "Enabled" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\InputPersonalization" "RestrictImplicitInkCollection" REG_DWORD "1"
call :T "HKCU\SOFTWARE\Microsoft\InputPersonalization" "RestrictImplicitTextCollection" REG_DWORD "1"
call :T "HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" "HarvestContacts" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Personalization\Settings" "AcceptedPrivacyPolicy" REG_DWORD "0"
rem -- Reconnaissance vocale en ligne --
call :T "HKCU\SOFTWARE\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" "HasAccepted" REG_DWORD "0"
rem -- Suggestions / contenu pousse / spotlight ecran verrouille / astuces --
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SilentInstalledAppsEnabled" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "PreInstalledAppsEnabled" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "OemPreInstalledAppsEnabled" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SoftLandingEnabled" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "RotatingLockScreenEnabled" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "RotatingLockScreenOverlayEnabled" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-338389Enabled" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-338393Enabled" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-353694Enabled" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-353696Enabled" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-310093Enabled" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-88000326Enabled" REG_DWORD "0"
rem -- Suggestions barre de recherche (web) + actions suggerees presse-papier --
call :T "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" "DisableSearchBoxSuggestions" REG_DWORD "1"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SmartActionPlatform\SmartClipboard" "Disabled" REG_DWORD "1"
rem -- Notifs pub explorateur + notifs de compte dans le menu Demarrer --
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ShowSyncProviderNotifications" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Start_AccountNotifications" REG_DWORD "0"
rem -- Experiences personnalisees + temps forts recherche + notifications Windows OFF --
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" "TailoredExperiencesWithDiagnosticDataEnabled" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" "IsDynamicSearchBoxEnabled" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds\DSB" "ShowDynamicContent" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" "ToastEnabled" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" "NoToastApplicationNotification" REG_DWORD "1"
echo   !OK! !CC![17b]!C0! !M72!
rem ============ [17c] PRESSE-PAPIER / BARRE / EXPLORATEUR / CORTANA / SONS / ECRAN ============
rem -- A : historique presse-papier + presse-papier cloud OFF --
call :T "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" "AllowClipboardHistory" REG_DWORD "0"
call :T "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" "AllowCrossDeviceClipboard" REG_DWORD "0"
rem -- B : bouton Chat/Teams de la barre des taches OFF --
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarMn" REG_DWORD "0"
rem -- C : fichiers recents + dossiers frequents dans l Explorateur OFF --
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ShowRecent" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ShowFrequent" REG_DWORD "0"
rem -- D : Cortana entierement desactivee --
call :T "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" "AllowCortana" REG_DWORD "0"
rem -- E : sons systeme OFF (schema Aucun son + vidage de chaque evenement) --
reg add "HKCU\AppEvents\Schemes" /ve /t REG_SZ /d ".None" /f >nul 2>&1
powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; Get-ChildItem -Path 'HKCU:\AppEvents\Schemes\Apps' -Recurse | Where-Object { $_.PSChildName -eq '.Current' } | ForEach-Object { Set-ItemProperty -Path $_.PSPath -Name '(default)' -Value '' }" >nul 2>&1
rem -- F : ecran de verrouillage desactive (direct au login) --
call :T "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" "NoLockScreen" REG_DWORD "1"
rem -- G : ecran de veille OFF --
call :T "HKCU\Control Panel\Desktop" "ScreenSaveActive" REG_SZ "0"
echo   !OK! !CC![17c]!C0! !M74!
rem ============ [17d] ANTI-NAG / REDEMARRAGE MAJ / MAINTENANCE / FEEDBACK ============
rem -- J : "Terminer la configuration de l appareil" (OOBE nag) OFF --
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement" "ScoobeSystemSettingEnabled" REG_DWORD "0"
rem -- K : pas de redemarrage auto apres MAJ si session ouverte --
call :T "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" "NoAutoRebootWithLoggedOnUsers" REG_DWORD "1"
rem -- L : notifications de feedback OFF --
call :T "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "DoNotShowFeedbackNotifications" REG_DWORD "1"
call :T "HKCU\SOFTWARE\Microsoft\Siuf\Rules" "NumberOfSIUFInPeriod" REG_DWORD "0"
rem -- M : maintenance automatique - pas de reveil du PC --
call :T "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" "WakeUp" REG_DWORD "0"
rem -- O : animation de premiere connexion OFF --
call :T "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" "EnableFirstLogonAnimation" REG_DWORD "0"
echo   !OK! !CC![17d]!C0! !M75!

echo.
echo   !CK!------------------------------------------------------------!C0!
echo.
echo   !CC!::!C0!  !CM!!BAN_C!!C0!
echo.
rem ============ [17]-[21] PERIPHERIQUES ============
rem -- Corps deplace dans :pcam / :pnet / :pbt / :pprn / :pxbx pour etre partage
rem    avec le sous-menu [9] du menu principal. Un seul comportement, un seul code. --
call :pcam
call :pnet
call :pbt
call :pprn
call :pxbx

echo.
echo   !CK!------------------------------------------------------------!C0!
echo.
echo   !CC!::!C0!  !CM!!BAN_D!!C0!
echo.
rem ============ [22] ONEDRIVE (toujours) ============
taskkill /f /im OneDrive.exe >nul 2>&1
if exist "%SystemRoot%\System32\OneDriveSetup.exe" "%SystemRoot%\System32\OneDriveSetup.exe" /uninstall >nul 2>&1
if exist "%SystemRoot%\SysWOW64\OneDriveSetup.exe" "%SystemRoot%\SysWOW64\OneDriveSetup.exe" /uninstall >nul 2>&1
call :T "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" "DisableFileSyncNGSC" REG_DWORD "1"
echo   !OK! !CC![22]!C0! !M36!
rem ============ [23] APPARENCE : transparence + accent gris + fond noir ============
rem LIGHTFX=1 : petit GPU integre ou RAM 16 Go et moins.
rem Effets visuels personnalises : coupe l ombre des listes, Aero Peek, le cache
rem de miniatures et la transparence. GARDE le lissage des polices, le rectangle
rem de selection translucide et les effets d animation (Parametres > Accessibilite
rem > Effets visuels : bit 0x02 du byte 4 de UserPreferencesMask, plus MinAnimate
rem et TaskbarAnimations). Theme sombre conserve.
if "!LIGHTFX!"=="1" (
    call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" "VisualFXSetting" REG_DWORD "3"
    call :T "HKCU\Control Panel\Desktop" "UserPreferencesMask" REG_BINARY "9012038012000000"
    call :T "HKCU\Control Panel\Desktop" "DragFullWindows" REG_SZ "0"
    call :T "HKCU\Control Panel\Desktop\WindowMetrics" "MinAnimate" REG_SZ "1"
    call :T "HKCU\Control Panel\Desktop" "FontSmoothing" REG_SZ "2"
    call :T "HKCU\Control Panel\Desktop" "FontSmoothingType" REG_DWORD "2"
    call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ListviewAlphaSelect" REG_DWORD "1"
    call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ListviewShadow" REG_DWORD "0"
    call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarAnimations" REG_DWORD "1"
    call :T "HKCU\SOFTWARE\Microsoft\Windows\DWM" "EnableAeroPeek" REG_DWORD "0"
    call :T "HKCU\SOFTWARE\Microsoft\Windows\DWM" "AlwaysHibernateThumbnails" REG_DWORD "0"
    call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" "EnableTransparency" REG_DWORD "0"
) else (
    call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" "VisualFXSetting" REG_DWORD "1"
    call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" "EnableTransparency" REG_DWORD "1"
)
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent" "AccentColorMenu" REG_DWORD "0xff484848"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent" "AccentPalette" REG_BINARY "a6a6a6ff808080ff646464ff484848ff3a3a3aff2c2c2cff1e1e1eff101010ff"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent" "StartColorMenu" REG_DWORD "0xff484848"
call :T "HKCU\SOFTWARE\Microsoft\Windows\DWM" "AccentColor" REG_DWORD "0xff484848"
call :T "HKCU\SOFTWARE\Microsoft\Windows\DWM" "ColorizationColor" REG_DWORD "0xc4484848"
call :T "HKCU\SOFTWARE\Microsoft\Windows\DWM" "ColorizationAfterglow" REG_DWORD "0xc4484848"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" "ColorPrevalence" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Windows\DWM" "ColorPrevalence" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ShowSecondsInSystemClock" REG_DWORD "1"
rem Fond d'ecran : couleur unie NOIR + qualite wallpaper 100
call :T "HKCU\Control Panel\Desktop" "Wallpaper" REG_SZ ""
call :T "HKCU\Control Panel\Desktop" "WallpaperStyle" REG_SZ "0"
call :T "HKCU\Control Panel\Desktop" "JPEGImportQuality" REG_DWORD "100"
call :T "HKCU\Control Panel\Colors" "Background" REG_SZ "0 0 0"
rundll32.exe user32.dll,UpdatePerUserSystemParameters 1, True
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" "AppsUseLightTheme" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" "SystemUsesLightTheme" REG_DWORD "0"
if "!LIGHTFX!"=="1" ( echo   !OK! !CC![23]!C0! !M40L! ) else ( echo   !OK! !CC![23]!C0! !M40! )

rem ============ [24] BARRE DES TACHES ============
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarAl" REG_DWORD "1"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" "SearchboxTaskbarMode" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarGlomLevel" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "MMTaskbarGlomLevel" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarSd" REG_DWORD "1"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarBadges" REG_DWORD "1"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "PenWorkspaceButtonDesiredVisibility" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" "TipbandDesiredVisibility" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings" "TaskbarEndTask" REG_DWORD "1"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarDa" REG_DWORD "0"
if "!NOVBS!"=="0" ( call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ShowCopilotButton" REG_DWORD "1" ) else ( call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ShowCopilotButton" REG_DWORD "0" )
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ShowTaskViewButton" REG_DWORD "0"
echo   !OK! !CC![24]!C0! !M43!

rem ============ [25] MENU DEMARRER ============
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Start_TrackProgs" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Start_TrackDocs" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Start_IrisRecommendations" REG_DWORD "0"
call :T "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" "HideRecommendedSection" REG_DWORD "1"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" "NOC_GLOBAL_SETTING_TOASTS_ENABLED" REG_DWORD "0"
call :T "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" "HideCategoryView" REG_DWORD "1"
call :T "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" "HideRecommendedSection" REG_DWORD "1"
call :T "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" "HideRecommendedPersonalizedSites" REG_DWORD "1"
echo   !OK! !CC![25]!C0! !M44!

rem ============ [26] EXPLORATEUR DE FICHIERS ============
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Hidden" REG_DWORD "1"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "HideFileExt" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "LaunchTo" REG_DWORD "1"
echo   !OK! !CC![26]!C0! !M45!

rem ============ [27] AVERTISSEMENTS DE SECURITE OFF ============
call :T "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" "SmartScreenEnabled" REG_SZ "Off"
call :T "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" "EnableSmartScreen" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" "EnableWebContentEvaluation" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments" "SaveZoneInformation" REG_DWORD "1"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments" "HideZoneInfoOnProperties" REG_DWORD "1"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments" "ScanWithAntiVirus" REG_DWORD "1"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Associations" "LowRiskFileTypes" REG_SZ ".exe;.bat;.cmd;.reg;.msi;.ps1;.vbs;.com;.scr;.zip;.7z;.rar"
call :T "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" "{2cc5ca98-6485-489a-920e-b3e88a6ccce3}" REG_DWORD "1"
call :T "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" "{2cc5ca98-6485-489a-920e-b3e88a6ccce3}" REG_DWORD "1"
echo   !OK! !CC![27]!C0! !M46!

rem ============ [28] MULTITACHE ON + AERO SHAKE OFF ============
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "DisallowShaking" REG_DWORD "1"
call :T "HKCU\Control Panel\Desktop" "WindowArrangementActive" REG_SZ "1"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "SnapAssist" REG_DWORD "1"
echo   !OK! !CC![28]!C0! !M47!

rem ============ [29] UAC : ne prevenir JAMAIS ============
call :T "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" "ConsentPromptBehaviorAdmin" REG_DWORD "0"
call :T "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" "PromptOnSecureDesktop" REG_DWORD "0"
echo   !OK! !CC![29]!C0! !M48!

rem ============ [30] UTILISATION A DISTANCE OFF ============
call :T "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" "fAllowToGetHelp" REG_DWORD "0"
call :T "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" "fDenyTSConnections" REG_DWORD "1"
echo   !OK! !CC![30]!C0! !M49!

rem ============ [31] INTEGRITE MEMOIRE (core isolation) ============
rem Mode normal : ON (requise par certains anticheats). Mode no-anticheat : OFF (perf).
if "!NOVBS!"=="1" goto _noac_vbs
call :T "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" "EnableVirtualizationBasedSecurity" REG_DWORD "1"
call :T "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" "Enabled" REG_DWORD "1"
bcdedit /set hypervisorlaunchtype auto >nul 2>&1
echo   !OK! !CC![31]!C0! !M50!
goto _noac_done
:_noac_vbs
call :T "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" "EnableVirtualizationBasedSecurity" REG_DWORD "0"
call :T "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" "Enabled" REG_DWORD "0"
bcdedit /set hypervisorlaunchtype off >nul 2>&1
echo   !OK! !CC![31]!C0! !M50OFF!
:_noac_done

rem ============ [32] DEMARRAGE : NE PAS AFFICHER L'OS ============
bcdedit /timeout 0 >nul 2>&1
bcdedit /set {current} bootux disabled >nul 2>&1
bcdedit /set {bootmgr} displaybootmenu no >nul 2>&1
call :T "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" "VerboseStatus" REG_DWORD "1"
echo   !OK! !CC![32]!C0! !M51!
rem ============ [33] PERIPHERIQUES FANTOMES + USELESS (safe) ============
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='SilentlyContinue'; $g=Get-PnpDevice | Where-Object { $_.Problem -eq 'CM_PROB_PHANTOM' -and $_.Present -ne $true }; foreach($d in $g){ & pnputil /remove-device $d.InstanceId 2>$null }" >nul 2>&1
echo   !OK! !CC![33]!C0! !M52!

rem ============ [34] BONUS : FTH OFF, delai demarrage 0, stockage reserve OFF ============
call :T "HKLM\SOFTWARE\Microsoft\FTH" "Enabled" REG_DWORD "0"
call :T "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Serialize" "StartupDelayInMSec" REG_DWORD "0"
call :T "HKCU\Control Panel\Desktop" "HungAppTimeout" REG_SZ "4000"
call :T "HKLM\SYSTEM\CurrentControlSet\Control" "WaitToKillServiceTimeout" REG_SZ "2000"
echo   !OK! !CC![34]!C0! !M53!

echo.
echo   !CK!------------------------------------------------------------!C0!
echo.
echo   !CC!::!C0!  !CM!!BAN_E!!C0!
echo.
rem ============ [35] ALIMENTATION : aucun economiseur ============
set "ULT="
set "ULTSAVED="
if "!MODEMARK!"=="soft" goto _pwrsave
if "!ISLAPTOP!"=="1" goto _pwrsave
for /f "tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\LowLatOptimizer" /v UltGuid 2^>nul ^| findstr /i /c:"REG_SZ"') do set "ULTSAVED=%%b"
if defined ULTSAVED for /f %%Z in ('powercfg /list ^| findstr /i /c:"!ULTSAVED!"') do set "ULT=!ULTSAVED!"
if not defined ULT for /f "tokens=2 delims=:" %%G in ('powercfg /list ^| findstr /i /c:"Ultimate Performance" /c:"Performances ultimes"') do for /f "tokens=1" %%H in ("%%G") do set "ULT=%%H"
if not defined ULT for /f "tokens=2 delims=:" %%G in ('powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61') do for /f "tokens=1" %%H in ("%%G") do set "ULT=%%H"
if defined ULT reg add "HKLM\SOFTWARE\LowLatOptimizer" /v UltGuid /t REG_SZ /d !ULT! /f >nul 2>&1
if defined ULT powercfg /setactive !ULT! >nul 2>&1
if not defined ULT powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
:_pwrsave
if "!MODEMARK!"=="soft" powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
if "!ISLAPTOP!"=="1" powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
rem -- Parking + C-states selon le CPU : X3D = parking ON + C-states ON ; non-X3D / Intel = unpark + C-states OFF --
set "CPMIN=100"
set "IDLEDIS=1"
if "!ISX3D!"=="1" set "CPMIN=0"
if "!ISX3D!"=="1" set "IDLEDIS=0"
if "!ISLAPTOP!"=="1" set "CPMIN=100"
if "!ISLAPTOP!"=="1" set "IDLEDIS=0"
powercfg /setacvalueindex scheme_current 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318583 !CPMIN! >nul 2>&1
powercfg /setdcvalueindex scheme_current 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318583 !CPMIN! >nul 2>&1
powercfg /setacvalueindex scheme_current 54533251-82be-4824-96c1-47b60b740d00 5d76a2ca-e8c0-402f-a133-2158492d58ad !IDLEDIS! >nul 2>&1
powercfg /setdcvalueindex scheme_current 54533251-82be-4824-96c1-47b60b740d00 5d76a2ca-e8c0-402f-a133-2158492d58ad !IDLEDIS! >nul 2>&1
powercfg /setacvalueindex scheme_current 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 >nul 2>&1
powercfg /setacvalueindex scheme_current sub_pciexpress ee12f906-d277-404b-b6da-e5fa1a576df5 0 >nul 2>&1
if "!ISLAPTOP!"=="1" if "!HASWIFI!"=="1" powercfg /setdcvalueindex scheme_current 19cbb8fa-5279-450e-9fac-8a3d5fedd0c1 12bbebe6-58d6-4636-95bb-3217ef867c1a 3 >nul 2>&1
if "!ISLAPTOP!"=="1" if "!HASWIFI!"=="1" powercfg /setacvalueindex scheme_current 19cbb8fa-5279-450e-9fac-8a3d5fedd0c1 12bbebe6-58d6-4636-95bb-3217ef867c1a 0 >nul 2>&1
powercfg /change standby-timeout-ac 0 >nul 2>&1
powercfg /change hibernate-timeout-ac 0 >nul 2>&1
powercfg /change monitor-timeout-ac 15 >nul 2>&1
powercfg /change disk-timeout-ac 0 >nul 2>&1
powercfg /setactive scheme_current >nul 2>&1
echo   !OK! !CC![35]!C0! !M54!

rem ============ [36] HAGS : verifie le support PUIS active ============
set "HAGSOK=NO"
for /f "usebackq delims=" %%h in (`powershell -NoProfile -Command "$p=Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers' -Name HwSchMode -EA SilentlyContinue; if($p -ne $null){'YES'}else{'NO'}"`) do set "HAGSOK=%%h"
if /i "!HAGSOK!"=="YES" (
    call :T "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" "HwSchMode" REG_DWORD "2"
    echo   !OK! !CC![36]!C0! !M55!
)
if /i not "!HAGSOK!"=="YES" echo   !OK! !CC![36]!C0! !M56!

rem ============ [37] FAST STARTUP ON ============
powercfg /hibernate on >nul 2>&1
call :T "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" "HiberbootEnabled" REG_DWORD "1"
echo   !OK! !CC![37]!C0! !M57!

rem ============ [38] ICONES DEMARRAGE + ANCIEN TIMERRES SUPPRIME ============
call :T "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" "HideSystray" REG_DWORD "1"
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v SecurityHealth /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v vgtray /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v vgtray /f >nul 2>&1
powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; foreach($k in 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run','HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run'){ if(Test-Path $k){ (Get-Item $k).Property | Where-Object { $_ -match 'Terminal' } | ForEach-Object { Remove-ItemProperty -Path $k -Name $_ } } }" >nul 2>&1
echo   !OK! !CC![38]!C0! !M58!

rem ============ [39] PILOTES MAINTENUS A JOUR ============
call :T "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" "SearchOrderConfig" REG_DWORD "1"
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v ExcludeWUDriversInQualityUpdate /f >nul 2>&1
echo   !OK! !CC![39]!C0! !M59!

echo.
echo   !CK!------------------------------------------------------------!C0!
echo.
echo   !CC!::!C0!  !CM!!BAN_F!!C0!
echo.
rem ============ [40] OPTIMISATION DISQUES via la tache WINDOWS native (silencieuse) ============
schtasks /Delete /F /TN "Opti Disques Quotidienne" >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Defrag\ScheduledDefrag" /Enable >nul 2>&1
powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; $tr=New-ScheduledTaskTrigger -Daily -At ([datetime]::Today.AddHours(3)); Set-ScheduledTask -TaskName 'ScheduledDefrag' -TaskPath '\Microsoft\Windows\Defrag\' -Trigger $tr" >nul 2>&1
echo   !OK! !CC![40]!C0! !M60!

rem ============ [41] ASSISTANT DE STOCKAGE ============
set "SS=HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy"
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\StorageSense" /v AllowStorageSenseGlobal /f >nul 2>&1
call :T "!SS!" "01" REG_DWORD "1"
call :T "!SS!" "04" REG_DWORD "1"
call :T "!SS!" "08" REG_DWORD "1"
call :T "!SS!" "256" REG_DWORD "1"
rem -- Telechargements : supprime les restes 32/512 d une v3.7, sans rien imposer --
reg delete "!SS!" /v 32 /f >nul 2>&1
reg delete "!SS!" /v 512 /f >nul 2>&1
call :T "!SS!" "2048" REG_DWORD "1"
rem -- Lance l assistant de stockage maintenant, puis a chaque ouverture de session
rem    via la tache LowLat Reapply : la tache Windows native est pilotee par la
rem    maintenance auto RunOnlyIfIdle et peut ne jamais tourner autrement. --
schtasks /Run /TN "\Microsoft\Windows\DiskFootprint\StorageSense" >nul 2>&1
echo   !OK! !CC![41]!C0! !M61!

if "%FASTMODE%"=="1" goto _aioskipclean
rem ============ [42] NETTOYAGE ============
set "CL1=Temp (user + Windows)"
set "CL2=Discord cache"
set "CL3=Steam cache"
set "CL4=Windows components (WinSxS)"
set "CL5=Old install (Windows.old)"
set "CL6=Recycle bin"
set "CLW=may take a few minutes"
set "CLS=Cleanup summary:"
set "CLT=Total freed:"
if /i "!L!"=="FR" set "CL1=Temp (utilisateur + Windows)"
if /i "!L!"=="FR" set "CL2=Cache Discord"
if /i "!L!"=="FR" set "CL3=Cache Steam"
if /i "!L!"=="FR" set "CL4=Composants Windows (WinSxS)"
if /i "!L!"=="FR" set "CL5=Ancienne installation (Windows.old)"
if /i "!L!"=="FR" set "CL6=Corbeille"
if /i "!L!"=="FR" set "CLW=peut prendre quelques minutes"
if /i "!L!"=="FR" set "CLS=Resume du nettoyage :"
if /i "!L!"=="FR" set "CLT=Total libere :"
set "CLNF0=0"
for /f %%s in ('powershell -NoProfile -Command "[math]::Round((Get-PSDrive ($env:SystemDrive[0])).Free/1MB)" 2^>nul') do set "CLNF0=%%s"
set "CLNFP=!CLNF0!"
echo   !CK!  -^> !C0!!CL1!...
del /q /f /s "%TEMP%\*" >nul 2>&1
del /q /f /s "%SystemRoot%\Temp\*" >nul 2>&1
call :cln43 CLNT1
rem -- Le dossier Telechargements n est JAMAIS touche : contenu utilisateur. --
echo   !CK!  -^> !C0!!CL2!...
rem -- Discord stocke son cache dans %APPDATA%\discord, pas dans %LOCALAPPDATA%. --
for %%C in (Cache "Code Cache" GPUCache blob_storage DawnGraphiteCache DawnWebGPUCache "Service Worker") do (
    del /q /f /s "%APPDATA%\discord\%%~C\*" >nul 2>&1
    for /d %%D in ("%APPDATA%\discord\%%~C\*") do rd /s /q "%%D" >nul 2>&1
)
del /q /f /s "%LOCALAPPDATA%\Discord\Cache\*" >nul 2>&1
del /q /f /s "%LOCALAPPDATA%\Discord\Code Cache\*" >nul 2>&1
del /q /f /s "%LOCALAPPDATA%\Discord\GPUCache\*" >nul 2>&1
call :cln43 CLNT2
echo   !CK!  -^> !C0!!CL3!...
if defined STEAMPATH del /q /f /s "!STEAMPATH!\appcache\httpcache\*" >nul 2>&1
if defined STEAMPATH del /q /f /s "!STEAMPATH!\config\htmlcache\*" >nul 2>&1
call :cln43 CLNT3
echo   !CK!  -^> !C0!!CL4! ^(!CLW!^)...
dism /Online /Cleanup-Image /StartComponentCleanup >nul 2>&1
call :cln43 CLNT4
echo   !CK!  -^> !C0!!CL5!...
if exist "%SystemDrive%\Windows.old" (
    takeown /F "%SystemDrive%\Windows.old" /R /A /D Y >nul 2>&1
    takeown /F "%SystemDrive%\Windows.old" /R /A /D O >nul 2>&1
    icacls "%SystemDrive%\Windows.old" /grant *S-1-5-32-544:F /T /C /Q >nul 2>&1
    rd /s /q "%SystemDrive%\Windows.old" >nul 2>&1
)
if exist "%SystemDrive%\Windows.old" (
    md "%TEMP%\llempty" >nul 2>&1
    robocopy "%TEMP%\llempty" "%SystemDrive%\Windows.old" /MIR /R:1 /W:1 >nul 2>&1
    rd /s /q "%SystemDrive%\Windows.old" >nul 2>&1
    rd /s /q "%TEMP%\llempty" >nul 2>&1
)
call :cln43 CLNT5
echo   !CK!  -^> !C0!!CL6!...
powershell -NoProfile -Command "Clear-RecycleBin -Force -EA SilentlyContinue" >nul 2>&1
call :cln43 CLNT6
echo.
set /a CLNTOT=!CLNFP!-!CLNF0!
if !CLNTOT! LSS 0 set "CLNTOT=0"
echo   !OK! !CC![42]!C0! !M62!
echo.
echo   !CW!  !CLS!!C0!
call :sh43 "!CL1!" !CLNT1!
call :sh43 "!CL2!" !CLNT2!
call :sh43 "!CL3!" !CLNT3!
call :sh43 "!CL4!" !CLNT4!
call :sh43 "!CL5!" !CLNT5!
call :sh43 "!CL6!" !CLNT6!
echo   !CK!  ----------------------------------------!C0!
echo   !CW!  !CLT! !CG!!CLNTOT! Mo!C0!

echo.
echo   !CK!------------------------------------------------------------!C0!
echo.
echo   !CC!::!C0!  !CM!!BAN_G!!C0!
echo.
rem ============ [43] WINDOWS UPDATE + winget (toujours) ============
echo   !OK! !CC![43]!C0! !M63!
rem -- IsInstalled=0 + IsHidden=0 (sans filtre BrowseOnly) : inclut aussi les MAJ FACULTATIVES (qualite optionnelle + drivers hors-GPU, le GPU restant fige) --
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='SilentlyContinue'; try { try { $sm=New-Object -ComObject Microsoft.Update.ServiceManager; $sm.AddService2('7971f918-a847-4430-9279-4a52d1efe18d',7,'')|Out-Null } catch {}; $s=New-Object -ComObject Microsoft.Update.Session; $se=$s.CreateUpdateSearcher(); $se.ServerSelection=3; $se.ServiceID='7971f918-a847-4430-9279-4a52d1efe18d'; $r=$se.Search('IsInstalled=0 and IsHidden=0'); if($r.Updates.Count -gt 0){ $dl=New-Object -ComObject Microsoft.Update.UpdateColl; foreach($u in $r.Updates){ try{ if(-not $u.EulaAccepted){$u.AcceptEula()} }catch{}; $dl.Add($u)|Out-Null }; $d=$s.CreateUpdateDownloader(); $d.Updates=$dl; $d.Download()|Out-Null; $ins=New-Object -ComObject Microsoft.Update.UpdateColl; foreach($u in $r.Updates){ if($u.IsDownloaded){$ins.Add($u)|Out-Null} }; if($ins.Count -gt 0){ $i=$s.CreateUpdateInstaller(); $i.Updates=$ins; $i.Install()|Out-Null } } } catch {}"
echo   !OK! !CC![43]!C0! !M64!
rem ---- winget : MAJ globale de toutes les applis (peut etre long) ----
echo   !OK! !CC![45b]!C0! !M66!
where winget >nul 2>&1 && winget upgrade --all --include-unknown --accept-source-agreements --accept-package-agreements --disable-interactivity --silent
echo   !OK! !CC![45b]!C0! !M67!

echo.
echo   !CK!------------------------------------------------------------!C0!
echo.
echo   !CC!::!C0!  !CM!!BAN_H!!C0!
echo.
:_aioskipclean
rem ============ [44] TIMER 0.5 ms force via PowerShell (sans logiciel externe) ============
rem Ecrit un petit script qui force le timer a 0.5 ms et le maintient,
rem lance au demarrage par une tache planifiee (process discret en fond).
schtasks /Delete /F /TN "TimerResolution 0.5ms" >nul 2>&1
del /f /q "%SystemRoot%\TimerResolution.exe" >nul 2>&1
powershell -NoProfile -Command "[IO.File]::WriteAllText('%SystemRoot%\timerres.ps1',[Text.Encoding]::ASCII.GetString([Convert]::FromBase64String('!TRPSB64!')))" >nul 2>&1
powershell -NoProfile -Command "[IO.File]::WriteAllText($env:TEMP+'\tinst.ps1',[Text.Encoding]::ASCII.GetString([Convert]::FromBase64String('!TASKB64!')))" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -File "%TEMP%\tinst.ps1" >nul 2>&1
del /f /q "%TEMP%\tinst.ps1" >nul 2>&1
set "TMROK=0"
schtasks /query /tn "TimerRes 0.5ms" >nul 2>&1 && set "TMROK=1"
if "!TMROK!"=="1" echo   !OK! !CC![44]!C0! !M69!
if "!TMROK!"=="0" echo   !CR!  -^> !C0!!M69NG!




rem ============ [45] RE-APPLICATION DES REGLAGES AU DEMARRAGE (valeurs fixes) ============
rem Petit script (valeurs FIXES, aucune dependance aux reponses). Il ne reecrit le
rem registre QUE si une MAJ Windows a change le build ; sinon il sort aussitot.
schtasks /Delete /F /TN "LowLat Reapply" >nul 2>&1
del "%TEMP%\llrap.b64" >nul 2>&1
echo JEVycm9yQWN0aW9uUHJlZmVyZW5jZT0nU2lsZW50bHlDb250aW51ZScKJGN2PSdIS0xNOlxTT0ZUV0FSRVxNaWNyb3NvZnRcV2luZG93cyBOVFxDdXJyZW50VmVyc2lvbicKJGN1cj1bc3RyaW5nXShHZXQtSXRlbVByb3BlcnR5ICRjdikuQ3VycmVudEJ1aWxkICsgJy4nICsgW3N0cmluZ10oR2V0LUl0ZW1Qcm9wZXJ0eSAkY3YpLlVCUgokcms9J0hLTE06XFNPRlRXQVJFXExvd0xhdE9wdGltaXplcicKJHByZXY9KEdldC1JdGVtUHJvcGVydHkgJHJrIC1OYW1lIExhc3RCdWlsZCAtRUEgU2lsZW50bHlDb250aW51ZSkuTGFzdEJ1aWxkCiRtbT0nSEtMTVxTT0ZUV0FSRVxNaWNyb3NvZnRcV2luZG93cyBOVFxDdXJyZW50VmVyc2lvblxNdWx0aW1lZGlhXFN5c3RlbVByb2ZpbGUnCiRtb2RlPShHZXQtSXRlbVByb3BlcnR5ICRyayAtTmFtZSBNb2RlIC1FQSBTaWxlbnRseUNvbnRpbnVlKS5Nb2RlCiR4M2Q9KEdldC1JdGVtUHJvcGVydHkgJHJrIC1OYW1lIElzWDNEIC1FQSBTaWxlbnRseUNvbnRpbnVlKS5Jc1gzRAokeDNkbT0oR2V0LUl0ZW1Qcm9wZXJ0eSAkcmsgLU5hbWUgWDNETXVsdGkgLUVBIFNpbGVudGx5Q29udGludWUpLlgzRE11bHRpCiRzdmNrYj0oR2V0LUl0ZW1Qcm9wZXJ0eSAkcmsgLU5hbWUgU3ZjS0IgLUVBIFNpbGVudGx5Q29udGludWUpLlN2Y0tCCiRpc2xhcD0oR2V0LUl0ZW1Qcm9wZXJ0eSAkcmsgLU5hbWUgSXNMYXB0b3AgLUVBIFNpbGVudGx5Q29udGludWUpLklzTGFwdG9wCmlmKCRtb2RlIC1lcSAnbG93ZXN0Jyl7ICRzcj0wOyAkcHM9NDI7ICRkdD0neWVzJyB9IGVsc2UgeyAkc3I9MTA7ICRwcz0zODsgJGR0PSdubycgfQppZigkaXNsYXAgLWVxICcxJyl7ICRkdD0nbm8nIH0KJGV4ZXM9QCgnY3MyLmV4ZScsJ0xlYWd1ZSBvZiBMZWdlbmRzLmV4ZScsJ0JyYXdsaGFsbGEuZXhlJywnUmFpbmJvd1NpeC5leGUnLCdSYWluYm93U2l4X0RYMTEuZXhlJywnVkFMT1JBTlQtV2luNjQtU2hpcHBpbmcuZXhlJywnVkFMT1JBTlQuZXhlJywncjVhcGV4LmV4ZScsJ3I1YXBleF9keDEyLmV4ZScsJ0ZvcnRuaXRlQ2xpZW50LVdpbjY0LVNoaXBwaW5nLmV4ZScsJ1dhcmZyYW1lLng2NC5leGUnLCdXYXJmcmFtZS5leGUnLCdSb2Jsb3hQbGF5ZXJCZXRhLmV4ZScpCmlmKCRjdXIgLW5lICRwcmV2KXsKICAmIHJlZy5leGUgYWRkICRtbSAvdiBTeXN0ZW1SZXNwb25zaXZlbmVzcyAvdCBSRUdfRFdPUkQgL2QgJHNyIC9mIHwgT3V0LU51bGwKICAmIHJlZy5leGUgYWRkICRtbSAvdiBOZXR3b3JrVGhyb3R0bGluZ0luZGV4IC90IFJFR19EV09SRCAvZCAxMCAvZiB8IE91dC1OdWxsCiAgJiByZWcuZXhlIGFkZCAiSEtMTVxTWVNURU1cQ3VycmVudENvbnRyb2xTZXRcQ29udHJvbFxQcmlvcml0eUNvbnRyb2wiIC92IFdpbjMyUHJpb3JpdHlTZXBhcmF0aW9uIC90IFJFR19EV09SRCAvZCAkcHMgL2YgfCBPdXQtTnVsbAogICYgYmNkZWRpdCAvc2V0IGRpc2FibGVkeW5hbWljdGljayAkZHQgfCBPdXQtTnVsbAogICRnbT0kbW0rJ1xUYXNrc1xHYW1lcycKICAmIHJlZy5leGUgYWRkICRnbSAvdiAiR1BVIFByaW9yaXR5IiAvdCBSRUdfRFdPUkQgL2QgOCAvZiB8IE91dC1OdWxsCiAgJiByZWcuZXhlIGFkZCAkZ20gL3YgUHJpb3JpdHkgL3QgUkVHX0RXT1JEIC9kIDYgL2YgfCBPdXQtTnVsbAogICYgcmVnLmV4ZSBhZGQgJGdtIC92ICJTY2hlZHVsaW5nIENhdGVnb3J5IiAvdCBSRUdfU1ogL2QgSGlnaCAvZiB8IE91dC1OdWxsCiAgJiByZWcuZXhlIGFkZCAkZ20gL3YgIlNGSU8gUHJpb3JpdHkiIC90IFJFR19TWiAvZCBIaWdoIC9mIHwgT3V0LU51bGwKICAmIHJlZy5leGUgYWRkICJIS0xNXFNZU1RFTVxDdXJyZW50Q29udHJvbFNldFxDb250cm9sXFNlc3Npb24gTWFuYWdlclxrZXJuZWwiIC92IEdsb2JhbFRpbWVyUmVzb2x1dGlvblJlcXVlc3RzIC90IFJFR19EV09SRCAvZCAxIC9mIHwgT3V0LU51bGwKICAmIHJlZy5leGUgYWRkICJIS0xNXFNZU1RFTVxDdXJyZW50Q29udHJvbFNldFxDb250cm9sXFBvd2VyXFBvd2VyVGhyb3R0bGluZyIgL3YgUG93ZXJUaHJvdHRsaW5nT2ZmIC90IFJFR19EV09SRCAvZCAxIC9mIHwgT3V0LU51bGwKICAmIHJlZy5leGUgYWRkICJIS0NVXFN5c3RlbVxHYW1lQ29uZmlnU3RvcmUiIC92IEdhbWVEVlJfRW5hYmxlZCAvdCBSRUdfRFdPUkQgL2QgMCAvZiB8IE91dC1OdWxsCiAgJiByZWcuZXhlIGFkZCAiSEtDVVxTT0ZUV0FSRVxNaWNyb3NvZnRcV2luZG93c1xDdXJyZW50VmVyc2lvblxHYW1lRFZSIiAvdiBBcHBDYXB0dXJlRW5hYmxlZCAvdCBSRUdfRFdPUkQgL2QgMCAvZiB8IE91dC1OdWxsCiAgJiByZWcuZXhlIGFkZCAiSEtMTVxTT0ZUV0FSRVxQb2xpY2llc1xNaWNyb3NvZnRcV2luZG93c1xHYW1lRFZSIiAvdiBBbGxvd0dhbWVEVlIgL3QgUkVHX0RXT1JEIC9kIDAgL2YgfCBPdXQtTnVsbAogICYgcmVnLmV4ZSBhZGQgIkhLQ1VcU09GVFdBUkVcTWljcm9zb2Z0XEdhbWVCYXIiIC92IEF1dG9HYW1lTW9kZUVuYWJsZWQgL3QgUkVHX0RXT1JEIC9kIDEgL2YgfCBPdXQtTnVsbAogICYgcmVnLmV4ZSBhZGQgIkhLQ1VcU09GVFdBUkVcTWljcm9zb2Z0XEdhbWVCYXIiIC92IEFsbG93QXV0b0dhbWVNb2RlIC90IFJFR19EV09SRCAvZCAxIC9mIHwgT3V0LU51bGwKICAmIHJlZy5leGUgYWRkICJIS0NVXFNPRlRXQVJFXE1pY3Jvc29mdFxEaXJlY3RYXFVzZXJHcHVQcmVmZXJlbmNlcyIgL3YgRGlyZWN0WFVzZXJHbG9iYWxTZXR0aW5ncyAvdCBSRUdfU1ogL2QgIlN3YXBFZmZlY3RVcGdyYWRlRW5hYmxlPTE7IiAvZiB8IE91dC1OdWxsCiAgJiBzYy5leGUgY29uZmlnIFdTZWFyY2ggc3RhcnQ9IGRlbGF5ZWQtYXV0byB8IE91dC1OdWxsCiAgJiBzYy5leGUgc3RhcnQgV1NlYXJjaCB8IE91dC1OdWxsCiAgJiByZWcuZXhlIGFkZCAiSEtDVVxTT0ZUV0FSRVxNaWNyb3NvZnRcSW5wdXRcVElQQyIgL3YgRW5hYmxlZCAvdCBSRUdfRFdPUkQgL2QgMCAvZiB8IE91dC1OdWxsCiAgJiByZWcuZXhlIGFkZCAiSEtDVVxTT0ZUV0FSRVxNaWNyb3NvZnRcSW5wdXRQ>>"%TEMP%\llrap.b64"
echo ZXJzb25hbGl6YXRpb24iIC92IFJlc3RyaWN0SW1wbGljaXRUZXh0Q29sbGVjdGlvbiAvdCBSRUdfRFdPUkQgL2QgMSAvZiB8IE91dC1OdWxsCiAgJiByZWcuZXhlIGFkZCAiSEtDVVxTT0ZUV0FSRVxNaWNyb3NvZnRcV2luZG93c1xDdXJyZW50VmVyc2lvblxDb250ZW50RGVsaXZlcnlNYW5hZ2VyIiAvdiBTeXN0ZW1QYW5lU3VnZ2VzdGlvbnNFbmFibGVkIC90IFJFR19EV09SRCAvZCAwIC9mIHwgT3V0LU51bGwKICAmIHJlZy5leGUgYWRkICJIS0NVXFNPRlRXQVJFXE1pY3Jvc29mdFxXaW5kb3dzXEN1cnJlbnRWZXJzaW9uXENvbnRlbnREZWxpdmVyeU1hbmFnZXIiIC92IFNpbGVudEluc3RhbGxlZEFwcHNFbmFibGVkIC90IFJFR19EV09SRCAvZCAwIC9mIHwgT3V0LU51bGwKICAmIHJlZy5leGUgYWRkICJIS0NVXFNPRlRXQVJFXE1pY3Jvc29mdFxXaW5kb3dzXEN1cnJlbnRWZXJzaW9uXENvbnRlbnREZWxpdmVyeU1hbmFnZXIiIC92IFN1YnNjcmliZWRDb250ZW50LTMzODM4OEVuYWJsZWQgL3QgUkVHX0RXT1JEIC9kIDAgL2YgfCBPdXQtTnVsbAogICYgcmVnLmV4ZSBhZGQgIkhLQ1VcU09GVFdBUkVcTWljcm9zb2Z0XFdpbmRvd3NcQ3VycmVudFZlcnNpb25cUHJpdmFjeSIgL3YgVGFpbG9yZWRFeHBlcmllbmNlc1dpdGhEaWFnbm9zdGljRGF0YUVuYWJsZWQgL3QgUkVHX0RXT1JEIC9kIDAgL2YgfCBPdXQtTnVsbAogICYgcmVnLmV4ZSBhZGQgIkhLQ1VcQ29udHJvbCBQYW5lbFxNb3VzZSIgL3YgTW91c2VTcGVlZCAvdCBSRUdfU1ogL2QgMCAvZiB8IE91dC1OdWxsCiAgJiByZWcuZXhlIGFkZCAiSEtDVVxDb250cm9sIFBhbmVsXE1vdXNlIiAvdiBNb3VzZVRocmVzaG9sZDEgL3QgUkVHX1NaIC9kIDAgL2YgfCBPdXQtTnVsbAogICYgcmVnLmV4ZSBhZGQgIkhLQ1VcQ29udHJvbCBQYW5lbFxNb3VzZSIgL3YgTW91c2VUaHJlc2hvbGQyIC90IFJFR19TWiAvZCAwIC9mIHwgT3V0LU51bGwKICAmIHJlZy5leGUgYWRkICJIS0xNXFNZU1RFTVxDdXJyZW50Q29udHJvbFNldFxDb250cm9sXEdyYXBoaWNzRHJpdmVycyIgL3YgSHdTY2hNb2RlIC90IFJFR19EV09SRCAvZCAyIC9mIHwgT3V0LU51bGwKICBpZigkc3Zja2IpeyAmIHJlZy5leGUgYWRkICJIS0xNXFNZU1RFTVxDdXJyZW50Q29udHJvbFNldFxDb250cm9sIiAvdiBTdmNIb3N0U3BsaXRUaHJlc2hvbGRJbktCIC90IFJFR19EV09SRCAvZCAkc3Zja2IgL2YgfCBPdXQtTnVsbCB9CiAgaWYoJHgzZG0gLWVxIDEpeyAmIGJjZGVkaXQgL3NldCB0c2NzeW5jcG9saWN5IGVuaGFuY2VkIHwgT3V0LU51bGwgfSBlbHNlIHsgJiBiY2RlZGl0IC9kZWxldGV2YWx1ZSB0c2NzeW5jcG9saWN5IHwgT3V0LU51bGwgfQogIGlmKCRtb2RlIC1lcSAnbG93ZXN0Jyl7ICYgcmVnLmV4ZSBhZGQgIkhLTE1cU1lTVEVNXEN1cnJlbnRDb250cm9sU2V0XENvbnRyb2xcR3JhcGhpY3NEcml2ZXJzIiAvdiBUZHJEZWxheSAvdCBSRUdfRFdPUkQgL2QgOCAvZiB8IE91dC1OdWxsIH0gZWxzZSB7ICYgcmVnLmV4ZSBkZWxldGUgIkhLTE1cU1lTVEVNXEN1cnJlbnRDb250cm9sU2V0XENvbnRyb2xcR3JhcGhpY3NEcml2ZXJzIiAvdiBUZHJEZWxheSAvZiB8IE91dC1OdWxsIH0KICAmIHJlZy5leGUgYWRkICJIS0xNXFNZU1RFTVxDdXJyZW50Q29udHJvbFNldFxTZXJ2aWNlc1xudmxkZG1rbVxGVFMiIC92IEVuYWJsZUdSNTM1IC90IFJFR19EV09SRCAvZCAwIC9mIHwgT3V0LU51bGwKICAmIHJlZy5leGUgYWRkICJIS0xNXFNZU1RFTVxDdXJyZW50Q29udHJvbFNldFxTZXJ2aWNlc1xudmxkZG1rbVxQYXJhbWV0ZXJzXEZUUyIgL3YgRW5hYmxlR1I1MzUgL3QgUkVHX0RXT1JEIC9kIDAgL2YgfCBPdXQtTnVsbAogIGZvcmVhY2goJGUgaW4gJGV4ZXMpeyAkaWs9J0hLTE1cU09GVFdBUkVcTWljcm9zb2Z0XFdpbmRvd3MgTlRcQ3VycmVudFZlcnNpb25cSW1hZ2UgRmlsZSBFeGVjdXRpb24gT3B0aW9uc1wnKyRlKydcUGVyZk9wdGlvbnMnOyBpZigkbW9kZSAtZXEgJ2xvd2VzdCcpeyAmIHJlZy5leGUgYWRkICRpayAvdiBDcHVQcmlvcml0eUNsYXNzIC90IFJFR19EV09SRCAvZCAzIC9mIHwgT3V0LU51bGw7ICYgcmVnLmV4ZSBhZGQgJGlrIC92IElvUHJpb3JpdHkgL3QgUkVHX0RXT1JEIC9kIDMgL2YgfCBPdXQtTnVsbCB9IGVsc2UgeyAmIHJlZy5leGUgZGVsZXRlICRpayAvZiB8IE91dC1OdWxsIH0gfQogIEdldC1QbnBEZXZpY2UgLUNsYXNzIERpc3BsYXkgLUVBIFNpbGVudGx5Q29udGludWUgfCBGb3JFYWNoLU9iamVjdCB7ICRtcD0nSEtMTVxTWVNURU1cQ3VycmVudENvbnRyb2xTZXRcRW51bVwnKyRfLkluc3RhbmNlSWQrJ1xEZXZpY2UgUGFyYW1ldGVyc1xJbnRlcnJ1cHQgTWFuYWdlbWVudFxNZXNzYWdlU2lnbmFsZWRJbnRlcnJ1cHRQcm9wZXJ0aWVzJzsgJiByZWcuZXhlIGFkZCAkbXAgL3YgTVNJU3VwcG9ydGVkIC90IFJFR19EV09SRCAvZCAxIC9mIHwgT3V0LU51bGwgfQogIGlmKC1ub3QoVGVzdC1QYXRoICRyaykpe05ldy1JdGVtICRyayAtRm9yY2UgfCBPdXQtTnVsbH0KICBOZXctSXRlbVByb3BlcnR5ICRyayAtTmFtZSBMYXN0QnVpbGQgLVZhbHVlICRjdXIgLVByb3BlcnR5VHlwZSBTdHJpbmcgLUZvcmNlIHwgT3V0LU51bGwKfQokdG49J1RpbWVyUmVzIDAuNW1zJwokdHJwcz0iJGVudjpTeXN0ZW1Sb290XHRpbWVycmVzLnBzMSIKIyBMZSBmaWNoaWVyIHBldXQgYXZvaXIgZGlzcGFydSAobmV0dG95YWdlIGRpc3F1ZSwgTUFKLCBhbnRpdmlydXMpIDogb24gbGUKIyByZWVjcml0IGRlcHVpcyBsYSBjb3BpZSBlbWJhcnF1ZWUgYXUgbGlldSBkZSByZW5vbmNlciBzaWxlbmNpZXVzZW1lbnQuCmlmKC1ub3QoVGVzdC1QYXRoICR0cnBzKSl7CiAgdHJ5e1tJTy5GaWxlXTo6V3JpdGVBbGxUZXh0KCR0cnBzLFtUZXh0LkVuY29kaW5nXTo6QVNDSUkuR2V0U3RyaW5nKFtDb252ZXJ0XTo6RnJvbUJhc2U2NFN0cmluZygnSkVWeWNtOXlRV04wYVc5dVVISmxabVZ5Wlc1alpUMG5VMmxzWlc1MGJIbERiMjUwYVc1MVpTY0tKRzEwZUQxT1pYY3RUMkpxWldO>>"%TEMP%\llrap.b64"
echo MElGTjVjM1JsYlM1VWFISmxZV1JwYm1jdVRYVjBaWGdvSkdaaGJITmxMQ2RIYkc5aVlXeGNURzkzVEdGMFZHbHRaWEpTWlhNd05TY3BDaVJoWW1GdVpHOXVaV1E5SkdaaGJITmxDblJ5ZVhzS0lDQnBaaWd0Ym05MElDUnRkSGd1VjJGcGRFOXVaU2d3S1NsN1pYaHBkSDBLZldOaGRHTm9JRnRUZVhOMFpXMHVWR2h5WldGa2FXNW5Ma0ZpWVc1a2IyNWxaRTExZEdWNFJYaGpaWEIwYVc5dVhYc0tJQ0FqSUUxMWRHVjRJR0ZpWVc1a2IyNXVaU0J3WVhJZ2RXNGdjSEpsWTJWa1pXNTBJSEJ5YjJObGMzTWdiVzl5ZENCbGJpQnNaU0IwWlc1aGJuUXVDaUFnSXlCVFpXMWhiblJwY1hWbGJXVnVkQ0E5SUdGamNYVnBjMmwwYVc5dUlISmxkWE56YVdVZ0tHOXVJR3hsSUhCdmMzTmxaR1VwTGlCUGJpQmpiMjUwYVc1MVpTNEtJQ0FrWVdKaGJtUnZibVZrUFNSMGNuVmxDbjBLVTNSaGNuUXRVMnhsWlhBZ0xWTmxZMjl1WkhNZ05Rb2tjMmxuUFVBbkNsdEViR3hKYlhCdmNuUW9JbTUwWkd4c0xtUnNiQ0lwWFNCd2RXSnNhV01nYzNSaGRHbGpJR1Y0ZEdWeWJpQnBiblFnVG5SVFpYUlVhVzFsY2xKbGMyOXNkWFJwYjI0b2RXbHVkQ0JFWlhOcGNtVmtVbVZ6YjJ4MWRHbHZiaXdnWW05dmJDQlRaWFJTWlhOdmJIVjBhVzl1TENCdmRYUWdkV2x1ZENCRGRYSnlaVzUwVW1WemIyeDFkR2x2YmlrN0NsdEViR3hKYlhCdmNuUW9JbTUwWkd4c0xtUnNiQ0lwWFNCd2RXSnNhV01nYzNSaGRHbGpJR1Y0ZEdWeWJpQnBiblFnVG5SUmRXVnllVlJwYldWeVVtVnpiMngxZEdsdmJpaHZkWFFnZFdsdWRDQk5hVzVTWlhNc0lHOTFkQ0IxYVc1MElFMWhlRkpsY3l3Z2IzVjBJSFZwYm5RZ1EzVnlVbVZ6S1RzS1cwUnNiRWx0Y0c5eWRDZ2lhMlZ5Ym1Wc016SXVaR3hzSWlsZElIQjFZbXhwWXlCemRHRjBhV01nWlhoMFpYSnVJR0p2YjJ3Z1IyVjBVM2x6ZEdWdFVHOTNaWEpUZEdGMGRYTW9iM1YwSUZOUVV5QnpLVHNLVzFOMGNuVmpkRXhoZVc5MWRDaE1ZWGx2ZFhSTGFXNWtMbE5sY1hWbGJuUnBZV3dwWFNCd2RXSnNhV01nYzNSeWRXTjBJRk5RVXlCN0lIQjFZbXhwWXlCaWVYUmxJRUZEVEdsdVpWTjBZWFIxY3pzZ2NIVmliR2xqSUdKNWRHVWdRbUYwZEdWeWVVWnNZV2M3SUhCMVlteHBZeUJpZVhSbElFSmhkSFJsY25sTWFXWmxVR1Z5WTJWdWREc2djSFZpYkdsaklHSjVkR1VnVTNsemRHVnRVM1JoZEhWelJteGhaenNnY0hWaWJHbGpJR2x1ZENCQ1lYUjBaWEo1VEdsbVpWUnBiV1U3SUhCMVlteHBZeUJwYm5RZ1FtRjBkR1Z5ZVVaMWJHeE1hV1psVkdsdFpUc2dmUW9uUUFva1ZGSTlKRzUxYkd3S0pHNDlNQXAzYUdsc1pTZ2tiblZzYkNBdFpYRWdKRlJTSUMxaGJtUWdKRzRnTFd4MElERXlNQ2w3Q2lBZ0l5QkJaR1F0Vkhsd1pTQXRVR0Z6YzFSb2NuVWdjbVZ1ZG05cFpTQlZUaUJVUVVKTVJVRlZJQ2hzWlNCMGVYQmxJQ3NnYkdFZ2MzUnlkV04wSUZOUVV5QnBiV0p5YVhGMVpXVXBMZzBLSUNBaklGTmhibk1nWTJVZ1YyaGxjbVV0VDJKcVpXTjBMQ0FrVkZJZ2RtRjFkQ0JQWW1wbFkzUmJYU0JsZENCVVQxVlVJR0Z3Y0dWc0lDUlVVam82V0hoNElHVmphRzkxWlM0TkNpQWdkSEo1ZXlSeVBVRmtaQzFVZVhCbElDMU9ZVzFsSUZSeWN5QXRUbUZ0WlhOd1lXTmxJRXhzSUMxTlpXMWlaWEpFWldacGJtbDBhVzl1SUNSemFXY2dMVkJoYzNOVWFISjFJQzFGY25KdmNrRmpkR2x2YmlCVGRHOXdPeUFrVkZJOVFDZ2tjaWtnZkNCWGFHVnlaUzFQWW1wbFkzUWdleUFrWHk1T1lXMWxJQzFsY1NBblZISnpKeUI5SUh3Z1UyVnNaV04wTFU5aWFtVmpkQ0F0Um1seWMzUWdNWDFqWVhSamFIdFRkR0Z5ZEMxVGJHVmxjQ0F0VTJWamIyNWtjeUF5ZlFvZ0lDUnVLeXNLZlFwcFppZ2tiblZzYkNBdFpYRWdKRlJTS1h0bGVHbDBJREY5Q2lSeVpXYzlKMGhMVEUwNlhGTlBSbFJYUVZKRlhFeHZkMHhoZEU5d2RHbHRhWHBsY2ljS2RISjVlMmxtS0MxdWIzUW9WR1Z6ZEMxUVlYUm9JQ1J5WldjcEtYdE9aWGN0U1hSbGJTQXRVR0YwYUNBa2NtVm5JQzFHYjNKalpYeFBkWFF0VG5Wc2JIMTlZMkYwWTJoN2ZRcG1kVzVqZEdsdmJpQk1iMmRVYVcxbGNpZ2tjM1JoZEdVcGV3b2dJSFJ5ZVhzS0lDQWdJQ1J0YVc0OVczVnBiblF6TWwwd095UnRZWGc5VzNWcGJuUXpNbDB3T3lSamRYSTlXM1ZwYm5Rek1sMHdDaUFnSUNCYmRtOXBaRjBrVkZJNk9rNTBVWFZsY25sVWFXMWxjbEpsYzI5c2RYUnBiMjRvVzNKbFpsMGtiV2x1TEZ0eVpXWmRKRzFoZUN4YmNtVm1YU1JqZFhJcENpQWdJQ0JUWlhRdFNYUmxiVkJ5YjNCbGNuUjVJQzFRWVhSb0lDUnlaV2NnTFU1aGJXVWdKMVJwYldWeVEzVnlKeUF0Vm1Gc2RXVWdKR04xY2lBdFZIbHdaU0JFVjI5eVpDQXRSbTl5WTJVS0lDQWdJRk5sZEMxSmRHVnRVSEp2Y0dWeWRIa2dMVkJoZEdnZ0pISmxaeUF0VG1GdFpTQW5WR2x0WlhKVGRHRjBaU2NnTFZaaGJIVmxJQ1J6ZEdGMFpTQXRWSGx3WlNCVGRISnBibWNnTFVadmNtTmxDaUFnSUNCVFpYUXRTWFJsYlZCeWIzQmxjblI1SUMxUVlYUm9JQ1J5WldjZ0xVNWhiV1VnSjFScGJXVnlRV0poYm1SdmJtVmtKeUF0Vm1Gc2RXVWdKR0ZpWVc1a2IyNWxaQ0F0Vkhsd1pTQkVWMjl5WkNBdFJtOXlZMlVLSUNCOVkyRjBZMmg3ZlFwOUNpUmpQVEFLZDJocGJHVW9KSFJ5ZFdVcGV3b2dJQ1JvYjJ4a1BTUjBjblZsQ2lBZ2RISjVld29nSUNBZ0pITTlUbVYzTFU5aWFtVmpkQ0FuVEd3dVZISnpLMU5RVXljS0lDQWdJR2xtS0NSVVVqbzZSMlYwVTNsemRHVnRVRzkzWlhKVGRHRjBkWE1vVzNKbFpsMGtjeWtwZXdvZ0lDQWdJQ0FqSUVKaGRIUmxjbmxHYkdGbklHVnpkQ0IxYmlCaWFYUm1hV1ZzWkNBN0lHSnBkQ0F4TWpnZ1BTQWlibThnYzNsemRHVnRJR0poZEhSbGNua2lJQ2hrWlhOcmRHOXdLUzRLSUNBZ0lDQWdJeUJQYmlCeVpXeGhZMmhsSUNob2IyeGtQV1poYkhObEtTQlZUa2xSVlVWTlJVNVVJSE5wSUdKaGRIUmxjbWxsSUhCeVpYTmxiblJsSUVWVUlITjFjaUJ6WldOMFpYVnlJR1JsWTI5dWJtVmpkR1V1Q2lBZ0lDQWdJR2xtS0Nnb0pITXVRbUYwZEdWeWVVWnNZV2NnTFdKaGJtUWdNVEk0S1NBdFpYRWdNQ2tnTFdG>>"%TEMP%\llrap.b64"
echo dVpDQWtjeTVCUTB4cGJtVlRkR0YwZFhNZ0xXVnhJREFwZXlSb2IyeGtQU1JtWVd4elpYMEtJQ0FnSUgwS0lDQjlZMkYwWTJoN0pHaHZiR1E5SkhSeWRXVjlDaUFnZEhKNWV3b2dJQ0FnYVdZb0pHaHZiR1FwZXdvZ0lDQWdJQ0FrVkZJNk9rNTBVMlYwVkdsdFpYSlNaWE52YkhWMGFXOXVLRFV3TURBc0pIUnlkV1VzVzNKbFpsMGtZeWw4VDNWMExVNTFiR3dLSUNBZ0lDQWdURzluVkdsdFpYSWdKMmhsYkdRbkNpQWdJQ0I5Wld4elpYc0tJQ0FnSUNBZ0pGUlNPanBPZEZObGRGUnBiV1Z5VW1WemIyeDFkR2x2YmlnMU1EQXdMQ1JtWVd4elpTeGJjbVZtWFNSaktYeFBkWFF0VG5Wc2JBb2dJQ0FnSUNCTWIyZFVhVzFsY2lBbmNtVnNaV0Z6WldRbkNpQWdJQ0I5Q2lBZ2ZXTmhkR05vZXdvZ0lDQWdkSEo1ZTFObGRDMUpkR1Z0VUhKdmNHVnlkSGtnTFZCaGRHZ2dKSEpsWnlBdFRtRnRaU0FuVkdsdFpYSlRkR0YwWlNjZ0xWWmhiSFZsSUNnblpYSnliM0k2SUNjckpGOHVSWGhqWlhCMGFXOXVMazFsYzNOaFoyVXBJQzFVZVhCbElGTjBjbWx1WnlBdFJtOXlZMlY5WTJGMFkyaDdmUW9nSUNBZ1UzUmhjblF0VTJ4bFpYQWdMVk5sWTI5dVpITWdNekFLSUNCOUNpQWdVM1JoY25RdFUyeGxaWEFnTFZObFkyOXVaSE1nTlFwOUNnPT0nKSkpfWNhdGNoe30KfQokbmVlZFRhc2sgPSAtbm90KEdldC1TY2hlZHVsZWRUYXNrIC1UYXNrTmFtZSAkdG4gLUVBIFNpbGVudGx5Q29udGludWUpCiMgVGFjaGUgcHJlc2VudGUgbWFpcyBhdWN1biBwcm9jZXNzIHZpdmFudCA9IGVsbGUgZXN0IG1vcnRlIDogb24gbGEgcmVsYW5jZS4KJGFsaXZlID0gQChHZXQtQ2ltSW5zdGFuY2UgV2luMzJfUHJvY2VzcyAtRUEgU2lsZW50bHlDb250aW51ZSB8IFdoZXJlLU9iamVjdCB7ICRfLkNvbW1hbmRMaW5lIC1saWtlICcqdGltZXJyZXMucHMxKicgfSkuQ291bnQKaWYoJG5lZWRUYXNrIC1hbmQgKFRlc3QtUGF0aCAkdHJwcykpewogICRhPU5ldy1TY2hlZHVsZWRUYXNrQWN0aW9uIC1FeGVjdXRlICdwb3dlcnNoZWxsLmV4ZScgLUFyZ3VtZW50ICgnLU5vUHJvZmlsZSAtV2luZG93U3R5bGUgSGlkZGVuIC1FeGVjdXRpb25Qb2xpY3kgQnlwYXNzIC1GaWxlICInKyR0cnBzKyciJykKICAkdDE9TmV3LVNjaGVkdWxlZFRhc2tUcmlnZ2VyIC1BdFN0YXJ0dXAKICAkdDI9TmV3LVNjaGVkdWxlZFRhc2tUcmlnZ2VyIC1BdExvZ09uCiAgJHByPU5ldy1TY2hlZHVsZWRUYXNrUHJpbmNpcGFsIC1Vc2VySWQgJ05UIEFVVEhPUklUWVxTWVNURU0nIC1Mb2dvblR5cGUgU2VydmljZUFjY291bnQgLVJ1bkxldmVsIEhpZ2hlc3QKICAkc2U9TmV3LVNjaGVkdWxlZFRhc2tTZXR0aW5nc1NldCAtQWxsb3dTdGFydElmT25CYXR0ZXJpZXMgLURvbnRTdG9wSWZHb2luZ09uQmF0dGVyaWVzIC1TdGFydFdoZW5BdmFpbGFibGUgLUV4ZWN1dGlvblRpbWVMaW1pdCAoW1RpbWVTcGFuXTo6WmVybykgLVJlc3RhcnRDb3VudCAzIC1SZXN0YXJ0SW50ZXJ2YWwgKE5ldy1UaW1lU3BhbiAtTWludXRlcyAxKSAtTXVsdGlwbGVJbnN0YW5jZXMgSWdub3JlTmV3CiAgUmVnaXN0ZXItU2NoZWR1bGVkVGFzayAtVGFza05hbWUgJHRuIC1BY3Rpb24gJGEgLVRyaWdnZXIgJHQxLCR0MiAtUHJpbmNpcGFsICRwciAtU2V0dGluZ3MgJHNlIC1Gb3JjZSB8IE91dC1OdWxsCn0KaWYoJGFsaXZlIC1lcSAwIC1hbmQgKFRlc3QtUGF0aCAkdHJwcykpeyBTdGFydC1TY2hlZHVsZWRUYXNrIC1UYXNrTmFtZSAkdG4gLUVBIFNpbGVudGx5Q29udGludWUgfQomIHJlZy5leGUgYWRkICJIS0xNXFNZU1RFTVxDdXJyZW50Q29udHJvbFNldFxDb250cm9sXFNlc3Npb24gTWFuYWdlclxrZXJuZWwiIC92IEdsb2JhbFRpbWVyUmVzb2x1dGlvblJlcXVlc3RzIC90IFJFR19EV09SRCAvZCAxIC9mIHwgT3V0LU51bGwKaWYoJG1vZGUgLWVxICdsb3dlc3QnKXsKICAkdXA9KCgmIHBvd2VyY2ZnIC9saXN0KSB8IFNlbGVjdC1TdHJpbmcgLVBhdHRlcm4gJ1VsdGltYXRlIFBlcmZvcm1hbmNlfFBlcmZvcm1hbmNlcyBvcHRpbWFsZXMnIHwgU2VsZWN0LU9iamVjdCAtRmlyc3QgMSkKICBpZigkdXApeyAkcGc9KFtyZWdleF06Ok1hdGNoKCR1cC5Ub1N0cmluZygpLCdbMC05YS1mQS1GLV17MzZ9JykpLlZhbHVlIH0gZWxzZSB7ICRkcD0oJiBwb3dlcmNmZyAtZHVwbGljYXRlc2NoZW1lIGU5YTQyYjAyLWQ1ZGYtNDQ4ZC1hYTAwLTAzZjE0NzQ5ZWI2MSk7ICRwZz0oW3JlZ2V4XTo6TWF0Y2goW3N0cmluZ10kZHAsJ1swLTlhLWZBLUYtXXszNn0nKSkuVmFsdWUgfQogIGlmKCRwZyl7ICYgcG93ZXJjZmcgL3NldGFjdGl2ZSAkcGcgfCBPdXQtTnVsbCB9IGVsc2UgeyAmIHBvd2VyY2ZnIC9zZXRhY3RpdmUgOGM1ZTdmZGEtZThiZi00YTk2LTlhODUtYTZlMjNhOGM2MzVjIHwgT3V0LU51bGwgfQp9IGVsc2UgeyAmIHBvd2VyY2ZnIC9zZXRhY3RpdmUgOGM1ZTdmZGEtZThiZi00YTk2LTlhODUtYTZlMjNhOGM2MzVjIHwgT3V0LU51bGwgfQppZigkaXNsYXAgLWVxICcxJyl7ICYgcG93ZXJjZmcgL3NldGFjdGl2ZSA4YzVlN2ZkYS1lOGJmLTRhOTYtOWE4NS1hNmUyM2E4YzYzNWMgfCBPdXQtTnVsbCB9CmlmKCRpc2xhcCAtZXEgJzEnKXsgJHBtaW49MTAwOyAkaWRsZT0wIH0gZWxzZWlmKCR4M2QgLWVxIDEpeyAkcG1pbj0wOyAkaWRsZT0wIH0gZWxzZSB7ICRwbWluPTEwMDsgJGlkbGU9MSB9CiYgcG93ZXJjZmcgL3NldGFjdmFsdWVpbmRleCBzY2hlbWVfY3VycmVudCA1NDUzMzI1MS04MmJlLTQ4MjQtOTZjMS00N2I2MGI3NDBkMDAgMGNjNWI2NDctYzFkZi00NjM3LTg5MWEtZGVjMzVjMzE4NTgzICRwbWluIHwgT3V0LU51bGwKJiBwb3dlcmNmZyAvc2V0ZGN2YWx1ZWluZGV4IHNjaGVtZV9jdXJyZW50IDU0NTMzMjUxLTgyYmUtNDgyNC05NmMxLTQ3YjYwYjc0MGQwMCAwY2M1YjY0Ny1jMWRmLTQ2MzctODkxYS1kZWMzNWMzMTg1ODMgJHBtaW4gfCBPdXQtTnVsbAomIHBvd2VyY2ZnIC9zZXRhY3ZhbHVlaW5kZXggc2NoZW1lX2N1cnJlbnQgNTQ1MzMyNTEtODJiZS00ODI0LTk2YzEtNDdiNjBiNzQwZDAwIDVk>>"%TEMP%\llrap.b64"
echo NzZhMmNhLWU4YzAtNDAyZi1hMTMzLTIxNTg0OTJkNThhZCAkaWRsZSB8IE91dC1OdWxsCiYgcG93ZXJjZmcgL3NldGRjdmFsdWVpbmRleCBzY2hlbWVfY3VycmVudCA1NDUzMzI1MS04MmJlLTQ4MjQtOTZjMS00N2I2MGI3NDBkMDAgNWQ3NmEyY2EtZThjMC00MDJmLWExMzMtMjE1ODQ5MmQ1OGFkICRpZGxlIHwgT3V0LU51bGwKJiBwb3dlcmNmZyAvc2V0YWN2YWx1ZWluZGV4IHNjaGVtZV9jdXJyZW50IDJhNzM3NDQxLTE5MzAtNDQwMi04ZDc3LWIyYmViYmEzMDhhMyA0OGU2YjdhNi01MGY1LTQ3ODItYTVkNC01M2JiOGYwN2UyMjYgMCB8IE91dC1OdWxsCiYgcG93ZXJjZmcgL3NldGFjdmFsdWVpbmRleCBzY2hlbWVfY3VycmVudCBzdWJfcGNpZXhwcmVzcyBlZTEyZjkwNi1kMjc3LTQwNGItYjZkYS1lNWZhMWE1NzZkZjUgMCB8IE91dC1OdWxsCmlmKCRpc2xhcCAtZXEgJzEnKXsKJHdpZmk9QChHZXQtTmV0QWRhcHRlciAtUGh5c2ljYWwgLUVBIFNpbGVudGx5Q29udGludWUgfCBXaGVyZS1PYmplY3R7JF8uUGh5c2ljYWxNZWRpYVR5cGUgLWxpa2UgJyo4MDIuMTEqJyAtb3IgJF8uSW50ZXJmYWNlRGVzY3JpcHRpb24gLWxpa2UgJypXaXJlbGVzcyonfSkuQ291bnQKaWYoJHdpZmkgLWdlIDEpewomIHBvd2VyY2ZnIC9zZXRkY3ZhbHVlaW5kZXggc2NoZW1lX2N1cnJlbnQgMTljYmI4ZmEtNTI3OS00NTBlLTlmYWMtOGEzZDVmZWRkMGMxIDEyYmJlYmU2LTU4ZDYtNDYzNi05NWJiLTMyMTdlZjg2N2MxYSAzIHwgT3V0LU51bGwKJiBwb3dlcmNmZyAvc2V0YWN2YWx1ZWluZGV4IHNjaGVtZV9jdXJyZW50IDE5Y2JiOGZhLTUyNzktNDUwZS05ZmFjLThhM2Q1ZmVkZDBjMSAxMmJiZWJlNi01OGQ2LTQ2MzYtOTViYi0zMjE3ZWY4NjdjMWEgMCB8IE91dC1OdWxsCn0KfQomIHBvd2VyY2ZnIC9jaGFuZ2Ugc3RhbmRieS10aW1lb3V0LWFjIDAgfCBPdXQtTnVsbAomIHBvd2VyY2ZnIC9jaGFuZ2UgaGliZXJuYXRlLXRpbWVvdXQtYWMgMCB8IE91dC1OdWxsCiYgcG93ZXJjZmcgL2NoYW5nZSBtb25pdG9yLXRpbWVvdXQtYWMgMTUgfCBPdXQtTnVsbAomIHBvd2VyY2ZnIC9zZXRhY3RpdmUgc2NoZW1lX2N1cnJlbnQgfCBPdXQtTnVsbAokZ3A9R2V0LVBucERldmljZSB8IFdoZXJlLU9iamVjdCB7ICRfLlByb2JsZW0gLWVxICdDTV9QUk9CX1BIQU5UT00nIC1hbmQgJF8uUHJlc2VudCAtbmUgJHRydWUgfQpmb3JlYWNoKCRkIGluICRncCl7ICYgcG5wdXRpbC5leGUgL3JlbW92ZS1kZXZpY2UgJGQuSW5zdGFuY2VJZCAyPiRudWxsIHwgT3V0LU51bGwgfQpHZXQtQ2hpbGRJdGVtIC1QYXRoICRlbnY6VEVNUCAtUmVjdXJzZSAtRm9yY2UgLUVBIFNpbGVudGx5Q29udGludWUgfCBSZW1vdmUtSXRlbSAtUmVjdXJzZSAtRm9yY2UgLUVBIFNpbGVudGx5Q29udGludWUKR2V0LUNoaWxkSXRlbSAtUGF0aCAiJGVudjpTeXN0ZW1Sb290XFRlbXAiIC1SZWN1cnNlIC1Gb3JjZSAtRUEgU2lsZW50bHlDb250aW51ZSB8IFJlbW92ZS1JdGVtIC1SZWN1cnNlIC1Gb3JjZSAtRUEgU2lsZW50bHlDb250aW51ZQppcGNvbmZpZyAvZmx1c2hkbnMgfCBPdXQtTnVsbAokc3A9J0hLQ1U6XFNPRlRXQVJFXE1pY3Jvc29mdFxXaW5kb3dzXEN1cnJlbnRWZXJzaW9uXFN0b3JhZ2VTZW5zZVxQYXJhbWV0ZXJzXFN0b3JhZ2VQb2xpY3knCmlmKChHZXQtSXRlbVByb3BlcnR5ICRzcCAtTmFtZSAnMDEnIC1FQSBTaWxlbnRseUNvbnRpbnVlKS4nMDEnIC1lcSAxKXsKICBTdGFydC1TY2hlZHVsZWRUYXNrIC1UYXNrUGF0aCAnXE1pY3Jvc29mdFxXaW5kb3dzXERpc2tGb290cHJpbnRcJyAtVGFza05hbWUgJ1N0b3JhZ2VTZW5zZScgLUVBIFNpbGVudGx5Q29udGludWUKfQ==>>"%TEMP%\llrap.b64"
powershell -NoProfile -Command "[IO.File]::WriteAllText('%SystemRoot%\lowlat_reapply.ps1',[Text.Encoding]::ASCII.GetString([Convert]::FromBase64String(((Get-Content '%TEMP%\llrap.b64') -join ''))))" >nul 2>&1
del "%TEMP%\llrap.b64" >nul 2>&1
rem -- schtasks /Create laisse des defauts hostiles : DisallowStartIfOnBatteries,
rem    StopIfGoingOnBatteries et StartWhenAvailable=False. Sur un portable
rem    debranche la tache ne tourne alors JAMAIS, et une ouverture de session
rem    manquee n est jamais rattrapee. On la reconfigure derriere. --
schtasks /Create /F /TN "LowLat Reapply" /TR "powershell -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File \"%SystemRoot%\lowlat_reapply.ps1\"" /SC ONLOGON /RL HIGHEST >nul 2>&1
powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; $s=New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable -MultipleInstances IgnoreNew -ExecutionTimeLimit (New-TimeSpan -Minutes 30); Set-ScheduledTask -TaskName 'LowLat Reapply' -Settings $s" >nul 2>&1
echo   !OK! !CC![45]!C0! !M71!


echo.
echo  !CC!================================================================!C0!
echo    !CG!!DONE_APPLY!!C0!   !CW!!SUMMARY_HEAD!!C0!
echo  !CC!================================================================!C0!
echo.
echo    !CG![+]!C0! !SUM02!
echo    !CG![+]!C0! !SUM03!
if "!ISLAPTOP!"=="1" echo    !CG![+]!C0! !SUMLAP!
echo    !CG![+]!C0! !SUM04!
echo    !CG![+]!C0! !SUM05!
echo    !CG![+]!C0! !SUM06!
echo    !CG![+]!C0! !SUM07!
echo    !CG![+]!C0! !SUM08!
echo    !CG![+]!C0! !SUM09!
echo    !CG![+]!C0! !SUM11!
echo    !CG![+]!C0! !SUM12!
echo    !CG![+]!C0! !SUM13!
echo    !CG![+]!C0! !SUM14!
echo    !CG![+]!C0! !SUM15!
echo    !CG![+]!C0! !SUM16!
echo    !CG![+]!C0! !SUM17!
echo    !CG![+]!C0! !SUM18!
echo    !CG![+]!C0! !SUM_DEV!
echo.
echo   !CK!- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -!C0!
echo.
echo      !CK!!SIGN_BY! !CB!@sofalost!CK!, !SIGN_TAIL!!C0!
echo.
echo  !CC!================================================================!C0!
echo.
if /i "!L!"=="FR" echo  !CC!================================================================!C0!
if /i "!L!"=="FR" echo    !CL!Verification en direct ^(lecture seule^) des reglages cles!C0!
if /i not "!L!"=="FR" echo  !CC!================================================================!C0!
if /i not "!L!"=="FR" echo    !CL!Live verification ^(read-only^) of key settings!C0!
echo.
set /a VT=0
set /a VOK=0
set "EVP=38"
if "!MODEMARK!"=="lowest" set "EVP=42"
call :vck "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" Win32PrioritySeparation !EVP! "Win32 PrioritySeparation"
set "EVS=10"
if "!MODEMARK!"=="lowest" set "EVS=0"
call :vck "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" SystemResponsiveness !EVS! "SystemResponsiveness"
set "EVT=absent"
if "!MODEMARK!"=="lowest" set "EVT=8"
call :vck "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" TdrDelay !EVT! "TdrDelay"
call :vck "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" HwSchMode 2 "HAGS HwSchMode"
call :vck "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" Priority 6 "MMCSS Games priority"
if /i "!GPUVENDOR!"=="NVIDIA" call :vck "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" EnableGR535 0 "NVIDIA GR535 off"
call :vck "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" AllowTelemetry 0 "Telemetry off"
call :vck "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" EnableSmartScreen 0 "SmartScreen off"
call :vck "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent" AccentColorMenu 0xff484848 "Accent grey"
set "EVTR=1"
if "!LIGHTFX!"=="1" set "EVTR=0"
call :vck "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" EnableTransparency !EVTR! "Transparency"
set "EW=skip"
if "!WIFI!"=="2" set "EW=0x4"
if "!WIFI!"=="4" set "EW=0x2"
call :vcs WlanSvc !EW! "WlanSvc Wi-Fi"
set "EB=skip"
if "!BT!"=="2" set "EB=0x4"
if "!BT!"=="3" set "EB=0x3"
call :vcs bthserv !EB! "bthserv Bluetooth"
set "EPR=skip"
if "!PRINT!"=="2" set "EPR=0x4"
if "!PRINT!"=="3" set "EPR=0x2"
call :vcs Spooler !EPR! "Spooler printing"
set "EXB=skip"
if "!XBOX!"=="2" set "EXB=0x4"
if "!XBOX!"=="3" set "EXB=0x3"
call :vcs XblAuthManager !EXB! "XblAuthManager"
echo.
if /i "!L!"=="FR" echo    !CW!Reglages cles confirmes : !CG!!VOK!!CW!/!VT!!C0!
if /i not "!L!"=="FR" echo    !CW!Key settings confirmed: !CG!!VOK!!CW!/!VT!!C0!
echo  !CC!================================================================!C0!
echo.
echo   !CY![ ? ]!C0!  !CW!!Q_RESTART!!C0!
echo.
echo        !QO_YESNO!!C0!
echo.
powershell -NoProfile -Command "try{while([Console]::KeyAvailable){[Console]::ReadKey($true)|Out-Null}}catch{}" >nul 2>&1
choice /C 12 /N /M "        !PROMPT!"
set "RBANS=!errorlevel!"
if "!RBANS!"=="1" (
    echo.
    echo   !CG!!RESTARTING!!C0!
    shutdown /r /t 5
    pause
    goto ENDOK
) else (
    echo.
    echo   !CY!!RESTART_LATER!!C0!
    echo.
    pause
    goto MENU
)

rem #####################################################################
rem #                   MODE RESTAURATION (Windows clean)               #
rem #####################################################################
:RESTORE
echo.
echo  !CY!!REST_INTRO!!C0!
echo.
rem -- Rejeu du journal : rend a chaque valeur ce que la machine avait avant --
set "JRNDIR=%ProgramData%\LowLatOptimizer"
set "JRN=!JRNDIR!\restore-journal.csv"
set "JRNCNT=0"
if exist "!JRN!" (
    for /f "usebackq tokens=1-4,* delims=|" %%a in ("!JRN!") do (
        set /a JRNCNT+=1
        if "%%c"=="ABSENT" (
            reg delete "%%a" /v "%%b" /f >nul 2>&1
        ) else (
            reg add "%%a" /v "%%b" /t %%d /d "%%e" /f >nul 2>&1
        )
    )
    del /f /q "!JRN!" >nul 2>&1
)
echo   !OK! !RJRN! !JRNCNT!

rem -- GPU : debloque les MAJ pilote (securite restauration) --
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Restrictions" /v DenyDeviceIDs /t REG_DWORD /d 0 /f >nul 2>&1
rem -- IA (Copilot / Recall / WindowsAI) : restaure les valeurs Windows par defaut --
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v DisableAIDataAnalysis /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v TurnOffWindowsCopilot /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v TurnOffWindowsCopilot /f >nul 2>&1
rem -- CPU / RAM / planificateur --
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 2 /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control" /v SvcHostSplitThresholdInKB /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v WaitToKillServiceTimeout /t REG_SZ /d "5000" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v HungAppTimeout /t REG_SZ /d "5000" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v PowerThrottlingOff /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v GlobalTimerResolutionRequests /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 20 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 10 /f >nul 2>&1
echo   !OK! !R0!
rem -- Anti pop-up Store + TdrDelay + mitigations : retour defaut --
for %%P in (ms-gamingoverlay ms-gamebar ms-gamebarservices ms-xbox ms-xboxlive ms-yourphone ms-getstarted ms-feedback ms-retaildemo) do reg delete "HKCU\Software\Classes\%%P" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v NoUseStoreOpenWith /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v HideCategoryView /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v TdrDelay /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v EnableVirtualizationBasedSecurity /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v Enabled /t REG_DWORD /d 1 /f >nul 2>&1
bcdedit /set hypervisorlaunchtype auto >nul 2>&1
rem -- Reseau --
netsh int tcp reset >nul 2>&1
netsh winsock reset >nul 2>&1
netsh int tcp set global autotuninglevel=normal >nul 2>&1
netsh int tcp set global rsc=enabled >nul 2>&1
rem -- Peripheriques : reactiver Wi-Fi / Ethernet / Bluetooth / Camera desactives a l apply --
powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; Get-NetAdapter -Physical | Where-Object { $_.Status -eq 'Disabled' } | Enable-NetAdapter -Confirm:$false" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='SilentlyContinue'; Get-PnpDevice -Class Camera,Image,Bluetooth | Where-Object { $_.Status -ne 'OK' } | ForEach-Object { Enable-PnpDevice -InstanceId $_.InstanceId -Confirm:$false }" >nul 2>&1
sc config WlanSvc start= auto >nul 2>&1
sc start WlanSvc >nul 2>&1
sc config bthserv start= demand >nul 2>&1
sc config BTAGService start= demand >nul 2>&1
powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; Get-NetAdapter -Physical | Where-Object {$_.InterfaceDescription -notmatch 'Wireless|Wi-?Fi|802\.11'} | ForEach-Object { Set-NetAdapterAdvancedProperty -Name $_.Name -RegistryKeyword '*InterruptModeration' -RegistryValue 1 -NoRestart -EA SilentlyContinue; Set-NetAdapterAdvancedProperty -Name $_.Name -RegistryKeyword '*FlowControl' -RegistryValue 3 -NoRestart -EA SilentlyContinue; Set-NetAdapterAdvancedProperty -Name $_.Name -RegistryKeyword '*EEE' -RegistryValue 1 -NoRestart -EA SilentlyContinue }" >nul 2>&1
for /f "delims=" %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" 2^>nul') do (
    reg delete "%%i" /v TcpAckFrequency /f >nul 2>&1
    reg delete "%%i" /v TCPNoDelay /f >nul 2>&1
)
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v NonBestEffortLimit /f >nul 2>&1
echo   !OK! !R1!
rem -- IFEO + FSO --
for %%E in (!GAMES!) do reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%~E" /f >nul 2>&1
powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; $lay='HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers'; if(Test-Path $lay){ (Get-Item $lay).Property | Where-Object { $_ -match 'cs2.exe|Brawlhalla.exe|RainbowSix|r5apex|FortniteClient|VALORANT|League of Legends|Warframe|RobloxPlayerBeta' } | ForEach-Object { Remove-ItemProperty -Path $lay -Name $_ } }" >nul 2>&1
powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; $gpu='HKCU:\Software\Microsoft\DirectX\UserGpuPreferences'; if(Test-Path $gpu){ (Get-Item $gpu).Property | Where-Object { $_ -match 'cs2.exe|Brawlhalla.exe|RainbowSix|r5apex|FortniteClient|VALORANT|League of Legends|Warframe|RobloxPlayerBeta' } | ForEach-Object { Remove-ItemProperty -Path $gpu -Name $_ } }" >nul 2>&1
echo   !OK! !R2!
rem -- GameDVR + EnableGR535 --
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 1 /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v EnableGR535 /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters\FTS" /v EnableGR535 /f >nul 2>&1
powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; Get-PnpDevice -Class Display | ForEach-Object { $p='HKLM:\SYSTEM\CurrentControlSet\Enum\'+$_.InstanceId+'\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties'; if(Test-Path $p){ Remove-ItemProperty -Path $p -Name MSISupported -EA SilentlyContinue } }" >nul 2>&1
echo   !OK! !R3!
rem -- Bcdedit + NTFS --
bcdedit /deletevalue disabledynamictick >nul 2>&1
bcdedit /deletevalue tscsyncpolicy >nul 2>&1
bcdedit /timeout 30 >nul 2>&1
bcdedit /deletevalue {current} sos >nul 2>&1
bcdedit /set {bootmgr} displaybootmenu yes >nul 2>&1
bcdedit /deletevalue {current} bootux >nul 2>&1
echo   !OK! !R4!
rem -- Services par defaut (best effort) --
for %%s in (DiagTrack SysMain Spooler WSearch) do sc config "%%s" start= auto >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v DisablePagingExecutive /t REG_DWORD /d 0 /f >nul 2>&1
fsutil behavior set disable8dot3 0 >nul 2>&1
for %%s in (dmwappushservice diagsvc Fax WerSvc MapsBroker lfsvc PhoneSvc SmsRouter TapiSrv autotimesvc RmSvc tzautoupdate SCardSvr ScDeviceEnum SCPolicySvc CertPropSvc SensorService SensrSvc SensorDataService TrkWks WpcMonSvc RetailDemo wisvc WalletService SEMgrSvc SSDPSRV upnphost FDResPub fdPHost lltdsvc NetTcpPortSharing StiSvc AJRouter WMPNetworkSvc diagnosticshub.standardcollector.service p2pimsvc p2psvc PNRPsvc PNRPAutoReg XblAuthManager XblGameSave XboxNetApiSvc XboxGipSvc GamingServices PrintNotify) do sc config "%%s" start= demand >nul 2>&1
sc start Spooler >nul 2>&1
echo   !OK! !R5!
rem -- UAC / distance / lighting / shake / storage / qos / power --
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 5 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowToGetHelp /t REG_DWORD /d 1 /f >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /Enable >nul 2>&1
powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; Set-MpPreference -ScanAvgCPULoadFactor 50 -DisableScanningNetworkFiles $false -DisableArchiveScanning $false -DisableRealtimeMonitoring $false -DisableBehaviorMonitoring $false -DisableIOAVProtection $false -DisableScriptScanning $false -MAPSReporting 2 -SubmitSamplesConsent 1" >nul 2>&1
rem -- Sons systeme : le schema par defaut et chaque evenement sont rendus --
rem L apply vide le .Current de tous les evenements : sans ce retour, le PC
rem reste muet apres une restauration, sans que rien ne l explique.
reg add "HKCU\AppEvents\Schemes" /ve /t REG_SZ /d ".Default" /f >nul 2>&1
powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; Get-ChildItem -Path 'HKCU:\AppEvents\Schemes\Apps' -Recurse | Where-Object { $_.PSChildName -eq '.Current' } | ForEach-Object { $d=($_.PSPath -replace '\.Current$','.Default'); if(Test-Path $d){ Set-ItemProperty -Path $_.PSPath -Name '(Default)' -Value (Get-ItemProperty $d).'(default)' } }" >nul 2>&1
rem -- Exclusions Defender : retrait symetrique de celles posees a l apply --
rem Sans ca, « restaurer les defauts » laissait l antivirus troue pour de bon :
rem 7 chemins et 14 processus restaient exclus, invisibles pour l utilisateur.
powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; $s=(Get-ItemProperty 'HKCU:\Software\Valve\Steam' -Name SteamPath -EA SilentlyContinue).SteamPath; if($s){ $s=$s -replace '/','\'; foreach($g in 'Counter-Strike Global Offensive','Brawlhalla','Tom Clancy''s Rainbow Six Siege','Warframe'){ Remove-MpPreference -ExclusionPath ($s+'\steamapps\common\'+$g) } }" >nul 2>&1
powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; Remove-MpPreference -ExclusionPath 'C:\Riot Games'; Remove-MpPreference -ExclusionPath ($env:ProgramFiles+'\Epic Games\Warframe'); Remove-MpPreference -ExclusionPath 'C:\XboxGames\Roblox'; Remove-MpPreference -ExclusionPath ($env:SystemRoot+'\System32\drivers\etc\hosts')" >nul 2>&1
powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; Remove-MpPreference -ExclusionProcess 'cs2.exe','Brawlhalla.exe','League of Legends.exe','RiotClientServices.exe','RainbowSix.exe','RainbowSix_DX11.exe','VALORANT.exe','VALORANT-Win64-Shipping.exe','r5apex.exe','r5apex_dx12.exe','FortniteClient-Win64-Shipping.exe','Warframe.x64.exe','Warframe.exe','RobloxPlayerBeta.exe'" >nul 2>&1
powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; Remove-MpPreference -ExclusionPath '%~f0'" >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableBehaviorMonitoring /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v SpynetReporting /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v SubmitSamplesConsent /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v SmartScreenEnabled /t REG_SZ /d "Warn" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableSmartScreen /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v SaveZoneInformation /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Associations" /v LowRiskFileTypes /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v DisallowShaking /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v 01 /t REG_DWORD /d 0 /f >nul 2>&1
rem -- Effets visuels : on ne retablit QUE si le script les avait coupes (LightFX relu avant delete de la cle) --
set "RSTLFX=0"
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\LowLatOptimizer" /v LightFX 2^>nul ^| findstr /i /c:"REG_"') do set /a RSTLFX=%%a 2>nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 0 /f >nul 2>&1
if "!RSTLFX!"=="1" (
    reg delete "HKCU\Control Panel\Desktop" /v UserPreferencesMask /f >nul 2>&1
    reg add "HKCU\Control Panel\Desktop" /v DragFullWindows /t REG_SZ /d "1" /f >nul 2>&1
    reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d "1" /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewShadow /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v EnableAeroPeek /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v AlwaysHibernateThumbnails /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 1 /f >nul 2>&1
)
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableActivityFeed /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v PublishUserActivities /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v UploadUserActivities /f >nul 2>&1
reg delete "HKCU\Control Panel\Keyboard" /v PrintScreenKeyForSnippingEnabled /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /f >nul 2>&1
powershell -NoProfile -Command "$h=$env:SystemRoot+'\System32\drivers\etc\hosts'; if(Test-Path $h){ $c=[IO.File]::ReadAllText($h); $c=[regex]::Replace($c,'(?s)# (?:ULTRA|WIN11)-ADBLOCK START.*?# (?:ULTRA|WIN11)-ADBLOCK END\s*',''); [IO.File]::WriteAllText($h,$c,[Text.Encoding]::ASCII) }" >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 1 /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 1 /f >nul 2>&1
powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e >nul 2>&1
powercfg /change monitor-timeout-ac 10 >nul 2>&1
powercfg /change standby-timeout-ac 30 >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Restrictions" /f >nul 2>&1
echo   !OK! !R6!
rem -- Taches creees + stockage reserve --
schtasks /Delete /F /TN "TimerResolution 0.5ms" >nul 2>&1
schtasks /Delete /F /TN "TimerRes 0.5ms" >nul 2>&1
schtasks /Delete /F /TN "LowLat Reapply" >nul 2>&1
del /f /q "%SystemRoot%\timerres.ps1" >nul 2>&1
del /f /q "%SystemRoot%\lowlat_reapply.ps1" >nul 2>&1
reg delete "HKLM\SOFTWARE\LowLatOptimizer" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\DirectX\UserGpuPreferences" /v DirectXUserGlobalSettings /f >nul 2>&1
rundll32.exe user32.dll,UpdatePerUserSystemParameters 1, True
schtasks /Delete /F /TN "Opti Disques Quotidienne" >nul 2>&1
echo   !OK! !R7!
echo.
echo  !CC!================================================================!C0!
echo    !CG!!REST_DONE_HEAD!!C0!
echo    !CW!!REST_NOTE1!!C0!
echo    !CW!!REST_NOTE2!!C0!
echo    !CW!!REST_NOTE3!!C0!
echo  !CC!================================================================!C0!
echo.
echo   !CK!- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -!C0!
echo.
echo      !CK!!SIGN_BY! !CB!@sofalost!CK!, !SIGN_TAIL!!C0!
echo.
pause

:ENDOK
goto MENU

rem ================= :T "<cle>" "<valeur>" <type> "<donnee>" =================
rem Ecrit une valeur de registre EN NOTANT D ABORD celle qu elle remplace.
rem Le journal est la seule source de la restauration : tout ce qui passe
rem par ici est restaurable, par construction. Une valeur deja journalisee
rem ne l est pas deux fois - la premiere capture est la vraie origine, et
rem relancer le script n ecrase donc pas l etat d avant la 1re execution.
:T
set "_k=%~1"
set "_v=%~2"
set "_t=%~3"
set "_d=%~4"
findstr /b /l /c:"!_k!|!_v!|" "!JRN!" >nul 2>&1 && goto :_tapply
set "_line="
for /f "delims=" %%L in ('reg query "!_k!" /v "!_v!" 2^>nul ^| findstr /r /c:"    REG_"') do set "_line=%%L"
set "_ot="
set "_od="
if defined _line for %%T in (REG_EXPAND_SZ REG_MULTI_SZ REG_DWORD REG_QWORD REG_BINARY REG_NONE REG_SZ) do (
    if not defined _ot if not "!_line!"=="!_line:    %%T    =!" (
        set "_ot=%%T"
        set "_od=!_line:*    %%T    =!"
    )
)
rem L ecriture se fait HORS du bloc : dans un ( ), cmd re-analyse !_od! et un
rem « | » present dans la donnee y redevient un pipe, tronquant le journal.
if not defined _ot (>>"!JRN!" echo !_k!^|!_v!^|ABSENT^|^|) else (call :_tjrn)
goto :_tapply
:_tjrn
>>"!JRN!" echo !_k!^|!_v!^|SET^|!_ot!^|!_od!
goto :eof
:_tapply
reg add "!_k!" /v "!_v!" /t !_t! /d "!_d!" /f >nul 2>&1
goto :eof

:cln43
set "CLNFN=!CLNFP!"
for /f %%s in ('powershell -NoProfile -Command "[math]::Round((Get-PSDrive ($env:SystemDrive[0])).Free/1MB)" 2^>nul') do set "CLNFN=%%s"
set /a CLND=!CLNFN!-!CLNFP!
if !CLND! LSS 0 set "CLND=0"
set "%1=!CLND!"
set "CLNFP=!CLNFN!"
goto :eof

:sh43
echo   !CK!  %~1 : !C0!!CG!%2 Mo!C0!
goto :eof

:vck
set "vc="
for /f "tokens=3" %%a in ('reg query "%~1" /v "%~2" 2^>nul ^| findstr /i /c:"REG_"') do set "vc=%%a"
set /a VT+=1
if /i "%~3"=="absent" goto vck_a
if not defined vc goto vck_x
set "vce=%~3"
if /i "!vce:~0,2!"=="0x" ( if /i "!vc!"=="!vce!" (goto vck_o) else (goto vck_x) )
set /a vcd=vc 2>nul
if !vcd! EQU %~3 goto vck_o
goto vck_x
:vck_o
echo    !CG![ ok ]!C0! %~4
set /a VOK+=1
goto :eof
:vck_x
echo    !CR![ X  ]!C0! %~4
goto :eof
:vck_a
if defined vc goto vck_x
echo    !CG![ ok ]!C0! %~4
set /a VOK+=1
goto :eof

:vcs
if /i "%~2"=="skip" goto :eof
set "vc="
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\%~1" /v Start 2^>nul ^| findstr /i /c:"REG_"') do set "vc=%%a"
set /a VT+=1
if not defined vc goto vcs_x
if /i "!vc!"=="%~2" goto vcs_o
echo    !CR![ X  ]!C0! %~3
goto :eof
:vcs_o
echo    !CG![ ok ]!C0! %~3
set /a VOK+=1
goto :eof
:vcs_x
echo    !CR![ X  ]!C0! %~3
goto :eof


:TIMERNV
rem ---- Detection GPU NVIDIA (pour le tweak EnableGR535) ----
set "HASNV=0"
for /f "usebackq delims=" %%g in (`powershell -NoProfile -Command "if((Get-CimInstance Win32_VideoController).Name -match 'NVIDIA'){'1'}else{'0'}"`) do set "HASNV=%%g"

rem ---- Base64 du timerres.ps1 (boucle NtSetTimerResolution 0.5 ms, mutex par session) ----
set "TRPSB64=JEVycm9yQWN0aW9uUHJlZmVyZW5jZT0nU2lsZW50bHlDb250aW51ZScKJG10eD1OZXctT2JqZWN0IFN5c3RlbS5UaHJlYWRpbmcuTXV0ZXgoJGZhbHNlLCdHbG9iYWxcTG93TGF0VGltZXJSZXMwNScpCiRhYmFuZG9uZWQ9JGZhbHNlCnRyeXsKICBpZigtbm90ICRtdHguV2FpdE9uZSgwKSl7ZXhpdH0KfWNhdGNoIFtTeXN0ZW0uVGhyZWFkaW5nLkFiYW5kb25lZE11dGV4RXhjZXB0aW9uXXsKICAjIE11dGV4IGFiYW5kb25uZSBwYXIgdW4gcHJlY2VkZW50IHByb2Nlc3MgbW9ydCBlbiBsZSB0ZW5hbnQuCiAgIyBTZW1hbnRpcXVlbWVudCA9IGFjcXVpc2l0aW9uIHJldXNzaWUgKG9uIGxlIHBvc3NlZGUpLiBPbiBjb250aW51ZS4KICAkYWJhbmRvbmVkPSR0cnVlCn0KU3RhcnQtU2xlZXAgLVNlY29uZHMgNQokc2lnPUAnCltEbGxJbXBvcnQoIm50ZGxsLmRsbCIpXSBwdWJsaWMgc3RhdGljIGV4dGVybiBpbnQgTnRTZXRUaW1lclJlc29sdXRpb24odWludCBEZXNpcmVkUmVzb2x1dGlvbiwgYm9vbCBTZXRSZXNvbHV0aW9uLCBvdXQgdWludCBDdXJyZW50UmVzb2x1dGlvbik7CltEbGxJbXBvcnQoIm50ZGxsLmRsbCIpXSBwdWJsaWMgc3RhdGljIGV4dGVybiBpbnQgTnRRdWVyeVRpbWVyUmVzb2x1dGlvbihvdXQgdWludCBNaW5SZXMsIG91dCB1aW50IE1heFJlcywgb3V0IHVpbnQgQ3VyUmVzKTsKW0RsbEltcG9ydCgia2VybmVsMzIuZGxsIildIHB1YmxpYyBzdGF0aWMgZXh0ZXJuIGJvb2wgR2V0U3lzdGVtUG93ZXJTdGF0dXMob3V0IFNQUyBzKTsKW1N0cnVjdExheW91dChMYXlvdXRLaW5kLlNlcXVlbnRpYWwpXSBwdWJsaWMgc3RydWN0IFNQUyB7IHB1YmxpYyBieXRlIEFDTGluZVN0YXR1czsgcHVibGljIGJ5dGUgQmF0dGVyeUZsYWc7IHB1YmxpYyBieXRlIEJhdHRlcnlMaWZlUGVyY2VudDsgcHVibGljIGJ5dGUgU3lzdGVtU3RhdHVzRmxhZzsgcHVibGljIGludCBCYXR0ZXJ5TGlmZVRpbWU7IHB1YmxpYyBpbnQgQmF0dGVyeUZ1bGxMaWZlVGltZTsgfQonQAokVFI9JG51bGwKJG49MAp3aGlsZSgkbnVsbCAtZXEgJFRSIC1hbmQgJG4gLWx0IDEyMCl7CiAgIyBBZGQtVHlwZSAtUGFzc1RocnUgcmVudm9pZSBVTiBUQUJMRUFVIChsZSB0eXBlICsgbGEgc3RydWN0IFNQUyBpbWJyaXF1ZWUpLg0KICAjIFNhbnMgY2UgV2hlcmUtT2JqZWN0LCAkVFIgdmF1dCBPYmplY3RbXSBldCBUT1VUIGFwcGVsICRUUjo6WHh4IGVjaG91ZS4NCiAgdHJ5eyRyPUFkZC1UeXBlIC1OYW1lIFRycyAtTmFtZXNwYWNlIExsIC1NZW1iZXJEZWZpbml0aW9uICRzaWcgLVBhc3NUaHJ1IC1FcnJvckFjdGlvbiBTdG9wOyAkVFI9QCgkcikgfCBXaGVyZS1PYmplY3QgeyAkXy5OYW1lIC1lcSAnVHJzJyB9IHwgU2VsZWN0LU9iamVjdCAtRmlyc3QgMX1jYXRjaHtTdGFydC1TbGVlcCAtU2Vjb25kcyAyfQogICRuKysKfQppZigkbnVsbCAtZXEgJFRSKXtleGl0IDF9CiRyZWc9J0hLTE06XFNPRlRXQVJFXExvd0xhdE9wdGltaXplcicKdHJ5e2lmKC1ub3QoVGVzdC1QYXRoICRyZWcpKXtOZXctSXRlbSAtUGF0aCAkcmVnIC1Gb3JjZXxPdXQtTnVsbH19Y2F0Y2h7fQpmdW5jdGlvbiBMb2dUaW1lcigkc3RhdGUpewogIHRyeXsKICAgICRtaW49W3VpbnQzMl0wOyRtYXg9W3VpbnQzMl0wOyRjdXI9W3VpbnQzMl0wCiAgICBbdm9pZF0kVFI6Ok50UXVlcnlUaW1lclJlc29sdXRpb24oW3JlZl0kbWluLFtyZWZdJG1heCxbcmVmXSRjdXIpCiAgICBTZXQtSXRlbVByb3BlcnR5IC1QYXRoICRyZWcgLU5hbWUgJ1RpbWVyQ3VyJyAtVmFsdWUgJGN1ciAtVHlwZSBEV29yZCAtRm9yY2UKICAgIFNldC1JdGVtUHJvcGVydHkgLVBhdGggJHJlZyAtTmFtZSAnVGltZXJTdGF0ZScgLVZhbHVlICRzdGF0ZSAtVHlwZSBTdHJpbmcgLUZvcmNlCiAgICBTZXQtSXRlbVByb3BlcnR5IC1QYXRoICRyZWcgLU5hbWUgJ1RpbWVyQWJhbmRvbmVkJyAtVmFsdWUgJGFiYW5kb25lZCAtVHlwZSBEV29yZCAtRm9yY2UKICB9Y2F0Y2h7fQp9CiRjPTAKd2hpbGUoJHRydWUpewogICRob2xkPSR0cnVlCiAgdHJ5ewogICAgJHM9TmV3LU9iamVjdCAnTGwuVHJzK1NQUycKICAgIGlmKCRUUjo6R2V0U3lzdGVtUG93ZXJTdGF0dXMoW3JlZl0kcykpewogICAgICAjIEJhdHRlcnlGbGFnIGVzdCB1biBiaXRmaWVsZCA7IGJpdCAxMjggPSAibm8gc3lzdGVtIGJhdHRlcnkiIChkZXNrdG9wKS4KICAgICAgIyBPbiByZWxhY2hlIChob2xkPWZhbHNlKSBVTklRVUVNRU5UIHNpIGJhdHRlcmllIHByZXNlbnRlIEVUIHN1ciBzZWN0ZXVyIGRlY29ubmVjdGUuCiAgICAgIGlmKCgoJHMuQmF0dGVyeUZsYWcgLWJhbmQgMTI4KSAtZXEgMCkgLWFuZCAkcy5BQ0xpbmVTdGF0dXMgLWVxIDApeyRob2xkPSRmYWxzZX0KICAgIH0KICB9Y2F0Y2h7JGhvbGQ9JHRydWV9CiAgdHJ5ewogICAgaWYoJGhvbGQpewogICAgICAkVFI6Ok50U2V0VGltZXJSZXNvbHV0aW9uKDUwMDAsJHRydWUsW3JlZl0kYyl8T3V0LU51bGwKICAgICAgTG9nVGltZXIgJ2hlbGQnCiAgICB9ZWxzZXsKICAgICAgJFRSOjpOdFNldFRpbWVyUmVzb2x1dGlvbig1MDAwLCRmYWxzZSxbcmVmXSRjKXxPdXQtTnVsbAogICAgICBMb2dUaW1lciAncmVsZWFzZWQnCiAgICB9CiAgfWNhdGNoewogICAgdHJ5e1NldC1JdGVtUHJvcGVydHkgLVBhdGggJHJlZyAtTmFtZSAnVGltZXJTdGF0ZScgLVZhbHVlICgnZXJyb3I6ICcrJF8uRXhjZXB0aW9uLk1lc3NhZ2UpIC1UeXBlIFN0cmluZyAtRm9yY2V9Y2F0Y2h7fQogICAgU3RhcnQtU2xlZXAgLVNlY29uZHMgMzAKICB9CiAgU3RhcnQtU2xlZXAgLVNlY29uZHMgNQp9Cg=="
set "TASKB64=JEVycm9yQWN0aW9uUHJlZmVyZW5jZT0nU2lsZW50bHlDb250aW51ZScKJHRuPSdUaW1lclJlcyAwLjVtcycKJHBzPSRlbnY6U3lzdGVtUm9vdCsnXHRpbWVycmVzLnBzMScKJGE9TmV3LVNjaGVkdWxlZFRhc2tBY3Rpb24gLUV4ZWN1dGUgJ3Bvd2Vyc2hlbGwuZXhlJyAtQXJndW1lbnQgKCctTm9Qcm9maWxlIC1XaW5kb3dTdHlsZSBIaWRkZW4gLUV4ZWN1dGlvblBvbGljeSBCeXBhc3MgLUZpbGUgIicrJHBzKyciJykKJHQxPU5ldy1TY2hlZHVsZWRUYXNrVHJpZ2dlciAtQXRTdGFydHVwCiR0Mj1OZXctU2NoZWR1bGVkVGFza1RyaWdnZXIgLUF0TG9nT24KJHA9TmV3LVNjaGVkdWxlZFRhc2tQcmluY2lwYWwgLVVzZXJJZCAnTlQgQVVUSE9SSVRZXFNZU1RFTScgLUxvZ29uVHlwZSBTZXJ2aWNlQWNjb3VudCAtUnVuTGV2ZWwgSGlnaGVzdAokcz1OZXctU2NoZWR1bGVkVGFza1NldHRpbmdzU2V0IC1BbGxvd1N0YXJ0SWZPbkJhdHRlcmllcyAtRG9udFN0b3BJZkdvaW5nT25CYXR0ZXJpZXMgLUV4ZWN1dGlvblRpbWVMaW1pdCAoW1RpbWVTcGFuXTo6WmVybykgLVJlc3RhcnRDb3VudCAzIC1SZXN0YXJ0SW50ZXJ2YWwgKE5ldy1UaW1lU3BhbiAtTWludXRlcyAxKSAtTXVsdGlwbGVJbnN0YW5jZXMgSWdub3JlTmV3IC1TdGFydFdoZW5BdmFpbGFibGUKUmVnaXN0ZXItU2NoZWR1bGVkVGFzayAtVGFza05hbWUgJHRuIC1BY3Rpb24gJGEgLVRyaWdnZXIgJHQxLCR0MiAtUHJpbmNpcGFsICRwIC1TZXR0aW5ncyAkcyAtRm9yY2UgfCBPdXQtTnVsbApTdGFydC1TY2hlZHVsZWRUYXNrIC1UYXNrTmFtZSAkdG4K"

set "TN_TITLE=0.5 ms TIMER  +  NVIDIA TWEAK (EnableGR535)"
set "TN_Q1=0.5 ms timer  (NtSetTimerResolution, re-armed at startup)"
set "TN_CH=      !CG2![1]!C0! Apply       !CO3![2]!C0! Remove       !CK![0]!C0! Skip"
set "TN_Q2=NVIDIA tweak  EnableGR535 = 0  (old sharpening method)"
set "TN_NONV=[ i ]  No NVIDIA GPU detected: EnableGR535 tweak skipped."
set "TN_NVNA=N/A - no NVIDIA GPU"
set "TN_TSKIP=[ - ] 0.5 ms timer: skipped."
set "TN_TAPP=[...] Applying the 0.5 ms timer..."
set "TN_TAPPST=APPLIED - SYSTEM task at boot + each logon"
set "TN_TAPPOK=[ OK ] 0.5 ms timer applied."
set "TN_TREM=[...] Removing the 0.5 ms timer..."
set "TN_TREMST=REMOVED"
set "TN_TREMOK=[ OK ] 0.5 ms timer removed."
set "TN_NVSKIP=[ - ] NVIDIA tweak: skipped."
set "TN_NVAPP=[...] Applying NVIDIA tweak EnableGR535=0..."
set "TN_NVAPPST=APPLIED - EnableGR535=0"
set "TN_NVAPPOK=[ OK ] NVIDIA EnableGR535=0 applied."
set "TN_NVREM=[...] Removing NVIDIA tweak EnableGR535..."
set "TN_NVREMST=REMOVED - driver default"
set "TN_NVREMOK=[ OK ] NVIDIA EnableGR535 removed."
set "TN_SUM=SUMMARY:"
set "TN_LT=0.5 ms timer"
set "TN_LNV=NVIDIA GR535"
set "TN_RB1=A reboot is recommended: the global timer request and the"
set "TN_RB2=NVIDIA tweak fully take effect after a reboot."
set "TN_UNCH=UNCHANGED"
if /i "!L!"=="FR" set "TN_TITLE=TIMER 0.5 ms  +  TWEAK NVIDIA (EnableGR535)"
if /i "!L!"=="FR" set "TN_Q1=Timer 0.5 ms  (NtSetTimerResolution, relance au demarrage)"
if /i "!L!"=="FR" set "TN_CH=      !CG2![1]!C0! Appliquer   !CO3![2]!C0! Retirer     !CK![0]!C0! Ignorer"
if /i "!L!"=="FR" set "TN_Q2=Tweak NVIDIA  EnableGR535 = 0  (ancienne methode de sharpening)"
if /i "!L!"=="FR" set "TN_NONV=[ i ]  Pas de GPU NVIDIA detecte : tweak EnableGR535 ignore."
if /i "!L!"=="FR" set "TN_NVNA=N/A - pas de GPU NVIDIA"
if /i "!L!"=="FR" set "TN_TSKIP=[ - ] Timer 0.5 ms : ignore."
if /i "!L!"=="FR" set "TN_TAPP=[...] Application du timer 0.5 ms..."
if /i "!L!"=="FR" set "TN_TAPPST=APPLIQUE - tache SYSTEM au boot + a chaque session"
if /i "!L!"=="FR" set "TN_TAPPOK=[ OK ] Timer 0.5 ms applique."
if /i "!L!"=="FR" set "TN_TREM=[...] Retrait du timer 0.5 ms..."
if /i "!L!"=="FR" set "TN_TREMST=RETIRE"
if /i "!L!"=="FR" set "TN_TREMOK=[ OK ] Timer 0.5 ms retire."
if /i "!L!"=="FR" set "TN_NVSKIP=[ - ] Tweak NVIDIA : ignore."
if /i "!L!"=="FR" set "TN_NVAPP=[...] Application du tweak NVIDIA EnableGR535=0..."
if /i "!L!"=="FR" set "TN_NVAPPST=APPLIQUE - EnableGR535=0"
if /i "!L!"=="FR" set "TN_NVAPPOK=[ OK ] NVIDIA EnableGR535=0 applique."
if /i "!L!"=="FR" set "TN_NVREM=[...] Retrait du tweak NVIDIA EnableGR535..."
if /i "!L!"=="FR" set "TN_NVREMST=RETIRE - retour defaut pilote"
if /i "!L!"=="FR" set "TN_NVREMOK=[ OK ] NVIDIA EnableGR535 retire."
if /i "!L!"=="FR" set "TN_SUM=RESUME :"
if /i "!L!"=="FR" set "TN_LT=Timer 0.5 ms"
if /i "!L!"=="FR" set "TN_RB1=Un redemarrage est conseille : la demande timer globale et le"
if /i "!L!"=="FR" set "TN_RB2=tweak NVIDIA prennent pleinement effet apres reboot."
if /i "!L!"=="FR" set "TN_UNCH=INCHANGE"
set "TN_SUB=Applying the timer also removes phantom (non-present) devices."
set "TN_PHAN=[...] Removing phantom (non-present) devices..."
set "TN_PHANOK1=[ OK ] Phantom devices removed:"
set "TN_LPH=Phantom devices"
if /i "!L!"=="FR" set "TN_SUB=Appliquer le timer nettoie aussi les peripheriques fantomes (absents)."
if /i "!L!"=="FR" set "TN_PHAN=[...] Nettoyage des peripheriques fantomes (absents)..."
if /i "!L!"=="FR" set "TN_PHANOK1=[ OK ] Peripheriques fantomes retires :"
if /i "!L!"=="FR" set "TN_LPH=Peripheriques fantomes"
set "TIMERSTATE=!TN_UNCH!"
set "NVSTATE=!TN_UNCH!"
set "PHANSTATE=!TN_UNCH!"

cls
echo  !CB2!================================================================!C0!
echo            !CT!!TN_TITLE!!C0!
echo  !CB2!================================================================!C0!
echo.
echo   !CK!!TN_SUB!!C0!
echo.

rem ====================== QUESTION 1 : TIMER ======================
echo   !CW![ !CG!?!CW! ]  !TN_Q1!!C0!
echo.
echo   !TN_CH!
echo.
choice /C 120 /N >nul
set "TIMERANS=!errorlevel!"
echo.

rem ================ QUESTION 2 : NVIDIA (si concerne) =============
set "NVANS=3"
if not "!HASNV!"=="1" goto Q2_SKIP
echo   !CW![ !CG!?!CW! ]  !TN_Q2!!C0!
echo.
echo   !TN_CH!
echo.
choice /C 120 /N >nul
set "NVANS=!errorlevel!"
echo.
goto Q2_DONE
:Q2_SKIP
echo   !CK!!TN_NONV!!C0!
set "NVSTATE=!TN_NVNA!"
echo.
:Q2_DONE

echo  !CK!----------------------------------------------------------------!C0!
echo.

rem ========================= TIMER : action =======================
if "!TIMERANS!"=="1" goto T_APPLY
if "!TIMERANS!"=="2" goto T_REMOVE
echo   !CK!!TN_TSKIP!!C0!
goto T_DONE
:T_APPLY
echo   !CY!!TN_TAPP!!C0!
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v GlobalTimerResolutionRequests /t REG_DWORD /d 1 /f >nul 2>&1
powershell -NoProfile -Command "[IO.File]::WriteAllText('%SystemRoot%\timerres.ps1',[Text.Encoding]::ASCII.GetString([Convert]::FromBase64String('!TRPSB64!')))" >nul 2>&1
powershell -NoProfile -Command "[IO.File]::WriteAllText($env:TEMP+'\tinst.ps1',[Text.Encoding]::ASCII.GetString([Convert]::FromBase64String('!TASKB64!')))" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -File "%TEMP%\tinst.ps1" >nul 2>&1
del /f /q "%TEMP%\tinst.ps1" >nul 2>&1
set "TIMERSTATE=!TN_TAPPST!"
echo   !CG!!TN_TAPPOK!!C0!
echo   !CY!!TN_PHAN!!C0!
set "PHANCNT=0"
for /f "usebackq delims=" %%n in (`powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; $k=0; Get-PnpDevice | Where-Object { $_.Problem -eq 'CM_PROB_PHANTOM' -and $_.Present -ne $true } | ForEach-Object { pnputil /remove-device $_.InstanceId | Out-Null; $k++ }; Write-Output $k"`) do set "PHANCNT=%%n"
set "PHANSTATE=!PHANCNT! removed"
if /i "!L!"=="FR" set "PHANSTATE=!PHANCNT! retire(s)"
echo   !CG!!TN_PHANOK1! !PHANCNT!!C0!
goto T_DONE
:T_REMOVE
echo   !CY!!TN_TREM!!C0!
schtasks /Delete /F /TN "TimerRes 0.5ms" >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v GlobalTimerResolutionRequests /f >nul 2>&1
powershell -NoProfile -Command "Get-CimInstance Win32_Process | Where-Object {$_.CommandLine -like '*timerres.ps1*'} | ForEach-Object { Stop-Process -Id $_.ProcessId -Force }" >nul 2>&1
del /f /q "%SystemRoot%\timerres.ps1" >nul 2>&1
set "TIMERSTATE=!TN_TREMST!"
echo   !CG!!TN_TREMOK!!C0!
:T_DONE

echo.

rem ========================= NVIDIA : action ======================
if "!NVANS!"=="1" goto NV_APPLY
if "!NVANS!"=="2" goto NV_REMOVE
if "!HASNV!"=="1" echo   !CK!!TN_NVSKIP!!C0!
goto NV_DONE
:NV_APPLY
echo   !CY!!TN_NVAPP!!C0!
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v EnableGR535 /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters\FTS" /v EnableGR535 /t REG_DWORD /d 0 /f >nul 2>&1
set "NVSTATE=!TN_NVAPPST!"
echo   !CG!!TN_NVAPPOK!!C0!
goto NV_DONE
:NV_REMOVE
echo   !CY!!TN_NVREM!!C0!
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v EnableGR535 /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters\FTS" /v EnableGR535 /f >nul 2>&1
set "NVSTATE=!TN_NVREMST!"
echo   !CG!!TN_NVREMOK!!C0!
:NV_DONE

echo.
echo  !CB2!================================================================!C0!
echo    !CC!!TN_SUM!!C0!
echo      !CW!!TN_LT!!C0!   : !CG!!TIMERSTATE!!C0!
echo      !CW!!TN_LNV!!C0!   : !CG!!NVSTATE!!C0!
echo      !CW!!TN_LPH!!C0!   : !CG!!PHANSTATE!!C0!
echo  !CB2!================================================================!C0!
echo.
echo   !CY!!TN_RB1!!C0!
echo   !CY!!TN_RB2!!C0!
echo.
pause
goto MENU


:QWMENU
cls
echo.
echo   !CB2!================================================================!C0!
echo              !CT!CLAVIER  QWERTY (US) / AZERTY (FR)  -  jeu!C0!
echo   !CB2!================================================================!C0!
echo.
echo   !CK!Claviers installes en ce moment :!C0!
for /f "delims=" %%k in ('powershell -NoProfile -Command "(Get-WinUserLanguageList).LanguageTag"') do echo       !CGE!%%k!C0!
echo.
echo       !CG2![1]!C0!   Ajouter le clavier !CW!QWERTY (US)!C0! en plus du francais
echo       !CO3![2]!C0!   Revenir au !CW!francais seul!C0! + masquer l'icone clavier
echo       !CK![0]!C0!   !BACK!
echo.
choice /c 120 /n /m "   Choix : "
if errorlevel 3 goto MENU
if errorlevel 2 goto QWREVERT
if errorlevel 1 goto QWADD

:QWADD
echo.
echo   !CY!Ajout du clavier anglais QWERTY (US)...!C0!
powershell -NoProfile -ExecutionPolicy Bypass -Command "$l=Get-WinUserLanguageList; if(-not($l|Where-Object{$_.LanguageTag-eq'en-US'})){$l.Add('en-US'); Set-WinUserLanguageList $l -Force}" >nul 2>&1
rem -- desactive Ctrl+Maj et Alt-gauche+Maj qui changent le clavier par erreur (anti-missclick en jeu) --
reg add "HKCU\Keyboard Layout\Toggle" /v "Hotkey" /t REG_SZ /d 3 /f >nul 2>&1
reg add "HKCU\Keyboard Layout\Toggle" /v "Language Hotkey" /t REG_SZ /d 3 /f >nul 2>&1
reg add "HKCU\Keyboard Layout\Toggle" /v "Layout Hotkey" /t REG_SZ /d 3 /f >nul 2>&1
echo   !CG![OK]!C0! Clavier anglais QWERTY ajoute (le francais AZERTY reste par defaut).
echo   !CK!        Raccourcis  !CW!Ctrl+Maj!CK!  /  !CW!Alt-gauche+Maj!CK!  desactives - anti-missclick en jeu.!C0!
echo   !CK!        Bascule volontaire via l'icone de langue dans la barre des taches.!C0!
echo.
pause
goto MENU

:QWREVERT
echo.
echo   !CY!Retour au francais seul + masquage de l'icone clavier...!C0!
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='SilentlyContinue'; $fr=@(Get-WinUserLanguageList|Where-Object{$_.LanguageTag-match'^fr'})|Select-Object -First 1; $tag='fr-FR'; if($fr){$tag=$fr.LanguageTag}; Set-WinUserLanguageList (New-WinUserLanguageList $tag) -Force; $p='HKCU:\Keyboard Layout\Preload'; foreach($n in (Get-Item $p).Property){if((Get-ItemProperty $p).$n -eq '00000409'){Remove-ItemProperty $p -Name $n}}" >nul 2>&1
reg add "HKCU\Software\Microsoft\CTF\LangBar" /v ShowStatus /t REG_DWORD /d 3 /f >nul 2>&1
rem -- remet les raccourcis de changement de clavier par defaut --
reg add "HKCU\Keyboard Layout\Toggle" /v "Hotkey" /t REG_SZ /d 1 /f >nul 2>&1
reg add "HKCU\Keyboard Layout\Toggle" /v "Language Hotkey" /t REG_SZ /d 1 /f >nul 2>&1
reg add "HKCU\Keyboard Layout\Toggle" /v "Layout Hotkey" /t REG_SZ /d 2 /f >nul 2>&1
echo   !CG![OK]!C0! Francais seul. Le clavier anglais QWERTY a ete retire.
echo   !CK!        Avec un seul clavier, l'icone de langue disparait de la barre.!C0!
echo   !CK!        Raccourcis de changement de clavier remis par defaut.!C0!
echo   !CK!        A appliquer apres une fermeture/reouverture de session (ou un reboot).!C0!
echo.
pause
goto MENU



:DEBUGRUN
cls
rem ===== langue EN/FR auto =====
set "LG=EN"
for /f "delims=" %%c in ('powershell -NoProfile -Command "(Get-UICulture).Name" 2^>nul') do set "UIC=%%c"
echo !UIC!| findstr /i /b "fr" >nul 2>&1 && set "LG=FR"
if /i "!LG!"=="FR" (
    set "LF=ECHEC"
    set "LEX=attendu"
    set "LDE=supprime"
    set "LPR=present"
    set "LTP=presente"
    set "LTA=absente"
    set "LSA=devrait etre absent"
    set "LNI=present sur une interface"
    set "LIL=illisible"
    set "LHN=cle absente, HAGS non dispo"
    set "LGN=absent, normal hors NVIDIA"
    set "LAN=inactif, normal hors AMD 25.9.1"
    set "LAA=actif DenyDeviceIDs=1"
    set "LAO=desactive DenyDeviceIDs=0"
    set "LNS=non defini, defaut"
    set "LSV=service absent"
    set "LPA=Plan d'alim actif"
    set "LTK=Tache"
    set "TMRL=Resolution timer mesuree ...."
    set "LHA=2 attendu si HAGS actif"
    set "LCH=selon ton choix"
    set "LTT=Verification des tweaks - LOW_LATENCY_GAMING_SCRIPT"
    set "LN1=Etat non trouve dans le registre."
    set "LN2=Le script principal n'a pas ete lance, ou etat efface."
    set "LN3=Valeurs brutes ; verdicts mode-dependants neutralises."
    set "LLAP=Portable"
    set "H1=TIMER / HORLOGE"
    set "H2=REACTIVITE / PRIORITE"
    set "H3=RESEAU"
    set "H4=ALIMENTATION"
    set "H5=MEMOIRE / PREFETCH"
    set "H6=PRIORITE JEUX"
    set "H7=SOURIS / CLAVIER"
    set "H8=ALIMENTATION (suite)"
    set "H9=SECURITE (a regarder consciemment)"
    set "H10=VIE PRIVEE / DEBLOAT"
    set "H11=DOIVENT ETRE ABSENTS (supprimes)"
    set "H12=SERVICES (Start: 4=desactive, 2=auto)"
    set "H13=VIE PRIVEE (suite)"
    set "H14=INTERFACE / APPARENCE"
    set "H15=CLAVIER / SYSTEME / DIVERS"
    set "LRS=Resultat"
    set "LGR=tweaks verifiables au vert."
    set "LNO=Les lignes [info] sont conditionnelles (vendeur GPU, mode, choix) et ne comptent pas comme echec."
    set "LTI=Astuce : si une ligne est en ECHEC, relance le script principal puis redemarre completement."
) else (
    set "LF=FAIL"
    set "LEX=expected"
    set "LDE=deleted"
    set "LPR=present"
    set "LTP=present"
    set "LTA=missing"
    set "LSA=should be absent"
    set "LNI=present on an interface"
    set "LIL=unreadable"
    set "LHN=key absent, HAGS unavailable"
    set "LGN=absent, normal unless NVIDIA"
    set "LAN=inactive, normal unless AMD 25.9.1"
    set "LAA=active DenyDeviceIDs=1"
    set "LAO=inactive DenyDeviceIDs=0"
    set "LNS=not set, default"
    set "LSV=service missing"
    set "LPA=Active power plan"
    set "LTK=Task"
    set "TMRL=Measured timer resolution ..."
    set "LHA=2 expected if HAGS on"
    set "LCH=per your choice"
    set "LTT=Tweak check - LOW_LATENCY_GAMING_SCRIPT"
    set "LN1=State not found in registry."
    set "LN2=Main script not run yet, or state cleared."
    set "LN3=Raw values; mode-dependent verdicts disabled."
    set "LLAP=Laptop"
    set "H1=TIMER / CLOCK"
    set "H2=RESPONSIVENESS / PRIORITY"
    set "H3=NETWORK"
    set "H4=POWER"
    set "H5=MEMORY / PREFETCH"
    set "H6=GAME PRIORITY"
    set "H7=MOUSE / KEYBOARD"
    set "H8=POWER (more)"
    set "H9=SECURITY (worth a conscious look)"
    set "H10=PRIVACY / DEBLOAT"
    set "H11=MUST BE ABSENT (deleted)"
    set "H12=SERVICES (Start: 4=disabled, 2=auto)"
    set "H13=PRIVACY (more)"
    set "H14=INTERFACE / APPEARANCE"
    set "H15=KEYBOARD / SYSTEM / MISC"
    set "LRS=Result"
    set "LGR=verifiable tweaks OK."
    set "LNO=[info] lines are conditional (GPU vendor, mode, choices) and are not failures."
    set "LTI=Tip: if a line shows FAIL, re-run the main script then fully reboot."
)

set /a OKC=0
set /a TOT=0

cls
echo.
echo   !CC!============================================================!C0!
echo   !CC!   !LTT!!C0!
echo   !CC!============================================================!C0!
echo.

rem ===== etat stocke =====
set "MODE="
set "NOVBS="
set "ISX3D="
set "ISLAP="
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\LowLatOptimizer" /v Mode 2^>nul ^| findstr /i /c:"REG_"') do set "MODE=%%a"
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\LowLatOptimizer" /v IsX3D 2^>nul ^| findstr /i /c:"REG_"') do set "ISX3D=%%a"
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\LowLatOptimizer" /v IsLaptop 2^>nul ^| findstr /i /c:"REG_"') do set "ISLAP=%%a"
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\LowLatOptimizer" /v NoVBS 2^>nul ^| findstr /i /c:"REG_"') do set "NOVBS=%%a"

if "!ISX3D!"=="0x1" set "ISX3D=1"
if "!ISX3D!"=="0x0" set "ISX3D=0"

if not defined MODE (
    echo   !CY! !LN1!!C0!
    echo   !CK! !LN2!!C0!
    echo   !CK! !LN3!!C0!
    echo.
    set "MODE=?"
)
if not defined ISX3D set "ISX3D=?"
if not defined ISLAP set "ISLAP=?"
if not defined NOVBS set "NOVBS=0"
set "X3DMULTI="
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\LowLatOptimizer" /v X3DMulti 2^>nul ^| findstr /i /c:"REG_"') do set "X3DMULTI=%%a"
if "!X3DMULTI!"=="0x1" set "X3DMULTI=1"
if "!X3DMULTI!"=="0x0" set "X3DMULTI=0"
if not defined X3DMULTI set "X3DMULTI=?"
set "SVCKB="
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\LowLatOptimizer" /v SvcKB 2^>nul ^| findstr /i /c:"REG_"') do set "SVCKB=%%a"
if defined SVCKB set /a SVCKB=SVCKB 2>nul
set "QCAM="
set "QWIFI="
set "QBT="
set "QPRINT="
set "QXBOX="
set "GPUV="
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\LowLatOptimizer" /v QCam 2^>nul ^| findstr /i /c:"REG_"') do set "QCAM=%%a"
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\LowLatOptimizer" /v QWifi 2^>nul ^| findstr /i /c:"REG_"') do set "QWIFI=%%a"
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\LowLatOptimizer" /v QBt 2^>nul ^| findstr /i /c:"REG_"') do set "QBT=%%a"
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\LowLatOptimizer" /v QPrint 2^>nul ^| findstr /i /c:"REG_"') do set "QPRINT=%%a"
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\LowLatOptimizer" /v QXbox 2^>nul ^| findstr /i /c:"REG_"') do set "QXBOX=%%a"
for /f "tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\LowLatOptimizer" /v GpuVendor 2^>nul ^| findstr /i /c:"REG_SZ"') do set "GPUV=%%b"
set "LIGHTFX="
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\LowLatOptimizer" /v LightFX 2^>nul ^| findstr /i /c:"REG_"') do set /a LIGHTFX=%%a 2>nul
if not defined LIGHTFX set "LIGHTFX=0"
if not defined QCAM set "QCAM=?"
if not defined QWIFI set "QWIFI=?"
if not defined QBT set "QBT=?"
if not defined QPRINT set "QPRINT=?"
if not defined QXBOX set "QXBOX=?"
if not defined GPUV set "GPUV=?"

echo   !CW! Mode!CK! ....... !C0!!CW!!MODE!!C0!     !CW!X3D!CK! ... !C0!!CW!!ISX3D!!C0!     !CW!!LLAP!!CK! ... !C0!!CW!!ISLAP!!C0!
echo.
echo   !CK! ------------------------------------------------------------!C0!
echo   !CO! !H1!!C0!

rem -- useplatformclock : doit etre ABSENT --
set "found="
for /f "delims=" %%a in ('bcdedit /enum {current} 2^>nul ^| findstr /i /c:"useplatformclock"') do set "found=1"
set /a TOT+=1
if defined found (
    echo   !CR! [!LF!]!C0! useplatformclock ........ !CR!!LPR!!C0!  ^(!LEX!: !LDE!^)
) else (
    echo   !CG! [ OK ]!C0! useplatformclock ........ !CG!absent!C0!  ^(!LDE!^)
    set /a OKC+=1
)

rem -- disabledynamictick : Yes si lowest+desktop, sinon No --
set "EXPDDT=No"
if "!MODE!"=="lowest" if not "!ISLAP!"=="1" set "EXPDDT=Yes"
set "ddt=ABSENT"
for /f "tokens=2" %%a in ('bcdedit /enum {current} 2^>nul ^| findstr /i /c:"disabledynamictick"') do set "ddt=%%a"
if /i "!ddt!"=="Oui" set "ddt=Yes"
if /i "!ddt!"=="Non" set "ddt=No"
set /a TOT+=1
if "!MODE!"=="?" (
    echo   !CC! [info]!C0! disabledynamictick ...... !CW!!ddt!!C0!
    set /a OKC+=1
) else if /i "!ddt!"=="!EXPDDT!" (
    echo   !CG! [ OK ]!C0! disabledynamictick ...... !CW!!ddt!!C0!  ^(!LEX!: !EXPDDT!^)
    set /a OKC+=1
) else (
    echo   !CR! [!LF!]!C0! disabledynamictick ...... !CW!!ddt!!C0!  ^(!LEX!: !EXPDDT!^)
)

call :ckdw "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" GlobalTimerResolutionRequests 1 "GlobalTimerResolutionReq ."

rem -- tache timer 0.5ms --
set /a TOT+=1
schtasks /query /tn "TimerRes 0.5ms" >nul 2>&1
if errorlevel 1 (
    echo   !CR! [!LF!]!C0! !LTK! "TimerRes 0.5ms" .... !CR!!LTA!!C0!
) else (
    echo   !CG! [ OK ]!C0! !LTK! "TimerRes 0.5ms" .... !CG!!LTP!!C0!
    set /a OKC+=1
)
rem -- La tache peut exister ET etre morte : on MESURE la resolution reelle
rem    au lieu de croire le planificateur. C est la seule preuve qui compte. --
set /a TOT+=1
set "TMRMS=?"
powershell -NoProfile -Command "$q=[char]34; $s='[DllImport('+$q+'ntdll.dll'+$q+')] public static extern int NtQueryTimerResolution(out uint a, out uint b, out uint c);'; $t=@(Add-Type -Name Tq -Namespace Vq -MemberDefinition $s -PassThru) | Where-Object { $_.Name -eq 'Tq' } | Select-Object -First 1; [uint32]$a=0;[uint32]$b=0;[uint32]$c=0; [void]$t::NtQueryTimerResolution([ref]$a,[ref]$b,[ref]$c); ($c/10000.0).ToString([Globalization.CultureInfo]::InvariantCulture) | Set-Content -Path ($env:TEMP+'\llmtr.txt') -Encoding ASCII" >nul 2>&1
for /f "usebackq delims=" %%r in ("%TEMP%\llmtr.txt") do set "TMRMS=%%r"
del /f /q "%TEMP%\llmtr.txt" >nul 2>&1
echo !TMRMS! | findstr /r "^0[.,]5" >nul 2>&1
if errorlevel 1 (
    echo   !CR! [!LF!]!C0! !TMRL! !CR!!TMRMS! ms!C0!
) else (
    echo   !CG! [ OK ]!C0! !TMRL! !CG!!TMRMS! ms!C0!
    set /a OKC+=1
)

echo.
echo   !CO! !H2!!C0!

rem SystemResponsiveness : lowest=0, soft=10
set "EXPSR=10"
if "!MODE!"=="lowest" set "EXPSR=0"
if "!MODE!"=="?" set "EXPSR=show"
call :ckdw "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" SystemResponsiveness !EXPSR! "SystemResponsiveness ..."

rem Win32PrioritySeparation : lowest=42, soft=38
set "EXPPS=38"
if "!MODE!"=="lowest" set "EXPPS=42"
if "!MODE!"=="?" set "EXPPS=show"
call :ckdw "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" Win32PrioritySeparation !EXPPS! "Win32PrioritySeparation ."
set "EXPTDR=absent"
if "!MODE!"=="lowest" set "EXPTDR=8"
if "!MODE!"=="?" set "EXPTDR=show"
call :ckdw "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" TdrDelay !EXPTDR! "TdrDelay (lowest=8) ....."
if /i "!GPUV!"=="NVIDIA" call :ckdw "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" EnableGR535 0 "NV GR535 FTS ..........."
if /i "!GPUV!"=="NVIDIA" call :ckdw "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters\FTS" EnableGR535 0 "NV GR535 Param ........."
if /i not "!GPUV!"=="NVIDIA" echo   !CC! [info]!C0! NV GR535 .............. !CK!GPU non-NVIDIA!C0!

rem NetworkThrottlingIndex : 10 (= aussi la valeur par defaut)
call :ckdw "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" NetworkThrottlingIndex 10 "NetworkThrottlingIndex .."

rem GameDVR_Enabled : 0
call :ckdw "HKCU\System\GameConfigStore" GameDVR_Enabled 0 "GameDVR_Enabled ........."

echo.
echo   !CO! !H3!!C0!

rem Nagle : TcpAckFrequency / TCPNoDelay doivent etre ABSENTS sur les interfaces
set /a TOT+=1
reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /s 2>nul | findstr /i /c:"TcpAckFrequency" >nul 2>&1
if errorlevel 1 (
    echo   !CG! [ OK ]!C0! Nagle ^(TcpAckFrequency^) .... !CG!absent!C0!  ^(!LDE!^)
    set /a OKC+=1
) else (
    echo   !CR! [!LF!]!C0! Nagle ^(TcpAckFrequency^) .... !CR!!LNI!!C0!
)

echo.
echo   !CO! !H4!!C0!

rem Plan actif (info)
set "PLAN=?"
for /f "tokens=2 delims=()" %%a in ('powercfg /getactivescheme 2^>nul') do set "PLAN=%%a"
echo   !CC! [info]!C0! !LPA! ........ !CW!!PLAN!!C0!
if "!MODE!"=="lowest" if not "!ISLAP!"=="1" echo   !CK!         !LEX!: Ultimate Performance!C0!
if "!MODE!"=="soft" echo   !CK!         !LEX!: High performance!C0!
if "!ISLAP!"=="1" echo   !CK!         !LEX! !LLAP!: High performance!C0!

rem -- GUID du plan actif (pour lire dans le registre, insensible a la langue) --
set "SCHEME="
for /f "tokens=2 delims=:" %%a in ('powercfg /getactivescheme 2^>nul') do for /f "tokens=1" %%b in ("%%a") do set "SCHEME=%%b"

rem Core parking CPMINCORES : X3D+desktop=0, sinon 100
set "EXPPARK=100"
if "!ISX3D!"=="1" if not "!ISLAP!"=="1" set "EXPPARK=0"
set "park=?"
if defined SCHEME for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes\!SCHEME!\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v ACSettingIndex 2^>nul ^| findstr /i /c:"REG_"') do set "park=%%a"
set /a TOT+=1
if "!park!"=="?" (
    echo   !CR! [!LF!]!C0! Core parking ^(min cores^) .. !CR!!LIL!!C0!
) else (
    set /a parkd=park 2>nul
    if "!MODE!"=="?" (
        echo   !CC! [info]!C0! Core parking ^(min cores^) .. !CW!!parkd!%%!C0!
        set /a OKC+=1
    ) else if !parkd! EQU !EXPPARK! (
        echo   !CG! [ OK ]!C0! Core parking ^(min cores^) .. !CW!!parkd!%%!C0!  ^(!LEX!: !EXPPARK!%%^)
        set /a OKC+=1
    ) else (
        echo   !CR! [!LF!]!C0! Core parking ^(min cores^) .. !CW!!parkd!%%!C0!  ^(!LEX!: !EXPPARK!%%^)
    )
)

rem Idle disable (C-states) : notX3D+notlaptop=1, sinon 0
set "EXPIDLE=1"
if "!ISX3D!"=="1" set "EXPIDLE=0"
if "!ISLAP!"=="1" set "EXPIDLE=0"
set "idle=?"
if defined SCHEME for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes\!SCHEME!\54533251-82be-4824-96c1-47b60b740d00\5d76a2ca-e8c0-402f-a133-2158492d58ad" /v ACSettingIndex 2^>nul ^| findstr /i /c:"REG_"') do set "idle=%%a"
set /a TOT+=1
if "!idle!"=="?" (
    echo   !CR! [!LF!]!C0! Idle disable ^(C-states^) ... !CR!!LIL!!C0!
) else (
    set /a idled=idle 2>nul
    if "!MODE!"=="?" (
        echo   !CC! [info]!C0! Idle disable ^(C-states^) ... !CW!!idled!!C0!
        set /a OKC+=1
    ) else if !idled! EQU !EXPIDLE! (
        echo   !CG! [ OK ]!C0! Idle disable ^(C-states^) ... !CW!!idled!!C0!  ^(!LEX!: !EXPIDLE!^)
        set /a OKC+=1
    ) else (
        echo   !CR! [!LF!]!C0! Idle disable ^(C-states^) ... !CW!!idled!!C0!  ^(!LEX!: !EXPIDLE!^)
    )
)

echo.
echo   !CO! GPU!C0!

rem HwSchMode (HAGS) : 2 si la cle existe (sinon HAGS indisponible = normal)
set "hags="
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode 2^>nul ^| findstr /i /c:"REG_"') do set "hags=%%a"
if not defined hags (
    echo   !CC! [info]!C0! HwSchMode ^(HAGS^) ......... !CK!!LHN!!C0!
) else (
    set /a hagsd=hags
    set /a TOT+=1
    if !hagsd! EQU 2 (
        echo   !CG! [ OK ]!C0! HwSchMode ^(HAGS^) ......... !CW!2!C0!
        set /a OKC+=1
    ) else (
        echo   !CY! [info]!C0! HwSchMode ^(HAGS^) ......... !CW!!hagsd!!C0!  ^(!LHA!^)
    )
)

rem TdrDelay : lowest=8, soft=absent
set "tdr="
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v TdrDelay 2^>nul ^| findstr /i /c:"REG_"') do set "tdr=%%a"
set /a TOT+=1
if "!MODE!"=="lowest" (
    if defined tdr ( set /a tdrd=tdr & echo   !CG! [ OK ]!C0! TdrDelay ................ !CW!!tdr!!C0! & set /a OKC+=1 ) else ( echo   !CR! [!LF!]!C0! TdrDelay ................ !CR!absent!C0!  ^(!LEX!: 8^) )
) else if "!MODE!"=="soft" (
    if defined tdr ( echo   !CR! [!LF!]!C0! TdrDelay ................ !CW!!tdr!!C0!  ^(!LEX!: absent^) ) else ( echo   !CG! [ OK ]!C0! TdrDelay ................ !CG!absent!C0! & set /a OKC+=1 )
) else (
    if defined tdr ( echo   !CC! [info]!C0! TdrDelay ................ !CW!!tdr!!C0! ) else ( echo   !CC! [info]!C0! TdrDelay ................ !CK!absent!C0! )
    set /a OKC+=1
)

rem EnableGR535 (NVIDIA only) : info
set "gr="
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v EnableGR535 2^>nul ^| findstr /i /c:"REG_"') do set "gr=%%a"
if not defined gr (
    echo   !CC! [info]!C0! EnableGR535 ^(NVIDIA^) ..... !CK!!LGN!!C0!
) else (
    echo   !CC! [info]!C0! EnableGR535 ^(NVIDIA^) ..... !CW!!gr!!C0!  ^(0 !LEX!^)
)

rem AMD DenyDeviceIDs (verrou driver 25.9.1) : info
set "deny="
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Restrictions" /v DenyDeviceIDs 2^>nul ^| findstr /i /c:"REG_"') do set "deny=%%a"
if not defined deny (
    echo   !CC! [info]!C0! Verrou driver AMD ........ !CK!!LAN!!C0!
) else (
    set /a denyd=deny
    if !denyd! EQU 1 ( echo   !CC! [info]!C0! Verrou driver AMD ........ !CG!!LAA!!C0! ) else ( echo   !CC! [info]!C0! Verrou driver AMD ........ !CK!!LAO!!C0! )
)

echo.
echo   !CO! !H5!!C0!
call :ckdw "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" PowerThrottlingOff 1 "PowerThrottlingOff ......"
call :ckdw "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" EnablePrefetcher 3 "EnablePrefetcher ........"
call :ckdw "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" EnableSuperfetch show "EnableSuperfetch ........"
set "EXPSVC=show"
if not "!SVCKB!"=="" if not "!SVCKB!"=="?" set "EXPSVC=!SVCKB!"
call :ckdw "HKLM\SYSTEM\CurrentControlSet\Control" SvcHostSplitThresholdInKB !EXPSVC! "SvcHostSplitThreshold ..."

echo.
echo   !CO! !H6!!C0!
call :ckdw "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" Priority 6 "MMCSS Games priority ...."
set "EXPIFE=absent"
if "!MODE!"=="lowest" set "EXPIFE=3"
if "!MODE!"=="?" set "EXPIFE=show"
call :ckdw "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\cs2.exe\PerfOptions" CpuPriorityClass !EXPIFE! "IFEO cs2 CPU prio ......."
call :ckdw "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\cs2.exe\PerfOptions" IoPriority !EXPIFE! "IFEO cs2 IO prio ........"

echo.
echo   !CO! !H7!!C0!
call :cksz "HKCU\Control Panel\Mouse" MouseSpeed "0" "Mouse accel (speed) ....."
call :cksz "HKCU\Control Panel\Mouse" MouseThreshold1 "0" "Mouse threshold 1 ......."
call :cksz "HKCU\Control Panel\Mouse" MouseThreshold2 "0" "Mouse threshold 2 ......."
call :cksz "HKCU\Control Panel\Mouse" MouseSensitivity "10" "Mouse sensitivity ......."
call :ckdw "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" MouseDataQueueSize 128 "Mouse queue size ........"
call :ckdw "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" KeyboardDataQueueSize 128 "Keyboard queue size ....."
call :cksz "HKCU\Control Panel\Keyboard" KeyboardDelay "0" "Keyboard delay .........."
call :cksz "HKCU\Control Panel\Keyboard" KeyboardSpeed "31" "Keyboard speed .........."

echo.
echo   !CO! !H8!!C0!
call :ckpwr 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 "USB selective suspend ..."
call :ckpwr 501a4d13-42af-4429-9fd1-a8218c268e20 ee12f906-d277-404b-b6da-e5fa1a576df5 0 "PCIe ASPM ..............."
set "EXPTSC=absent"
if "!X3DMULTI!"=="1" set "EXPTSC=enhanced"
set "tsc=absent"
for /f "tokens=2" %%a in ('bcdedit /enum {current} 2^>nul ^| findstr /i /c:"tscsyncpolicy"') do set "tsc=%%a"
set /a TOT+=1
if "!X3DMULTI!"=="?" (
    echo   !CC! [info]!C0! tscsyncpolicy ........... !CW!!tsc!!C0!
) else if /i "!tsc!"=="!EXPTSC!" (
    echo   !CG! [ OK ]!C0! tscsyncpolicy ........... !CW!!tsc!!C0!
    set /a OKC+=1
) else (
    echo   !CR! [!LF!]!C0! tscsyncpolicy ........... !CW!!tsc!!C0!  ^(!LEX!: !EXPTSC!^)
)

echo.
echo   !CO! !H9!!C0!
set "VBSEXP=1"
set "VBSLBL=VBS enabled ............."
set "HVCLBL=HVCI memory integrity ..."
if "!NOVBS!"=="1" set "VBSEXP=0"
if "!NOVBS!"=="1" set "VBSLBL=VBS off (max perf) ..........."
if "!NOVBS!"=="1" set "HVCLBL=HVCI off (max perf) ............"
call :ckdw "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" EnableVirtualizationBasedSecurity !VBSEXP! "!VBSLBL!"
call :ckdw "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" Enabled !VBSEXP! "!HVCLBL!"
call :ckdw "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" ConsentPromptBehaviorAdmin 0 "UAC admin prompt (0) ...."
call :ckdw "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" PromptOnSecureDesktop 0 "UAC secure desktop(0) ..."
call :ckdw "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" fDenyTSConnections 1 "RDP disabled ..........."

echo.
echo   !CO! !H10!!C0!
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" AllowTelemetry 0 "Telemetry (policy) ......"
call :ckdw "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" AllowTelemetry 0 "Telemetry (cv) .........."
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" DODownloadMode 0 "Delivery Optimization ..."
if "!NOVBS!"=="1" ( call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" DisableAIDataAnalysis 1 "Recall off .............." ) else ( call :cksvci "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" "Recall kept (VM/AI) ....." )
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" DisableWindowsConsumerFeatures 1 "Consumer features off ..."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" BingSearchEnabled 0 "Bing search off ........."
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" AllowGameDVR 0 "GameDVR policy off ......"
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" AppCaptureEnabled 0 "App capture off ........."
call :ckdw "HKCU\SOFTWARE\Microsoft\GameBar" AutoGameModeEnabled 1 "Game Mode on ............"
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Edge" StartupBoostEnabled 0 "Edge startup boost off .."
if "!NOVBS!"=="1" ( call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" TurnOffWindowsCopilot 1 "Copilot off ............." ) else ( call :cksvci "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" "Copilot kept (VM/AI) ...." )

echo.
echo   !CO! !H11!!C0!
set "FSOEXP=absent"
set "FSOLBL=CPU mitigations kept ON ...."
if /i "!MODE!"=="lowest" set "FSOEXP=3"
if /i "!MODE!"=="lowest" set "FSOLBL=CPU mitigations OFF (lowest) ."
call :ckdw "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" FeatureSettingsOverride !FSOEXP! "!FSOLBL!"
call :ckdw "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" FeatureSettingsOverrideMask !FSOEXP! "Mitigations mask ........"
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" ExcludeWUDriversInQualityUpdate absent "WU drivers excluded ...."
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Windows\StorageSense" AllowStorageSenseGlobal absent "StorageSense global ....."

echo.
echo   !CO! !H12!!C0!
call :cksvc DiagTrack 4 "DiagTrack (telemetry) ..."
call :cksvc dmwappushservice 4 "dmwappushservice ......."
call :CKS BTAGService !QBT! 2 0x4 3 0x3 "BTAGService ............."
call :CKS bthserv !QBT! 2 0x4 3 0x3 "bthserv (Bluetooth) ....."
call :CKS GamingServices !QXBOX! 2 0x4 3 0x3 "GamingServices .........."
call :CKS XblAuthManager !QXBOX! 2 0x4 3 0x3 "XblAuthManager .........."
call :CKS XblGameSave !QXBOX! 2 0x4 3 0x3 "XblGameSave ............."
call :CKS XboxGipSvc !QXBOX! 2 0x4 3 0x3 "XboxGipSvc .............."
call :CKS XboxNetApiSvc !QXBOX! 2 0x4 3 0x3 "XboxNetApiSvc ..........."
call :CKS PrintNotify !QPRINT! 2 0x4 3 0x3 "PrintNotify ............."
call :CKS Spooler !QPRINT! 2 0x4 3 0x2 "Spooler (printing) ......"
call :CKS WlanSvc !QWIFI! 2 0x4 4 0x2 "WlanSvc (Wi-Fi) ........."
call :CKS FrameServer !QCAM! 2 0x4 3 0x3 "FrameServer (camera) ......"
call :cksvc SysMain 2 "SysMain (auto, kept) ..."
echo.
echo   !CO! !H13!!C0!
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" Enabled 0 "Enabled ................."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" SystemPaneSuggestionsEnabled 0 "SystemPaneSuggestionsEnabled .."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" SubscribedContent-338388Enabled 0 "SubscribedContent-338388Enabled .."
if "!NOVBS!"=="1" ( call :ckdw "HKCU\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" TurnOffWindowsCopilot 1 "TurnOffWindowsCopilot ..." ) else ( call :cksvci "HKCU\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" "Copilot HKCU kept (VM/AI)." )
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Dsh" AllowNewsAndInterests 0 "AllowNewsAndInterests ..."
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" EnableFeeds 0 "EnableFeeds ............."
call :ckdw "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" Disabled 1 "Disabled ................"
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" LetAppsRunInBackground 2 "LetAppsRunInBackground .."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" GlobalUserDisabled 1 "GlobalUserDisabled ......"
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" EnableActivityFeed 0 "EnableActivityFeed ......"
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" PublishUserActivities 0 "PublishUserActivities ..."
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" UploadUserActivities 0 "UploadUserActivities ...."
call :ckdw "HKCU\SOFTWARE\Microsoft\Input\TIPC" Enabled 0 "Enabled TIPC ............"
call :ckdw "HKCU\SOFTWARE\Microsoft\InputPersonalization" RestrictImplicitInkCollection 1 "RestrictImplicitInkCollection .."
call :ckdw "HKCU\SOFTWARE\Microsoft\InputPersonalization" RestrictImplicitTextCollection 1 "RestrictImplicitTextCollection .."
call :ckdw "HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" HarvestContacts 0 "HarvestContacts ........."
call :ckdw "HKCU\SOFTWARE\Microsoft\Personalization\Settings" AcceptedPrivacyPolicy 0 "AcceptedPrivacyPolicy ..."
call :ckdw "HKCU\SOFTWARE\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" HasAccepted 0 "HasAccepted ............."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" SilentInstalledAppsEnabled 0 "SilentInstalledAppsEnabled .."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" PreInstalledAppsEnabled 0 "PreInstalledAppsEnabled .."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" OemPreInstalledAppsEnabled 0 "OemPreInstalledAppsEnabled .."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" SoftLandingEnabled 0 "SoftLandingEnabled ......"
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" RotatingLockScreenEnabled 0 "RotatingLockScreenEnabled .."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" RotatingLockScreenOverlayEnabled 0 "RotatingLockScreenOverlayEnabled .."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" SubscribedContent-338389Enabled 0 "SubscribedContent-338389Enabled .."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" SubscribedContent-338393Enabled 0 "SubscribedContent-338393Enabled .."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" SubscribedContent-353694Enabled 0 "SubscribedContent-353694Enabled .."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" SubscribedContent-353696Enabled 0 "SubscribedContent-353696Enabled .."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" SubscribedContent-310093Enabled 0 "SubscribedContent-310093Enabled .."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" SubscribedContent-88000326Enabled 0 "SubscribedContent-88000326Enabled .."
call :ckdw "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" DisableSearchBoxSuggestions 1 "DisableSearchBoxSuggestions .."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SmartActionPlatform\SmartClipboard" Disabled 1 "Disabled SmartClipboard .."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" ShowSyncProviderNotifications 0 "ShowSyncProviderNotifications .."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" Start_AccountNotifications 0 "Start_AccountNotifications .."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" TailoredExperiencesWithDiagnosticDataEnabled 0 "TailoredExperiencesWithDiagnosticDataEna .."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" IsDynamicSearchBoxEnabled 0 "IsDynamicSearchBoxEnabled .."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds\DSB" ShowDynamicContent 0 "ShowDynamicContent ......"
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" ToastEnabled 0 "ToastEnabled ............"
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" AllowClipboardHistory 0 "AllowClipboardHistory ..."
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" AllowCrossDeviceClipboard 0 "AllowCrossDeviceClipboard .."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" TaskbarMn 0 "TaskbarMn ..............."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" ShowRecent 0 "ShowRecent .............."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" ShowFrequent 0 "ShowFrequent ............"
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" AllowCortana 0 "AllowCortana ............"
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" NoLockScreen 1 "NoLockScreen ............"
call :cksz "HKCU\Control Panel\Desktop" ScreenSaveActive "0" "ScreenSaveActive ........"
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement" ScoobeSystemSettingEnabled 0 "ScoobeSystemSettingEnabled .."
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" NoAutoRebootWithLoggedOnUsers 1 "NoAutoRebootWithLoggedOnUsers .."
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" DoNotShowFeedbackNotifications 1 "DoNotShowFeedbackNotifications .."
call :ckdw "HKCU\SOFTWARE\Microsoft\Siuf\Rules" NumberOfSIUFInPeriod 0 "NumberOfSIUFInPeriod ...."
call :ckdw "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" WakeUp 0 "WakeUp .................."
call :ckdw "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" EnableFirstLogonAnimation 0 "EnableFirstLogonAnimation .."
echo.
echo   !CO! !H14!!C0!
set "EFX=1"
set "ETR=1"
if "!LIGHTFX!"=="1" set "EFX=3"
if "!LIGHTFX!"=="1" set "ETR=0"
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" VisualFXSetting !EFX! "VisualFXSetting ........."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" EnableTransparency !ETR! "EnableTransparency ......"
if "!LIGHTFX!"=="1" call :cksz "HKCU\Control Panel\Desktop" FontSmoothing "2" "FontSmoothing (kept) ...."
if "!LIGHTFX!"=="1" call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" ListviewAlphaSelect 1 "ListviewAlphaSelect (kept) .."
if "!LIGHTFX!"=="1" call :cksz "HKCU\Control Panel\Desktop\WindowMetrics" MinAnimate "1" "MinAnimate (kept) ......."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent" AccentColorMenu 0xff484848 "AccentColorMenu ........."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent" StartColorMenu 0xff484848 "StartColorMenu .........."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\DWM" AccentColor 0xff484848 "AccentColor ............."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\DWM" ColorizationColor 0xc4484848 "ColorizationColor ......."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" ColorPrevalence 0 "ColorPrevalence ........."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\DWM" ColorPrevalence 0 "ColorPrevalence DWM ....."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" ShowSecondsInSystemClock 1 "ShowSecondsInSystemClock .."
call :cksz "HKCU\Control Panel\Desktop" WallpaperStyle "0" "WallpaperStyle .........."
call :ckdw "HKCU\Control Panel\Desktop" JPEGImportQuality 100 "JPEGImportQuality ......."
call :cksz "HKCU\Control Panel\Colors" Background "0 0 0" "Background .............."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" AppsUseLightTheme 0 "AppsUseLightTheme ......."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" SystemUsesLightTheme 0 "SystemUsesLightTheme ...."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" TaskbarAl 1 "TaskbarAl ..............."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" SearchboxTaskbarMode 0 "SearchboxTaskbarMode ...."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" TaskbarGlomLevel 0 "TaskbarGlomLevel ........"
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" MMTaskbarGlomLevel 0 "MMTaskbarGlomLevel ......"
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" TaskbarSd 1 "TaskbarSd ..............."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" TaskbarBadges 1 "TaskbarBadges ..........."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" PenWorkspaceButtonDesiredVisibility 0 "PenWorkspaceButtonDesiredVisibility .."
call :ckdw "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" TipbandDesiredVisibility 0 "TipbandDesiredVisibility .."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings" TaskbarEndTask 1 "TaskbarEndTask .........."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" TaskbarDa 0 "TaskbarDa ..............."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" ShowTaskViewButton 0 "ShowTaskViewButton ......"
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" Start_TrackProgs 0 "Start_TrackProgs ........"
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" Start_TrackDocs 0 "Start_TrackDocs ........."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" Start_IrisRecommendations 0 "Start_IrisRecommendations .."
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" HideRecommendedSection 1 "HideRecommendedSection .."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" NOC_GLOBAL_SETTING_TOASTS_ENABLED 0 "NOC_GLOBAL_SETTING_TOASTS_ENABLED .."
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" HideCategoryView 1 "HideCategoryView ........"
call :ckdw "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" HideRecommendedSection 1 "HideRecommendedSection Start .."
call :ckdw "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" HideRecommendedPersonalizedSites 1 "HideRecommendedPersonalizedSites .."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" Hidden 1 "Hidden .................."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" HideFileExt 0 "HideFileExt ............."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" LaunchTo 1 "LaunchTo ................"
call :cksz "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" SmartScreenEnabled "Off" "SmartScreenEnabled ......"
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" EnableSmartScreen 0 "EnableSmartScreen ......."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" EnableWebContentEvaluation 0 "EnableWebContentEval ...."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments" SaveZoneInformation 1 "SaveZoneInformation ....."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments" ScanWithAntiVirus 1 "ScanWithAntiVirus ......."
call :ckdw "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" {2cc5ca98-6485-489a-920e-b3e88a6ccce3} 1 "{2cc5ca98-6485-489a-920e-b3e88a6ccce3} .."
echo.
echo   !CO! !H15!!C0!
call :ckdw "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" "GPU Priority" 8 "GPU Priority ............"
call :cksz "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" "Scheduling Category" "High" "Scheduling Category ....."
call :cksz "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" "SFIO Priority" "High" "SFIO Priority ..........."
call :cksz "HKU\.DEFAULT\Control Panel\Mouse" MouseSpeed "0" "MouseSpeed .............."
call :cksz "HKU\.DEFAULT\Control Panel\Mouse" MouseThreshold1 "0" "MouseThreshold1 ........."
call :cksz "HKU\.DEFAULT\Control Panel\Mouse" MouseThreshold2 "0" "MouseThreshold2 ........."
call :cksz "HKU\.DEFAULT\Control Panel\Keyboard" InitialKeyboardIndicators "2147483650" "InitialKeyboardIndicators .."
call :cksz "HKCU\Control Panel\Accessibility\StickyKeys" Flags "506" "Flags ..................."
call :cksz "HKCU\Control Panel\Accessibility\Keyboard Response" Flags "122" "Flags Keyboard Response .."
call :cksz "HKCU\Control Panel\Accessibility\ToggleKeys" Flags "58" "Flags ToggleKeys ........"
call :ckdw "HKCU\Control Panel\Keyboard" PrintScreenKeyForSnippingEnabled 1 "PrintScreenKeyForSnippingEnabled .."
call :cksz "HKCU\Control Panel\Desktop" MenuShowDelay "0" "MenuShowDelay ..........."
call :cksz "HKCU\Control Panel\Desktop" AutoEndTasks "1" "AutoEndTasks ............"
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" NoUseStoreOpenWith 1 "NoUseStoreOpenWith ......"
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" NonBestEffortLimit 0 "NonBestEffortLimit ......"
call :ckdw "HKCU\SOFTWARE\Microsoft\GameBar" AllowAutoGameMode 1 "AllowAutoGameMode ......."
call :cksz "HKCU\SOFTWARE\Microsoft\DirectX\UserGpuPreferences" DirectXUserGlobalSettings "SwapEffectUpgradeEnable=1;" "DirectXUserGlobalSettings .."
if "!NOVBS!"=="1" ( call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" ShowCopilotButton 0 "ShowCopilotButton ......." ) else ( call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" ShowCopilotButton 1 "Copilot btn kept (VM/AI)." )
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" DisableFileSyncNGSC 1 "DisableFileSyncNGSC ....."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" DisallowShaking 1 "DisallowShaking ........."
call :cksz "HKCU\Control Panel\Desktop" WindowArrangementActive "1" "WindowArrangementActive .."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" SnapAssist 1 "SnapAssist .............."
call :ckdw "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" fAllowToGetHelp 0 "fAllowToGetHelp ........."
call :ckdw "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" VerboseStatus 1 "VerboseStatus ..........."
call :ckdw "HKLM\SOFTWARE\Microsoft\FTH" Enabled 0 "Enabled ................."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Serialize" StartupDelayInMSec 0 "StartupDelayInMSec ......"
call :cksz "HKCU\Control Panel\Desktop" HungAppTimeout "4000" "HungAppTimeout .........."
call :cksz "HKLM\SYSTEM\CurrentControlSet\Control" WaitToKillServiceTimeout "2000" "WaitToKillServiceTimeout .."
call :ckdw "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" HwSchMode 2 "HwSchMode ..............."
call :ckdw "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" HiberbootEnabled 1 "HiberbootEnabled ........"
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" HideSystray 1 "HideSystray ............."
call :ckdw "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" SearchOrderConfig 1 "SearchOrderConfig ......."
set "SS=HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy"
call :ckdw "!SS!" 01 1 "01 ......................"
call :ckdw "!SS!" 04 1 "04 ......................"
call :ckdw "!SS!" 08 1 "08 ......................"
call :ckdw "!SS!" 256 1 "256 ....................."
call :ckdw "!SS!" 2048 1 "2048 ...................."
call :ckdw "!SS!" 32 absent "32 Downloads (v3.7 leftover) .."
call :ckdw "!SS!" 512 absent "512 retention (v3.7 leftover) .."
echo.
echo   !CK! ------------------------------------------------------------!C0!
echo   !CW! !LRS! : !CG!!OKC!!CW! / !TOT! !LGR!!C0!
echo   !CK! !LNO!!C0!
echo.
echo   !CK! !LTI!!C0!
echo.
pause
goto MENU

rem ============================================================
rem  Sous-routine : verifie un REG_DWORD
rem  %~1=cle  %~2=valeur  %~3=attendu(decimal) ou "show"  %~4=label
rem ============================================================
:ckdw
set "cur="
set "rl="
for /f "delims=" %%L in ('reg query "%~1" /v "%~2" 2^>nul ^| findstr /i /c:"REG_DWORD"') do set "rl=%%L"
if defined rl for /f "tokens=1" %%v in ("!rl:*REG_DWORD=!") do set "cur=%%v"
set /a TOT+=1
if /i "%~3"=="absent" goto ckdw_wantabs
if "%~3"=="show" goto ckdw_show
if not defined cur goto ckdw_absent
set "cue=%~3"
if /i "!cue:~0,2!"=="0x" goto ckdw_hex
set /a curd=cur 2>nul
if !curd! EQU %~3 goto ckdw_ok
echo   !CR! [!LF!]!C0! %~4 !CW!!curd!!C0!  ^(!LEX!: %~3^)
goto :eof
:ckdw_hex
if /i "!cur!"=="!cue!" goto ckdw_hxok
echo   !CR! [!LF!]!C0! %~4 !CW!!cur!!C0!  ^(!LEX!: %~3^)
goto :eof
:ckdw_hxok
echo   !CG! [ OK ]!C0! %~4 !CW!!cur!!C0!
set /a OKC+=1
goto :eof
:ckdw_wantabs
if not defined cur goto ckdw_okabs
echo   !CR! [!LF!]!C0! %~4 !CW!!cur!!C0!  ^(!LSA!^)
goto :eof
:ckdw_okabs
echo   !CG! [ OK ]!C0! %~4 !CG!absent (!LDE!)!C0!
set /a OKC+=1
goto :eof
:ckdw_ok
echo   !CG! [ OK ]!C0! %~4 !CW!!curd!!C0!
set /a OKC+=1
goto :eof
:ckdw_show
if defined cur echo   !CC! [info]!C0! %~4 !CW!!cur!!C0!
if not defined cur echo   !CC! [info]!C0! %~4 !CK!absent!C0!
set /a OKC+=1
goto :eof
:ckdw_absent
echo   !CR! [!LF!]!C0! %~4 !CR!absent!C0!  ^(!LEX!: %~3^)
goto :eof

:cksz
set "cur="
set "rl="
for /f "delims=" %%L in ('reg query "%~1" /v "%~2" 2^>nul ^| findstr /i /c:"REG_SZ"') do set "rl=%%L"
if defined rl set "cur=!rl:*REG_SZ=!"
if defined cur for /f "tokens=* delims= " %%v in ("!cur!") do set "cur=%%v"
set /a TOT+=1
if not defined cur goto cksz_na
if /i "!cur!"=="%~3" goto cksz_ok
echo   !CR! [!LF!]!C0! %~4 !CW!!cur!!C0!  ^(!LEX!: %~3^)
goto :eof
:cksz_ok
echo   !CG! [ OK ]!C0! %~4 !CW!!cur!!C0!
set /a OKC+=1
goto :eof
:cksz_na
echo   !CR! [!LF!]!C0! %~4 !CR!absent!C0!  ^(!LEX!: %~3^)
goto :eof

:cksvc
set "st="
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\%~1" /v Start 2^>nul ^| findstr /i /c:"REG_"') do set "st=%%a"
set /a TOT+=1
if not defined st goto cksvc_na
set /a std=st 2>nul
if !std! EQU %~2 goto cksvc_ok
echo   !CR! [!LF!]!C0! %~3 !CW!Start=!std!!C0!  ^(!LEX!: %~2^)
goto :eof
:cksvc_ok
echo   !CG! [ OK ]!C0! %~3 !CW!Start=!std!!C0!
set /a OKC+=1
goto :eof
:cksvc_na
echo   !CC! [info]!C0! %~3 !CK!!LSV!!C0!
goto :eof

:ckpwr
set "cur="
if defined SCHEME for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes\!SCHEME!\%~1\%~2" /v ACSettingIndex 2^>nul ^| findstr /i /c:"REG_"') do set "cur=%%a"
set /a TOT+=1
if not defined cur goto ckpwr_na
set /a curd=cur 2>nul
if !curd! EQU %~3 goto ckpwr_ok
echo   !CR! [!LF!]!C0! %~4 !CW!!curd!!C0!  ^(!LEX!: %~3^)
goto :eof
:ckpwr_ok
echo   !CG! [ OK ]!C0! %~4 !CW!!curd!!C0!
set /a OKC+=1
goto :eof
:ckpwr_na
echo   !CC! [info]!C0! %~4 !CK!!LNS!!C0!
goto :eof


:cksvci
set "st="
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\%~1" /v Start 2^>nul ^| findstr /i /c:"REG_"') do set "st=%%a"
if not defined st goto cksvci_na
set /a std=st 2>nul
echo   !CC! [info]!C0! %~2 !CW!Start=!std!!C0!  !CK!(!LCH!)!C0!
goto :eof
:cksvci_na
echo   !CC! [info]!C0! %~2 !CK!!LSV!!C0!
goto :eof

:CKS
set "E="
if "%~2"=="%~3" set "E=%~4"
if "%~2"=="%~5" set "E=%~6"
set "cur="
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\%~1" /v Start 2^>nul ^| findstr /i /c:"REG_"') do set "cur=%%a"
if not defined E goto CKS_i
set /a TOT+=1
if not defined cur goto CKS_m
if /i "!cur!"=="!E!" goto CKS_o
echo   !CR! [!LF!]!C0! %~7 !CW!!cur!!C0!  ^(!LEX!: !E!^)
goto :eof
:CKS_o
echo   !CG! [ OK ]!C0! %~7 !CW!!cur!!C0!
set /a OKC+=1
goto :eof
:CKS_m
echo   !CR! [!LF!]!C0! %~7 !CK!!LSV!!C0!  ^(!LEX!: !E!^)
goto :eof
:CKS_i
if not defined cur goto CKS_ina
echo   !CC! [info]!C0! %~7 !CW!!cur!!C0!  !CK!^(!LCH!^)!C0!
goto :eof
:CKS_ina
echo   !CC! [info]!C0! %~7 !CK!!LSV!!C0!
goto :eof


:pcam
if "!CAM!"=="1" echo   !OK! !CC![17]!C0! !M21!
if "!CAM!"=="2" (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='SilentlyContinue'; Get-PnpDevice -Class Camera,Image | Where-Object { $_.Status -eq 'OK' } | ForEach-Object { Disable-PnpDevice -InstanceId $_.InstanceId -Confirm:$false }" >nul 2>&1
    powershell -NoProfile -Command "Get-AppxPackage -AllUsers *Microsoft.WindowsCamera* | Remove-AppxPackage -AllUsers -EA SilentlyContinue" >nul 2>&1
    echo   !OK! !CC![17]!C0! !M22!
)
if "!CAM!"=="3" (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='SilentlyContinue'; Get-PnpDevice -Class Camera,Image | Where-Object { $_.Status -ne 'OK' } | ForEach-Object { Enable-PnpDevice -InstanceId $_.InstanceId -Confirm:$false }" >nul 2>&1
    echo   !OK! !CC![17]!C0! !M23!
)
goto :eof

:pnet
if "!WIFI!"=="1" echo   !OK! !CC![18]!C0! !M24!
if "!WIFI!"=="2" (
    sc stop WlanSvc >nul 2>&1
    sc config WlanSvc start= disabled >nul 2>&1
    powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; Get-NetAdapter -Physical | Where-Object { $_.PhysicalMediaType -eq 'Native 802.11' } | Disable-NetAdapter -Confirm:$false" >nul 2>&1
    echo   !OK! !CC![18]!C0! !M25!
)
if "!WIFI!"=="3" (
    powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; Get-NetAdapter -Physical | Where-Object { $_.PhysicalMediaType -eq '802.3' } | Disable-NetAdapter -Confirm:$false" >nul 2>&1
    echo   !OK! !CC![18]!C0! !M25E!
)
if "!WIFI!"=="4" (
    sc config WlanSvc start= auto >nul 2>&1
    sc start WlanSvc >nul 2>&1
    powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; Get-NetAdapter -Physical | Where-Object { $_.PhysicalMediaType -eq 'Native 802.11' -or $_.InterfaceDescription -match 'Wireless|Wi-?Fi|802\.11' } | Enable-NetAdapter -Confirm:$false" >nul 2>&1
    echo   !OK! !CC![18]!C0! !M26!
)
if "!WIFI!"=="5" (
    powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; Get-NetAdapter -Physical | Where-Object { $_.PhysicalMediaType -eq '802.3' } | Enable-NetAdapter -Confirm:$false" >nul 2>&1
    echo   !OK! !CC![18]!C0! !M26E!
)
goto :eof

:pbt
if "!BT!"=="1" echo   !OK! !CC![19]!C0! !M27!
if "!BT!"=="2" (
    sc stop bthserv >nul 2>&1
    sc config bthserv start= disabled >nul 2>&1
    sc stop BTAGService >nul 2>&1
    sc config BTAGService start= disabled >nul 2>&1
    powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; Get-PnpDevice -Class Bluetooth | Where-Object { $_.Status -eq 'OK' } | ForEach-Object { Disable-PnpDevice -InstanceId $_.InstanceId -Confirm:$false }" >nul 2>&1
    echo   !OK! !CC![19]!C0! !M28!
)
if "!BT!"=="3" (
    sc config bthserv start= demand >nul 2>&1
    sc config BTAGService start= demand >nul 2>&1
    powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; Get-PnpDevice -Class Bluetooth | Where-Object { $_.Status -ne 'OK' } | ForEach-Object { Enable-PnpDevice -InstanceId $_.InstanceId -Confirm:$false }" >nul 2>&1
    echo   !OK! !CC![19]!C0! !M29!
)
goto :eof

:pprn
if "!PRINT!"=="1" echo   !OK! !CC![20]!C0! !M30!
if "!PRINT!"=="2" (
    sc stop Spooler >nul 2>&1
    sc config Spooler start= disabled >nul 2>&1
    sc stop PrintNotify >nul 2>&1
    sc config PrintNotify start= disabled >nul 2>&1
    echo   !OK! !CC![20]!C0! !M31!
)
if "!PRINT!"=="3" (
    sc config Spooler start= auto >nul 2>&1
    sc start Spooler >nul 2>&1
    sc config PrintNotify start= demand >nul 2>&1
    echo   !OK! !CC![20]!C0! !M32!
)
goto :eof

:pxbx
if "!XBOX!"=="1" echo   !OK! !CC![21]!C0! !M33!
if "!XBOX!"=="2" (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "foreach($x in @('*Microsoft.GamingApp*','*Microsoft.XboxApp*','*Microsoft.Xbox.TCUI*','*Microsoft.XboxGameOverlay*','*Microsoft.XboxGamingOverlay*','*Microsoft.XboxIdentityProvider*','*Microsoft.XboxSpeechToTextOverlay*')){ Get-AppxPackage -AllUsers -Name $x -EA SilentlyContinue | Remove-AppxPackage -AllUsers -EA SilentlyContinue }" >nul 2>&1
    sc config XblAuthManager start= disabled >nul 2>&1
    sc config XblGameSave start= disabled >nul 2>&1
    sc config XboxNetApiSvc start= disabled >nul 2>&1
    sc config XboxGipSvc start= disabled >nul 2>&1
    sc config GamingServices start= disabled >nul 2>&1
    schtasks /Change /TN "\Microsoft\Windows\XblGameSave\XblGameSaveTask" /Disable >nul 2>&1
    echo   !OK! !CC![21]!C0! !M34!
)
if "!XBOX!"=="3" (
    sc config XblAuthManager start= demand >nul 2>&1
    sc config XblGameSave start= demand >nul 2>&1
    sc config XboxNetApiSvc start= demand >nul 2>&1
    sc config XboxGipSvc start= demand >nul 2>&1
    sc config GamingServices start= demand >nul 2>&1
    schtasks /Change /TN "\Microsoft\Windows\XblGameSave\XblGameSaveTask" /Enable >nul 2>&1
    echo   !OK! !CC![21]!C0! !M35!
)
goto :eof

:PERIPH
rem -- Sous-menu : rejoue une seule des questions [17]-[21] hors passage complet.
rem    Les actions reelles vivent dans les sous-routines :pcam/:pnet/:pbt/:pprn/:pxbx,
rem    appelees aussi par l apply pour eviter toute divergence de comportement. --
cls
echo.
echo   !CB2!===============================================================!C0!
echo.
echo        !CBG4!!PHEAD!!C0!
echo.
echo   !CB2!===============================================================!C0!
echo.
echo       !CBG1![1]!C0!   !PH1!
echo       !CBG2![2]!C0!   !PH2!
echo       !CBG3![3]!C0!   !PH3!
echo       !CBG4![4]!C0!   !PH4!
echo       !CBG4![5]!C0!   !PH5!
echo.
echo       !CK![0]!C0!   !BACK!
echo.
choice /C 123450 /N /M "   !PROMPT!"
set "PCH=!errorlevel!"
if "!PCH!"=="6" goto MENU
if "!PCH!"=="1" goto _pq_cam
if "!PCH!"=="2" goto _pq_net
if "!PCH!"=="3" goto _pq_bt
if "!PCH!"=="4" goto _pq_prn
if "!PCH!"=="5" goto _pq_xbx
goto PERIPH

:_pq_cam
echo.
echo   !CY![ ? ]!C0!  !CW!!QH_CAM!!C0!
echo.
echo        !QO_CAM!!C0!
echo        !CK![0] !BACK!!C0!
echo.
choice /C 1230 /N /M "        !PROMPT!"
set "CAM=!errorlevel!"
if "!CAM!"=="4" goto PERIPH
call :pcam
reg add "HKLM\SOFTWARE\LowLatOptimizer" /v QCam /t REG_DWORD /d !CAM! /f >nul 2>&1
goto _pdone

:_pq_net
echo.
echo   !CY![ ? ]!C0!  !CW!!QH_WIFI!!C0!
echo.
echo        !QO_NET!!C0!
echo        !QO_NET2!!C0!
echo        !CK![0] !BACK!!C0!
echo.
choice /C 123450 /N /M "        !PROMPT!"
set "WIFI=!errorlevel!"
if "!WIFI!"=="6" goto PERIPH
call :pnet
reg add "HKLM\SOFTWARE\LowLatOptimizer" /v QWifi /t REG_DWORD /d !WIFI! /f >nul 2>&1
goto _pdone

:_pq_bt
echo.
echo   !CY![ ? ]!C0!  !CW!!QH_BT!!C0!
echo.
echo        !QO_NDR!!C0!
echo        !CK![0] !BACK!!C0!
echo.
choice /C 1230 /N /M "        !PROMPT!"
set "BT=!errorlevel!"
if "!BT!"=="4" goto PERIPH
call :pbt
reg add "HKLM\SOFTWARE\LowLatOptimizer" /v QBt /t REG_DWORD /d !BT! /f >nul 2>&1
goto _pdone

:_pq_prn
echo.
echo   !CY![ ? ]!C0!  !CW!!QH_PRINT!!C0!
echo.
echo        !QO_NDR!!C0!
echo        !CK![0] !BACK!!C0!
echo.
choice /C 1230 /N /M "        !PROMPT!"
set "PRINT=!errorlevel!"
if "!PRINT!"=="4" goto PERIPH
call :pprn
reg add "HKLM\SOFTWARE\LowLatOptimizer" /v QPrint /t REG_DWORD /d !PRINT! /f >nul 2>&1
goto _pdone

:_pq_xbx
echo.
echo   !CY![ ? ]!C0!  !CW!!QH_XBOX!!C0!
echo.
echo        !QO_XBOX!!C0!
echo        !CK![0] !BACK!!C0!
echo.
choice /C 1230 /N /M "        !PROMPT!"
set "XBOX=!errorlevel!"
if "!XBOX!"=="4" goto PERIPH
call :pxbx
reg add "HKLM\SOFTWARE\LowLatOptimizer" /v QXbox /t REG_DWORD /d !XBOX! /f >nul 2>&1
goto _pdone

:_pdone
echo.
echo   !CG!  !PDONE!!C0!
echo.
pause
goto PERIPH

:RTREVERT
cls
echo.
set "RTRM=Re-enabling Defender real-time protection..."
if /i "!L!"=="FR" set "RTRM=Reactivation de la protection temps reel Defender..."
echo   !CG! !RTRM!!C0!
powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; Set-MpPreference -DisableRealtimeMonitoring $false -DisableBehaviorMonitoring $false -DisableIOAVProtection $false -DisableScriptScanning $false -MAPSReporting 2 -SubmitSamplesConsent 1" >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableBehaviorMonitoring /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v SpynetReporting /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v SubmitSamplesConsent /f >nul 2>&1
set "RTRD=Defender real-time protection re-enabled."
if /i "!L!"=="FR" set "RTRD=Protection temps reel Defender reactivee."
echo   !OK! !CC!!RTRD!!C0!
echo.
pause
goto MENU

:SPECREVERT
cls
echo.
set "SRM=Restoring default Spectre/Meltdown CPU mitigations..."
if /i "!L!"=="FR" set "SRM=Restauration des mitigations CPU Spectre/Meltdown par defaut..."
echo   !CG! !SRM!!C0!
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /f >nul 2>&1
set "SRD=CPU mitigations back to default - reboot to apply."
if /i "!L!"=="FR" set "SRD=Mitigations CPU revenues par defaut - reboot pour appliquer."
echo   !OK! !CC!!SRD!!C0!
echo.
pause
goto MENU

:AIOEND
endlocal
exit /b
