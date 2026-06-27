@echo off
chcp 1252 >nul
setlocal EnableDelayedExpansion

rem ===== auto-elevation =====
net session >nul 2>&1
if errorlevel 1 (
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs" >nul 2>&1
    exit /b
)

rem ===== couleurs ANSI =====
for /f %%E in ('echo prompt $E ^| cmd') do set "ESC=%%E"
set "C0=!ESC![0m"
set "CG=!ESC![92m"
set "CR=!ESC![91m"
set "CY=!ESC![93m"
set "CW=!ESC![97m"
set "CK=!ESC![90m"
set "CC=!ESC![96m"
set "CO=!ESC![38;5;208m"
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
set "ISX3D="
set "ISLAP="
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\LowLatOptimizer" /v Mode 2^>nul ^| findstr /i /c:"REG_"') do set "MODE=%%a"
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\LowLatOptimizer" /v IsX3D 2^>nul ^| findstr /i /c:"REG_"') do set "ISX3D=%%a"
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\LowLatOptimizer" /v IsLaptop 2^>nul ^| findstr /i /c:"REG_"') do set "ISLAP=%%a"

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
set "X3DMULTI="
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\LowLatOptimizer" /v X3DMulti 2^>nul ^| findstr /i /c:"REG_"') do set "X3DMULTI=%%a"
if "!X3DMULTI!"=="0x1" set "X3DMULTI=1"
if "!X3DMULTI!"=="0x0" set "X3DMULTI=0"
if not defined X3DMULTI set "X3DMULTI=?"
set "SVCKB="
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\LowLatOptimizer" /v SvcKB 2^>nul ^| findstr /i /c:"REG_"') do set "SVCKB=%%a"
if defined SVCKB set /a SVCKB=SVCKB 2>nul

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

set "EXPGTR=1"
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
call :ckdw "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" EnableSuperfetch 3 "EnableSuperfetch ........"
set "EXPSVC=show"
if not "!SVCKB!"=="" if not "!SVCKB!"=="?" set "EXPSVC=!SVCKB!"
call :ckdw "HKLM\SYSTEM\CurrentControlSet\Control" SvcHostSplitThresholdInKB !EXPSVC! "SvcHostSplitThreshold ..."

echo.
echo   !CO! !H6!!C0!
call :ckdw "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" Priority 6 "MMCSS Games priority ...."

echo.
echo   !CO! !H7!!C0!
call :cksz "HKCU\Control Panel\Mouse" MouseSpeed "0" "Mouse accel (speed) ....."
call :cksz "HKCU\Control Panel\Mouse" MouseThreshold1 "0" "Mouse threshold 1 ......."
call :cksz "HKCU\Control Panel\Mouse" MouseThreshold2 "0" "Mouse threshold 2 ......."
call :cksz "HKCU\Control Panel\Mouse" MouseSensitivity "10" "Mouse sensitivity ......."
call :ckdw "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" MouseDataQueueSize 128 "Mouse queue size ........"
call :ckdw "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" KeyboardDataQueueSize 128 "Keyboard queue size ....."

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
call :ckdw "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" EnableVirtualizationBasedSecurity 1 "VBS enabled ............."
call :ckdw "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" Enabled 1 "HVCI memory integrity ..."
call :ckdw "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" ConsentPromptBehaviorAdmin 0 "UAC admin prompt (0) ...."
call :ckdw "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" PromptOnSecureDesktop 0 "UAC secure desktop(0) ..."
call :ckdw "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" fDenyTSConnections 1 "RDP disabled ..........."

echo.
echo   !CO! !H10!!C0!
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" AllowTelemetry 0 "Telemetry (policy) ......"
call :ckdw "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" AllowTelemetry 0 "Telemetry (cv) .........."
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" DODownloadMode 0 "Delivery Optimization ..."
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" DisableAIDataAnalysis 1 "Recall off .............."
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" DisableWindowsConsumerFeatures 1 "Consumer features off ..."
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" BingSearchEnabled 0 "Bing search off ........."
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" AllowGameDVR 0 "GameDVR policy off ......"
call :ckdw "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" AppCaptureEnabled 0 "App capture off ........."
call :ckdw "HKCU\SOFTWARE\Microsoft\GameBar" AutoGameModeEnabled 1 "Game Mode on ............"
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Edge" StartupBoostEnabled 0 "Edge startup boost off .."

echo.
echo   !CO! !H11!!C0!
call :ckdw "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" FeatureSettingsOverride absent "Mitigations override ...."
call :ckdw "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" FeatureSettingsOverrideMask absent "Mitigations mask ........"
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" ExcludeWUDriversInQualityUpdate absent "WU drivers excluded ...."
call :ckdw "HKLM\SOFTWARE\Policies\Microsoft\Windows\StorageSense" AllowStorageSenseGlobal absent "StorageSense global ....."

echo.
echo   !CO! !H12!!C0!
call :cksvc DiagTrack 4 "DiagTrack (telemetry) ..."
call :cksvc dmwappushservice 4 "dmwappushservice ......."
call :cksvci BTAGService "BTAGService ............."
call :cksvci bthserv "bthserv (Bluetooth) ....."
call :cksvci GamingServices "GamingServices .........."
call :cksvci XblAuthManager "XblAuthManager .........."
call :cksvci XblGameSave "XblGameSave ............."
call :cksvci XboxGipSvc "XboxGipSvc .............."
call :cksvci XboxNetApiSvc "XboxNetApiSvc ..........."
call :cksvci PrintNotify "PrintNotify ............."
call :cksvci Spooler "Spooler (printing) ......"
call :cksvci WlanSvc "WlanSvc (Wi-Fi) ........."
call :cksvc SysMain 2 "SysMain (auto, kept) ..."
echo.
echo   !CK! ------------------------------------------------------------!C0!
echo   !CW! !LRS! : !CG!!OKC!!CW! / !TOT! !LGR!!C0!
echo   !CK! !LNO!!C0!
echo.
echo   !CK! !LTI!!C0!
echo.
pause
exit /b

rem ============================================================
rem  Sous-routine : verifie un REG_DWORD
rem  %~1=cle  %~2=valeur  %~3=attendu(decimal) ou "show"  %~4=label
rem ============================================================
:ckdw
set "cur="
for /f "tokens=3" %%a in ('reg query "%~1" /v %~2 2^>nul ^| findstr /i /c:"REG_"') do set "cur=%%a"
set /a TOT+=1
if /i "%~3"=="absent" goto ckdw_wantabs
if not defined cur goto ckdw_absent
if "%~3"=="show" goto ckdw_show
set /a curd=cur 2>nul
if !curd! EQU %~3 goto ckdw_ok
echo   !CR! [!LF!]!C0! %~4 !CW!!curd!!C0!  ^(!LEX!: %~3^)
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
echo   !CC! [info]!C0! %~4 !CW!!cur!!C0!
set /a OKC+=1
goto :eof
:ckdw_absent
echo   !CR! [!LF!]!C0! %~4 !CR!absent!C0!  ^(!LEX!: %~3^)
goto :eof

:cksz
set "cur="
for /f "tokens=2*" %%a in ('reg query "%~1" /v %~2 2^>nul ^| findstr /i /c:"REG_SZ"') do set "cur=%%b"
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
