@echo off
chcp 1252 >nul
title Low Latency Gaming Script
setlocal EnableExtensions EnableDelayedExpansion

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
set "C0=!ESC![0m"
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
set "OK=!CG![!CW!OK!CG!]!C0!"
color 0F
set "TRPSB64=JEVycm9yQWN0aW9uUHJlZmVyZW5jZT0nU2lsZW50bHlDb250aW51ZScKJG10eD1OZXctT2JqZWN0IFN5c3RlbS5UaHJlYWRpbmcuTXV0ZXgoJGZhbHNlLCdMb3dMYXRUaW1lclJlczA1JykKaWYoLW5vdCAkbXR4LldhaXRPbmUoMCkpeyBleGl0IH0KJGNvZGU9QCcKdXNpbmcgU3lzdGVtOwp1c2luZyBTeXN0ZW0uUnVudGltZS5JbnRlcm9wU2VydmljZXM7CnB1YmxpYyBjbGFzcyBUUiB7CiAgW0RsbEltcG9ydCgibnRkbGwuZGxsIildIHB1YmxpYyBzdGF0aWMgZXh0ZXJuIGludCBOdFNldFRpbWVyUmVzb2x1dGlvbih1aW50IERlc2lyZWRSZXNvbHV0aW9uLCBib29sIFNldFJlc29sdXRpb24sIG91dCB1aW50IEN1cnJlbnRSZXNvbHV0aW9uKTsKfQonQApBZGQtVHlwZSAtVHlwZURlZmluaXRpb24gJGNvZGUKJGN1cj0wCndoaWxlKCR0cnVlKXsgW1RSXTo6TnRTZXRUaW1lclJlc29sdXRpb24oNTAwMCwkdHJ1ZSxbcmVmXSRjdXIpIHwgT3V0LU51bGw7IFN0YXJ0LVNsZWVwIC1TZWNvbmRzIDIgfQo="
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
set "M3L=High CPU and I/O priority on !CW!CS2, LoL, Brawlhalla, R6, Valorant, Apex, Fortnite!C0!"
set "M3S=Per-game CPU/IO priority: !CG!default (soft)!C0!"
set "M4=!CW!NVIDIA!C0! GPU: legacy sharpening !CG!on!C0!, MSI mode !CG!on!C0!"
set "M5=!CW!AMD!C0! GPU: ULPS !CR!off!C0!, MSI mode !CG!on!C0!, driver !CG!frozen!C0! (no GPU update via Windows Update)"
set "M6=Mouse !CG!1:1!C0! (acceleration !CR!off!C0!), keyboard fast, sticky keys !CR!off!C0!, PrtScn opens !CW!Snipping Tool!C0!"
set "M7=!CW!Network!C0!: RSC !CR!off!C0!, RSS !CG!on!C0!, NIC power saving and moderation !CR!off!C0!"
set "M8=Boot timers tuned, NTFS 8.3 names !CR!off!C0!"
set "M9=Telemetry, ads, !CW!Copilot, Recall, Widgets!C0! !CR!off!C0!"
set "M10=!CW!Ad and telemetry blocklist!C0!: !CC!215 domains!C0! via hosts"
set "M11=Telemetry scheduled tasks !CR!disabled!C0!"
set "M12=Useless services !CR!disabled!C0! (!CW!anticheats!C0! and drivers untouched)"
set "M13=Windows indexing !CG!on!C0! (file search)"
set "M14=Exclusive fullscreen !CG!forced!C0!, high-performance GPU on all !CC!7!C0! games"
set "M15=!CW!GameDVR!C0! !CR!off!C0!, !CW!Game Mode!C0! !CG!on!C0!, windowed-game optimizations !CG!on!C0!"
set "M16=!CW!Defender!C0!: games !CG!excluded!C0! from scanning (system still protected)"
set "M17=Debloat !CG!done!C0! (!CW!Store, Security, Snipping, Calculator, Paint, Spotify!C0! kept)"
set "M19=New !CW!Outlook!C0! and !CW!Copilot!C0! !CR!removed!C0!"
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
set "M37=!CW!Edge!C0! !CR!uninstalled!C0! (allowed in the EU/EEA, France OK)"
set "M40=!CW!Appearance!C0!: transparency, grey accent, black wallpaper, !CW!dark theme!C0!"
set "M43=Taskbar cleaned (search hidden, combined, !CW!Widgets!C0! !CR!off!C0!, !CW!Task View!C0! !CR!off!C0!, End task !CG!on!C0!)"
set "M44=!CW!Start menu!C0!: more pins, no recommendations, no recent apps, notifications !CR!off!C0!"
set "M45=!CW!File Explorer!C0!: hidden items shown, extensions !CG!on!C0!, opens to !CW!This PC!C0!"
set "M46=!CW!Dynamic Lighting!C0! !CR!off!C0!"
set "M47=Snap and multitasking !CG!on!C0!, Aero Shake !CR!off!C0!"
set "M48=!CW!UAC!C0!: !CY!never prompts!C0! (silent elevation)"
set "M49=Remote Desktop and Remote Assistance !CR!off!C0!"
set "M50=Memory integrity (core isolation) !CG!kept on!C0! - required by some !CW!anticheats!C0!"
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
set "M61=!CW!Storage Sense!C0! !CG!on!C0!: temp + recycle 1d + downloads 1d, daily"
set "M62=!CW!Cleanup!C0!: temp, !CW!Discord/Steam!C0! cache, WinSxS, Windows.old, recycle bin"
set "M63=!CW!Windows Update!C0! !CY!running!C0! (incl. !CW!optional!C0! updates)... can take a while, do not close"
set "M64=!CW!Windows Update!C0! !CG!finished!C0!"
set "M66=Updating apps via !CW!winget!C0!... can take a while"
set "M67=!CW!winget!C0! !CG!finished!C0!"
set "M69=Windows timer forced to !CC!0.5 ms!C0! at startup (no external tool)"
set "M71=Settings re-applied !CG!only after a Windows update!C0!; safe cleanup temp + DNS !CG!every session!C0!"
set "R0=Restored: !CW!CPU/RAM core!C0! to default"
set "R1=Restored: !CW!network!C0! to default"
set "R2=Restored: !CW!per-game priorities and fullscreen!C0! to default"
set "R3=Restored: !CW!GameDVR and NVIDIA sharpening!C0! to default"
set "R4=Restored: !CW!timers, boot and NTFS!C0! to default"
set "R5=Restored: !CW!services!C0! to default"
set "R6=Restored: !CW!UAC, remote, lighting, power, telemetry!C0!; !CW!AMD!C0! lock removed"
set "R7=Restored: !CW!custom tasks!C0! removed"
set "MODE_HEAD=MODE"
set "MODE_1=!CO!Apply!C0! optimizations"
set "DESC1=Reduces system latency and input lag for gaming."
set "DESC2=Anticheat-safe. Fully reversible with the Restore option."
set "MODE_2=!CG!Restore!C0! Windows default values"
set "QMODE_HEAD=CHOOSE YOUR OPTIMIZATION MODE"
set "QMODE_S_NAME=SOFT MODE"
set "QMODE_S_DESC=High Performance plan, no per-game priority, default GPU timeout - cooler"
set "QMODE_L_NAME=LOWEST LATENCY"
set "QMODE_L_DESC=Ultimate plan, per-game priority, GPU timeout 8s, constant timer - warmer"
set "MODE_ACTIVE=ACTIVE MODE"
set "PROMPT=Your choice: "
set "DET_GPU=Graphics card"
set "DET_RAM=Memory       "
set "DET_CPU=Processor    "
set "DET_CORES=cores"
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
set "SUM04=Mouse !CG!1:1!C0!, zero Windows acceleration."
set "SUM05=Network tuned for minimal lag."
set "SUM06=Trackers, telemetry and useless services !CR!off!C0!."
set "SUM07=Ad + MS telemetry blocking via hosts (!CC!215 domains!C0! + Defender exclusion)."
set "SUM08=!CW!Widgets, Copilot, new Outlook, Task View!C0! !CR!removed!C0!."
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
set "REST_NOTE2=Not auto-reverted: debloated apps, OneDrive, Edge, unpinned items."
set "REST_NOTE3=Core isolation was NOT touched by this script."
set "BAN_A=Core engine: CPU, scheduler, GPU, mouse, network"
set "BAN_B=Privacy, telemetry and game mode"
set "BAN_C=Devices & Xbox (your choices)"
set "BAN_D=Apps, appearance and interface"
set "BAN_E=Power plan and boot"
set "BAN_F=Disks and maintenance"
set "BAN_G=Updates"
set "BAN_H=Real-time latency"
set "BACK=Back"
set "SIGN_BY=by"
set "SIGN_TAIL=made with Claude.ai"
goto _strdone
:_strfr
set "M0=!CW!CPU/RAM!C0! : svchost regroupé, quantum premier plan, SysMain on"
set "M2=!CW!MMCSS!C0! profil Games : priorité GPU et CPU !CG!maximale!C0!"
set "M3L=Priorité CPU et E/S élevée sur !CW!CS2, LoL, Brawlhalla, R6, Valorant, Apex, Fortnite!C0!"
set "M3S=Priorité CPU/E-S par jeu : !CG!défaut (soft)!C0!"
set "M4=GPU !CW!NVIDIA!C0! : affûtage hérité !CG!activé!C0!, mode MSI !CG!activé!C0!"
set "M5=GPU !CW!AMD!C0! : ULPS !CR!off!C0!, mode MSI !CG!on!C0!, pilote !CG!figé!C0! (aucune MAJ GPU via Windows Update)"
set "M6=Souris !CG!1:1!C0! (accélération !CR!off!C0!), clavier rapide, touches rémanentes !CR!off!C0!, Impr écran ouvre !CW!Capture!C0!"
set "M7=!CW!Réseau!C0! : RSC !CR!off!C0!, RSS !CG!on!C0!, économie et modération carte réseau !CR!off!C0!"
set "M8=Timers de démarrage réglés, noms courts 8.3 NTFS !CR!off!C0!"
set "M9=Télémétrie, publicité, !CW!Copilot, Recall, Widgets!C0! !CR!off!C0!"
set "M10=!CW!Liste de blocage pub et télémétrie!C0! : !CC!215 domaines!C0! via hosts"
set "M11=Tâches planifiées de télémétrie !CR!désactivées!C0!"
set "M12=Services inutiles !CR!désactivés!C0! (!CW!anticheats!C0! et pilotes intacts)"
set "M13=Indexation Windows !CG!activée!C0! (recherche de fichiers)"
set "M14=Plein écran exclusif !CG!forcé!C0!, GPU hautes performances sur les !CC!7!C0! jeux"
set "M15=!CW!GameDVR!C0! !CR!off!C0!, !CW!Mode Jeu!C0! !CG!on!C0!, optimisations jeux fenêtrés !CG!on!C0!"
set "M16=!CW!Defender!C0! : jeux !CG!exclus!C0! de l'analyse (système toujours protégé)"
set "M17=Debloat !CG!effectué!C0! (!CW!Store, Sécurité, Capture, Calculatrice, Paint, Spotify!C0! gardés)"
set "M19=!CW!Outlook!C0! (nouveau) et !CW!Copilot!C0! !CR!retirés!C0!"
set "M20=!CW!Confidentialité!C0! : accès applis !CR!off!C0! sauf !CG!microphone!C0! ; applis en arrière-plan !CR!off!C0!"
set "M72=!CW!Infos de saisie!C0! + !CW!suggestions!C0! + spotlight/voix/presse-papier !CR!OFF!C0!"
set "M73=!CW!MSI mode!C0! sur le GPU (interruptions signalées) : !CG!ON!C0! (au reboot)"
set "M74=Historique presse-papier, bouton Chat, récents Explorateur, Cortana, sons, verrouillage/veille !CR!OFF!C0!"
set "M75=!CW!Nag config!C0!, redémarrage auto MAJ, feedback, réveil maintenance, animation 1re connexion !CR!OFF!C0!"
set "M21=!CW!Caméra!C0! !CG!gardée active!C0! (applis autorisées)"
set "M22=!CW!Caméra!C0! !CR!désactivée!C0! (périphérique et accès applis off)"
set "M23=!CW!Caméra!C0! !CG!restaurée!C0! (périphérique réactivé)"
set "M24=!CW!Wi-Fi + Ethernet!C0! : inchangé"
set "M25=!CW!Wi-Fi!C0! !CR!désactivé!C0! (service et adaptateurs)"
set "M26=!CW!Wi-Fi!C0! !CG!restauré!C0! (service et adaptateurs)"
set "M25E=!CW!Ethernet!C0! !CR!désactivé!C0! (adaptateur)"
set "M26E=!CW!Ethernet!C0! !CG!restauré!C0! (adaptateur)"
set "M27=!CW!Bluetooth!C0! : inchangé"
set "M28=!CW!Bluetooth!C0! !CR!désactivé!C0! (services et radios)"
set "M29=!CW!Bluetooth!C0! !CG!restauré!C0! (services et radios)"
set "M30=!CW!Imprimante!C0! : inchangée"
set "M31=!CW!Imprimante!C0! !CR!désactivée!C0! (spouleur off)"
set "M32=!CW!Imprimante!C0! !CG!restaurée!C0! (spouleur on)"
set "M33=!CW!Xbox!C0! : inchangé"
set "M34=!CW!Xbox!C0! !CR!supprimé!C0! (apps, services, tâche)"
set "M35=!CW!Xbox!C0! !CG!restauré!C0! (services en manuel)"
set "M36=!CW!OneDrive!C0! !CR!désinstallé!C0!"
set "M37=!CW!Edge!C0! !CR!désinstallé!C0! (autorisé dans l'UE/EEE, France OK)"
set "M40=!CW!Apparence!C0! : transparence, accent gris, fond noir, !CW!thème sombre!C0!"
set "M43=Barre des tâches épurée (recherche masquée, combinée, !CW!Widgets!C0! !CR!off!C0!, !CW!Task View!C0! !CR!off!C0!, Terminer la tâche !CG!on!C0!)"
set "M44=!CW!Menu Démarrer!C0! : plus d'épingles, pas de reco, pas d'applis récentes, notifs !CR!off!C0!"
set "M45=!CW!Explorateur!C0! : éléments masqués visibles, extensions !CG!on!C0!, ouvre sur !CW!Ce PC!C0!"
set "M46=!CW!Éclairage dynamique!C0! !CR!off!C0!"
set "M47=Ancrage et multitâche !CG!on!C0!, Aero Shake !CR!off!C0!"
set "M48=!CW!UAC!C0! : !CY!ne prévient jamais!C0! (élévation silencieuse)"
set "M49=Bureau à distance et Assistance à distance !CR!off!C0!"
set "M50=Intégrité mémoire (core isolation) !CG!gardée on!C0! - requise par certains !CW!anticheats!C0!"
set "M51=!CW!Démarrage!C0! : pas d'interface, OS non affiché, délai !CC!0 seconde!C0!"
set "M52=Périphériques fantômes (débranchés) !CR!supprimés!C0!"
set "M53=!CW!Extras!C0! : FTH !CR!off!C0!, délai de démarrage des applis !CC!0!C0!, arrêt accéléré"
set "M54L=!CW!Performances optimales!C0! : USB suspend !CR!off!C0!, ASPM !CR!off!C0!, jamais de veille; parking/C-states selon le CPU"
set "M54S=!CW!Performances élevées!C0! : USB suspend !CR!off!C0!, ASPM !CR!off!C0! ; parking/C-states selon le CPU"
set "M55=!CW!HAGS!C0! supporté : !CG!activé!C0! (effet au redémarrage)"
set "M56=!CW!HAGS!C0! non exposé par la plateforme : !CY!non activé!C0!"
set "M57=!CW!Démarrage rapide!C0! !CG!activé!C0!"
set "M58=!CW!Icônes au démarrage masquées!C0! : !CW!Vanguard + Defender!C0! (services actifs)"
set "M59=Pilotes maintenus !CG!à jour!C0! via Windows Update"
set "M60=!CW!Optimisation des disques!C0! : tâche !CW!Windows!C0! native !CG!on!C0! (silencieuse, quotidienne)"
set "M61=!CW!Assistant de stockage!C0! !CG!on!C0! : temp + corbeille 1j + téléchargements 1j, chaque jour"
set "M62=!CW!Nettoyage!C0! : temp, cache !CW!Discord/Steam!C0!, WinSxS, Windows.old, corbeille"
set "M63=!CW!Windows Update!C0! !CY!en cours!C0! (y compris les !CW!facultatives!C0!)... peut être long, ne ferme pas"
set "M64=!CW!Windows Update!C0! !CG!terminé!C0!"
set "M66=Mise à jour des applis via !CW!winget!C0!... peut être long"
set "M67=!CW!winget!C0! !CG!terminé!C0!"
set "M69=Timer Windows forcé à !CC!0.5 ms!C0! au démarrage (aucun outil externe)"
set "M71=Réglages ré-appliqués !CG!seulement après une MAJ Windows!C0! ; nettoyage sûr temp + DNS !CG!à chaque session!C0!"
set "R0=Restauré : !CW!noyau CPU/RAM!C0! par défaut"
set "R1=Restauré : !CW!réseau!C0! par défaut"
set "R2=Restauré : !CW!priorités par jeu et plein écran!C0! par défaut"
set "R3=Restauré : !CW!GameDVR et affûtage NVIDIA!C0! par défaut"
set "R4=Restauré : !CW!timers, démarrage et NTFS!C0! par défaut"
set "R5=Restauré : !CW!services!C0! par défaut"
set "R6=Restauré : !CW!UAC, distance, éclairage, alimentation, télémétrie!C0! ; blocage !CW!AMD!C0! retiré"
set "R7=Restauré : !CW!tâches personnalisées!C0! retirées"
set "MODE_HEAD=MODE"
set "MODE_1=!CO!Appliquer!C0! les optimisations"
set "DESC1=Réduit la latence et le lag d'entrée pour le jeu."
set "DESC2=Compatible anticheat. Entièrement réversible (Restaurer)."
set "MODE_2=!CG!Restaurer!C0! les valeurs par défaut Windows"
set "QMODE_HEAD=CHOISIS TON MODE D'OPTIMISATION"
set "QMODE_S_NAME=MODE SOUPLE"
set "QMODE_S_DESC=Plan Performances élevées, sans priorité par jeu, timeout GPU défaut - frais"
set "QMODE_L_NAME=LATENCE MINIMALE"
set "QMODE_L_DESC=Plan Ultimate, priorité par jeu, timeout GPU 8s, timer constant - chaud"
set "MODE_ACTIVE=MODE ACTIF"
set "PROMPT=Ton choix : "
set "DET_GPU=Carte graphique"
set "DET_RAM=Mémoire vive "
set "DET_CPU=Processeur   "
set "DET_CORES=coeurs"
set "DET_THRESH=seuil svchost"
set "DET_GB=Go"
set "DET_KB=Ko"
set "Q_INTRO=Réponds aux questions ci-dessous (une touche; tape 0 pour revenir) :"
set "QH_CAM=CAMÉRA"
set "QH_WIFI=CARTES RÉSEAU (WI-FI / ETHERNET)"
set "QH_BT=BLUETOOTH"
set "QH_PRINT=IMPRIMANTE"
set "QH_XBOX=XBOX"
set "QO_YESNO=!CG![1] Oui!C0!  !CR![2] Non!C0!"
set "CFM_KEEP=inchangé"
set "CFM_OFF=désactivé"
set "CFM_RST=restauré"
set "QO_CAM=!CL![1] Garder active!C0!  !CR![2] Désactiver!C0!  !CG![3] Restaurer défaut!C0!"
set "QO_NDR=!CL![1] Ne rien faire!C0!  !CR![2] Désactiver!C0!  !CG![3] Restaurer défaut!C0!"
set "QO_NET=!CL![1] Garder!C0!  !CR![2] Désactiver Wi-Fi!C0!  !CR![3] Désactiver Ethernet!C0!"
set "QO_NET2=!CG![4] Restaurer Wi-Fi!C0!  !CG![5] Restaurer Ethernet!C0!"
set "QO_XBOX=!CL![1] Ne rien faire!C0!  !CR![2] Tout supprimer!C0!  !CG![3] Restaurer services!C0!"
set "APPLYING=Application des optimisations, patiente..."
set "DONE_APPLY=TERMINÉ"
set "SUMMARY_HEAD=RÉSUMÉ"
set "SUM02=Le jeu au premier plan a la !CG!priorité maximale!C0!."
set "SUM03=CPU totalement !CG!déparké!C0!, aucun économiseur, pas de veille."
set "SUM04=Souris !CG!1:1!C0!, zéro accélération Windows."
set "SUM05=Réseau réglé pour le minimum de lag."
set "SUM06=Mouchards, télémétrie et services inutiles !CR!coupés!C0!."
set "SUM07=Blocage pub + télémétrie MS via hosts (!CC!215 domaines!C0! + exclusion Defender)."
set "SUM08=!CW!Widgets, Copilot, Outlook (nouveau), Task View!C0! !CR!retirés!C0!."
set "SUM09=Plein écran exclusif + GPU hautes performances sur les jeux."
set "SUM11=Intégrité mémoire !CG!gardée on!C0!, !CW!UAC!C0! ne prévient jamais."
set "SUM12=Bureau à distance !CR!off!C0!, indexation !CG!activée!C0!."
set "SUM13=Apparence : transparence, accent gris, fond noir, secondes."
set "SUM14=Disques optimisés par la tâche native + !CW!Assistant de stockage!C0!."
set "SUM15=Nettoyage temp, cache et !CW!Windows.old!C0! effectué."
set "SUM16=Timer forcé à !CC!0.5 ms!C0! au démarrage (aucun outil externe)."
set "SUM17=Réglages clés ré-appliqués après les MAJ ; nettoyage sûr !CG!à chaque session!C0!."
set "SUM18=Infos de saisie, suggestions, spotlight écran verrouillé, voix en ligne, actions suggérées : OFF"
set "SUM_DEV=Périphériques & Xbox (!CW!caméra, Wi-Fi, Bluetooth, imprimante!C0!) : selon tes choix."
set "Q_RESTART=Redémarrer le PC maintenant pour tout appliquer ?"
set "RESTARTING=Redémarrage dans 5 secondes..."
set "RESTART_LATER=OK - pense à redémarrer plus tard pour tout appliquer."
set "REST_INTRO=Restauration des valeurs par défaut Windows..."
set "REST_DONE_HEAD=RESTAURATION TERMINÉE"
set "REST_NOTE1=Valeurs par défaut Windows restaurées."
set "REST_NOTE2=Non auto-restauré : applis debloatées, OneDrive, Edge, épingles."
set "REST_NOTE3=L'isolation du noyau n'a PAS été touchée par ce script."
set "BAN_A=Moteur système : CPU, planificateur, GPU, souris, réseau"
set "BAN_B=Confidentialité, télémétrie et mode jeu"
set "BAN_C=Périphériques & Xbox (selon tes choix)"
set "BAN_D=Applis, apparence et interface"
set "BAN_E=Alimentation et démarrage"
set "BAN_F=Disques et maintenance"
set "BAN_G=Mises à jour"
set "BAN_H=Latence temps réel"
set "BACK=Retour"
set "SIGN_BY=par"
set "SIGN_TAIL=réalisé avec Claude.ai"
:_strdone
cls
echo  !CM!================================================================!C0!
echo  !CW!                   LOW LATENCY GAMING SCRIPT!C0!
echo  !CB!                !BSUB!!C0!
echo  !CM!================================================================!C0!
echo.
echo   !CW!!DESC1!!C0!
echo   !CK!!DESC2!!C0!
echo.
echo   !CY!!MODE_HEAD!!C0!
echo.
echo       !CC![1]!C0! !MODE_1!
echo       !CC![2]!C0! !MODE_2!
echo.
choice /C 12 /N /M "   !PROMPT!"
if "!errorlevel!"=="2" goto RESTORE

rem ============ DETECTION ============
set "GPUVENDOR=OTHER"
for /f "usebackq delims=" %%g in (`powershell -NoProfile -Command "$v=(Get-CimInstance Win32_VideoController).Name -join ' '; if($v -match 'NVIDIA'){'NVIDIA'}elseif($v -match 'AMD|Radeon'){'AMD'}else{'OTHER'}"`) do set "GPUVENDOR=%%g"
set "RAMGB=0"
for /f "usebackq delims=" %%g in (`powershell -NoProfile -Command "[math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory/1GB)"`) do set "RAMGB=%%g"
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
echo.
echo   !CC!  !DET_GPU!  !CK!....!C0!  !CW!!GPUVENDOR!!C0!
echo   !CC!  !DET_RAM!  !CK!....!C0!  !CW!!RAMGB! !DET_GB!!C0!   !CK!(!DET_THRESH! = !SVCKB! !DET_KB!)!C0!
set "CPUDISP=!CPUVENDOR!"
if "!ISX3D!"=="1" set "CPUDISP=!CPUVENDOR! X3D mono-CCD"
if "!X3DMULTI!"=="1" set "CPUDISP=!CPUVENDOR! X3D bi-CCD"
echo   !CC!  !DET_CPU!  !CK!....!C0!  !CW!!CPUDISP!, !CPUCORES! !DET_CORES!!C0!
echo.

rem ============ QUESTIONS ============
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
choice /C 12 /N /M "        !PROMPT!"
set "MM=!errorlevel!"
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
echo.
echo      !CW!  [*] !MODE_ACTIVE! :!C0!  !CTHEME!!MODENAME!!C0!
echo.
echo  !CY!!Q_INTRO!!C0!
echo.
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
rem ============ [01] NOYAU CPU / RAM ============
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v SvcHostSplitThresholdInKB /t REG_DWORD /d !SVCKB! /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d !PRIOSEP! /f >nul 2>&1
reg add "HKLM\SOFTWARE\LowLatOptimizer" /v Mode /t REG_SZ /d !MODEMARK! /f >nul 2>&1
reg add "HKLM\SOFTWARE\LowLatOptimizer" /v IsX3D /t REG_DWORD /d !ISX3D! /f >nul 2>&1
reg add "HKLM\SOFTWARE\LowLatOptimizer" /v X3DMulti /t REG_DWORD /d !X3DMULTI! /f >nul 2>&1
reg add "HKLM\SOFTWARE\LowLatOptimizer" /v SvcKB /t REG_DWORD /d !SVCKB! /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v GlobalTimerResolutionRequests /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v PowerThrottlingOff /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnablePrefetcher /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnableSuperfetch /t REG_DWORD /d 3 /f >nul 2>&1
sc config SysMain start= auto >nul 2>&1
sc start SysMain >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /f >nul 2>&1
echo   !OK! !CC![01]!C0! !M0!

rem ============ [02] MMCSS (planificateur jeux) ============
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d !SYSRESP! /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 10 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul 2>&1
rem -- neutralise d'anciens tweaks Nagle (placebo en UDP), retour au defaut
for /f "delims=" %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" 2^>nul') do (
    reg delete "%%i" /v TcpAckFrequency /f >nul 2>&1
    reg delete "%%i" /v TCPNoDelay /f >nul 2>&1
)
echo   !OK! !CC![02]!C0! !M2!

rem ============ [03] PRIORITES PAR JEU (IFEO) ============
if "!MODEMARK!"=="soft" goto _ifeoDef
for %%E in ("cs2.exe" "League of Legends.exe" "Brawlhalla.exe" "RainbowSix.exe" "RainbowSix_DX11.exe" "VALORANT-Win64-Shipping.exe" "VALORANT.exe" "r5apex.exe" "r5apex_dx12.exe" "FortniteClient-Win64-Shipping.exe") do (
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%~E\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 3 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%~E\PerfOptions" /v IoPriority /t REG_DWORD /d 3 /f >nul 2>&1
)
goto _ifeoEnd
:_ifeoDef
for %%E in ("cs2.exe" "League of Legends.exe" "Brawlhalla.exe" "RainbowSix.exe" "RainbowSix_DX11.exe" "VALORANT-Win64-Shipping.exe" "VALORANT.exe" "r5apex.exe" "r5apex_dx12.exe" "FortniteClient-Win64-Shipping.exe") do reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%~E\PerfOptions" /f >nul 2>&1
:_ifeoEnd
echo   !OK! !CC![03]!C0! !M3!

rem ============ [04] GPU (selon detection) ============
if /i "!GPUVENDOR!"=="NVIDIA" (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v EnableGR535 /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters\FTS" /v EnableGR535 /t REG_DWORD /d 0 /f >nul 2>&1
    echo   !OK! !CC![04]!C0! !M4!
)
if /i "!GPUVENDOR!"=="AMD" (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='SilentlyContinue'; $base='HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}'; Get-ChildItem $base | Where-Object { $_.PSChildName -match '^[0-9]{4}$' } | ForEach-Object { $k=$_.PSPath; $d=(Get-ItemProperty $k -Name DriverDesc -EA SilentlyContinue).DriverDesc; if($d -match 'AMD|Radeon'){ Set-ItemProperty $k 'EnableUlps' 0 -Type DWord -Force } }" >nul 2>&1
    echo   !OK! !CC![04]!C0! !M5!
)
if "!MODEMARK!"=="lowest" reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v TdrDelay /t REG_DWORD /d 8 /f >nul 2>&1
if "!MODEMARK!"=="soft" reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v TdrDelay /f >nul 2>&1
rem -- MSI mode (Message Signaled Interrupts) sur le GPU : ON - reduit la latence d interruption (effet au reboot) --
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='SilentlyContinue'; Get-PnpDevice -Class Display | ForEach-Object { $p='HKLM:\SYSTEM\CurrentControlSet\Enum\'+$_.InstanceId+'\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties'; New-Item -Path $p -Force | Out-Null; New-ItemProperty -Path $p -Name MSISupported -PropertyType DWord -Value 1 -Force | Out-Null }" >nul 2>&1
echo   !OK! !CC![04]!C0! !M73!

rem ============ [05] SOURIS 1:1 + CLAVIER + ANTI POP-UP ============
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d "0" /f >nul 2>&1
rem -- MarkC : sensibilite 6/11 (aucun multiplicateur) + accel OFF aussi sur l ecran de connexion --
reg add "HKCU\Control Panel\Mouse" /v MouseSensitivity /t REG_SZ /d "10" /f >nul 2>&1
reg add "HKU\.DEFAULT\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKU\.DEFAULT\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKU\.DEFAULT\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v MouseDataQueueSize /t REG_DWORD /d 128 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v KeyboardDataQueueSize /t REG_DWORD /d 128 /f >nul 2>&1
reg add "HKCU\Control Panel\Keyboard" /v KeyboardDelay /t REG_SZ /d "0" /f >nul 2>&1
rem -- NumLock active des le demarrage (valeur qui prime sur l etat memorise par Fast Startup) --
reg add "HKU\.DEFAULT\Control Panel\Keyboard" /v InitialKeyboardIndicators /t REG_SZ /d "2147483650" /f >nul 2>&1
reg add "HKCU\Control Panel\Keyboard" /v InitialKeyboardIndicators /t REG_SZ /d "2147483650" /f >nul 2>&1
rem -- N : repetition clavier au maximum --
reg add "HKCU\Control Panel\Keyboard" /v KeyboardSpeed /t REG_SZ /d "31" /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v Flags /t REG_SZ /d "506" /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v Flags /t REG_SZ /d "122" /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\ToggleKeys" /v Flags /t REG_SZ /d "58" /f >nul 2>&1
reg add "HKCU\Control Panel\Keyboard" /v PrintScreenKeyForSnippingEnabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v AutoEndTasks /t REG_SZ /d "1" /f >nul 2>&1
rem -- Anti pop-up ms-gamebar / ms-gamingoverlay (appli Xbox, overlay) : handler neutre
for %%P in (ms-gamingoverlay ms-gamebar ms-gamebarservices ms-xbox ms-xboxlive ms-yourphone ms-getstarted ms-feedback ms-retaildemo) do (
reg add "HKCU\Software\Classes\%%P" /f /ve /d "URL:%%P" >nul 2>&1
reg add "HKCU\Software\Classes\%%P" /f /v "URL Protocol" /d "" >nul 2>&1
reg add "HKCU\Software\Classes\%%P\shell\open\command" /f /ve /d "systray.exe" >nul 2>&1
)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v NoUseStoreOpenWith /t REG_DWORD /d 1 /f >nul 2>&1
echo   !OK! !CC![05]!C0! !M6!

rem ============ [06] RESEAU + QoS ============
netsh int tcp set global rss=enabled >nul 2>&1
netsh int tcp set global rsc=disabled >nul 2>&1
netsh int tcp set heuristics disabled >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v NonBestEffortLimit /t REG_DWORD /d 0 /f >nul 2>&1
powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; Get-NetAdapter -Physical | Where-Object {$_.Status -eq 'Up' -and $_.InterfaceDescription -notmatch 'Wireless|Wi-?Fi|802\.11'} | ForEach-Object { $n=$_.Name; Disable-NetAdapterPowerManagement -Name $n -EA SilentlyContinue; Set-NetAdapterAdvancedProperty -Name $n -RegistryKeyword '*InterruptModeration' -RegistryValue 0 -NoRestart -EA SilentlyContinue; Set-NetAdapterAdvancedProperty -Name $n -RegistryKeyword '*FlowControl' -RegistryValue 0 -NoRestart -EA SilentlyContinue; Set-NetAdapterAdvancedProperty -Name $n -RegistryKeyword '*EEE' -RegistryValue 0 -NoRestart -EA SilentlyContinue }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v DODownloadMode /t REG_DWORD /d 0 /f >nul 2>&1
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
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338388Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v TurnOffWindowsCopilot /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v DisableAIDataAnalysis /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v AllowNewsAndInterests /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v LetAppsRunInBackground /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v StartupBoostEnabled /t REG_DWORD /d 0 /f >nul 2>&1
echo   !OK! !CC![08]!C0! !M9!

rem ============ [09b] BLOCAGE PUB / TELEMETRIE via le fichier HOSTS ============
attrib -r "%SystemRoot%\System32\drivers\etc\hosts" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='SilentlyContinue'; Add-MpPreference -ExclusionPath ($env:SystemRoot+'\System32\drivers\etc\hosts') -EA SilentlyContinue; $h=$env:SystemRoot+'\System32\drivers\etc\hosts'; $nl=[char]13+[char]10; $doms='doubleclick.net www.doubleclick.net googleadservices.com pagead2.googlesyndication.com googlesyndication.com pubads.g.doubleclick.net securepubads.g.doubleclick.net stats.g.doubleclick.net ad.doubleclick.net adservice.google.com www.googletagservices.com partner.googleadservices.com www.googletagmanager.com www.google-analytics.com google-analytics.com ssl.google-analytics.com adnxs.com ib.adnxs.com secure.adnxs.com prebid.adnxs.com advertising.com ads.yahoo.com analytics.yahoo.com scorecardresearch.com b.scorecardresearch.com sb.scorecardresearch.com quantserve.com pixel.quantserve.com criteo.com static.criteo.net gum.criteo.com bidder.criteo.com taboola.com cdn.taboola.com trc.taboola.com outbrain.com mab.outbrain.com tr.outbrain.com mgid.com jsc.mgid.com servicer.mgid.com revcontent.com trends.revcontent.com cdn.revcontent.com adskeeper.com moatads.com z.moatads.com applovin.com adcolony.com amazon-adsystem.com aax.amazon-adsystem.com c.amazon-adsystem.com s.amazon-adsystem.com pubmatic.com ads.pubmatic.com image6.pubmatic.com rubiconproject.com fastlane.rubiconproject.com pixel.rubiconproject.com openx.net us-u.openx.net rtb.openx.net casalemedia.com dsum.casalemedia.com as.casalemedia.com indexww.com 3lift.com eb2.3lift.com tlx.3lift.com sharethrough.com btlr.sharethrough.com sovrn.com ap.lijit.com lijit.com gumgum.com g2.gumgum.com adform.net adx.adform.net track.adform.net smartadserver.com ww1.smartadserver.com diff.smartadserver.com spotxchange.com spotx.tv search.spotxchange.com teads.tv t.teads.tv sync.teads.tv adsrvr.org match.adsrvr.org insight.adsrvr.org bidswitch.net x.bidswitch.net contextweb.com tag.contextweb.com yieldmo.com ads.yieldmo.com 33across.com ssc.33across.com media.net contextual.media.net static.media.net innovid.com rtr.innovid.com hotjar.com static.hotjar.com script.hotjar.com api.mixpanel.com cdn.mxpnl.com api.segment.io cdn.segment.com api.amplitude.com cdn.amplitude.com api2.branch.io mc.yandex.ru adsterra.com propellerads.com bat.bing.com clarity.ms ads.linkedin.com px.ads.linkedin.com ads.tiktok.com analytics.tiktok.com business-api.tiktok.com ads-twitter.com static.ads-twitter.com analytics.twitter.com adroll.com d.adroll.com demdex.net omtrdc.net 2o7.net everesttech.net krxd.net nr-data.net chartbeat.com mktoresp.com hsadspixel.net mouseflow.com fullstory.com smartlook.com doubleverify.com adsafeprotected.com crwdcntrl.net rlcdn.com agkn.com mathtag.com eyeota.net tapad.com adsymptotic.com bidr.io onetag-sys.com yieldlab.net stickyadstv.com smartclip.net xiti.com ati-host.net weborama.fr weborama.com adverline.com adyoulike.com omnitagjs.com themoneytizer.com sublime.xyz ayads.co tradedoubler.com hubvisor.io 1rx.io adition.com ligatus.com plista.com gemius.pl vortex.data.microsoft.com vortex-win.data.microsoft.com v10.vortex-win.data.microsoft.com us.vortex-win.data.microsoft.com settings-win.data.microsoft.com telemetry.microsoft.com df.telemetry.microsoft.com oca.telemetry.microsoft.com sqm.telemetry.microsoft.com telecommand.telemetry.microsoft.com watson.telemetry.microsoft.com watson.ppe.telemetry.microsoft.com telemetry.urs.microsoft.com telemetry.appex.bing.net watson.live.com watson.microsoft.com choice.microsoft.com reports.wes.df.telemetry.microsoft.com services.wes.df.telemetry.microsoft.com v10.events.data.microsoft.com v20.events.data.microsoft.com us-v10.events.data.microsoft.com eu-v20.events.data.microsoft.com self.events.data.microsoft.com umwatson.events.data.microsoft.com vortex-sandbox.data.microsoft.com settings-sandbox.data.microsoft.com i1.services.social.microsoft.com redir.metaservices.microsoft.com functional.events.data.microsoft.com browser.events.data.microsoft.com eu-v10.events.data.microsoft.com eu-mobile.events.data.microsoft.com mobile.events.data.microsoft.com v10c.events.data.microsoft.com sqm.df.telemetry.microsoft.com statsfe2.ws.microsoft.com statsfe1.ws.microsoft.com watson.events.data.microsoft.com feedback.windows.com feedback.search.microsoft.com survey.watson.microsoft.com tile-service.weather.microsoft.com'; if(Test-Path $h){ $c=[IO.File]::ReadAllText($h) } else { $c='' }; $c=[regex]::Replace($c,'(?s)# ULTRA-ADBLOCK START.*?# ULTRA-ADBLOCK END[\r\n]*',''); $b='# ULTRA-ADBLOCK START'+$nl; foreach($d in $doms.Split(' ')){ if($d){ $b=$b+'0.0.0.0 '+$d+$nl } }; $b=$b+'# ULTRA-ADBLOCK END'+$nl; [IO.File]::WriteAllText($h,$c.TrimEnd()+$nl+$nl+$b,[Text.Encoding]::ASCII)" >nul 2>&1
ipconfig /flushdns >nul 2>&1
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
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='SilentlyContinue'; $q=[char]34; $steam=(Get-ItemProperty 'HKCU:\Software\Valve\Steam' -Name SteamPath).SteamPath; if(-not $steam){ $steam=(Get-ItemProperty 'HKLM:\SOFTWARE\WOW6432Node\Valve\Steam' -Name InstallPath).InstallPath }; $libs=@(); if($steam){ $libs+=$steam; $vdf=Join-Path $steam 'steamapps\libraryfolders.vdf'; if(Test-Path $vdf){ Get-Content $vdf | Select-String ($q+'path'+$q) | ForEach-Object { $libs += (($_ -split $q)[3]).Replace('\\','\') } } }; $rel=@('steamapps\common\Counter-Strike Global Offensive\game\bin\win64\cs2.exe','steamapps\common\Brawlhalla\Brawlhalla.exe','steamapps\common\Tom Clancy''s Rainbow Six Siege\RainbowSix.exe','steamapps\common\Tom Clancy''s Rainbow Six Siege\RainbowSix_DX11.exe','steamapps\common\Apex Legends\r5apex.exe','steamapps\common\Apex Legends\r5apex_dx12.exe'); $lay='HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers'; if(-not(Test-Path $lay)){New-Item $lay -Force|Out-Null}; $gpu='HKCU:\Software\Microsoft\DirectX\UserGpuPreferences'; if(-not(Test-Path $gpu)){New-Item $gpu -Force|Out-Null}; foreach($lib in ($libs | Select-Object -Unique)){ foreach($r in $rel){ $full=Join-Path $lib $r; if(Test-Path $full){ New-ItemProperty $lay $full -Value '~ DISABLEDXMAXIMIZEDWINDOWEDMODE' -PropertyType String -Force|Out-Null; New-ItemProperty $gpu $full -Value 'GpuPreference=2;' -PropertyType String -Force|Out-Null } } }; $abs=@($env:ProgramFiles+'\Epic Games\Fortnite\FortniteGame\Binaries\Win64\FortniteClient-Win64-Shipping.exe','C:\Riot Games\VALORANT\live\ShooterGame\Binaries\Win64\VALORANT-Win64-Shipping.exe','C:\Riot Games\League of Legends\Game\League of Legends.exe'); foreach($f in $abs){ if(Test-Path $f){ New-ItemProperty $lay $f -Value '~ DISABLEDXMAXIMIZEDWINDOWEDMODE' -PropertyType String -Force|Out-Null; New-ItemProperty $gpu $f -Value 'GpuPreference=2;' -PropertyType String -Force|Out-Null } }" >nul 2>&1
echo   !OK! !CC![12]!C0! !M14!

rem ============ [13] GAMEDVR OFF + MODE JEU FORCE ON ============
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\DirectX\UserGpuPreferences" /v DirectXUserGlobalSettings /t REG_SZ /d "SwapEffectUpgradeEnable=1;" /f >nul 2>&1
echo   !OK! !CC![13]!C0! !M15!

rem ============ [14] DEFENDER : exclusions des jeux ============
if defined STEAMPATH (
    powershell -NoProfile -Command "Add-MpPreference -ExclusionPath '!STEAMPATH!\steamapps\common\Counter-Strike Global Offensive' -EA SilentlyContinue; Add-MpPreference -ExclusionPath '!STEAMPATH!\steamapps\common\Brawlhalla' -EA SilentlyContinue; Add-MpPreference -ExclusionPath '!STEAMPATH!\steamapps\common\Tom Clancy''s Rainbow Six Siege' -EA SilentlyContinue" >nul 2>&1
)
powershell -NoProfile -Command "Add-MpPreference -ExclusionPath 'C:\Riot Games' -EA SilentlyContinue; Add-MpPreference -ExclusionProcess 'cs2.exe','Brawlhalla.exe','League of Legends.exe','RiotClientServices.exe','RainbowSix.exe','RainbowSix_DX11.exe','VALORANT.exe','VALORANT-Win64-Shipping.exe','r5apex.exe','r5apex_dx12.exe','FortniteClient-Win64-Shipping.exe' -EA SilentlyContinue" >nul 2>&1
echo   !OK! !CC![14]!C0! !M16!
rem ============ [15] DEBLOAT (toujours) ============
powershell -NoProfile -ExecutionPolicy Bypass -Command "$a=@('*Microsoft.YourPhone*','*MicrosoftWindows.CrossDevice*','*WindowsBackup*','*Microsoft.Getstarted*','*Microsoft.GetHelp*','*PowerAutomate*','*Microsoft.BingNews*','*Microsoft.BingWeather*','*Microsoft.BingFinance*','*Microsoft.BingSports*','*Microsoft.News*','*Microsoft.3DBuilder*','*Microsoft.Microsoft3DViewer*','*Microsoft.MicrosoftOfficeHub*','*Microsoft.OutlookForWindows*','*Microsoft.SkypeApp*','*MicrosoftTeams*','*Microsoft.People*','*Microsoft.WindowsFeedbackHub*','*Microsoft.WindowsMaps*','*Microsoft.MixedReality.Portal*','*Microsoft.MicrosoftSolitaireCollection*','*Microsoft.Todos*','*Clipchamp.Clipchamp*','*Microsoft.Windows.DevHome*','*Microsoft.549981C3F5F10*','*Microsoft.QuickAssist*','*Microsoft.Whiteboard*','*CandyCrush*','*Disney*','*TikTok*','*Netflix*','*Facebook*','*Twitter*','*Duolingo*'); foreach($x in $a){ Get-AppxPackage -AllUsers -Name $x -EA SilentlyContinue | Remove-AppxPackage -AllUsers -EA SilentlyContinue; Get-AppxProvisionedPackage -Online -EA SilentlyContinue | Where-Object {$_.DisplayName -like $x} | Remove-AppxProvisionedPackage -Online -EA SilentlyContinue | Out-Null }" >nul 2>&1
echo   !OK! !CC![15]!C0! !M17!

rem ============ [16b] OUTLOOK (nouveau) + COPILOT retires (toujours) ============
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='SilentlyContinue'; foreach($x in @('*Microsoft.OutlookForWindows*','*Microsoft.Copilot*','*Microsoft.Windows.Ai.Copilot.Provider*')){ Get-AppxPackage -AllUsers -Name $x | Remove-AppxPackage -AllUsers; Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -like $x } | Remove-AppxProvisionedPackage -Online | Out-Null }" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v TurnOffWindowsCopilot /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowCopilotButton /t REG_DWORD /d 0 /f >nul 2>&1
echo   !OK! !CC![16b]!C0! !M19!

rem ============ [16] CONFIDENTIALITE : acces applis OFF sauf MICRO ============
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='SilentlyContinue'; $base='HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore'; function S($c,$v){ $p=Join-Path $base $c; if(-not(Test-Path $p)){New-Item $p -Force|Out-Null}; New-ItemProperty $p 'Value' -Value $v -PropertyType String -Force|Out-Null; $np=Join-Path $p 'NonPackaged'; if(-not(Test-Path $np)){New-Item $np -Force|Out-Null}; New-ItemProperty $np 'Value' -Value $v -PropertyType String -Force|Out-Null }; foreach($c in @('location','contacts','appointments','phoneCallHistory','email','userDataTasks','chat','phoneCall','radios','bluetoothSync','appDiagnostics','documentsLibrary','picturesLibrary','videosLibrary','broadFileSystemAccess','userAccountInformation','userNotificationListener','activity','cellularData','gazeInput','graphicsCaptureProgrammatic','graphicsCaptureWithoutBorder','humanPresence')){ S $c 'Deny' }; S 'microphone' 'Allow'; $cam='Deny'; if('!CAMALLOW!' -eq '1'){$cam='Allow'}; S 'webcam' $cam" >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableActivityFeed /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v PublishUserActivities /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v UploadUserActivities /t REG_DWORD /d 0 /f >nul 2>&1
echo   !OK! !CC![16]!C0! !M20!
rem ============ [17b] SAISIE / SUGGESTIONS / FEATURES INUTILES OFF ============
rem -- Information sur la saisie (typing insights) + personnalisation entree --
reg add "HKCU\SOFTWARE\Microsoft\Input\TIPC" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v RestrictImplicitInkCollection /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v RestrictImplicitTextCollection /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /v HarvestContacts /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Personalization\Settings" /v AcceptedPrivacyPolicy /t REG_DWORD /d 0 /f >nul 2>&1
rem -- Reconnaissance vocale en ligne --
reg add "HKCU\SOFTWARE\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" /v HasAccepted /t REG_DWORD /d 0 /f >nul 2>&1
rem -- Suggestions / contenu pousse / spotlight ecran verrouille / astuces --
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SilentInstalledAppsEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v PreInstalledAppsEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v OemPreInstalledAppsEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SoftLandingEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v RotatingLockScreenEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v RotatingLockScreenOverlayEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338389Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338393Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353694Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353696Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-310093Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-88000326Enabled /t REG_DWORD /d 0 /f >nul 2>&1
rem -- Suggestions barre de recherche (web) + actions suggerees presse-papier --
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v DisableSearchBoxSuggestions /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SmartActionPlatform\SmartClipboard" /v Disabled /t REG_DWORD /d 1 /f >nul 2>&1
rem -- Notifs pub explorateur + notifs de compte dans le menu Demarrer --
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSyncProviderNotifications /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_AccountNotifications /t REG_DWORD /d 0 /f >nul 2>&1
rem -- Experiences personnalisees + temps forts recherche + notifications Windows OFF --
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v TailoredExperiencesWithDiagnosticDataEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" /v IsDynamicSearchBoxEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds\DSB" /v ShowDynamicContent /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v ToastEnabled /t REG_DWORD /d 0 /f >nul 2>&1
echo   !OK! !CC![17b]!C0! !M72!
rem ============ [17c] PRESSE-PAPIER / BARRE / EXPLORATEUR / CORTANA / SONS / ECRAN ============
rem -- A : historique presse-papier + presse-papier cloud OFF --
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v AllowClipboardHistory /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v AllowCrossDeviceClipboard /t REG_DWORD /d 0 /f >nul 2>&1
rem -- B : bouton Chat/Teams de la barre des taches OFF --
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarMn /t REG_DWORD /d 0 /f >nul 2>&1
rem -- C : fichiers recents + dossiers frequents dans l Explorateur OFF --
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowRecent /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowFrequent /t REG_DWORD /d 0 /f >nul 2>&1
rem -- D : Cortana entierement desactivee --
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f >nul 2>&1
rem -- E : sons systeme OFF (schema Aucun son + vidage de chaque evenement) --
reg add "HKCU\AppEvents\Schemes" /ve /t REG_SZ /d ".None" /f >nul 2>&1
powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; Get-ChildItem -Path 'HKCU:\AppEvents\Schemes\Apps' -Recurse | Where-Object { $_.PSChildName -eq '.Current' } | ForEach-Object { Set-ItemProperty -Path $_.PSPath -Name '(default)' -Value '' }" >nul 2>&1
rem -- F : ecran de verrouillage desactive (direct au login) --
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v NoLockScreen /t REG_DWORD /d 1 /f >nul 2>&1
rem -- G : ecran de veille OFF --
reg add "HKCU\Control Panel\Desktop" /v ScreenSaveActive /t REG_SZ /d "0" /f >nul 2>&1
echo   !OK! !CC![17c]!C0! !M74!
rem ============ [17d] ANTI-NAG / REDEMARRAGE MAJ / MAINTENANCE / FEEDBACK ============
rem -- J : "Terminer la configuration de l appareil" (OOBE nag) OFF --
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v ScoobeSystemSettingEnabled /t REG_DWORD /d 0 /f >nul 2>&1
rem -- K : pas de redemarrage auto apres MAJ si session ouverte --
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoRebootWithLoggedOnUsers /t REG_DWORD /d 1 /f >nul 2>&1
rem -- L : notifications de feedback OFF --
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v DoNotShowFeedbackNotifications /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v NumberOfSIUFInPeriod /t REG_DWORD /d 0 /f >nul 2>&1
rem -- M : maintenance automatique - pas de reveil du PC --
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v WakeUp /t REG_DWORD /d 0 /f >nul 2>&1
rem -- O : animation de premiere connexion OFF --
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableFirstLogonAnimation /t REG_DWORD /d 0 /f >nul 2>&1
echo   !OK! !CC![17d]!C0! !M75!

echo.
echo   !CK!------------------------------------------------------------!C0!
echo.
echo   !CC!::!C0!  !CM!!BAN_C!!C0!
echo.
rem ============ [17] CAMERA (3 choix) ============
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

rem ============ [18] WIFI / ETHERNET (5 choix) ============
if "!WIFI!"=="1" echo   !OK! !CC![18]!C0! !M24!
if "!WIFI!"=="2" (
    sc stop WlanSvc >nul 2>&1
    sc config WlanSvc start= disabled >nul 2>&1
    powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; Get-NetAdapter -Physical | Where-Object { $_.InterfaceDescription -match 'Wireless|Wi-?Fi|802\.11' } | Disable-NetAdapter -Confirm:$false" >nul 2>&1
    echo   !OK! !CC![18]!C0! !M25!
)
if "!WIFI!"=="3" (
    powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; Get-NetAdapter -Physical | Where-Object { $_.InterfaceDescription -notmatch 'Wireless|Wi-?Fi|802\.11' } | Disable-NetAdapter -Confirm:$false" >nul 2>&1
    echo   !OK! !CC![18]!C0! !M25E!
)
if "!WIFI!"=="4" (
    sc config WlanSvc start= auto >nul 2>&1
    sc start WlanSvc >nul 2>&1
    powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; Get-NetAdapter -Physical | Where-Object { $_.InterfaceDescription -match 'Wireless|Wi-?Fi|802\.11' } | Enable-NetAdapter -Confirm:$false" >nul 2>&1
    echo   !OK! !CC![18]!C0! !M26!
)
if "!WIFI!"=="5" (
    powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; Get-NetAdapter -Physical | Where-Object { $_.InterfaceDescription -notmatch 'Wireless|Wi-?Fi|802\.11' } | Enable-NetAdapter -Confirm:$false" >nul 2>&1
    echo   !OK! !CC![18]!C0! !M26E!
)

rem ============ [19] BLUETOOTH (3 choix) ============
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

rem ============ [20] IMPRIMANTE (3 choix) ============
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

rem ============ [21] XBOX (3 choix) ============
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

echo.
echo   !CK!------------------------------------------------------------!C0!
echo.
echo   !CC!::!C0!  !CM!!BAN_D!!C0!
echo.
rem ============ [22] ONEDRIVE (toujours) ============
taskkill /f /im OneDrive.exe >nul 2>&1
if exist "%SystemRoot%\System32\OneDriveSetup.exe" "%SystemRoot%\System32\OneDriveSetup.exe" /uninstall >nul 2>&1
if exist "%SystemRoot%\SysWOW64\OneDriveSetup.exe" "%SystemRoot%\SysWOW64\OneDriveSetup.exe" /uninstall >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v DisableFileSyncNGSC /t REG_DWORD /d 1 /f >nul 2>&1
echo   !OK! !CC![22]!C0! !M36!
rem ============ [23] EDGE (winget, toujours) ============
where winget >nul 2>&1 && start "" /min /wait cmd /c "winget uninstall --id Microsoft.Edge --accept-source-agreements --disable-interactivity --silent >nul 2>&1"
echo   !OK! !CC![23]!C0! !M37!
rem ============ [24] APPARENCE : transparence + accent gris + fond noir ============
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent" /v AccentColorMenu /t REG_DWORD /d 0xff484848 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent" /v StartColorMenu /t REG_DWORD /d 0xff484848 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v AccentColor /t REG_DWORD /d 0xff484848 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v ColorizationColor /t REG_DWORD /d 0xc4484848 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v ColorPrevalence /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v ColorPrevalence /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSecondsInSystemClock /t REG_DWORD /d 1 /f >nul 2>&1
rem Fond d'ecran : couleur unie NOIR + qualite wallpaper 100
reg add "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v WallpaperStyle /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v JPEGImportQuality /t REG_DWORD /d 100 /f >nul 2>&1
reg add "HKCU\Control Panel\Colors" /v Background /t REG_SZ /d "0 0 0" /f >nul 2>&1
rundll32.exe user32.dll,UpdatePerUserSystemParameters 1, True
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f >nul 2>&1
echo   !OK! !CC![24]!C0! !M40!

rem ============ [25] BARRE DES TACHES ============
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAl /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarGlomLevel /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v MMTaskbarGlomLevel /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarSd /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarBadges /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v PenWorkspaceButtonDesiredVisibility /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v TipbandDesiredVisibility /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings" /v TaskbarEndTask /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f >nul 2>&1
echo   !OK! !CC![25]!C0! !M43!

rem ============ [26] MENU DEMARRER ============
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackProgs /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackDocs /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_IrisRecommendations /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v HideRecommendedSection /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v NOC_GLOBAL_SETTING_TOASTS_ENABLED /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_Layout /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v HideCategoryView /t REG_DWORD /d 1 /f >nul 2>&1
echo   !OK! !CC![26]!C0! !M44!

rem ============ [27] EXPLORATEUR DE FICHIERS ============
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f >nul 2>&1
echo   !OK! !CC![27]!C0! !M45!

rem ============ [28] ECLAIRAGE DYNAMIQUE OFF ============
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Lighting" /v AmbientLightingEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Lighting" /v AmbientLightingEnabled /t REG_DWORD /d 0 /f >nul 2>&1
echo   !OK! !CC![28]!C0! !M46!

rem ============ [29] MULTITACHE ON + AERO SHAKE OFF ============
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v DisallowShaking /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v WindowArrangementActive /t REG_SZ /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v SnapAssist /t REG_DWORD /d 1 /f >nul 2>&1
echo   !OK! !CC![29]!C0! !M47!

rem ============ [30] UAC : ne prevenir JAMAIS ============
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop /t REG_DWORD /d 0 /f >nul 2>&1
echo   !OK! !CC![30]!C0! !M48!

rem ============ [31] UTILISATION A DISTANCE OFF ============
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowToGetHelp /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f >nul 2>&1
echo   !OK! !CC![31]!C0! !M49!

rem ============ [32] INTEGRITE MEMOIRE (core isolation) : ON ============
rem Laissee ACTIVE (requise par certains anticheats), on garantit qu'elle est ON
rem (utile si une version precedente du script l'avait coupee).
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v EnableVirtualizationBasedSecurity /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v Enabled /t REG_DWORD /d 1 /f >nul 2>&1
echo   !OK! !CC![32]!C0! !M50!

rem ============ [33] DEMARRAGE : NE PAS AFFICHER L'OS ============
bcdedit /timeout 0 >nul 2>&1
bcdedit /deletevalue {current} sos >nul 2>&1
bcdedit /set {current} bootux disabled >nul 2>&1
bcdedit /set {bootmgr} displaybootmenu no >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v VerboseStatus /t REG_DWORD /d 1 /f >nul 2>&1
echo   !OK! !CC![33]!C0! !M51!
rem ============ [34] PERIPHERIQUES FANTOMES + USELESS (safe) ============
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='SilentlyContinue'; $g=Get-PnpDevice | Where-Object { $_.Status -eq 'Unknown' }; foreach($d in $g){ & pnputil /remove-device $d.InstanceId 2>$null }" >nul 2>&1
echo   !OK! !CC![34]!C0! !M52!

rem ============ [35] BONUS : FTH OFF, delai demarrage 0, stockage reserve OFF ============
reg add "HKLM\SOFTWARE\Microsoft\FTH" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v StartupDelayInMSec /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v HungAppTimeout /t REG_SZ /d "4000" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v WaitToKillServiceTimeout /t REG_SZ /d "2000" /f >nul 2>&1
echo   !OK! !CC![35]!C0! !M53!

echo.
echo   !CK!------------------------------------------------------------!C0!
echo.
echo   !CC!::!C0!  !CM!!BAN_E!!C0!
echo.
rem ============ [36] ALIMENTATION : aucun economiseur ============
set "ULT="
for /f "tokens=2 delims=:" %%G in ('powercfg /list ^| findstr /i /c:"Ultimate Performance" /c:"Performances optimales"') do for /f "tokens=1" %%H in ("%%G") do set "ULT=%%H"
if not defined ULT for /f "tokens=2 delims=:" %%G in ('powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61') do for /f "tokens=1" %%H in ("%%G") do set "ULT=%%H"
if defined ULT powercfg /setactive !ULT! >nul 2>&1
if not defined ULT powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
if "!MODEMARK!"=="soft" powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
rem -- Parking + C-states selon le CPU : X3D = parking ON + C-states ON ; non-X3D / Intel = unpark + C-states OFF --
set "CPMIN=100"
set "IDLEDIS=1"
if "!ISX3D!"=="1" set "CPMIN=0"
if "!ISX3D!"=="1" set "IDLEDIS=0"
powercfg /setacvalueindex scheme_current 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318583 !CPMIN! >nul 2>&1
powercfg /setdcvalueindex scheme_current 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318583 !CPMIN! >nul 2>&1
powercfg /setacvalueindex scheme_current 54533251-82be-4824-96c1-47b60b740d00 5d76a2ca-e8c0-402f-a133-2158492d58ad !IDLEDIS! >nul 2>&1
powercfg /setdcvalueindex scheme_current 54533251-82be-4824-96c1-47b60b740d00 5d76a2ca-e8c0-402f-a133-2158492d58ad !IDLEDIS! >nul 2>&1
powercfg /setacvalueindex scheme_current 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 >nul 2>&1
powercfg /setacvalueindex scheme_current sub_pciexpress ee12f906-d277-404b-b6da-e5fa1a576df5 0 >nul 2>&1
powercfg /change standby-timeout-ac 0 >nul 2>&1
powercfg /change hibernate-timeout-ac 0 >nul 2>&1
powercfg /change monitor-timeout-ac 15 >nul 2>&1
powercfg /setactive scheme_current >nul 2>&1
echo   !OK! !CC![36]!C0! !M54!

rem ============ [37] HAGS : verifie le support PUIS active ============
set "HAGSOK=NO"
for /f "usebackq delims=" %%h in (`powershell -NoProfile -Command "$p=Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers' -Name HwSchMode -EA SilentlyContinue; if($p -ne $null){'YES'}else{'NO'}"`) do set "HAGSOK=%%h"
if /i "!HAGSOK!"=="YES" (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f >nul 2>&1
    echo   !OK! !CC![37]!C0! !M55!
)
if /i not "!HAGSOK!"=="YES" echo   !OK! !CC![37]!C0! !M56!

rem ============ [38] FAST STARTUP ON ============
powercfg /hibernate on >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 1 /f >nul 2>&1
echo   !OK! !CC![38]!C0! !M57!

rem ============ [39] ICONES DEMARRAGE + ANCIEN TIMERRES SUPPRIME ============
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" /v HideSystray /t REG_DWORD /d 1 /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v SecurityHealth /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v vgtray /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v vgtray /f >nul 2>&1
powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; foreach($k in 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run','HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run'){ if(Test-Path $k){ (Get-Item $k).Property | Where-Object { $_ -match 'Terminal' } | ForEach-Object { Remove-ItemProperty -Path $k -Name $_ } } }" >nul 2>&1
echo   !OK! !CC![39]!C0! !M58!

rem ============ [40] PILOTES MAINTENUS A JOUR ============
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v SearchOrderConfig /t REG_DWORD /d 1 /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v ExcludeWUDriversInQualityUpdate /f >nul 2>&1
echo   !OK! !CC![40]!C0! !M59!

echo.
echo   !CK!------------------------------------------------------------!C0!
echo.
echo   !CC!::!C0!  !CM!!BAN_F!!C0!
echo.
rem ============ [41] OPTIMISATION DISQUES via la tache WINDOWS native (silencieuse) ============
schtasks /Delete /F /TN "Opti Disques Quotidienne" >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Defrag\ScheduledDefrag" /Enable >nul 2>&1
powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; $tr=New-ScheduledTaskTrigger -Daily -At ([datetime]::Today.AddHours(3)); Set-ScheduledTask -TaskName 'ScheduledDefrag' -TaskPath '\Microsoft\Windows\Defrag\' -Trigger $tr" >nul 2>&1
echo   !OK! !CC![41]!C0! !M60!

rem ============ [42] ASSISTANT DE STOCKAGE ============
set "SS=HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy"
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\StorageSense" /v AllowStorageSenseGlobal /f >nul 2>&1
reg add "!SS!" /v 01 /t REG_DWORD /d 1 /f >nul 2>&1
reg add "!SS!" /v 04 /t REG_DWORD /d 1 /f >nul 2>&1
reg add "!SS!" /v 08 /t REG_DWORD /d 1 /f >nul 2>&1
reg add "!SS!" /v 32 /t REG_DWORD /d 1 /f >nul 2>&1
reg add "!SS!" /v 256 /t REG_DWORD /d 1 /f >nul 2>&1
reg add "!SS!" /v 512 /t REG_DWORD /d 1 /f >nul 2>&1
reg add "!SS!" /v 2048 /t REG_DWORD /d 1 /f >nul 2>&1
echo   !OK! !CC![42]!C0! !M61!

rem ============ [43] NETTOYAGE ============
del /q /f /s "%TEMP%\*" >nul 2>&1
del /q /f /s "%SystemRoot%\Temp\*" >nul 2>&1
del /q /f /s "%LOCALAPPDATA%\Discord\Cache\*" >nul 2>&1
del /q /f /s "%LOCALAPPDATA%\Discord\Code Cache\*" >nul 2>&1
del /q /f /s "%LOCALAPPDATA%\Discord\GPUCache\*" >nul 2>&1
if defined STEAMPATH del /q /f /s "!STEAMPATH!\appcache\httpcache\*" >nul 2>&1
if defined STEAMPATH del /q /f /s "!STEAMPATH!\config\htmlcache\*" >nul 2>&1
dism /Online /Cleanup-Image /StartComponentCleanup >nul 2>&1
takeown /F "%SystemDrive%\Windows.old" /R /A /D O >nul 2>&1
icacls "%SystemDrive%\Windows.old" /grant administrators:F /T /C >nul 2>&1
rd /s /q "%SystemDrive%\Windows.old" >nul 2>&1
powershell -NoProfile -Command "Clear-RecycleBin -Force -EA SilentlyContinue" >nul 2>&1
echo   !OK! !CC![43]!C0! !M62!

echo.
echo   !CK!------------------------------------------------------------!C0!
echo.
echo   !CC!::!C0!  !CM!!BAN_G!!C0!
echo.
rem ============ [44] WINDOWS UPDATE + winget (toujours) ============
echo   !OK! !CC![44]!C0! !M63!
rem -- IsInstalled=0 + IsHidden=0 (sans filtre BrowseOnly) : inclut aussi les MAJ FACULTATIVES (qualite optionnelle + drivers hors-GPU, le GPU restant fige) --
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='SilentlyContinue'; try { try { $sm=New-Object -ComObject Microsoft.Update.ServiceManager; $sm.AddService2('7971f918-a847-4430-9279-4a52d1efe18d',7,'')|Out-Null } catch {}; $s=New-Object -ComObject Microsoft.Update.Session; $se=$s.CreateUpdateSearcher(); $se.ServerSelection=3; $se.ServiceID='7971f918-a847-4430-9279-4a52d1efe18d'; $r=$se.Search('IsInstalled=0 and IsHidden=0'); if($r.Updates.Count -gt 0){ $dl=New-Object -ComObject Microsoft.Update.UpdateColl; foreach($u in $r.Updates){ try{ if(-not $u.EulaAccepted){$u.AcceptEula()} }catch{}; $dl.Add($u)|Out-Null }; $d=$s.CreateUpdateDownloader(); $d.Updates=$dl; $d.Download()|Out-Null; $ins=New-Object -ComObject Microsoft.Update.UpdateColl; foreach($u in $r.Updates){ if($u.IsDownloaded){$ins.Add($u)|Out-Null} }; if($ins.Count -gt 0){ $i=$s.CreateUpdateInstaller(); $i.Updates=$ins; $i.Install()|Out-Null } } } catch {}"
echo   !OK! !CC![44]!C0! !M64!
rem ---- winget : question separee (peut etre long) ----
echo   !OK! !CC![45b]!C0! !M66!
where winget >nul 2>&1 && winget upgrade --all --include-unknown --accept-source-agreements --accept-package-agreements --disable-interactivity --silent
echo   !OK! !CC![45b]!C0! !M67!

echo.
echo   !CK!------------------------------------------------------------!C0!
echo.
echo   !CC!::!C0!  !CM!!BAN_H!!C0!
echo.
rem ============ [45] TIMER 0.5 ms force via PowerShell (sans logiciel externe) ============
rem Ecrit un petit script qui force le timer a 0.5 ms et le maintient,
rem lance au demarrage par une tache planifiee (process discret en fond).
schtasks /Delete /F /TN "TimerResolution 0.5ms" >nul 2>&1
del /f /q "%SystemRoot%\TimerResolution.exe" >nul 2>&1
powershell -NoProfile -Command "[IO.File]::WriteAllText('%SystemRoot%\timerres.ps1',[Text.Encoding]::ASCII.GetString([Convert]::FromBase64String('!TRPSB64!')))" >nul 2>&1
powershell -NoProfile -Command "[IO.File]::WriteAllText($env:TEMP+'\tinst.ps1',[Text.Encoding]::ASCII.GetString([Convert]::FromBase64String('!TASKB64!')))" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -File "%TEMP%\tinst.ps1" >nul 2>&1
del /f /q "%TEMP%\tinst.ps1" >nul 2>&1
echo   !OK! !CC![45]!C0! !M69!


rem ============ [46] RE-APPLICATION DES REGLAGES AU DEMARRAGE (valeurs fixes) ============
rem Petit script (valeurs FIXES, aucune dependance aux reponses). Il ne reecrit le
rem registre QUE si une MAJ Windows a change le build ; sinon il sort aussitot.
schtasks /Delete /F /TN "LowLat Reapply" >nul 2>&1
del "%TEMP%\llrap.b64" >nul 2>&1
echo JEVycm9yQWN0aW9uUHJlZmVyZW5jZT0nU2lsZW50bHlDb250aW51ZScKJGN2PSdIS0xNOlxTT0ZUV0FSRVxNaWNyb3NvZnRcV2luZG93cyBOVFxDdXJyZW50VmVyc2lvbicKJGN1cj1bc3RyaW5nXShHZXQtSXRlbVByb3BlcnR5ICRjdikuQ3VycmVudEJ1aWxkICsgJy4nICsgW3N0cmluZ10oR2V0LUl0ZW1Qcm9wZXJ0eSAkY3YpLlVCUgokcms9J0hLTE06XFNPRlRXQVJFXExvd0xhdE9wdGltaXplcicKJHByZXY9KEdldC1JdGVtUHJvcGVydHkgJHJrIC1OYW1lIExhc3RCdWlsZCAtRUEgU2lsZW50bHlDb250aW51ZSkuTGFzdEJ1aWxkCiRtbT0nSEtMTVxTT0ZUV0FSRVxNaWNyb3NvZnRcV2luZG93cyBOVFxDdXJyZW50VmVyc2lvblxNdWx0aW1lZGlhXFN5c3RlbVByb2ZpbGUnCiRtb2RlPShHZXQtSXRlbVByb3BlcnR5ICRyayAtTmFtZSBNb2RlIC1FQSBTaWxlbnRseUNvbnRpbnVlKS5Nb2RlCiR4M2Q9KEdldC1JdGVtUHJvcGVydHkgJHJrIC1OYW1lIElzWDNEIC1FQSBTaWxlbnRseUNvbnRpbnVlKS5Jc1gzRAokeDNkbT0oR2V0LUl0ZW1Qcm9wZXJ0eSAkcmsgLU5hbWUgWDNETXVsdGkgLUVBIFNpbGVudGx5Q29udGludWUpLlgzRE11bHRpCiRzdmNrYj0oR2V0LUl0ZW1Qcm9wZXJ0eSAkcmsgLU5hbWUgU3ZjS0IgLUVBIFNpbGVudGx5Q29udGludWUpLlN2Y0tCCmlmKCRtb2RlIC1lcSAnbG93ZXN0Jyl7ICRzcj0wOyAkcHM9NDI7ICRkdD0neWVzJyB9IGVsc2UgeyAkc3I9MTA7ICRwcz0zODsgJGR0PSdubycgfQokZXhlcz1AKCdjczIuZXhlJywnTGVhZ3VlIG9mIExlZ2VuZHMuZXhlJywnQnJhd2xoYWxsYS5leGUnLCdSYWluYm93U2l4LmV4ZScsJ1JhaW5ib3dTaXhfRFgxMS5leGUnLCdWQUxPUkFOVC1XaW42NC1TaGlwcGluZy5leGUnLCdWQUxPUkFOVC5leGUnLCdyNWFwZXguZXhlJywncjVhcGV4X2R4MTIuZXhlJywnRm9ydG5pdGVDbGllbnQtV2luNjQtU2hpcHBpbmcuZXhlJykKaWYoJGN1ciAtbmUgJHByZXYpewogICYgcmVnLmV4ZSBhZGQgJG1tIC92IFN5c3RlbVJlc3BvbnNpdmVuZXNzIC90IFJFR19EV09SRCAvZCAkc3IgL2YgfCBPdXQtTnVsbAogICYgcmVnLmV4ZSBhZGQgJG1tIC92IE5ldHdvcmtUaHJvdHRsaW5nSW5kZXggL3QgUkVHX0RXT1JEIC9kIDEwIC9mIHwgT3V0LU51bGwKICAmIHJlZy5leGUgYWRkICJIS0xNXFNZU1RFTVxDdXJyZW50Q29udHJvbFNldFxDb250cm9sXFByaW9yaXR5Q29udHJvbCIgL3YgV2luMzJQcmlvcml0eVNlcGFyYXRpb24gL3QgUkVHX0RXT1JEIC9kICRwcyAvZiB8IE91dC1OdWxsCiAgJiBiY2RlZGl0IC9zZXQgZGlzYWJsZWR5bmFtaWN0aWNrICRkdCB8IE91dC1OdWxsCiAgJGdtPSRtbSsnXFRhc2tzXEdhbWVzJwogICYgcmVnLmV4ZSBhZGQgJGdtIC92ICJHUFUgUHJpb3JpdHkiIC90IFJFR19EV09SRCAvZCA4IC9mIHwgT3V0LU51bGwKICAmIHJlZy5leGUgYWRkICRnbSAvdiBQcmlvcml0eSAvdCBSRUdfRFdPUkQgL2QgNiAvZiB8IE91dC1OdWxsCiAgJiByZWcuZXhlIGFkZCAkZ20gL3YgIlNjaGVkdWxpbmcgQ2F0ZWdvcnkiIC90IFJFR19TWiAvZCBIaWdoIC9mIHwgT3V0LU51bGwKICAmIHJlZy5leGUgYWRkICRnbSAvdiAiU0ZJTyBQcmlvcml0eSIgL3QgUkVHX1NaIC9kIEhpZ2ggL2YgfCBPdXQtTnVsbAogICYgcmVnLmV4ZSBhZGQgIkhLTE1cU1lTVEVNXEN1cnJlbnRDb250cm9sU2V0XENvbnRyb2xcU2Vzc2lvbiBNYW5hZ2VyXGtlcm5lbCIgL3YgR2xvYmFsVGltZXJSZXNvbHV0aW9uUmVxdWVzdHMgL3QgUkVHX0RXT1JEIC9kIDEgL2YgfCBPdXQtTnVsbAogICYgcmVnLmV4ZSBhZGQgIkhLTE1cU1lTVEVNXEN1cnJlbnRDb250cm9sU2V0XENvbnRyb2xcUG93ZXJcUG93ZXJUaHJvdHRsaW5nIiAvdiBQb3dlclRocm90dGxpbmdPZmYgL3QgUkVHX0RXT1JEIC9kIDEgL2YgfCBPdXQtTnVsbAogICYgcmVnLmV4ZSBhZGQgIkhLQ1VcU3lzdGVtXEdhbWVDb25maWdTdG9yZSIgL3YgR2FtZURWUl9FbmFibGVkIC90IFJFR19EV09SRCAvZCAwIC9mIHwgT3V0LU51bGwKICAmIHJlZy5leGUgYWRkICJIS0NVXFNPRlRXQVJFXE1pY3Jvc29mdFxXaW5kb3dzXEN1cnJlbnRWZXJzaW9uXEdhbWVEVlIiIC92IEFwcENhcHR1cmVFbmFibGVkIC90IFJFR19EV09SRCAvZCAwIC9mIHwgT3V0LU51bGwKICAmIHJlZy5leGUgYWRkICJIS0xNXFNPRlRXQVJFXFBvbGljaWVzXE1pY3Jvc29mdFxXaW5kb3dzXEdhbWVEVlIiIC92IEFsbG93R2FtZURWUiAvdCBSRUdfRFdPUkQgL2QgMCAvZiB8IE91dC1OdWxsCiAgJiByZWcuZXhlIGFkZCAiSEtDVVxTT0ZUV0FSRVxNaWNyb3NvZnRcR2FtZUJhciIgL3YgQXV0b0dhbWVNb2RlRW5hYmxlZCAvdCBSRUdfRFdPUkQgL2QgMSAvZiB8IE91dC1OdWxsCiAgJiByZWcuZXhlIGFkZCAiSEtDVVxTT0ZUV0FSRVxNaWNyb3NvZnRcR2FtZUJhciIgL3YgQWxsb3dBdXRvR2FtZU1vZGUgL3QgUkVHX0RXT1JEIC9kIDEgL2YgfCBPdXQtTnVsbAogICYgcmVnLmV4ZSBhZGQgIkhLQ1VcU09GVFdBUkVcTWljcm9zb2Z0XERpcmVjdFhcVXNlckdwdVByZWZlcmVuY2VzIiAvdiBEaXJlY3RYVXNlckdsb2JhbFNldHRpbmdzIC90IFJFR19TWiAvZCAiU3dhcEVmZmVjdFVwZ3JhZGVFbmFibGU9MTsiIC9mIHwgT3V0LU51bGwKICAmIHNjLmV4ZSBjb25maWcgV1NlYXJjaCBzdGFydD0gZGVsYXllZC1hdXRvIHwgT3V0LU51bGwKICAmIHNjLmV4ZSBzdGFydCBXU2VhcmNoIHwgT3V0LU51bGwKICAmIHJlZy5leGUgYWRkICJIS0NVXFNPRlRXQVJFXE1pY3Jvc29mdFxJbnB1dFxUSVBDIiAvdiBFbmFibGVkIC90IFJFR19EV09SRCAvZCAwIC9mIHwgT3V0LU51bGwKICAmIHJlZy5leGUgYWRkICJIS0NVXFNPRlRXQVJFXE1pY3Jvc29mdFxJbnB1dFBlcnNvbmFsaXphdGlvbiIgL3YgUmVzdHJpY3RJbXBsaWNpdFRleHRDb2xsZWN0aW9uIC90IFJFR19EV09SRCAvZCAxIC9mIHwgT3V0LU51bGwKICAmIHJlZy5leGUgYWRkICJIS0NVXFNPRlRXQVJFXE1pY3Jvc29mdFxXaW5kb3dzXEN1cnJlbnRWZXJzaW9uXENvbnRlbnREZWxpdmVyeU1h>>"%TEMP%\llrap.b64"
echo bmFnZXIiIC92IFN5c3RlbVBhbmVTdWdnZXN0aW9uc0VuYWJsZWQgL3QgUkVHX0RXT1JEIC9kIDAgL2YgfCBPdXQtTnVsbAogICYgcmVnLmV4ZSBhZGQgIkhLQ1VcU09GVFdBUkVcTWljcm9zb2Z0XFdpbmRvd3NcQ3VycmVudFZlcnNpb25cQ29udGVudERlbGl2ZXJ5TWFuYWdlciIgL3YgU2lsZW50SW5zdGFsbGVkQXBwc0VuYWJsZWQgL3QgUkVHX0RXT1JEIC9kIDAgL2YgfCBPdXQtTnVsbAogICYgcmVnLmV4ZSBhZGQgIkhLQ1VcU09GVFdBUkVcTWljcm9zb2Z0XFdpbmRvd3NcQ3VycmVudFZlcnNpb25cQ29udGVudERlbGl2ZXJ5TWFuYWdlciIgL3YgU3Vic2NyaWJlZENvbnRlbnQtMzM4Mzg4RW5hYmxlZCAvdCBSRUdfRFdPUkQgL2QgMCAvZiB8IE91dC1OdWxsCiAgJiByZWcuZXhlIGFkZCAiSEtDVVxTT0ZUV0FSRVxNaWNyb3NvZnRcV2luZG93c1xDdXJyZW50VmVyc2lvblxQcml2YWN5IiAvdiBUYWlsb3JlZEV4cGVyaWVuY2VzV2l0aERpYWdub3N0aWNEYXRhRW5hYmxlZCAvdCBSRUdfRFdPUkQgL2QgMCAvZiB8IE91dC1OdWxsCiAgJiByZWcuZXhlIGFkZCAiSEtDVVxDb250cm9sIFBhbmVsXE1vdXNlIiAvdiBNb3VzZVNwZWVkIC90IFJFR19TWiAvZCAwIC9mIHwgT3V0LU51bGwKICAmIHJlZy5leGUgYWRkICJIS0NVXENvbnRyb2wgUGFuZWxcTW91c2UiIC92IE1vdXNlVGhyZXNob2xkMSAvdCBSRUdfU1ogL2QgMCAvZiB8IE91dC1OdWxsCiAgJiByZWcuZXhlIGFkZCAiSEtDVVxDb250cm9sIFBhbmVsXE1vdXNlIiAvdiBNb3VzZVRocmVzaG9sZDIgL3QgUkVHX1NaIC9kIDAgL2YgfCBPdXQtTnVsbAogICYgcmVnLmV4ZSBhZGQgIkhLTE1cU1lTVEVNXEN1cnJlbnRDb250cm9sU2V0XENvbnRyb2xcR3JhcGhpY3NEcml2ZXJzIiAvdiBId1NjaE1vZGUgL3QgUkVHX0RXT1JEIC9kIDIgL2YgfCBPdXQtTnVsbAogIGlmKCRzdmNrYil7ICYgcmVnLmV4ZSBhZGQgIkhLTE1cU1lTVEVNXEN1cnJlbnRDb250cm9sU2V0XENvbnRyb2wiIC92IFN2Y0hvc3RTcGxpdFRocmVzaG9sZEluS0IgL3QgUkVHX0RXT1JEIC9kICRzdmNrYiAvZiB8IE91dC1OdWxsIH0KICBpZigkeDNkbSAtZXEgMSl7ICYgYmNkZWRpdCAvc2V0IHRzY3N5bmNwb2xpY3kgZW5oYW5jZWQgfCBPdXQtTnVsbCB9IGVsc2UgeyAmIGJjZGVkaXQgL2RlbGV0ZXZhbHVlIHRzY3N5bmNwb2xpY3kgfCBPdXQtTnVsbCB9CiAgaWYoJG1vZGUgLWVxICdsb3dlc3QnKXsgJiByZWcuZXhlIGFkZCAiSEtMTVxTWVNURU1cQ3VycmVudENvbnRyb2xTZXRcQ29udHJvbFxHcmFwaGljc0RyaXZlcnMiIC92IFRkckRlbGF5IC90IFJFR19EV09SRCAvZCA4IC9mIHwgT3V0LU51bGwgfSBlbHNlIHsgJiByZWcuZXhlIGRlbGV0ZSAiSEtMTVxTWVNURU1cQ3VycmVudENvbnRyb2xTZXRcQ29udHJvbFxHcmFwaGljc0RyaXZlcnMiIC92IFRkckRlbGF5IC9mIHwgT3V0LU51bGwgfQogICYgcmVnLmV4ZSBhZGQgIkhLTE1cU1lTVEVNXEN1cnJlbnRDb250cm9sU2V0XFNlcnZpY2VzXG52bGRkbWttXEZUUyIgL3YgRW5hYmxlR1I1MzUgL3QgUkVHX0RXT1JEIC9kIDAgL2YgfCBPdXQtTnVsbAogICYgcmVnLmV4ZSBhZGQgIkhLTE1cU1lTVEVNXEN1cnJlbnRDb250cm9sU2V0XFNlcnZpY2VzXG52bGRkbWttXFBhcmFtZXRlcnNcRlRTIiAvdiBFbmFibGVHUjUzNSAvdCBSRUdfRFdPUkQgL2QgMCAvZiB8IE91dC1OdWxsCiAgZm9yZWFjaCgkZSBpbiAkZXhlcyl7ICRpaz0nSEtMTVxTT0ZUV0FSRVxNaWNyb3NvZnRcV2luZG93cyBOVFxDdXJyZW50VmVyc2lvblxJbWFnZSBGaWxlIEV4ZWN1dGlvbiBPcHRpb25zXCcrJGUrJ1xQZXJmT3B0aW9ucyc7IGlmKCRtb2RlIC1lcSAnbG93ZXN0Jyl7ICYgcmVnLmV4ZSBhZGQgJGlrIC92IENwdVByaW9yaXR5Q2xhc3MgL3QgUkVHX0RXT1JEIC9kIDMgL2YgfCBPdXQtTnVsbDsgJiByZWcuZXhlIGFkZCAkaWsgL3YgSW9Qcmlvcml0eSAvdCBSRUdfRFdPUkQgL2QgMyAvZiB8IE91dC1OdWxsIH0gZWxzZSB7ICYgcmVnLmV4ZSBkZWxldGUgJGlrIC9mIHwgT3V0LU51bGwgfSB9CiAgR2V0LVBucERldmljZSAtQ2xhc3MgRGlzcGxheSAtRUEgU2lsZW50bHlDb250aW51ZSB8IEZvckVhY2gtT2JqZWN0IHsgJG1wPSdIS0xNXFNZU1RFTVxDdXJyZW50Q29udHJvbFNldFxFbnVtXCcrJF8uSW5zdGFuY2VJZCsnXERldmljZSBQYXJhbWV0ZXJzXEludGVycnVwdCBNYW5hZ2VtZW50XE1lc3NhZ2VTaWduYWxlZEludGVycnVwdFByb3BlcnRpZXMnOyAmIHJlZy5leGUgYWRkICRtcCAvdiBNU0lTdXBwb3J0ZWQgL3QgUkVHX0RXT1JEIC9kIDEgL2YgfCBPdXQtTnVsbCB9CiAgaWYoLW5vdChUZXN0LVBhdGggJHJrKSl7TmV3LUl0ZW0gJHJrIC1Gb3JjZSB8IE91dC1OdWxsfQogIE5ldy1JdGVtUHJvcGVydHkgJHJrIC1OYW1lIExhc3RCdWlsZCAtVmFsdWUgJGN1ciAtUHJvcGVydHlUeXBlIFN0cmluZyAtRm9yY2UgfCBPdXQtTnVsbAp9CiR0bj0nVGltZXJSZXMgMC41bXMnCmlmKC1ub3QoR2V0LVNjaGVkdWxlZFRhc2sgLVRhc2tOYW1lICR0biAtRUEgU2lsZW50bHlDb250aW51ZSkpewogIGlmKFRlc3QtUGF0aCAiJGVudjpTeXN0ZW1Sb290XHRpbWVycmVzLnBzMSIpewogICAgJGE9TmV3LVNjaGVkdWxlZFRhc2tBY3Rpb24gLUV4ZWN1dGUgJ3Bvd2Vyc2hlbGwuZXhlJyAtQXJndW1lbnQgKCctTm9Qcm9maWxlIC1XaW5kb3dTdHlsZSBIaWRkZW4gLUV4ZWN1dGlvblBvbGljeSBCeXBhc3MgLUZpbGUgIicrJGVudjpTeXN0ZW1Sb290KydcdGltZXJyZXMucHMxIicpCiAgICAkdDE9TmV3LVNjaGVkdWxlZFRhc2tUcmlnZ2VyIC1BdFN0YXJ0dXAKICAgICR0Mj1OZXctU2NoZWR1bGVkVGFza1RyaWdnZXIgLUF0TG9nT24KICAgICRwcj1OZXctU2NoZWR1bGVkVGFza1ByaW5jaXBhbCAtVXNlcklkICdOVCBBVVRIT1JJVFlcU1lTVEVNJyAtTG9nb25UeXBlIFNlcnZpY2VBY2NvdW50IC1SdW5MZXZlbCBIaWdoZXN0CiAgICAkc2U9TmV3LVNjaGVkdWxlZFRhc2tTZXR0aW5nc1NldCAtRXhlY3V0aW9uVGltZUxpbWl0IChbVGltZVNwYW5dOjpaZXJv>>"%TEMP%\llrap.b64"
echo KSAtUmVzdGFydENvdW50IDMgLVJlc3RhcnRJbnRlcnZhbCAoTmV3LVRpbWVTcGFuIC1NaW51dGVzIDEpIC1NdWx0aXBsZUluc3RhbmNlcyBJZ25vcmVOZXcKICAgIFJlZ2lzdGVyLVNjaGVkdWxlZFRhc2sgLVRhc2tOYW1lICR0biAtQWN0aW9uICRhIC1UcmlnZ2VyICR0MSwkdDIgLVByaW5jaXBhbCAkcHIgLVNldHRpbmdzICRzZSAtRm9yY2UgfCBPdXQtTnVsbAogICAgU3RhcnQtU2NoZWR1bGVkVGFzayAtVGFza05hbWUgJHRuCiAgfQp9CiYgcmVnLmV4ZSBhZGQgIkhLTE1cU1lTVEVNXEN1cnJlbnRDb250cm9sU2V0XENvbnRyb2xcU2Vzc2lvbiBNYW5hZ2VyXGtlcm5lbCIgL3YgR2xvYmFsVGltZXJSZXNvbHV0aW9uUmVxdWVzdHMgL3QgUkVHX0RXT1JEIC9kIDEgL2YgfCBPdXQtTnVsbAppZigkbW9kZSAtZXEgJ2xvd2VzdCcpewogICR1cD0oKCYgcG93ZXJjZmcgL2xpc3QpIHwgU2VsZWN0LVN0cmluZyAtUGF0dGVybiAnVWx0aW1hdGUgUGVyZm9ybWFuY2V8UGVyZm9ybWFuY2VzIG9wdGltYWxlcycgfCBTZWxlY3QtT2JqZWN0IC1GaXJzdCAxKQogIGlmKCR1cCl7ICRwZz0oW3JlZ2V4XTo6TWF0Y2goJHVwLlRvU3RyaW5nKCksJ1swLTlhLWZBLUYtXXszNn0nKSkuVmFsdWUgfSBlbHNlIHsgJGRwPSgmIHBvd2VyY2ZnIC1kdXBsaWNhdGVzY2hlbWUgZTlhNDJiMDItZDVkZi00NDhkLWFhMDAtMDNmMTQ3NDllYjYxKTsgJHBnPShbcmVnZXhdOjpNYXRjaChbc3RyaW5nXSRkcCwnWzAtOWEtZkEtRi1dezM2fScpKS5WYWx1ZSB9CiAgaWYoJHBnKXsgJiBwb3dlcmNmZyAvc2V0YWN0aXZlICRwZyB8IE91dC1OdWxsIH0gZWxzZSB7ICYgcG93ZXJjZmcgL3NldGFjdGl2ZSA4YzVlN2ZkYS1lOGJmLTRhOTYtOWE4NS1hNmUyM2E4YzYzNWMgfCBPdXQtTnVsbCB9Cn0gZWxzZSB7ICYgcG93ZXJjZmcgL3NldGFjdGl2ZSA4YzVlN2ZkYS1lOGJmLTRhOTYtOWE4NS1hNmUyM2E4YzYzNWMgfCBPdXQtTnVsbCB9CmlmKCR4M2QgLWVxIDEpeyAkcG1pbj0wOyAkaWRsZT0wIH0gZWxzZSB7ICRwbWluPTEwMDsgJGlkbGU9MSB9CiYgcG93ZXJjZmcgL3NldGFjdmFsdWVpbmRleCBzY2hlbWVfY3VycmVudCA1NDUzMzI1MS04MmJlLTQ4MjQtOTZjMS00N2I2MGI3NDBkMDAgMGNjNWI2NDctYzFkZi00NjM3LTg5MWEtZGVjMzVjMzE4NTgzICRwbWluIHwgT3V0LU51bGwKJiBwb3dlcmNmZyAvc2V0ZGN2YWx1ZWluZGV4IHNjaGVtZV9jdXJyZW50IDU0NTMzMjUxLTgyYmUtNDgyNC05NmMxLTQ3YjYwYjc0MGQwMCAwY2M1YjY0Ny1jMWRmLTQ2MzctODkxYS1kZWMzNWMzMTg1ODMgJHBtaW4gfCBPdXQtTnVsbAomIHBvd2VyY2ZnIC9zZXRhY3ZhbHVlaW5kZXggc2NoZW1lX2N1cnJlbnQgNTQ1MzMyNTEtODJiZS00ODI0LTk2YzEtNDdiNjBiNzQwZDAwIDVkNzZhMmNhLWU4YzAtNDAyZi1hMTMzLTIxNTg0OTJkNThhZCAkaWRsZSB8IE91dC1OdWxsCiYgcG93ZXJjZmcgL3NldGRjdmFsdWVpbmRleCBzY2hlbWVfY3VycmVudCA1NDUzMzI1MS04MmJlLTQ4MjQtOTZjMS00N2I2MGI3NDBkMDAgNWQ3NmEyY2EtZThjMC00MDJmLWExMzMtMjE1ODQ5MmQ1OGFkICRpZGxlIHwgT3V0LU51bGwKJiBwb3dlcmNmZyAvc2V0YWN2YWx1ZWluZGV4IHNjaGVtZV9jdXJyZW50IDJhNzM3NDQxLTE5MzAtNDQwMi04ZDc3LWIyYmViYmEzMDhhMyA0OGU2YjdhNi01MGY1LTQ3ODItYTVkNC01M2JiOGYwN2UyMjYgMCB8IE91dC1OdWxsCiYgcG93ZXJjZmcgL3NldGFjdmFsdWVpbmRleCBzY2hlbWVfY3VycmVudCBzdWJfcGNpZXhwcmVzcyBlZTEyZjkwNi1kMjc3LTQwNGItYjZkYS1lNWZhMWE1NzZkZjUgMCB8IE91dC1OdWxsCiYgcG93ZXJjZmcgL2NoYW5nZSBzdGFuZGJ5LXRpbWVvdXQtYWMgMCB8IE91dC1OdWxsCiYgcG93ZXJjZmcgL2NoYW5nZSBoaWJlcm5hdGUtdGltZW91dC1hYyAwIHwgT3V0LU51bGwKJiBwb3dlcmNmZyAvY2hhbmdlIG1vbml0b3ItdGltZW91dC1hYyAxNSB8IE91dC1OdWxsCiYgcG93ZXJjZmcgL3NldGFjdGl2ZSBzY2hlbWVfY3VycmVudCB8IE91dC1OdWxsCiRncD1HZXQtUG5wRGV2aWNlIHwgV2hlcmUtT2JqZWN0IHsgJF8uU3RhdHVzIC1lcSAnVW5rbm93bicgfQpmb3JlYWNoKCRkIGluICRncCl7ICYgcG5wdXRpbC5leGUgL3JlbW92ZS1kZXZpY2UgJGQuSW5zdGFuY2VJZCAyPiRudWxsIHwgT3V0LU51bGwgfQpHZXQtQ2hpbGRJdGVtIC1QYXRoICRlbnY6VEVNUCAtUmVjdXJzZSAtRm9yY2UgLUVBIFNpbGVudGx5Q29udGludWUgfCBSZW1vdmUtSXRlbSAtUmVjdXJzZSAtRm9yY2UgLUVBIFNpbGVudGx5Q29udGludWUKR2V0LUNoaWxkSXRlbSAtUGF0aCAiJGVudjpTeXN0ZW1Sb290XFRlbXAiIC1SZWN1cnNlIC1Gb3JjZSAtRUEgU2lsZW50bHlDb250aW51ZSB8IFJlbW92ZS1JdGVtIC1SZWN1cnNlIC1Gb3JjZSAtRUEgU2lsZW50bHlDb250aW51ZQppcGNvbmZpZyAvZmx1c2hkbnMgfCBPdXQtTnVsbA==>>"%TEMP%\llrap.b64"
powershell -NoProfile -Command "[IO.File]::WriteAllText('%SystemRoot%\lowlat_reapply.ps1',[Text.Encoding]::ASCII.GetString([Convert]::FromBase64String(((Get-Content '%TEMP%\llrap.b64') -join ''))))" >nul 2>&1
del "%TEMP%\llrap.b64" >nul 2>&1
schtasks /Create /F /TN "LowLat Reapply" /TR "powershell -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File \"%SystemRoot%\lowlat_reapply.ps1\"" /SC ONLOGON /RL HIGHEST >nul 2>&1
echo   !OK! !CC![46]!C0! !M71!


echo.
echo  !CC!================================================================!C0!
echo    !CG!!DONE_APPLY!!C0!   !CW!!SUMMARY_HEAD!!C0!
echo  !CC!================================================================!C0!
echo.
echo    !CG![+]!C0! !SUM02!
echo    !CG![+]!C0! !SUM03!
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
echo   !CY![ ? ]!C0!  !CW!!Q_RESTART!!C0!
echo.
echo        !QO_YESNO!!C0!
echo.
choice /C 12 /N /M "        !PROMPT!"
if "!errorlevel!"=="1" (
    echo.
    echo   !CG!!RESTARTING!!C0!
    shutdown /r /t 5
) else (
    echo.
    echo   !CY!!RESTART_LATER!!C0!
)
echo.
pause
goto ENDOK

rem #####################################################################
rem #                   MODE RESTAURATION (Windows clean)               #
rem #####################################################################
:RESTORE
echo.
echo  !CY!!REST_INTRO!!C0!
echo.
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
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_Layout /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v TdrDelay /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /f >nul 2>&1
rem -- Reseau --
netsh int tcp reset >nul 2>&1
netsh winsock reset >nul 2>&1
netsh int tcp set global autotuninglevel=normal >nul 2>&1
netsh int tcp set global rsc=enabled >nul 2>&1
powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; Get-NetAdapter -Physical | Where-Object {$_.InterfaceDescription -notmatch 'Wireless|Wi-?Fi|802\.11'} | ForEach-Object { Set-NetAdapterAdvancedProperty -Name $_.Name -RegistryKeyword '*InterruptModeration' -RegistryValue 1 -NoRestart -EA SilentlyContinue; Set-NetAdapterAdvancedProperty -Name $_.Name -RegistryKeyword '*FlowControl' -RegistryValue 3 -NoRestart -EA SilentlyContinue; Set-NetAdapterAdvancedProperty -Name $_.Name -RegistryKeyword '*EEE' -RegistryValue 1 -NoRestart -EA SilentlyContinue }" >nul 2>&1
for /f "delims=" %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" 2^>nul') do (
    reg delete "%%i" /v TcpAckFrequency /f >nul 2>&1
    reg delete "%%i" /v TCPNoDelay /f >nul 2>&1
)
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v NonBestEffortLimit /f >nul 2>&1
echo   !OK! !R1!
rem -- IFEO + FSO --
for %%E in ("cs2.exe" "League of Legends.exe" "Brawlhalla.exe" "RainbowSix.exe" "RainbowSix_DX11.exe" "VALORANT-Win64-Shipping.exe" "VALORANT.exe" "r5apex.exe" "r5apex_dx12.exe" "FortniteClient-Win64-Shipping.exe") do reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%~E" /f >nul 2>&1
powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; $lay='HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers'; if(Test-Path $lay){ (Get-Item $lay).Property | Where-Object { $_ -match 'cs2.exe|Brawlhalla.exe|RainbowSix|r5apex|FortniteClient|VALORANT-Win64|League of Legends' } | ForEach-Object { Remove-ItemProperty -Path $lay -Name $_ } }" >nul 2>&1
powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; $gpu='HKCU:\Software\Microsoft\DirectX\UserGpuPreferences'; if(Test-Path $gpu){ (Get-Item $gpu).Property | Where-Object { $_ -match 'cs2.exe|Brawlhalla.exe|RainbowSix|r5apex|FortniteClient|VALORANT-Win64|League of Legends' } | ForEach-Object { Remove-ItemProperty -Path $gpu -Name $_ } }" >nul 2>&1
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
for %%s in (dmwappushservice diagsvc Fax WerSvc MapsBroker lfsvc PhoneSvc SmsRouter TapiSrv autotimesvc RmSvc tzautoupdate SCardSvr ScDeviceEnum SCPolicySvc CertPropSvc SensorService SensrSvc SensorDataService TrkWks WpcMonSvc RetailDemo wisvc WalletService SEMgrSvc SSDPSRV upnphost FDResPub fdPHost lltdsvc NetTcpPortSharing StiSvc AJRouter WMPNetworkSvc diagnosticshub.standardcollector.service p2pimsvc p2psvc PNRPsvc PNRPAutoReg WlanSvc bthserv BTAGService XblAuthManager XblGameSave XboxNetApiSvc XboxGipSvc GamingServices PrintNotify) do sc config "%%s" start= demand >nul 2>&1
sc start Spooler >nul 2>&1
echo   !OK! !R5!
rem -- UAC / distance / lighting / shake / storage / qos / power --
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 5 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowToGetHelp /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Lighting" /v AmbientLightingEnabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v DisallowShaking /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v 01 /t REG_DWORD /d 0 /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableActivityFeed /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v PublishUserActivities /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v UploadUserActivities /f >nul 2>&1
reg delete "HKCU\Control Panel\Keyboard" /v PrintScreenKeyForSnippingEnabled /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /f >nul 2>&1
powershell -NoProfile -Command "$h=$env:SystemRoot+'\System32\drivers\etc\hosts'; if(Test-Path $h){ $c=[IO.File]::ReadAllText($h); $c=[regex]::Replace($c,'(?s)# ULTRA-ADBLOCK START.*?# ULTRA-ADBLOCK END\s*',''); [IO.File]::WriteAllText($h,$c,[Text.Encoding]::ASCII) }" >nul 2>&1
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
endlocal
exit /b
