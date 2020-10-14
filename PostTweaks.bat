@echo off
setlocal enabledelayedexpansion
mode con lines=20 cols=125
cd /d "%~dp0"
chcp 65001 >nul 2>&1

set VERSION=1.0
set VERSION_INFO=31/10/2020
title Post Tweaks

openfiles >nul 2>&1
if !ERRORLEVEL! neq 0 (
    echo [40;90mYou are not running as [40;31mAdministrator[40;90m...
    echo This batch cannot do it's job without elevation!
    echo.
    echo Right-click and select [40;33m^'Run as Administrator^' [40;90mand try again...
    echo.
    echo Press any key to exit . . .
    pause >nul && exit
)

whoami /user | find /i "S-1-5-18" >nul 2>&1
if !ERRORLEVEL! neq 0 call "modules\nsudo.exe" -U:T -P:E -UseCurrentConsole "%~dpnx0" && exit

ping -n 1 "google.com" >nul 2>&1
if !ERRORLEVEL! neq 0 (
    echo [40;31mERROR: [40;90mNo internet connection found
    echo.
    echo Please make sure you are connected to the internet and try again . . .
    pause >nul && exit
)

set "NEEDEDFILES=modules/7z.exe modules/7z.dll modules/choicebox.exe modules/smartctl.exe modules/nsudo.exe modules/devicecleanup.exe resources/procexp.exe resources/ExtremePerformance.pow resources/1usmus.pow resources/SetTimerResolutionService.exe resources/StartIsBack.exe resources/SDL.dll resources/nvdrsdb0.bin resources/nvdrsdb1.bin"
for %%i in (!NEEDEDFILES!) do (
    if not exist %%i (
        set "MISSINGFILES=True"
        echo [40;31mERROR: [40;33m%%i [40;90mis missing
        echo.
    )
)
if "!MISSINGFILES!"=="True" echo Downloading missing files please wait...[40;33m
for %%i in (!NEEDEDFILES!) do (
    if not exist %%i (
        call :CURL -L --progress-bar "https://raw.githubusercontent.com/ArtanisInc/Post-Tweaks/main/%%i" --create-dirs -o "%%i"
    )
)

set NVERSION=0
set NVERSION_INFO=0

call :CURL --silent "https://raw.githubusercontent.com/ArtanisInc/Post-Tweaks/main/version.txt" --create-dirs -o "version.txt"
if !ERRORLEVEL! equ 0 (
    for /f "tokens=1 delims= " %%i in (version.txt) do set NVERSION=%%i
    for /f "tokens=1,2 delims= " %%i in (version.txt) do set NVERSION_INFO=%%j
)

if /i !VERSION! lss !NVERSION! (
    echo.
    echo    [40;90mA new version of Post Tweaks is available on the official repo.
    echo.
    echo    Current version:   [40;33m!VERSION![40;90m - [40;33m!VERSION_INFO![40;90m
    echo    Latest version:    [40;33m!NVERSION![40;90m - [40;33m!NVERSION_INFO![40;90m
    echo.
    echo Auto-download latest version now? [[40;33mYes[40;90m^/[40;33mNo[40;90m][40;33m
    choice /c yn /n /m "" /t 25 /d y
    if !ERRORLEVEL! equ 1 (
        cls
        echo.
        echo Updating to the latest version, please wait...
        echo.
        call :CURL -L --progress-bar "https://github.com/ArtanisInc/Post-Tweaks/archive/main.zip" --create-dirs -o "main.zip"
        call "modules\7z.exe" x -aoa "main.zip" >nul 2>&1
        del /f /q "main.zip" >nul 2>&1
        rd /s /q "modules" >nul 2>&1
        rd /s /q "resources" >nul 2>&1
        move "Post-Tweaks-main\modules" "modules" >nul 2>&1
        move "Post-Tweaks-main\resources" "resources" >nul 2>&1
        move "Post-Tweaks-main\PostTweaks.bat" "PostTweaks.bat" >nul 2>&1
        rd /s /q "Post-Tweaks-main" >nul 2>&1
        del /f /q "version.txt" >nul 2>&1
        if exist "PostTweaks.bat" call "modules\nsudo.exe" -U:T -P:E "%~dpnx0" && exit
    )
    cls
)

:MAIN_MENU
MODE CON LINES=27 COLS=125
echo.
echo [40;90m
echo                   [40;31m██████[40;37m╗  [40;31m██████[40;37m╗ [40;31m███████[40;37m╗[40;31m████████[40;37m╗    [40;31m████████[40;37m╗[40;31m██[40;37m╗    [40;31m██[40;37m╗[40;31m███████[40;37m╗ [40;31m█████[40;37m╗ [40;31m██[40;37m╗  [40;31m██[40;37m╗[40;31m███████[40;37m╗
echo                   [40;31m██[40;37m╔══[40;31m██[40;37m╗[40;31m██[40;37m╔═══[40;31m██[40;37m╗[40;31m██[40;37m╔════╝╚══[40;31m██[40;37m╔══╝    ╚══[40;31m██[40;37m╔══╝[40;31m██[40;37m║    [40;31m██[40;37m║[40;31m██[40;37m╔════╝[40;31m██[40;37m╔══[40;31m██[40;37m╗[40;31m██[40;37m║ [40;31m██[40;37m╔╝[40;31m██[40;37m╔════╝
echo                   [40;31m██████[40;37m╔╝[40;31m██[40;37m║   [40;31m██[40;37m║[40;31m███████[40;37m╗   [40;31m██[40;37m║          [40;31m██[40;37m║   [40;31m██[40;37m║ [40;31m█[40;37m╗ [40;31m██[40;37m║[40;31m█████[40;37m╗  [40;31m███████[40;37m║[40;31m█████[40;37m╔╝ [40;31m███████[40;37m╗
echo                   [40;31m██[40;37m╔═══╝ [40;31m██[40;37m║   [40;31m██[40;37m║╚════[40;31m██[40;37m║   [40;31m██[40;37m║          [40;31m██[40;37m║   [40;31m██[40;37m║[40;31m███[40;37m╗[40;31m██[40;37m║[40;31m██[40;37m╔══╝  [40;31m██[40;37m╔══[40;31m██[40;37m║[40;31m██[40;37m╔═[40;31m██[40;37m╗ [40;37m╚════[40;31m██[40;37m║
echo                   [40;31m██[40;37m║     ╚[40;31m██████[40;37m╔╝[40;31m███████[40;37m║   [40;31m██[40;37m║          [40;31m██[40;37m║   ╚[40;31m███[40;37m╔[40;31m███[40;37m╔╝[40;31m███████[40;37m╗[40;31m██[40;37m║  [40;31m██[40;37m║[40;31m██[40;37m║  [40;31m██[40;37m╗[40;31m███████[40;37m║
echo                   [40;37m╚═╝      ╚═════╝ ╚══════╝   ╚═╝          ╚═╝    ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝
echo.
echo                    [40;95m╔═════════════════════════════════════════════════════════════════════════════════════╗
echo                    ║                [4m[40;91mv!version![40;95m[40;24m                [40;31m█[43;30m MAIN MENU [40;31m█[40;95m        [4m[91mWelcome %username%[40;95m[40;24m             ║
echo                    ╚═════════════════════════════════════════════════════════════════════════════════════╝
echo.
echo                            [ [40;33m1[40;95m ] [40;37mSYSTEM TWEAKS[40;95m                            [ [40;33m2[40;95m ] [40;37mSOFTWARE INSTALLER[40;95m
echo.
echo                                                         [ [40;33m3[40;95m ] [40;37mTOOLS[40;95m
echo.
echo                    ╔══════════════════════════════════════════╦══════════════════════════════════════════╗
echo                    ║     [40;33mC[40;95m  ^> [40;37m Credits[40;95m[40;24m                        ║              [40;33mG[40;95m  ^>  [4m[40;91mGithub repository[40;95m[40;24m     ║
echo                    ╚══════════════════════════════════════════╩══════════════════════════════════════════╝
echo.
echo                                                  [40;90mMake your choices or [40;33m"HELP"[40;90m
echo.
set choice=
set /p "choice=[40;33m                                                              "
if "!choice!"=="1" goto SYSTWEAKS
if "!choice!"=="2" goto APPS_MENU_CLEAR
if "!choice!"=="3" goto TOOLS_MENU_CLEAR
if /i "!choice!"=="c" goto CREDITS
if /i "!choice!"=="g" start "" "https://github.com/ArtanisInc/Post-Tweaks" && goto MAIN_MENU
if /i "!choice!"=="h" goto HELP
if /i "!choice!"=="help" goto HELP
echo                                             [40;31mError : [40;33m"!choice!"[40;90m is not a valid choice...
timeout /t 3 /nobreak >nul 2>&1
goto MAIN_MENU


:SYSTWEAKS
call :SETVARIABLES >nul 2>&1

call :MSGBOX "Do you want to create a registry backup and a restore point ?" vbYesNo+vbQuestion "System Restore"
if !ERRORLEVEL! equ 6 (
    wmic /namespace:\\root\default path systemrestore call createrestorepoint "Post Tweaks", 100, 12 >nul 2>&1
    regedit /e "%UserProfile%\desktop\Registry Backup.reg" >nul 2>&1
)

:: Disable User Account Control
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableVirtualization" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableInstallerDetection" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableSecureUIAPaths" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ValidateAdminCodeSignatures" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableUIADesktopToggle" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorUser" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "FilterAdministratorToken" /t REG_DWORD /d "0" /f >nul 2>&1

:: Disable Windows synchronization
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSync" /t Reg_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSyncUserOverride" /t Reg_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableAppSyncSettingSync" /t Reg_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableAppSyncSettingSyncUserOverride" /t Reg_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableApplicationSettingSync" /t Reg_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableApplicationSettingSyncUserOverride" /t Reg_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableCredentialsSettingSync" /t Reg_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableCredentialsSettingSyncUserOverride" /t Reg_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableDesktopThemeSettingSync" /t Reg_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableDesktopThemeSettingSyncUserOverride" /t Reg_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisablePersonalizationSettingSync" /t Reg_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisablePersonalizationSettingSyncUserOverride" /t Reg_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableStartLayoutSettingSync" /t Reg_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableStartLayoutSettingSyncUserOverride" /t Reg_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSyncOnPaidNetwork" /t Reg_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWebBrowserSettingSync" /t Reg_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWebBrowserSettingSyncUserOverride" /t Reg_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWindowsSettingSync" /t Reg_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWindowsSettingSyncUserOverride" /t Reg_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Accessibility" /v "Enabled" /t Reg_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\AppSync" /v "Enabled" /t Reg_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\BrowserSettings" /v "Enabled" /t Reg_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Credentials" /v "Enabled" /t Reg_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\DesktopTheme" /v "Enabled" /t Reg_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language" /v "Enabled" /t Reg_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\PackageState" /v "Enabled" /t Reg_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Personalization" /v "Enabled" /t Reg_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\StartLayout" /v "Enabled" /t Reg_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Windows" /v "Enabled" /t Reg_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" /v "SyncPolicy" /t Reg_DWORD /d "5" /f >nul 2>&1

:: BCDEDIT
bcdedit /set disabledynamictick Yes >nul 2>&1
bcdedit /set useplatformclock No >nul 2>&1
bcdedit /set useplatformtick Yes >nul 2>&1
bcdedit /set tscsyncpolicy Enhanced >nul 2>&1
bcdedit /set nx AlwaysOff >nul 2>&1
bcdedit /set pae ForceDisable >nul 2>&1
bcdedit /set ems No >nul 2>&1
bcdedit /set bootems No >nul 2>&1
bcdedit /set integrityservices disable >nul 2>&1
bcdedit /set tpmbootentropy ForceDisable >nul 2>&1
bcdedit /set debug No >nul 2>&1
bcdedit /set hypervisorlaunchtype Off >nul 2>&1
bcdedit /set disableelamdrivers Yes >nul 2>&1
bcdedit /set firstmegabytepolicy UseAll >nul 2>&1
bcdedit /set avoidlowmemory 0x8000000 >nul 2>&1
bcdedit /set allowedinmemorysettings 0x0 >nul 2>&1
bcdedit /set isolatedcontext No >nul 2>&1
bcdedit /set vsmlaunchtype Off >nul 2>&1
bcdedit /set vm No >nul 2>&1
bcdedit /set nolowmem Yes >nul 2>&1
bcdedit /set x2apicpolicy Enable >nul 2>&1
bcdedit /set configaccesspolicy Default >nul 2>&1
bcdedit /set MSI Default >nul 2>&1
bcdedit /set usephysicaldestination No >nul 2>&1
bcdedit /set usefirmwarepcisettings No >nul 2>&1
bcdedit /set linearaddress57 OptOut >nul 2>&1
bcdedit /set increaseuserva 268435328 >nul 2>&1
bcdedit /set bootmenupolicy Legacy >nul 2>&1
bcdedit /set quietboot Yes >nul 2>&1
bcdedit /set {globalsettings} custom:16000067 true >nul 2>&1
bcdedit /set {globalsettings} custom:16000068 true >nul 2>&1
bcdedit /set {globalsettings} custom:16000069 true >nul 2>&1
bcdedit /timeout 3 >nul 2>&1

:: Enable Windows Components
dism /online /enable-feature /featurename:DesktopExperience /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:LegacyComponents /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:DirectPlay /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:NetFx4-AdvSrvs /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:NetFx3 /all /norestart >nul 2>&1

:: Process Scheduling
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "38" /f >nul 2>&1

:: Disable Mitigations
powershell "ForEach($v in (Get-Command -Name \"Set-ProcessMitigation\").Parameters[\"Disable\"].Attributes.ValidValues){Set-ProcessMitigation -System -Disable $v.ToString()}" >nul 2>&1

:: Disable RAM compression
powershell "Disable-MMAgent -MemoryCompression -ApplicationPreLaunch" >nul 2>&1

:: Disable Meltdown/Spectre patches
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "EnableCfg" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettings" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d "3" /f >nul 2>&1

:: Disable DMA memory protection and cores isolation
reg add "HKLM\SOFTWARE\Policies\Microsoft\FVE" /v "DisableExternalDMAUnderLock" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "HVCIMATRequired" /t REG_DWORD /d "0" /f >nul 2>&1

:: Power settings
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CsEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnergyEstimationEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "PerfCalculateActualUtilization" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "SleepReliabilityDetailedDiagnostics" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EventProcessorEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "QosManagesIdleProcessors" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableVsyncLatencyUpdate" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableSensorWatchdog" /t REG_DWORD /d "1" /f >nul 2>&1

:: Kernel settings
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DpcWatchdogProfileOffset" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DisableExceptionChainValidation" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "KernelSEHOPEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DpcWatchdogPeriod" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MitigationOptions" /t REG_BINARY /d "22222222222222222002000000200000" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MitigationAuditOptions" /t REG_BINARY /d "20000020202022220000000000000000" /f >nul 2>&1

:: MMCSS
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "AlwaysOn" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NoLazyMode" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d "4294967295" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Affinity" /t REG_DWORD /d "7" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Background Only" /t REG_SZ /d "True" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Clock Rate" /t REG_DWORD /d "10000" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "GPU Priority" /t REG_DWORD /d "8" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Priority" /t REG_DWORD /d "6" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Scheduling Category" /t REG_SZ /d "Medium" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "SFIO Priority" /t REG_SZ /d "Normal" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d "10000" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d "18" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d "6" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "Affinity" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "Background Only" /t REG_SZ /d "True" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "BackgroundPriority" /t REG_DWORD /d "24" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "Clock Rate" /t REG_DWORD /d "10000" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "GPU Priority" /t REG_DWORD /d "18" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "Priority" /t REG_DWORD /d "8" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "Latency Sensitive" /t REG_SZ /d "True" /f >nul 2>&1

:: Disable NTFS/ReFS mitigations
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "ProtectionMode" /t REG_DWORD /d "0" /f >nul 2>&1

:: Using big system memory caching to improve microstuttering
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d "1" /f >nul 2>&1

:: Disabling Windows attempt to save as much RAM as possible, such as sharing pages for images, copy-on-write for data pages, and compression
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingCombining" /t REG_DWORD /d "1" /f >nul 2>&1

::Force contiguous memory allocation in the DirectX Graphics Kernel
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "DpiMapIommuContiguous" /t REG_DWORD /d "1" /f >nul 2>&1

:: GPU scheduling
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchedMode" /t REG_DWORD /d "2" /f >nul 2>&1

:: Disable automatic folder type discovery
reg add "HKCU\SOFTWARE\Classes\Local Settings\SOFTWARE\Microsoft\Windows\Shell\Bags\AllFolders\Shell" /v "FolderType" /t REG_SZ /d "NotSpecified" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Classes\Local Settings\SOFTWARE\Microsoft\Windows\Shell\Bags" /f >nul 2>&1

:: Do not use AutoPlay for all media and devices
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" /v "DisableAutoplay" /t REG_DWORD /d "1" /f >nul 2>&1

:: Disable automatic maintenance
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d "1" /f >nul 2>&1

:: Disable Hibernation
reg add "HKLM\System\CurrentControlSet\Control\Power" /v "HibernateEnabled" /t REG_DWORD /d "0" /f >nul 2>&1

:: Disable fast startup
reg add "HKLM\System\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d "0" /f >nul 2>&1

:: Disable Sleep study
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "SleepStudyDisabled" /t REG_DWORD /d "1" /f >nul 2>&1

:: Disable Aero shake
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisallowShaking" /t REG_DWORD /d "1" /f >nul 2>&1

:: Disable Downloads blocking
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v "SaveZoneInformation" /t REG_DWORD /d "1" /f >nul 2>&1

:: Disable Malicious SOFTWARE removal tool from installing
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v "DontOfferThroughWUAU" /t REG_DWORD /d "1" /f >nul 2>&1

:: Change Windows feedback to Never
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d "0" /f >nul 2>&1

:: Disable SigninInfo
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\UserARSO\$SID" /t REG_DWORD /d "1" /f >nul 2>&1

:: Show BSOD details instead of the sad smiley
reg add "HKLM\System\CurrentControlSet\Control\CrashControl" /v "DisplayParameters" /t REG_DWORD /d "1" /f >nul 2>&1

:: Disable Keyboard Toggle
reg add "HKCU\Keyboard Layout\Toggle" /v "Language Hotkey" /t REG_SZ /d "3" /f >nul 2>&1
reg add "HKCU\Keyboard Layout\Toggle" /v "Hotkey" /t REG_SZ /d "3" /f >nul 2>&1
reg add "HKCU\Keyboard Layout\Toggle" /v "Layout Hotkey" /t REG_SZ /d "3" /f >nul 2>&1

:: Disable Snap Assist
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SnapAssist" /t REG_DWORD /d "0" /f >nul 2>&1

:: Disable Administrative shares
reg add "HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareWks" /t REG_DWORD /d "0" /f >nul 2>&1

:: Turn off sleep and lock in power options
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" /v "ShowSleepOption" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" /v "ShowLockOption" /t REG_DWORD /d "0" /f >nul 2>&1

:: Sound communications do nothing
reg add "HKCU\SOFTWARE\Microsoft\Multimedia\Audio" /v "UserDuckingPreference" /t REG_DWORD /d "3" /f >nul 2>&1

:: Speed up start time
reg add "HKCU\AppEvents\Schemes" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "DelayedDesktopSwitchTimeout" /t REG_DWORD /d "0" /f >nul 2>&1

:: Disable network notification icon
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HideSCANetwork" /t REG_DWORD /d "1" /f >nul 2>&1

:: Do not add the "- Shortcut" suffix to the file name of created shortcuts
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "link" /t REG_BINARY /d "00000000" /f >nul 2>&1

:: Disable KB4524752 support notifications
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Gwx" /v "DisableGwx" /t REG_DWORD /d "1" /f >nul 2>&1

:: Disable KB4524752 support notifications
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableOSUpgrade" /t REG_DWORD /d "1" /f >nul 2>&1

:: Always show all icons in the notification area
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "EnableAutoTray" /t REG_DWORD /d "0" /f >nul 2>&1

:: Disable FSO Globally and GameDVR
reg add "HKCU\Software\Microsoft\GameBar" /v "ShowStartupPanel" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\GameBar" /v "GamePanelStartupTipIndex" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\GameBar" /v "UseNexusForGameBarEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehavior" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_DSEBehavior" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKU\.DEFAULT\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg delete "HKCU\System\GameConfigStore\Children" /f >nul 2>&1
reg delete "HKCU\System\GameConfigStore\Parents" /f >nul 2>&1

:: Disable power throttling
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d "1" /f >nul 2>&1

:: Mouse
reg add "HKCU\Control Panel\Mouse" /v "SmoothMouseXCurve" /t REG_BINARY /d "0000000000000000c0cc0c0000000000809919000000000040662600000000000033330000000000" /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "SmoothMouseYCurve" /t REG_BINARY /d "0000000000000000000038000000000000007000000000000000a800000000000000e00000000000" /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "MouseSensitivity" /t REG_SZ /d "10" /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f >nul 2>&1

:: DWM
reg add "HKCU\Software\Microsoft\Windows\DWM" /v "CompositionPolicy" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "Composition" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "EnableWindowColorization" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "EnableAeroPeek" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "AlwaysHibernateThumbnails" /t REG_DWORD /d "0" /f >nul 2>&1

:: Disable Startup Sound
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\BootAnimation" /v "DisableStartupSound" /t REG_DWORD /d "1" /f >nul 2>&1

:: Mouse and Keyboard Buffering
reg add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "MouseDataQueueSize " /t REG_DWORD /d "16" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "KeyboardDataQueueSize" /t REG_DWORD /d "16" /f >nul 2>&1

:: Disable system energy-saving
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\ModernSleep" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul 2>&1

:: Make desktop faster
reg add "HKU\.DEFAULT\Control Panel\Desktop" /v "ForegroundLockTimeout" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKU\.DEFAULT\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKU\.DEFAULT\Control Panel\Desktop" /v "MouseWheelRouting" /t REG_DWORD /d "0" /f >nul 2>&1

:: Acessibility keys
reg add "HKU\.DEFAULT\Control Panel\Accessibility\HighContrast" /v "Flags" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKU\.DEFAULT\Control Panel\Accessibility\Keyboard Response" /v "Flags" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKU\.DEFAULT\Control Panel\Accessibility\MouseKeys" /v "Flags" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKU\.DEFAULT\Control Panel\Accessibility\SoundSentry" /v "Flags" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKU\.DEFAULT\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKU\.DEFAULT\Control Panel\Accessibility\TimeOut" /v "Flags" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKU\.DEFAULT\Control Panel\Accessibility\ToggleKeys" /v "Flags" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\MouseKeys" /v "Flags" /t REG_SZ /d "186" /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\MouseKeys" /v "MaximumSpeed" /t REG_SZ /d "40" /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\MouseKeys" /v "TimeToMaximumSpeed" /t REG_SZ /d "3000" /f >nul 2>&1

:: Visual effects
reg add "HKCU\Control Panel\Desktop" /v "VisualFXSetting" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "DragFullWindows" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "FontSmoothing" /t REG_SZ /d "2" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d "9012038010020000" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShellState" /t REG_BINARY /d "240000003E28000000000000000000000000000001000000130000000000000072000000" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "IconsOnly" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewAlphaSelect" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewShadow" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAnimations" /t REG_DWORD /d "0" /f >nul 2>&1

:: Dark theme
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme" /t REG_DWORD /d "0" /f >nul 2>&1

:: Explorer hide library
reg add "HKCR\CLSID\{031E4825-7B94-4dc3-B131-E946B44C8DD5}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2962227469" /f >nul 2>&1
reg add "HKCR\WOW6432Node\CLSID\{031E4825-7B94-4dc3-B131-E946B44C8DD5}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2962227469" /f >nul 2>&1
:: Explorer hide Favorites
reg add "HKCR\CLSID\{323CA680-C24D-4099-B94D-446DD2D7249E}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2696937728" /f >nul 2>&1
reg add "HKCR\WOW6432Node\CLSID\{323CA680-C24D-4099-B94D-446DD2D7249E}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2696937728" /f >nul 2>&1
:: Explorer hide family group
reg add "HKCR\CLSID\{B4FB3F98-C1EA-428d-A78A-D1F5659CBA93}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2962489612" /f >nul 2>&1
reg add "HKCR\WOW6432Node\CLSID\{B4FB3F98-C1EA-428d-A78A-D1F5659CBA93}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2962489612" /f >nul 2>&1
:: Explorer hide network
reg add "HKCR\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2954100836" /f >nul 2>&1
reg add "HKCR\WOW6432Node\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2954100836" /f >nul 2>&1
:: Explorer hide OneDrive
reg add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder" /v "Attributes" /t REG_DWORD /d "4035969101" /f >nul 2>&1
reg add "HKCR\WOW6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder" /v "Attributes" /t REG_DWORD /d "4035969101" /f >nul 2>&1
:: Explorer hide Quick Access
reg add "HKCR\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2689597440" /f >nul 2>&1
reg add "HKCR\WOW6432Node\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2689597440" /f >nul 2>&1
:: Explorer show file extensions
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d "0" /f >nul 2>&1
:: Explorer show Hidden folders
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d "1" /f >nul 2>&1
:: Explorer disable Recent items and Frequent Places
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d "0" /f >nul 2>&1

:: Taskbar Hide Search box
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d "0" /f >nul 2>&1
:: Taskbar Hide Task View
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d "0" /f >nul 2>&1
:: Taskbar Hide Action Center Tray
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /t REG_DWORD /d "1" /f >nul 2>&1
:: Taskbar Lock
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarSizeMove" /t REG_DWORD /d "0" /f >nul 2>&1
:: Taskbar Hide Contact icon
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v "PeopleBand" /t REG_DWORD /d "0" /f >nul 2>&1
:: Taskbar Disable transparency
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d "0" /f >nul 2>&1
:: Taskbar Disable animations
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAnimations" /t REG_DWORD /d "0" /f >nul 2>&1
:: Taskbar small icons
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarSmallIcons" /t REG_DWORD /d "1" /f >nul 2>&1
:: Taskbar show seconds on the taskbar clock
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSecondsInSystemClock" /t REG_DWORD /d "1" /f >nul 2>&1
:: Taskbar Hide language Bar
reg add "HKCU\SOFTWARE\Microsoft\CTF\LangBar" /v "ShowStatus" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\CTF\LangBar" /v "ExtraIconsOnMinimized" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\CTF\LangBar" /v "Transparency" /t REG_DWORD /d "255" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\CTF\LangBar" /v "Label" /t REG_DWORD /d "0" /f >nul 2>&1
:: Taskbar Hide Windows Ink Workspace
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\PenWorkspace" /v "PenWorkspaceButtonDesiredVisibility" /t REG_DWORD /d "0" /f >nul 2>&1

:: Turn off microsoft peer-to-peer networking services
reg add "HKLM\SOFTWARE\Policies\Microsoft\Peernet" /v "Disabled" /t REG_DWORD /d "0" /f >nul 2>&1

:: Turn off data execution prevention
reg add "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" /v "DEPOff" /t REG_DWORD /d "1" /f >nul 2>&1

:: Display highly detailed status messages
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "VerboseStatus" /t REG_DWORD /d "1" /f >nul 2>&1

:: Trick to make system Startup faster
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v "StartupDelayInMSec" /t REG_DWORD /d "0" /f >nul 2>&1

:: Turn off Pen feedback
reg add "HKLM\SOFTWARE\Policies\Microsoft\TabletPC" /v "TurnOffPenFeedback" /t REG_DWORD /d "1" /f >nul 2>&1

:: Do not offer tailored experiences based on the diagnostic data setting
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "0" /f >nul 2>&1

:: Disable Remote assistance connections
reg add "HKLM\System\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d "0" /f >nul 2>&1

:: Do not allow apps to use advertising ID
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1

:: Do not let apps on other devices open and message apps on this device
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP" /v "RomeSdkChannelUserAuthzPolicy" /t REG_DWORD /d "0" /f >nul 2>&1

:: Do not show the Windows welcome experiences after updates
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d "0" /f >nul 2>&1

:: Do not get tip, trick, and suggestions as you use Windows
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d "0" /f >nul 2>&1

:: Do not show suggested content in the Settings app
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /d "0" /f >nul 2>&1

:: Turn off automatic installing suggested apps
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d "0" /f >nul 2>&1

:: Do not suggest ways I can finish setting up my device to get the most out of Windows
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v "ScoobeSystemSettingEnabled" /t REG_DWORD /d "0" /f >nul 2>&1

:: Do not show recently added apps in the Start menu
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "HideRecentlyAddedApps" /t REG_DWORD /d "1" /f >nul 2>&1

:: Do not show app suggestions in the Start menu
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d "0" /f >nul 2>&1

:: Prevent Windows From Downloading Broken Drivers From Windows Update
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /f >nul 2>&1

:: Old volume layout
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\MTCUVC" /v "EnableMtcUvc" /t REG_DWORD /d "0" /f >nul 2>&1

:: Old Alt Tab
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "AltTabSettings" /t REG_DWORD /d "1" /f >nul 2>&1

:: SvcHostSplitThreshold
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "!TOTAL_MEMORYbis!" /f >nul 2>&1

:: Memory
reg add "HKLM\SYSTEM\currentcontrolset\control\filesystem" /v "ContigFileAllocSize" /t REG_DWORD /d "1536" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\filesystem" /v "DisableDeleteNotification" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\filesystem" /v "DontVerifyRandomDrivers" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\filesystem" /v "FileNameCache" /t REG_DWORD /d "1024" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\filesystem" /v "LongPathsEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\filesystem" /v "NtfsAllowExtendedCharacter8dot3Rename" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\filesystem" /v "NtfsBugcheckOnCorrupt" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\filesystem" /v "NtfsDisable8dot3NameCreation" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\filesystem" /v "NtfsDisableCompression" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\filesystem" /v "NtfsDisableEncryption" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\filesystem" /v "NtfsEncryptPagingFile" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\filesystem" /v "NtfsMemoryUsage" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\filesystem" /v "NtfsMftZoneReservation" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\filesystem" /v "PathCache" /t REG_DWORD /d "128" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\filesystem" /v "RefsDisableLastAccessUpdate" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\filesystem" /v "UdfsSoftwareDefectManagement" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\filesystem" /v "Win31FileSystem" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\executive" /v "AdditionalCriticalWorkerThreads" /t REG_DWORD /d "00000016" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\executive" /v "AdditionalCriticalWorkerThreads" /t REG_DWORD /d "00000016" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\i/o system" /v "CountOperations" /t REG_DWORD /d "00000000" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\memory management" /v "ClearPageFileAtShutdown" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\memory management" /v "FeatureSettingsOverride" REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\memory management" /v "FeatureSettingsOverridemask" REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\memory management" /v "IoPageLockLimit" /t REG_DWORD /d "8000000" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\memory management" /v "LargeSystemCache" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\memory management" /v "SystemPages" /t REG_DWORD /d "4294967295" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\memory management" /v "DisablePagingExecutive" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\memory management\prefetchparameters" /v "EnableBoottrace" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\memory management\prefetchparameters" /v "EnablePrefetcher" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\memory management\prefetchparameters" /v "EnableSuperfetch" /t REG_DWORD /d "0" /f >nul 2>&1

::::::::::::::::::::::::::::::: Set thread-related stuff
reg add "HKLM\System\CurrentControlSet\Control\Session Manager\Executive" /v "AdditionalCriticalWorkerThreads" /T REG_DWORD /d %NUMBER_OF_PROCESSORS% /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Control\Session Manager\Executive" /v "AdditionalDelayedWorkerThreads" /T REG_DWORD /d %NUMBER_OF_PROCESSORS% /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters" /v "MaxWorkItems" /T REG_DWORD /d %NUMBER_OF_PROCESSORS% /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "MaxThreads" /T REG_DWORD /d %NUMBER_OF_PROCESSORS% /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Control\Session Manager\I/O System" /v "PassiveIntRealTimeWorkerCount" /T REG_DWORD /d %NUMBER_OF_PROCESSORS% /f >nul 2>&1
netsh int ip set global loopbackworkercount = %NUMBER_OF_PROCESSORS% >nul 2>&1
bcdedit /set numproc %NUMBER_OF_PROCESSORS% >nul 2>&1
bcdedit /set maxproc Yes >nul 2>&1

:: Disable Windows Customer Experience Improvement Program
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient" /v "CorporateSQMURL" /t REG_SZ /d "0.0.0.0" /f >nul 2>&1

:: Disable Biometrics
reg add "HKLM\SOFTWARE\Policies\Microsoft\Biometrics" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1

:: Windows Error Reporting
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d "1" /f >nul 2>&1

:: Disable SmartScreen
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "0" /f >nul 2>&1

:: Image File Execution for csrss
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "3" /f >nul 2>&1

:: Delete MicrocodeUpdate
del /f /q"%WinDir%\System32\mcupdate_GenuineIntel.dll" >nul 2>&1
del /f /q "%WinDir%\System32\mcupdate_AuthenticAMD.dll" >nul 2>&1

:: Disable performance counter
for %%i in (wsearchidxpi wmiaprpl usbhub ugthrsvc ugatherer termservice
    tcpip spooler "smsvchost 5.0.0.0" "smsvchost 4.0.0.0"
    "smsvchost 3.0.0.0" "servicemodelservice 3.0.0.0" tapisrv
    "windows workflow foundation 3.0.0.0" "windows workflow foundation 4.0.0.0"
    "windows workflow foundation 5.0.0.0" "servicemodeloperation 4.0.0.0"
    "servicemodeloperation 3.0.0.0" "servicemodelendpoint 4.0.0.0"
    "servicemodelendpoint 3.0.0.0" rdyboost perfproc perfnet perfdisk
    outlook msscntrs "msdtc bridge 5.0.0.0" "msdtc bridge 4.0.0.0"
    "msdtc bridge 3.0.0.0" msdtc lsa esent remoteaccess
    bits aspnet_state asp.net_4.0.30319 asp.net ".netframework"
    ".NET CLR Data" ".NET CLR Networking" ".NET CLR Networking 5.0.0.0"
    ".NET CLR Networking 4.0.0.0" ".NET Data Provider for Oracle"
    ".NET Data Provider for SqlServer" ".NET Memory Cache 4.0"
    ".NET Memory Cache 4.1") do lodctr /d:%%i >nul 2>&1

:: Remove ThreadPriority
for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services" /s /f "ThreadPriority"^| findstr /v "ThreadPriority"^| findstr "HKEY"') do reg delete "%%i" /v "ThreadPriority" /f >nul 2>&1

:: Remove ProcessorAffinityMask
for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services" /s /f "ProcessorAffinityMask"^| findstr /v "ProcessorAffinityMask"^| findstr "HKEY"') do reg delete "%%i" /v "ProcessorAffinityMask" /f >nul 2>&1

:: Set all IoLatencyCaps to 0
for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services" /s /f "IoLatencyCap"^| findstr /v "IoLatencyCap"^| findstr "HKEY"') do reg add "%%i" /v "IoLatencyCap" /t REG_DWORD /d "0" /f >nul 2>&1

:: Disable Link power management mode
for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services" /s /f "EnableHIPM"^| findstr /v "EnableHIPM"^| findstr "HKEY"') do (
    reg add "%%i" /v "EnableHIPM" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "%%i" /v "EnableDIPM" /t REG_DWORD /d "0" /f >nul 2>&1
)

:: USB Hubs against power saving
for /f %%i in ('wmic PATH Win32_USBHub GET DeviceID^| findstr /l "VID_"') do (
    reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters" /v "EnhancedPowerManagementEnabled" /T REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters" /v "AllowIdleIrpInD3" /T REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters" /v "DeviceSelectiveSuspended" /T REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters" /v "SelectiveSuspendEnabled" /T REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters" /v "SelectiveSuspendOn" /T REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters" /v "fid_D1Latency" /T REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters" /v "fid_D2Latency" /T REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters" /v "fid_D3Latency" /T REG_DWORD /d "0" /f >nul 2>&1
)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\usbflags" /v "fid_D1Latency" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\usbflags" /v "fid_D2Latency" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\usbflags" /v "fid_D3Latency" /t REG_DWORD /d "0" /f >nul 2>&1
    
:: StorPort against power saving
for /f "tokens=*" %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum" /s /f "StorPort"^| findstr "StorPort"') do reg add "%%i" /v "EnableIdlePowerManagement" /t REG_DWORD /d "0" /f >nul 2>&1

:: Remove IRQ Priorities
for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /f "irq"^| findstr "irq"') do reg delete "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "%%i" /f >nul 2>&1

:: Enable MSI mode & Remove DevicePriority
for /f %%i in ('wmic path Win32_PnPEntity get DeviceID^| findstr /l "VEN_"') do (
    for /f "tokens=*" %%j in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum\%%i" /s /f "MessageSignaledInterruptProperties"^| findstr /e "MessageSignaledInterruptProperties"') do reg add "%%j" /v "MSISupported" /t REG_DWORD /d "1" /f >nul 2>&1
    for /f "tokens=*" %%j in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum\%%i" /s /f "Affinity Policy"^| findstr /e "Affinity Policy"') do reg delete "%%j" /v "DevicePriority" /f >nul 2>&1
)
for /f %%i in ('wmic path win32_VideoController get DeviceID ^| findstr /l "VEN_"') do reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d "1" /f >nul 2>&1

:: Remove priorities of devices
for /f "tokens=*" %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum" /s /f "AssignmentSetOverride"^| findstr "HKEY"') do reg delete "%%i" /v "AssignmentSetOverride" /f >nul 2>&1

:: DedicatedSegmentSize in Intel iGPU
for /f %%i in ('reg query "HKLM\SOFTWARE\Intel" /s /f "GMM"^| findstr "HKEY"') do reg add "%%i" /v "DedicatedSegmentSize" /t REG_DWORD /d "4132" /f >nul 2>&1

:: Use big page file
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False >nul 2>&1
wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=!PAGEFILE!,MaximumSize=!PAGEFILE! >nul 2>&1

:: Text Improvements
reg query "HKLM\SOFTWARE\Microsoft\Avalon.Graphics" /f >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKLM\SOFTWARE\Microsoft\Avalon.Graphics" /v "ClearTypeLevel" /t REG_DWORD /d "100" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Avalon.Graphics" /v "EnhancedContrastLevel" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Avalon.Graphics" /v "GammaLevel" /t REG_DWORD /d "1600" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Avalon.Graphics" /v "GrayscaleEnhancedContrastLevel" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Avalon.Graphics" /v "PixelStructure" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Avalon.Graphics" /v "TextContrastLevel" /t REG_DWORD /d "6" /f >nul 2>&1
)

reg query "HKLM\SOFTWARE\WOW6432Node\Microsoft\Avalon.Graphics" /f >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Avalon.Graphics" /v "ClearTypeLevel" /t REG_DWORD /d "100" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Avalon.Graphics" /v "EnhancedContrastLevel" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Avalon.Graphics" /v "GammaLevel" /t REG_DWORD /d "1600" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Avalon.Graphics" /v "GrayscaleEnhancedContrastLevel" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Avalon.Graphics" /v "PixelStructure" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Avalon.Graphics" /v "TextContrastLevel" /t REG_DWORD /d "6" /f >nul 2>&1
)

reg query "HKCU\SOFTWARE\Microsoft\Avalon.Graphics" /f >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKCU\SOFTWARE\Microsoft\Avalon.Graphics" /v "ClearTypeLevel" /t REG_DWORD /d "100" /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Avalon.Graphics" /v "EnhancedContrastLevel" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Avalon.Graphics" /v "GammaLevel" /t REG_DWORD /d "1600" /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Avalon.Graphics" /v "GrayscaleEnhancedContrastLevel" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Avalon.Graphics" /v "PixelStructure" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Avalon.Graphics" /v "TextContrastLevel" /t REG_DWORD /d "6" /f >nul 2>&1
)

:: Laptop
if "!LAPTOP!"=="False" (
    echo test >nul 2>&1
)

:: SSD specefic
if "!SSD!"=="True" (
    echo test >nul 2>&1
)

:: Nvidia specific
if "!GPU!"=="NVIDIA" (
    ::Low Latency
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "UseGpuTimer" /T REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "RmGpsPsEnablePerCpuCoreDpc" /T REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "PowerSavingTweaks" /T REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableWriteCombining" /T REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "EnableRuntimePowerManagement" /T REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "PrimaryPushBufferSize" /T REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "FlTransitionLatency" /T REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "D3PCLatency" /T REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "RMDeepLlEntryLatencyUsec" /T REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "PciLatencyTimerControl" /T REG_DWORD /d "32" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "Node3DLowLatency" /T REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "LOWLATENCY" /T REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "RmDisableRegistryCaching" /T REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "RMDisablePostL2Compression" /T REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "RmFbsrPagedDMA" /T REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "AdaptiveVsyncEnable" /T REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "AllowDeepCStates" /T REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableGDIAcceleration" /T REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisablePFonDP" /T REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "Disable_OverlayDSQualityEnhancement" /T REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "BuffersInFlight" /T REG_DWORD /d "128" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v Display"!MonitorAmount!"_PipeOptimizationEnable /T REG_DWORD /d "1" /f >nul 2>&1
    :: silk smooth
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v "EnableRID61684" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PreferSystemMemoryContiguous" /t REG_DWORD /d "1" /f >nul 2>&1
    :: kboost
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E968-E325-11CE-BFC1-08002BE10318}\0000" /v "EnableCoreSlowdown" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E968-E325-11CE-BFC1-08002BE10318}\0000" /v "EnableMClkSlowdown" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E968-E325-11CE-BFC1-08002BE10318}\0000" /v "EnableNVClkSlowdown" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E968-E325-11CE-BFC1-08002BE10318}\0000" /v "PerfLevelSrc" /t REG_DWORD /d "2222" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\control\class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "powermizerenable" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\control\class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "powermizerlevel" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\control\class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "powermizerlevelac" /t REG_DWORD /d "1" /f >nul 2>&1
    :: Import Nvidia settings
    taskkill /f /im nvcplui.exe >nul 2>&1
    copy /y "resources\nvdrsdb0.bin" "%ProgramData%\NVIDIA Corporation\Drs" >nul 2>&1
    copy /y "resources\nvdrsdb1.bin" "%ProgramData%\NVIDIA Corporation\Drs" >nul 2>&1
)

:: AMD specific
if "!GPU!"=="AMD" (
    ::Low Latency
    for %%i in (LTRSnoopL1Latency LTRSnoopL0Latency LTRNoSnoopL1Latency LTRMaxNoSnoopLatency KMD_RpmComputeLatency
        DalUrgentLatencyNs memClockSwitchLatency PP_RTPMComputeF1Latency PP_DGBMMMaxTransitionLatencyUvd
        PP_DGBPMMaxTransitionLatencyGfx DalNBLatencyForUnderFlow DalDramClockChangeLatencyNs
        BGM_LTRSnoopL1Latency BGM_LTRSnoopL0Latency BGM_LTRNoSnoopL1Latency BGM_LTRNoSnoopL0Latency
        BGM_LTRMaxSnoopLatencyValue BGM_LTRMaxNoSnoopLatencyValue) do reg add "HKLM\SYSTEM\CurrentControlSet\control\class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "%%i" /t REG_DWORD /d "1" /f >nul 2>&1

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableDMACopy" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableBlockWrite" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "StutterMode" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableUlps" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PP_SclkDeepSleepDisable" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PP_ThermalAutoThrottlingEnable" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableDrmdmaPowerGating" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Main3D_DEF" /t REG_STRING /d "1" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Main3D" /t REG_BINARY /d "3100" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ShaderCache" /t REG_BINARY /d "3200" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Tessellation_OPTION" /t REG_BINARY /d "3200" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Tessellation" /t REG_BINARY /d "3100" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "VSyncControl" /t REG_BINARY /d "3000" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdlog" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
)

:: Services
for %%i IN (BITS BrokerInfrastructure BFE EventSystem CDPSvc CDPUserSvc_!SERVICE! CoreMessagingRegistrar
    CryptSvc DusmSvc DcomLaunch Dhcp Dnscache gpsvc LSM NlaSvc nsi Power PcaSvc RpcSs
    RpcEptMapper SamSs ShellHWDetection sppsvc SysMain OneSyncSvc_!SERVICE! SENS
    SystemEventsBroker Schedule Themes UserManager ProfSvc AudioSrv AudioEndpointBuilder Wcmsvc WinDefend
    MpsSvc SecurityHealthService EventLog FontCache Winmgmt WpnService WSearch LanmanWorkstation) DO (
    reg query "HKLM\SYSTEM\CurrentControlSet\Services\%%i" /ve >nul 2>&1
    if !ERRORLEVEL! equ 0 reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%i" /v "Start" /t REG_DWORD /d "2" /f >nul 2>&1
)
for %%i IN (AxInstSV AppReadiness AppIDSvc Appinfo AppXSVC BDESVC wbengine camsvc ClipSVC KeyIso
    COMSysApp Browser PimIndexMaintenanceSvc_!SERVICE! VaultSvc DsSvc DeviceAssociationService
    DeviceInstall DmEnrollmentSvc DsmSVC DevicesFlowUserSvc_!SERVICE! DevQueryBroker diagsvc
    WdiSystemHost MSDTC embeddedmode EFS EntAppSvc EapHost fhsvc fdPHost FDResPub GraphicsPerfSvc
    hidserv IKEEXT UI0Detect PolicyAgent KtmRm lltdsvc wlpasvc MessagingService_!SERVICE! wlidsvc
    NgcSvc NgcCtnrSvc swprv smphost Netman NcaSVC netprofm NetSetupSvc defragsvc PNRPsvc p2psvc
    p2pimsvc PerfHost pla PlugPlay PNRPAutoReg WPDBusEnum PrintNotify PrintWorkflowUserSvc_!SERVICE!
    wercplsupport QWAVE RmSvc RasAuto RasMan seclogon SstpSvc SharedRealitySvc svsvc SSDPSRV
    StateRepository WiaRpc StorSvc TieringEngineService lmhosts TapiSrv tiledatamodelsvc TimeBroker
    UsoSvc upnphost UserDataSvc_!SERVICE! UnistoreSvc_!SERVICE! vds VSS WalletService TokenBroker
    SDRSVC Sense WdNisSvc WEPHOSTSVC WerSvc Wecsvc StiSvc msiserver LicenseManager TrustedInstaller
    spectrum WpnUserService_!SERVICE! InstallService W32Time wuauserv WinHttpAutoProxySvc dot3svc
    WlanSvc wmiApSrv XboxGipSvc) do (
    reg query "HKLM\SYSTEM\CurrentControlSet\Services\%%i" /ve >nul 2>&1
    if !ERRORLEVEL! equ 0 reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%i" /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1
)
for %%i in (AJRouter ALG AppMgmt tzautoupdate BthHFSrv bthserv PeerDistSvc CertPropSvc NfsClnt
    MapsBroker lfsvc HvHost vmickvpexchange vmicguestinterface vmicshutdown vmicheartbeat
    vmicvmsession vmicrdv vmictimesync vmicvss irmon SharedAccess iphlpsvc IpxlatCfgSvc AppVClient
    MSiSCSI SmsRouter NaturalAuthentication Netlogon NcdAutoSetup CscService SEMgrSvc PhoneSvc
    SessionEnv TermService UmRdpService RpcLocator RemoteRegistry RetailDemo RemoteAccess SensorDataService
    SensrSvc SensorService shpamsvc SCardSvr ScDeviceEnum SCPolicySvc SNMPTRAP TabletInputService
    UevAgentService WebClient WFDSConSvc FrameServer wcncsvc wisvc WMPNetworkSvc icssvc WinRM WwanSvc
    xbgm XblAuthManager XblGameSave XboxNetApiSvc diagnosticshub.standardcollector.service DiagTrack
    DoSvc DPS WdiServiceHost HomeGroupListener HomeGroupProvider NetTcpPortSharing TrkWks WbioSrvc
    wscsvc NcbService Spooler LanmanServer dmwappushservice) do (
    reg query "HKLM\SYSTEM\CurrentControlSet\Services\%%i" /ve >nul 2>&1
    if !ERRORLEVEL! equ 0 reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%i" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
)

call "modules\choicebox.exe" "Disable Windows Search; Disable OneDrive; Disable Windows Store; Disable Xbox Apps; Disable Wi-Fi; Disable Bluetooth; Disable Printer; Disable Hyper-V; Disable Remote Desktop; Disable Task Scheduler; Disable Compatibility Assistant; Disable Disk Management; Disable Windows Update; Disable Windows Defender; Disable Windows Firewall" " " "Services" /C:2 >"%TMP%\services.txt"
findstr /c:"Disable Windows Search" "%TMP%\services.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\wsearch" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\TabletInputService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchPrivacy" /t REG_DWORD /d "3" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWebOverMeteredConnections" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Experience\AllowCortana" /v "value" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CortanaEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CortanaEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CanCortanaBeEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "DeviceHistoryEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "HistoryViewEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "CTFMon" /t REG_SZ /d "%WinDir%\System32\ctfmon.exe" /f >nul 2>&1

    if exist "%WinDir%\SystemApps\Microsoft.Windows.Cortana_cw5n1h2txyewy" (
        taskkill /f /im SearchUI.exe /f >nul 2>&1
        rd "%LocalAppData%\Packages\Microsoft.Windows.Cortana_cw5n1h2txyewy" /q /s /f >nul 2>&1
        rd "%WinDir%\SystemApps\Microsoft.Windows.Cortana_cw5n1h2txyewy" /q /s /f >nul 2>&1
    ) 
    if exist "%WinDir%\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy" (
        taskkill /f /im SearchApp.exe /f >nul 2>&1
        rd "%LocalAppData%\Packages\Microsoft.Windows.Search_cw5n1h2txyewy" /q /s /f >nul 2>&1
        rd "%WinDir%\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy" /q /s /f >nul 2>&1
    )
)
findstr /c:"Disable OneDrive" "%TMP%\services.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    taskkill /f /im OneDrive.exe >nul 2>&1
    if exist "%WinDir%\System32\OneDriveSetup.exe" start /wait "%WinDir%\System32\OneDriveSetup.exe" /uninstall >nul 2>&1
    rd "%UserProfile%\OneDrive" /q /s >nul 2>&1
    rd "%SystemDrive%\OneDriveTemp" /q /s >nul 2>&1
    rd "%LocalAppData%\Microsoft\OneDrive" /q /s >nul 2>&1
    rd "%ProgramData%\Microsoft OneDrive" /q /s >nul 2>&1
    reg delete "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
    reg delete "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSync" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableMeteredNetworkFileSync" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableLibrariesDefaultSaveToOneDrive" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\OneDrive" /v "DisablePersonalSync" /t REG_DWORD /d "1" /f >nul 2>&1
)
findstr /c:"Disable Windows Store" "%TMP%\services.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\iphlpsvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\ClipSVC" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AppXSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\LicenseManager" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\NgcSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\NgcCtnrSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\wlidsvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\TokenBroker" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WalletService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /t REG_DWORD /d "2" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "DisableStoreApps" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "RemoveWindowsStore" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v "SystemSettingsDownloadMode" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "SystemSettingsDownloadMode" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DoSvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1

    taskkill /f /im winstore.app.exe /f >nul 2>&1
    for /d %%i in ("\Program Files\WindowsApps\*Store*") do set rd /s /q "%%~nxi" >nul 2>&1
)
findstr /c:"Disable Xbox Apps" "%TMP%\services.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\XboxNetApiSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\XblGameSave" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\XblAuthManager" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\xbgm" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\XboxGipSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    
    for /d %%i in ("\Program Files\WindowsApps\*Xbox*") do set rd /s /q "%%~nxi" >nul 2>&1
    rd /s /q "%WinDir%\SystemApps\Microsoft.XboxGameCallableUI_cw5n1h2txyewy" >nul 2>&1
)
findstr /c:"Disable Wi-Fi" "%TMP%\services.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WwanSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WlanSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\wcncsvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\lmhosts" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\vwififlt" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\vwifibus" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
)
findstr /c:"Disable Bluetooth" "%TMP%\services.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTAGService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\bthserv" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthAvctpSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\NaturalAuthentication" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BluetoothUserService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
)
findstr /c:"Disable Printer" "%TMP%\services.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Fax" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Spooler" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\PrintNotify" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\PrintWorkflowUserSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
)
findstr /c:"Disable Hyper-V" "%TMP%\services.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\HvHost" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\vmickvpexchange" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\vmicguestinterface" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\vmicshutdown" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\vmicheartbeat" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\vmicvmsession" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\vmicrdv" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\vmictimesync" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\vmicvss" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
)
findstr /c:"Disable Remote Desktop" "%TMP%\services.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\RasAuto" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\RasMan" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SessionEnv" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\TermService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\UmRdpService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\RemoteRegistry" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\RpcLocator" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
)
findstr /c:"Disable Task Scheduler" "%TMP%\services.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Schedule" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\TimeBrokerSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
)
findstr /c:"Disable Compatibility Assistant" "%TMP%\services.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisablePCA" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\PcaSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
)
findstr /c:"Disable Disk Management" "%TMP%\services.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\defragsvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\vds" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
)
findstr /c:"Disable Windows Update" "%TMP%\services.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\PeerDistSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DoSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "BranchReadinessLevel" /t REG_DWORD /d "16" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DeferFeatureUpdates" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DeferFeatureUpdatesPeriodInDays" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ManagePreviewBuilds" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ManagePreviewBuildsPolicyValue" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "PauseFeatureUpdatesStartTime" /t REG_SZ /d "" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "DetectionFrequency" /t REG_DWORD /d "20" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "DetectionFrequencyEnabled" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "EnableFeaturedSoftware" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState" /v "BranchReadinessLevel" /t REG_SZ /d "CB" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState" /v "DeferFeatureUpdates" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState" /v "DeferQualityUpdates" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState" /v "ExcludeWUDrivers" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState" /v "FeatureUpdatesDeferralInDays" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState" /v "IsDeferralIsActive" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState" /v "IsWUfBConfigured" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState" /v "IsWUfBDualScanActive" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState" /v "PolicySources" /t REG_DWORD /d "2" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Update" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update\ExcludeWUDriversInQualityUpdate" /v "value" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d "1" /f >nul 2>&1
)
findstr /c:"Disable Windows Defender" "%TMP%\services.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Sense" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WdNisSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SamSs" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\wscsvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SgrmBroker" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableBehaviorMonitoring" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableIOAVProtection" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableOnAccessProtection" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableRealtimeMonitoring" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableRoutinelyTakingAction" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "ServiceKeepAlive" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\WOW6432Node\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\WOW6432Node\Policies\Microsoft\Windows Defender" /v "DisableRoutinelyTakingAction" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\WOW6432Node\Policies\Microsoft\Windows Defender" /v "ServiceKeepAlive" /t REG_DWORD /d "0" /f >nul 2>&1
    reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SPP\Clients" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Wdboot" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WdFilter" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WdNisDrv" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\mpsdrv" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Wdnsfltr" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
)
findstr /c:"Disable Windows Firewall" "%TMP%\services.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    netsh advfirewall set allprofiles state off >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\mpssvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BFE" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile" /v "EnableFirewall" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile" /v "DisableNotifications" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile" /v "DoNotAllowExceptions" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile" /v "EnableFirewall" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile" /v "DisableNotifications" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile" /v "DoNotAllowExceptions" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile" /v "EnableFirewall" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile" /v "DisableNotifications" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile" /v "DoNotAllowExceptions" /t REG_DWORD /d "1" /f >nul 2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" /f >nul 2>&1
)
del /f /q "%TMP%\services.txt"

:: drivers Services
reg add "HKLM\SYSTEM\CurrentControlSet\Services\fvevol" /v "ErrorControl" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dhcp" /v "DependOnService" /t REG_MULTI_SZ /d "" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\hidserv" /v "DependOnService" /t REG_MULTI_SZ /d "" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Audiosrv" /v "DependOnService" /t REG_MULTI_SZ /d "" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e96c-e325-11ce-bfc1-08002be10318}" /v "UpperFilters" /t REG_MULTI_SZ /d "" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e967-e325-11ce-bfc1-08002be10318}" /v "LowerFilters" /t REG_MULTI_SZ /d "" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{6bdd1fc6-810f-11d0-bec7-08002be2092f}" /v "UpperFilters" /t REG_MULTI_SZ /d "" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{71a27cdd-812a-11d0-bec7-08002be2092f}" /v "LowerFilters" /t REG_MULTI_SZ /d "" /f >nul 2>&1
for %%i in (AcpiDev CAD CldFlt FileCrypt GpuEnergyDrv PptpMiniport RapiMgr RasAgileVpn Rasl2tp
    RasSstp Wanarp wanarpv6 WcesComm Wcifs Wcnfs WindowsTrustedRT WindowsTrustedRTProxy
    bam cnghwassist iorate mssecflt tunnel acpipagr AcpiPmi Acpitime Beep bowser CLFS
    CompositeBus condrv CSC dam dfsc EhStorClass fastfat FileInfo fvevol kdnic KSecPkg
    lltdio luafv Modem MpsSvc mrxsmb Mrxsmb10 Mrxsmb20 MsLldp mssmbios NdisCap NdisTapi
    NdisVirtualBus NdisWan Ndproxy Ndu NetBIOS NetBT Npsvctrig PEAUTH Psched QWAVEdrv
    RasAcd RasPppoe rdbss rdpbus rdyboost rspndr spaceport srv2 Srvnet TapiSrv Tcpip6
    tcpipreg tdx TPM umbus vdrvroot Vid Volmgrx WmiAcpi ws2ifsl) do (
    reg query "HKLM\SYSTEM\CurrentControlSet\Services\%%i" /ve >nul 2>&1
    if !ERRORLEVEL! equ 0 reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%i" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
)

:: Network
netsh winsock reset >nul 2>&1
netsh interface teredo set state disabled >nul 2>&1
netsh interface 6to4 set state disabled >nul 2>&1
netsh int isatap set state disable >nul 2>&1
netsh int ip set global neighborcachelimit=4096 >nul 2>&1
netsh int tcp set global dca=enabled >nul 2>&1
netsh int tcp set global netdma=enabled >nul 2>&1
netsh int tcp set supplemental internet congestionprovider=CUBIC >nul 2>&1
wmic nicconfig where TcpipNetbiosOptions=0 call SetTcpipNetbios 2 >nul 2>&1
wmic nicconfig where TcpipNetbiosOptions=1 call SetTcpipNetbios 2 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableICMPRedirect" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnablePMTUDiscovery" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "Tcp1323Opts" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "GlobalMaxTcpWindowSize" /t REG_DWORD /d "5840" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpWindowSize" /t REG_DWORD /d "5840" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxConnectionsPerServer" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxUserPort" /t REG_DWORD /d "65534" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpTimedWaitDelay" /t REG_DWORD /d "32" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnablePMTUBHDetect" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DefaultTTL" /t REG_DWORD /d "64" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "SackOpts" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpMaxDupAcks" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Winsock" /v "UseDelayedAcceptance" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Winsock" /v "MaxSockAddrLength" /t REG_DWORD /d "16" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Winsock" /v "MinSockAddrLength" /t REG_DWORD /d "16" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WinSock2\Parameters" /v "Ws2_32NumHandleBuckets" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\MSMQ\Parameters" /v "TCPNoDelay" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v "MaxOutstandingSends" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v "NonBestEffortLimit" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v "TimerResolution" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched\DiffservByteMappingConforming" /v "ServiceTypeGuaranteed" /t REG_DWORD /d "46" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched\DiffservByteMappingConforming" /v "ServiceTypeNetworkControl" /t REG_DWORD /d "56" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched\DiffservByteMappingNonConforming" /v "ServiceTypeGuaranteed" /t REG_DWORD /d "46" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched\DiffservByteMappingNonConforming" /v "ServiceTypeNetworkControl" /t REG_DWORD /d "56" /f >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MAXCONNECTIONSPER1_0SERVER" /v "explorer.exe" /t REG_DWORD /d "10" /f >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MAXCONNECTIONSPER1_0SERVER" /v "iexplore.exe" /t REG_DWORD /d "10" /f >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MAXCONNECTIONSPERSERVER" /v "explorer.exe" /t REG_DWORD /d "10" /f >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MAXCONNECTIONSPERSERVER" /v "iexplore.exe" /t REG_DWORD /d "10" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "DnsPriority" /t REG_DWORD /d "6" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "HostsPriority" /t REG_DWORD /d "5" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "LocalPriority" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "NetbtPriority" /t REG_DWORD /d "7" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "DefaultReceiveWindow" /t REG_DWORD /d "16384" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "DefaultSendWindow" /t REG_DWORD /d "16384" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "DisableRawSecurity" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "DynamicSendBufferDisable" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "FastCopyReceiveThreshold" /t REG_DWORD /d "16384" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "FastSendDatagramThreshold" /t REG_DWORD /d "16384" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "IgnorePushBitOnReceives" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "NonBlockingSendSpecialBuffering" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v "DisabledComponents" /t REG_DWORD /d "255" /f >nul 2>&1
for /f %%i in ('wmic path win32_networkadapter get GUID ^| findstr "{"') do (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%i" /v "TcpAckFrequency" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%i" /v "TcpDelAckTicks" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%i" /v "TCPNoDelay" /t REG_DWORD /d "1" /f >nul 2>&1
)
powershell "Set-NetTCPSetting -SettingName InternetCustom -AutoTuningLevelLocal Experimental" >nul 2>&1
powershell "Set-NetTCPSetting -SettingName InternetCustom -ScalingHeuristics Disabled" >nul 2>&1
powershell "Set-NetTCPSetting -SettingName InternetCustom -CongestionProvider CUBIC" >nul 2>&1
powershell "Set-NetTCPSetting -SettingName InternetCustom -MemoryPressureProtection Disabled" >nul 2>&1
powershell "Set-NetTCPSetting -SettingName InternetCustom -InitialCongestionWindow 10" >nul 2>&1
powershell "Set-NetTCPSetting -SettingName InternetCustom -EcnCapability Disabled" >nul 2>&1
powershell "Set-NetTCPSetting -SettingName InternetCustom -Timestamps Disabled" >nul 2>&1
powershell "Set-NetTCPSetting -SettingName InternetCustom -MaxSynRetransmissions 2" >nul 2>&1
powershell "Set-NetTCPSetting -SettingName InternetCustom -NonSackRttResiliency disabled" >nul 2>&1
powershell "Set-NetTCPSetting -SettingName InternetCustom -InitialRto 2000" >nul 2>&1
powershell "Set-NetTCPSetting -SettingName InternetCustom -MinRto 300" >nul 2>&1
powershell "Set-NetOffloadGlobalSetting -ReceiveSegmentCoalescing Disabled" >nul 2>&1
powershell "Set-NetOffloadGlobalSetting -ReceiveSegmentSideScaling Disabled" >nul 2>&1
powershell "Set-NetOffloadGlobalSetting -Chimney Disabled" >nul 2>&1
powershell "Set-NetOffloadGlobalSetting -TaskOffload Disabled" >nul 2>&1
powershell "Enable-NetAdapterRss -Name *" >nul 2>&1
powershell "Set-NetAdapterRSS -Name '*' -BaseProcessorNumber 1" >nul 2>&1
powershell "Set-NetAdapterRss -Name '*' -MaxProcessorNumber 1" >nul 2>&1
powershell "Disable-NetAdapterRsc -Name *" >nul 2>&1
powershell "Disable-NetAdapterLso -Name *" >nul 2>&1
powershell "Disable-NetAdapterIPsecOffload -Name *" >nul 2>&1
powershell "Disable-NetAdapterPowerManagement -Name *" >nul 2>&1
powershell "Disable-NetAdapterChecksumOffload -Name *" >nul 2>&1
powershell "Disable-NetAdapterEncapsulatedPacketTaskOffload -Name *" >nul 2>&1
powershell "Disable-NetAdapterQos -Name *" >nul 2>&1
for %%i in (ms_lldp ms_lltdio ms_msclient ms_rspndr ms_server ms_implat ms_pacer ms_tcpip6) do powershell "Disable-NetAdapterBinding -Name * -ComponentID %%i" >nul 2>&1
for %%i in ("Ultra Low Power Mode" "Green Ethernet" "Gigabit Lite"
    "Enable PME" "Ultra Low Power Mode" "System Idle Power Saver"
    "Idle Power Saving" "Advanced EEE" "Log Link State Event"
    "Reduce Speed on Power Down" "Jumbo Packet" "Flow Control"
    "Interrupt Moderation" "Wake on Magic Packet" "Wake on Pattern Match"
    "IPV4 Checksum Offloading" "Protocol ARP Offload" "Protocol NS Offload"
    "TCP Checksum Offload (IPv4)" "TCP Checksum Offload (IPv6)"
    "Large Send Offload V2 (IPv4)" "Large Send Offload V2 (IPv6)") do powershell "Set-NetAdapterAdvancedProperty -Name '*' -DisplayName '%%i' -DisplayValue 'Disabled'" >nul 2>&1
powershell "Set-NetAdapterAdvancedProperty -Name '*' -DisplayName 'Energy Efficient Ethernet' -DisplayValue 'Off'" >nul 2>&1
powershell "Set-NetAdapterAdvancedProperty -Name '*' -DisplayName 'Interrupt Moderation Rate' -DisplayValue 'Off'" >nul 2>&1
powershell "Set-NetAdapterAdvancedProperty -Name '*' -DisplayName 'Gigabit Master Slave Mode' -DisplayValue 'Auto Detect'" >nul 2>&1
powershell "Set-NetAdapterAdvancedProperty -Name '*' -DisplayName 'Link Speed & Duplex' -DisplayValue 'Auto Negotiation'" >nul 2>&1
powershell "Set-NetAdapterAdvancedProperty -Name '*' -DisplayName 'Packet Priority & VLAN' -DisplayValue 'Packet Priority & VLAN Disabled'" >nul 2>&1
powershell "Set-NetAdapterAdvancedProperty -Name '*' -DisplayName 'Transmit Buffers' -DisplayValue '1024'" >nul 2>&1
powershell "Set-NetAdapterAdvancedProperty -Name '*' -DisplayName 'Receive Buffers' -DisplayValue '1024'" >nul 2>&1
powershell "Set-NetAdapterAdvancedProperty -Name '*' -DisplayName 'Receive Side Scaling' -DisplayValue 'On'" >nul 2>&1
powershell "Set-NetAdapterAdvancedProperty -Name '*' -DisplayName 'Maximum Number of RSS Queues' -DisplayValue '1 Queues'" >nul 2>&1
powershell "Set-NetAdapterAdvancedProperty -Name '*' -RegistryKeyword 'TxIntDelay' -RegistryValue '5'" >nul 2>&1
powershell "Set-NetAdapterAdvancedProperty -Name 'Wi-Fi' -DisplayName 'ARP offload for WoWLAN' -DisplayValue 'Disabled'" >nul 2>&1
powershell "Set-NetAdapterAdvancedProperty -Name 'Wi-Fi' -DisplayName 'NS offloading for WoWLAN' -DisplayValue 'Disabled'" >nul 2>&1
powershell "Set-NetAdapterAdvancedProperty -Name 'Wi-Fi' -DisplayName 'GTK rekeying for WoWLAN' -DisplayValue 'Disabled'" >nul 2>&1
powershell "Set-NetAdapterAdvancedProperty -Name 'Wi-Fi' -DisplayName 'Roaming Aggressiveness' -DisplayValue '1. Lowest'" >nul 2>&1
powershell "Set-NetAdapterAdvancedProperty -Name 'Wi-Fi' -DisplayName 'Preferred Band' -DisplayValue '3. Prefer 5GHz band'" >nul 2>&1
powershell "Set-NetAdapterAdvancedProperty -Name 'Wi-Fi' -DisplayName 'Transmit Power' -DisplayValue '5. Highest'" >nul 2>&1
powershell "Set-NetAdapterAdvancedProperty -Name 'Wi-Fi' -DisplayName 'Throughput Booster' -DisplayValue 'Enabled'" >nul 2>&1
powershell "Set-NetAdapterAdvancedProperty -Name 'Wi-Fi' -DisplayName 'U-APSD support' -DisplayValue 'Disabled'" >nul 2>&1
:: Set static ip
set DNS1=1.1.1.1
set DNS2=1.0.0.1
for /f "tokens=3,*" %%i in ('netsh int show interface ^| findstr "Connected"') do set INTERFACE=%%j
for /f "tokens=3 delims=: " %%i in ('netsh int ip show config name^="%INTERFACE%" ^| findstr "IP Address"') do set IP=%%i
for /f "tokens=2 delims=()" %%i in ('netsh int ip show config name^="%INTERFACE%" ^| findstr /r "(.*)"') do for %%j in (%%i) do set MASK=%%j
for /f "tokens=3 delims=: " %%i in ('netsh int ip show config name^="%INTERFACE%" ^| findstr "Default"') do set GATEWAY=%%i
netsh int ipv4 set address name="%INTERFACE%" static %IP% %MASK% %GATEWAY% >nul 2>&1
netsh int ipv4 set dns name="%INTERFACE%" static %DNS1% primary validate=no >nul 2>&1
netsh int ipv4 add dns name="%INTERFACE%" %DNS2% index=2 validate=no >nul 2>&1
for /f "tokens=3 delims=: " %%i in ('netsh int ip show config name^="%INTERFACE%" ^| findstr "DHCP"') do set DHCP=%%i
if "%DHCP%"=="Yes" (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dhcp" /v "Start" /t REG_DWORD /d "2" /f >nul 2>&1
)

:: Large page drivers
set WHITELIST=ACPI AcpiDev AcpiPmi AFD AMDPCIDev amdgpio2 amdgpio3 AmdPPM amdpsp amdsata amdsbs amdxata asmtxhci BasicDisplay BasicRender dc1-controll Disk DXGKrnl e1iexpress e1rexpress genericusbfn hwpolicy IntcAzAudAdd kbdclass kbdhid MMCSS monitor mouclass mouhid mountmgr mt7612US MTConfig NDIS nvdimm nvlddmkm pci PktMon Psched rt640x64 RTCore64 RzCommon RzDev_0244 Tcpip usbehci usbhub USBHUB3 USBXHCI Wdf01000 xboxgip xinputhid
for /f %%i in ('driverquery ^| findstr "%WHITELIST%"') do if "!DRIVERLIST!"=="" (set DRIVERLIST=%%i) else (set DRIVERLIST=!DRIVERLIST!\0%%i)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargePageDrivers" /t REG_MULTI_SZ /d "%DRIVERLIST%\0" /f >nul 2>&1

:: Disable devices
for %%i in ("Microsoft Kernel Debug Network Adapter" "WAN Miniport" "Teredo Tunneling"
    "UMBus Root Bus Enumerator" "Composite Bus Enumerator" "Microsoft Virtual Drive Enumerator"
    "NDIS Virtual Network Adapter Enumerator" "System Timer" "Programmable Interrupt Controller"
    "PCI standard RAM Controller" "PCI Simple Communications Controller" "Numeric Data Processor" "NVIDIA USB"
    "Intel Management Engine" "Intel SMBus" "AMD PSP" "SM Bus Controller" "Remote Desktop Device Redirector Bus"
    "Microsoft System Management BIOS Driver" "Microsoft GS Wavetable Synth" "NVIDIA High Definition Audio" "Microsoft Wi-Fi Direct Virtual Adapter"
    "HID-compliant Consumer Control Device" "HID-compliant System Controller" "HID-compliant Vendor-Defined Device" "High Precision Event Timer"
    "Microsoft Windows Management Interface for ACPI" "Microsoft Storage Spaces Controller" "Microsoft Hyper-V Virtualization Infrastructure Driver") do powershell "Get-PnpDevice | Where-Object {$_.FriendlyName -match '%%i'} | Disable-PnpDevice -Confirm:$false" >nul 2>&1

:: Clean non-present devices
call "modules\devicecleanup.exe" * -s -n >nul 2>&1

:: Disable devices power management
powershell "$devices = Get-WmiObject Win32_PnPEntity; $powerMgmt = Get-WmiObject MSPower_DeviceEnable -Namespace root\wmi; foreach ($p in $powerMgmt){$IN = $p.InstanceName.ToUpper(); foreach ($h in $devices){$PNPDI = $h.PNPDeviceID; if ($IN -like \"*$PNPDI*\"){$p.enable = $False; $p.psbase.put()}}}" >nul 2>&1

:: Import Power Plan
if "!CPU!"=="RYZEN" (
    powercfg -query 33333333-3333-3333-3333-333333333333 >nul 2>&1 && powercfg -delete 33333333-3333-3333-3333-333333333333 >nul 2>&1
    powercfg -import "%~dp0\resources\1usmus.pow" 33333333-3333-3333-3333-333333333333 >nul 2>&1
    powercfg -setactive 33333333-3333-3333-3333-333333333333 >nul 2>&1
) else (
    powercfg -query 33333333-3333-3333-3333-333333333333 >nul 2>&1 && powercfg -delete 33333333-3333-3333-3333-333333333333 >nul 2>&1
    powercfg -import "%~dp0\resources\ExtremePerformance.pow" 33333333-3333-3333-3333-333333333333 >nul 2>&1
    powercfg -setactive 33333333-3333-3333-3333-333333333333 >nul 2>&1
)

:: Remove Windows apps
call :MSGBOX "Would you like to strip Windows bloatware ?" vbYesNo+vbQuestion "Bloatware"
if !ERRORLEVEL! equ 6 (
    taskkill /f /im ShellExperienceHost.exe >nul 2>&1
    taskkill /f /im StartMenuExperienceHost.exe >nul 2>&1
    taskkill /f /im MicrosoftEdge.exe >nul 2>&1
    taskkill /f /im TextInputHost.exe >nul 2>&1

    for /d %%i in ("\Program Files\WindowsApps\*Xbox*") do set "WINXBOX=%%~nxi"
    for /d %%i in ("\Program Files\WindowsApps\*Store*") do set "WINSTORE=%%~nxi"
    for /d %%i in ("\Program Files\WindowsApps\*") do if /i not "%%~nxi"==!WINXBOX! if /i not "%%~nxi"==!WINSTORE! rd /s /q "%%i" >nul 2>&1
    rd /s /q "%ProgramData%\Packages" >nul 2>&1
    rd /s /q "%LocalAppData%\Microsoft\WindowsApps" >nul 2>&1

    for /d %%i in ("%WinDir%\SystemApps\*Xbox*") do set "XBOX=%%~nxi"
    for /d %%i in ("%WinDir%\SystemApps\*Store*") do set "STORE=%%~nxi"
    for /d %%i in ("%WinDir%\SystemApps\*NET.Native*") do set "NET=%%~nxi"
    for /d %%i in ("%WinDir%\SystemApps\*VCLibs*") do set "VCLIBS=%%~nxi"
    for /d %%i in ("%WinDir%\SystemApps\*") do if /i not "%%~nxi"=="windows.immersivecontrolpanel_cw5n1h2txyewy" if /i not "%%~nxi"=="Microsoft.Windows.Search_cw5n1h2txyewy" if /i not "%%~nxi"=="Microsoft.Windows.Cortana_cw5n1h2txyewy" if /i not "%%~nxi"==!XBOX! if /i not "%%~nxi"==!STORE! if /i not "%%~nxi"==!NET! if /i not "%%~nxi"==!VCLIBS! rd /s /q "%%i" >nul 2>&1
    for /d %%i in ("%LocalAppData%\Packages\*") do if /i not "%%~nxi"=="windows.immersivecontrolpanel_cw5n1h2txyewy" if /i not "%%~nxi"=="Microsoft.Windows.Search_cw5n1h2txyewy" if /i not "%%~nxi"=="Microsoft.Windows.Cortana_cw5n1h2txyewy" if /i not "%%~nxi"==!XBOX! if /i not "%%~nxi"==!STORE! if /i not "%%~nxi"==!NET! if /i not "%%~nxi"==!VCLIBS! rd /s /q "%%i" >nul 2>&1
)

:: Telemetry
reg add "HKCU\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v "value" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v "value" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DownloadMode" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v "UseActionCenterExperience" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HideSCAHealth" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\EnhancedStorageDevices" /v "TCGSecurityActivationDisabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\codeidentifiers" /v "authenticodeenabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "DontSendAdditionalData" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f >nul 2>&1
for %%i in (AutoLogger-Diagtrack-Listener AppModel Cellcore CloudExperienceHostOobe
    DataMarket DefenderApiLogger DefenderAuditLogger DiagLog HolographicDevice iclsClient
    iclsProxy LwtNetLog Mellanox-Kernel Microsoft-Windows-AssignedAccess-Trace Microsoft-Windows-Setup
    NBSMBLOGGER PEAuthLog RdrLog ReadyBoot SetupPlatform SetupPlatformTel SocketHeciServer
    SpoolerLogger SQMLogger TCPIPLOGGER TileStore Tpm TPMProvisioningService UBPM WdiContextLog
    WFP-IPsec Trace WiFiDriverIHVSession WiFiDriverIHVSessionRepro WiFiSession WinPhoneCritical) do (
    reg query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\%%i" /ve >nul 2>&1
    if !ERRORLEVEL! equ 0 reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\%%i" /v "Start" /t REG_DWORD /d "0" /f >nul 2>&1
)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\Circular Kernel Context Logger" /v "Start" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WUDF" /v "LogEnable" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WUDF" /v "LogLevel" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa\Credssp" /v "DebugLogLevel" /t REG_DWORD /d "0" /f >nul 2>&1

:: Scheduled tasks
schtasks /change /tn "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable >nul 2>&1
schtasks /change /tn "Microsoft\Windows\Application Experience\ProgramDataUpdater" /disable >nul 2>&1
schtasks /change /tn "Microsoft\Windows\Application Experience\StartupAppTask" /disable >nul 2>&1
schtasks /change /tn "Microsoft\Windows\Application Experience\AitAgent" /disable >nul 2>&1
schtasks /change /tn "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable >nul 2>&1
schtasks /change /tn "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /disable >nul 2>&1
schtasks /change /tn "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /disable >nul 2>&1
schtasks /change /tn "Microsoft\Windows\Customer Experience Improvement Program\Uploader" /disable >nul 2>&1
schtasks /change /tn "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /disable >nul 2>&1
schtasks /change /tn "Microsoft\Windows\AppID\SmartScreenSpecific" /disable >nul 2>&1
schtasks /change /tn "Microsoft\Windows\Shell\FamilySafetyMonitor" /disable >nul 2>&1
schtasks /change /tn "Microsoft\Windows\Shell\FamilySafetyRefresh" /disable >nul 2>&1
schtasks /change /tn "Microsoft\Windows\Shell\FamilySafetyUpload" /disable >nul 2>&1
schtasks /change /tn "Microsoft\Windows\Autochk\Proxy" /disable >nul 2>&1
schtasks /change /tn "Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /disable >nul 2>&1
schtasks /change /tn "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /disable >nul 2>&1
schtasks /change /tn "Microsoft\Windows\DiskFootprint\Diagnostics" /disable >nul 2>&1
schtasks /change /tn "Microsoft\Windows\FileHistory\File History (maintenance mode)" /disable >nul 2>&1
schtasks /change /tn "Microsoft\Windows\Maintenance\WinSAT" /disable >nul 2>&1
schtasks /change /tn "Microsoft\Windows\NetTrace\GatherNetworkInfo" /disable >nul 2>&1
schtasks /change /tn "Microsoft\Windows\PI\Sqm-Tasks" /disable >nul 2>&1
schtasks /change /tn "Microsoft\Windows\Time Synchronization\ForceSynchronizeTime" /disable >nul 2>&1
schtasks /change /tn "Microsoft\Windows\Time Synchronization\SynchronizeTime" /disable >nul 2>&1
schtasks /change /tn "Microsoft\Windows\Windows Error Reporting\QueueReporting" /disable >nul 2>&1
schtasks /change /tn "Microsoft\Windows\WindowsUpdate\Automatic App Update" /disable >nul 2>&1
for /f "tokens=1 delims=," %%i in ('schtasks /query /fo csv ^| findstr /v "TaskName" ^| findstr "Office"') do schtasks /change /tn "%%i" /disable >nul 2>&1
for /f "tokens=1 delims=," %%i in ('schtasks /query /fo csv ^| findstr /v "TaskName" ^| findstr "NvTm"') do schtasks /change /tn "%%i" /disable >nul 2>&1
for /f "tokens=1 delims=," %%i in ('schtasks /query /fo csv ^| findstr /v "TaskName" ^| findstr "NvProfile"') do schtasks /change /tn "%%i" /disable >nul 2>&1
for /f "tokens=1 delims=," %%i in ('schtasks /query /fo csv ^| findstr /v "TaskName" ^| findstr "Intel"') do schtasks /change /tn "%%i" /disable >nul 2>&1
schtasks /change /tn "USER_ESRV_SVC_QUEENCREEK" /disable >nul 2>&1

:: Hosts
call :CURL -L "https://gist.githubusercontent.com/ArtanisInc/74081e8f0548105412e8082ed47c4c97/raw/fce96a4ad8175249b7b8965af623d25c3c99659a/hosts" --create-dirs -o "%WinDir%\System32\drivers\etc\hosts" >nul 2>&1

:: Enable HRTF
echo hrtf ^= true > "%appdata%\alsoft.ini"
echo hrtf ^= true > "%ProgramData%\alsoft.ini"

:: Install Simple DirectMedia Layer
if not exist "%WinDir%\System32\SDL.dll" copy "resources\SDL.dll" "%WinDir%\System32" >nul 2>&1
if not exist "%WinDir%\SysWOW64\SDL.dll" copy "resources\SDL.dll" "%WinDir%\SysWOW64" >nul 2>&1

:: Install Timer resolution service
if not exist "%WinDir%\SetTimerResolutionService.exe" copy "resources\SetTimerResolutionService.exe" "%WinDir%" >nul 2>&1
call "%WinDir%\SetTimerResolutionService.exe" -Install >nul 2>&1

:: Process Explorer
taskkill /f /im procexp.exe >nul 2>&1
if not exist "%WinDir%\procexp.exe" copy "resources\procexp.exe" "%WinDir%" >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\taskmgr.exe" /v "Debugger" /t REG_SZ /d "%WinDir%\procexp.exe" /f >nul 2>&1
reg add "HKCU\Software\Sysinternals\Process Explorer" /v "AlwaysOntop" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\Software\Sysinternals\Process Explorer" /v "OneInstance" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\Software\Sysinternals\Process Explorer" /v "ConfirmKill" /t REG_DWORD /d "0" /f >nul 2>&1

:: Install StartisBack
taskkill /f /im explorer.exe >nul 2>&1
call "resources\StartIsBack.exe" /silent >nul 2>&1
timeout /t 5 /nobreak >nul 2>&1
taskkill /f /im explorer.exe >nul 2>&1
reg add "HKCU\SOFTWARE\StartIsBack" /v "StartIsApps" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\StartIsBack" /v "NoXAMLPrelaunch" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\StartIsBack" /v "TerminateOnClose" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\StartIsBack" /v "StartMetroAppsMFU" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\StartIsBack" /v "TaskbarLargerIcons" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\StartIsBack" /v "HideSecondaryOrb" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\StartIsBack" /v "HideUserFrame" /t REG_DWORD /d "1" /f >nul 2>&1
start "" "explorer.exe" >nul 2>&1

:: Reboot
call :MSGBOX "Some registry changes may require a reboot to take effect.\n\nWould you like to restart now?" vbYesNo+vbQuestion "Shut Down Windows"
if !ERRORLEVEL! equ 6 shutdown -r -f -t 0
timeout /t 1 /nobreak >nul 2>&1
goto MAIN_MENU



:APPS_MENU_CLEAR
:: Web Browsers
set "Chromium=[40;95m[ ][40;37m Chromium"
set "Mozilla Firefox=[40;95m[ ][40;37m Mozilla Firefox"
set "Brave=[40;95m[ ][40;37m Brave"
set "Opera GX=[40;95m[ ][40;37m Opera GX"
:: Media
set "Deezer=[40;95m[ ][40;37m Deezer"
set "Spotify=[40;95m[ ][40;37m Spotify"
set "PotPlayer=[40;95m[ ][40;37m PotPlayer"
set "VLC media player=[40;95m[ ][40;37m VLC media player"
:: Imaging
set "ImageGlass=[40;95m[ ][40;37m ImageGlass"
set "ShareX=[40;95m[ ][40;37m ShareX"
set "GIMP=[40;95m[ ][40;37m GIMP"
:: Messaging
set "Discord=[40;95m[ ][40;37m Discord"
set "Ripcord=[40;95m[ ][40;37m Ripcord"
set "TeamSpeak=[40;95m[ ][40;37m TeamSpeak"
:: Documents
set "Foxit Reader=[40;95m[ ][40;37m Foxit Reader"
set "Microsoft Office=[40;95m[ ][40;37m Microsoft Office"
set "Libre Office=[40;95m[ ][40;37m Libre Office"
:: Compression
set "Easy 7zip=[40;95m[ ][40;37m Easy 7zip"
set "Winrar=[40;95m[ ][40;37m Winrar"
:: Developer Tools
set "Visual Studio Code=[40;95m[ ][40;37m Visual Studio Code"
set "Sublime Text=[40;95m[ ][40;37m Sublime Text"
set "FileZilla=[40;95m[ ][40;37m FileZilla"
set "PuTTY=[40;95m[ ][40;37m PuTTY"
:: Games Launcher
set "Steam=[40;95m[ ][40;37m Steam"
set "GOG Galaxy=[40;95m[ ][40;37m GOG Galaxy"
set "Epic Games=[40;95m[ ][40;37m Epic Games"
set "Uplay=[40;95m[ ][40;37m Uplay"
set "Battle.net=[40;95m[ ][40;37m Battle.net"
set "Origin=[40;95m[ ][40;37m Origin"
:: Others
set "Dashlane=[40;95m[ ][40;37m Dashlane"
set "Vortex=[40;95m[ ][40;37m Vortex"
:: Recommended to install
set "Visual C++ Redistributables=[40;95m[ ][40;37m Visual C++ Redistributables"
set "DirectX=[40;95m[ ][40;37m DirectX"
set ".NET Framework 4.8=[40;95m[ ][40;37m .NET Framework 4.8"

:APPS_MENU
cls
mode con lines=38 cols=133
echo [40;95m
echo                        ╔═════════════════════════════════════════════════════════════════════════════════════╗
echo                        ║                                  [40;33mSOFTWARE INSTALLER[40;95m                                 ║
echo                        ╚═════════════════════════════════════════════════════════════════════════════════════╝
echo.
echo              [40;93mWEB BROWSERS                                 MEDIA                                        IMAGING
echo              [40;93m------------                                 -----                                        -------
echo               [40;33m1 !Chromium!                               [40;33m5 !Deezer!                                 [40;33m9 !ImageGlass!
echo               [40;33m2 !Mozilla Firefox!                        [40;33m6 !Spotify!                               [40;33m10 !ShareX!
echo               [40;33m3 !Brave!                                  [40;33m7 !PotPlayer!                             [40;33m11 !GIMP!
echo               [40;33m4 !Opera GX!                               [40;33m8 !VLC media player!
echo.
echo              [40;93mMESSAGING                                    DOCUMENTS                                    COMPRESSION
echo              [40;93m---------                                    ---------                                    -----------
echo              [40;33m12 !Discord!                               [40;33m15 !Foxit Reader!                          [40;33m18 !Easy 7zip!
echo              [40;33m13 !Ripcord!                               [40;33m16 !Microsoft Office!                      [40;33m19 !Winrar!
echo              [40;33m14 !TeamSpeak!                             [40;33m17 !Libre Office!
echo.
echo              [40;93mDEVELOPER TOOLS                              GAMES LAUNCHER                               OTHERS
echo              [40;93m---------------                              --------------                               ------
echo              [40;33m20 !Visual Studio Code!                    [40;33m24 !Steam!                                 [40;33m30 !Dashlane!
echo              [40;33m21 !Sublime Text!                          [40;33m25 !GOG Galaxy!                            [40;33m31 !Vortex!
echo              [40;33m22 !FileZilla!                             [40;33m26 !Epic Games!
echo              [40;33m23 !PuTTY!                                 [40;33m27 !Uplay!
echo                                                           [40;33m28 !Battle.net!
echo                                                           [40;33m29 !Origin!
echo              [40;91mRecommended to install
echo              [40;91m----------------------
echo              [40;33m32 !Visual C++ Redistributables!
echo              [40;33m33 !DirectX!
echo              [40;33m34 !.NET Framework 4.8!
echo.
echo                                                      [40;90mMake your choices or [40;33m"BACK"[40;90m
echo.
set choice=
set /p "choice=[40;33m                                                                 "
:: Web Browsers
if "!choice!"=="1" if "!Chromium!"=="[40;95m[ ][40;37m Chromium" set "Chromium=[40;95m[[40;33mx[40;95m][40;37m Chromium" && goto APPS_MENU
if "!choice!"=="1" if "!Chromium!"=="[40;95m[[40;33mx[40;95m][40;37m Chromium" set "Chromium=[40;95m[ ][40;37m Chromium" && goto APPS_MENU
if "!choice!"=="2" if "!Mozilla Firefox!"=="[40;95m[ ][40;37m Mozilla Firefox" set "Mozilla Firefox=[40;95m[[40;33mx[40;95m][40;37m Mozilla Firefox" && goto APPS_MENU
if "!choice!"=="2" if "!Mozilla Firefox!"=="[40;95m[[40;33mx[40;95m][40;37m Mozilla Firefox" set "Mozilla Firefox=[40;95m[ ][40;37m Mozilla Firefox" && goto APPS_MENU
if "!choice!"=="3" if "!Brave!"=="[40;95m[ ][40;37m Brave" set "Brave=[40;95m[[40;33mx[40;95m][40;37m Brave" && goto APPS_MENU
if "!choice!"=="3" if "!Brave!"=="[40;95m[[40;33mx[40;95m][40;37m Brave" set "Brave=[40;95m[ ][40;37m Brave" && goto APPS_MENU
if "!choice!"=="4" if "!Opera GX!"=="[40;95m[ ][40;37m Opera GX" set "Opera GX=[40;95m[[40;33mx[40;95m][40;37m Opera GX" && goto APPS_MENU
if "!choice!"=="4" if "!Opera GX!"=="[40;95m[[40;33mx[40;95m][40;37m Opera GX" set "Opera GX=[40;95m[ ][40;37m Opera GX" && goto APPS_MENU
:: MEDIA
if "!choice!"=="5" if "!Deezer!"=="[40;95m[ ][40;37m Deezer" set "Deezer=[40;95m[[40;33mx[40;95m][40;37m Deezer" && goto APPS_MENU
if "!choice!"=="5" if "!Deezer!"=="[40;95m[[40;33mx[40;95m][40;37m Deezer" set "Deezer=[40;95m[ ][40;37m Deezer" && goto APPS_MENU
if "!choice!"=="6" if "!Spotify!"=="[40;95m[ ][40;37m Spotify" set "Spotify=[40;95m[[40;33mx[40;95m][40;37m Spotify" && goto APPS_MENU
if "!choice!"=="6" if "!Spotify!"=="[40;95m[[40;33mx[40;95m][40;37m Spotify" set "Spotify=[40;95m[ ][40;37m Spotify" && goto APPS_MENU
if "!choice!"=="7" if "!PotPlayer!"=="[40;95m[ ][40;37m PotPlayer" set "PotPlayer=[40;95m[[40;33mx[40;95m][40;37m PotPlayer" && goto APPS_MENU
if "!choice!"=="7" if "!PotPlayer!"=="[40;95m[[40;33mx[40;95m][40;37m PotPlayer" set "PotPlayer=[40;95m[ ][40;37m PotPlayer" && goto APPS_MENU
if "!choice!"=="8" if "!VLC media player!"=="[40;95m[ ][40;37m VLC media player" set "VLC media player=[40;95m[[40;33mx[40;95m][40;37m VLC media player" && goto APPS_MENU
if "!choice!"=="8" if "!VLC media player!"=="[40;95m[[40;33mx[40;95m][40;37m VLC media player" set "VLC media player=[40;95m[ ][40;37m VLC media player" && goto APPS_MENU
:: IMAGING
if "!choice!"=="9" if "!ImageGlass!"=="[40;95m[ ][40;37m ImageGlass" set "ImageGlass=[40;95m[[40;33mx[40;95m][40;37m ImageGlass" && goto APPS_MENU
if "!choice!"=="9" if "!ImageGlass!"=="[40;95m[[40;33mx[40;95m][40;37m ImageGlass" set "ImageGlass=[40;95m[ ][40;37m ImageGlass" && goto APPS_MENU
if "!choice!"=="10" if "!ShareX!"=="[40;95m[ ][40;37m ShareX" set "ShareX=[40;95m[[40;33mx[40;95m][40;37m ShareX" && goto APPS_MENU
if "!choice!"=="10" if "!ShareX!"=="[40;95m[[40;33mx[40;95m][40;37m ShareX" set "ShareX=[40;95m[ ][40;37m ShareX" && goto APPS_MENU
if "!choice!"=="11" if "!GIMP!"=="[40;95m[ ][40;37m GIMP" set "GIMP=[40;95m[[40;33mx[40;95m][40;37m GIMP" && goto APPS_MENU
if "!choice!"=="11" if "!GIMP!"=="[40;95m[[40;33mx[40;95m][40;37m GIMP" set "GIMP=[40;95m[ ][40;37m GIMP" && goto APPS_MENU
:: MESSAGING
if "!choice!"=="12" if "!Discord!"=="[40;95m[ ][40;37m Discord" set "Discord=[40;95m[[40;33mx[40;95m][40;37m Discord" && goto APPS_MENU
if "!choice!"=="12" if "!Discord!"=="[40;95m[[40;33mx[40;95m][40;37m Discord" set "Discord=[40;95m[ ][40;37m Discord" && goto APPS_MENU
if "!choice!"=="13" if "!Ripcord!"=="[40;95m[ ][40;37m Ripcord" set "Ripcord=[40;95m[[40;33mx[40;95m][40;37m Ripcord" && goto APPS_MENU
if "!choice!"=="13" if "!Ripcord!"=="[40;95m[[40;33mx[40;95m][40;37m Ripcord" set "Ripcord=[40;95m[ ][40;37m Ripcord" && goto APPS_MENU
if "!choice!"=="14" if "!TeamSpeak!"=="[40;95m[ ][40;37m TeamSpeak" set "TeamSpeak=[40;95m[[40;33mx[40;95m][40;37m TeamSpeak" && goto APPS_MENU
if "!choice!"=="14" if "!TeamSpeak!"=="[40;95m[[40;33mx[40;95m][40;37m TeamSpeak" set "TeamSpeak=[40;95m[ ][40;37m TeamSpeak" && goto APPS_MENU
:: DOCUMENTS
if "!choice!"=="15" if "!Foxit Reader!"=="[40;95m[ ][40;37m Foxit Reader" set "Foxit Reader=[40;95m[[40;33mx[40;95m][40;37m Foxit Reader" && goto APPS_MENU
if "!choice!"=="15" if "!Foxit Reader!"=="[40;95m[[40;33mx[40;95m][40;37m Foxit Reader" set "Foxit Reader=[40;95m[ ][40;37m Foxit Reader" && goto APPS_MENU
if "!choice!"=="16" if "!Microsoft Office!"=="[40;95m[ ][40;37m Microsoft Office" set "Microsoft Office=[40;95m[[40;33mx[40;95m][40;37m Microsoft Office" && goto APPS_MENU
if "!choice!"=="16" if "!Microsoft Office!"=="[40;95m[[40;33mx[40;95m][40;37m Microsoft Office" set "Microsoft Office=[40;95m[ ][40;37m Microsoft Office" && goto APPS_MENU
if "!choice!"=="17" if "!Libre Office!"=="[40;95m[ ][40;37m Libre Office" set "Libre Office=[40;95m[[40;33mx[40;95m][40;37m Libre Office" && goto APPS_MENU
if "!choice!"=="17" if "!Libre Office!"=="[40;95m[[40;33mx[40;95m][40;37m Libre Office" set "Libre Office=[40;95m[ ][40;37m Libre Office" && goto APPS_MENU
:: COMPRESSION
if "!choice!"=="18" if "!Easy 7zip!"=="[40;95m[ ][40;37m Easy 7zip" set "Easy 7zip=[40;95m[[40;33mx[40;95m][40;37m Easy 7zip" && goto APPS_MENU
if "!choice!"=="18" if "!Easy 7zip!"=="[40;95m[[40;33mx[40;95m][40;37m Easy 7zip" set "Easy 7zip=[40;95m[ ][40;37m Easy 7zip" && goto APPS_MENU
if "!choice!"=="19" if "!Winrar!"=="[40;95m[ ][40;37m Winrar" set "Winrar=[40;95m[[40;33mx[40;95m][40;37m Winrar" && goto APPS_MENU
if "!choice!"=="19" if "!Winrar!"=="[40;95m[[40;33mx[40;95m][40;37m Winrar" set "Winrar=[40;95m[ ][40;37m Winrar" && goto APPS_MENU
:: DEVELOPER TOOLS
if "!choice!"=="20" if "!Visual Studio Code!"=="[40;95m[ ][40;37m Visual Studio Code" set "Visual Studio Code=[40;95m[[40;33mx[40;95m][40;37m Visual Studio Code" && goto APPS_MENU
if "!choice!"=="20" if "!Visual Studio Code!"=="[40;95m[[40;33mx[40;95m][40;37m Visual Studio Code" set "Visual Studio Code=[40;95m[ ][40;37m Visual Studio Code" && goto APPS_MENU
if "!choice!"=="21" if "!Sublime Text!"=="[40;95m[ ][40;37m Sublime Text" set "Sublime Text=[40;95m[[40;33mx[40;95m][40;37m Sublime Text" && goto APPS_MENU
if "!choice!"=="21" if "!Sublime Text!"=="[40;95m[[40;33mx[40;95m][40;37m Sublime Text" set "Sublime Text=[40;95m[ ][40;37m Sublime Text" && goto APPS_MENU
if "!choice!"=="22" if "!FileZilla!"=="[40;95m[ ][40;37m FileZilla" set "FileZilla=[40;95m[[40;33mx[40;95m][40;37m FileZilla" && goto APPS_MENU
if "!choice!"=="22" if "!FileZilla!"=="[40;95m[[40;33mx[40;95m][40;37m FileZilla" set "FileZilla=[40;95m[ ][40;37m FileZilla" && goto APPS_MENU
if "!choice!"=="23" if "!PuTTY!"=="[40;95m[ ][40;37m PuTTY" set "PuTTY=[40;95m[[40;33mx[40;95m][40;37m PuTTY" && goto APPS_MENU
if "!choice!"=="23" if "!PuTTY!"=="[40;95m[[40;33mx[40;95m][40;37m PuTTY" set "PuTTY=[40;95m[ ][40;37m PuTTY" && goto APPS_MENU
:: GAMES LAUNCHER
if "!choice!"=="24" if "!Steam!"=="[40;95m[ ][40;37m Steam" set "Steam=[40;95m[[40;33mx[40;95m][40;37m Steam" && goto APPS_MENU
if "!choice!"=="24" if "!Steam!"=="[40;95m[[40;33mx[40;95m][40;37m Steam" set "Steam=[40;95m[ ][40;37m Steam" && goto APPS_MENU
if "!choice!"=="25" if "!GOG Galaxy!"=="[40;95m[ ][40;37m GOG Galaxy" set "GOG Galaxy=[40;95m[[40;33mx[40;95m][40;37m GOG Galaxy" && goto APPS_MENU
if "!choice!"=="25" if "!GOG Galaxy!"=="[40;95m[[40;33mx[40;95m][40;37m GOG Galaxy" set "GOG Galaxy=[40;95m[ ][40;37m GOG Galaxy" && goto APPS_MENU
if "!choice!"=="26" if "!Epic Games!"=="[40;95m[ ][40;37m Epic Games" set "Epic Games=[40;95m[[40;33mx[40;95m][40;37m Epic Games" && goto APPS_MENU
if "!choice!"=="26" if "!Epic Games!"=="[40;95m[[40;33mx[40;95m][40;37m Epic Games" set "Epic Games=[40;95m[ ][40;37m Epic Games" && goto APPS_MENU
if "!choice!"=="27" if "!Uplay!"=="[40;95m[ ][40;37m Uplay" set "Uplay=[40;95m[[40;33mx[40;95m][40;37m Uplay" && goto APPS_MENU
if "!choice!"=="27" if "!Uplay!"=="[40;95m[[40;33mx[40;95m][40;37m Uplay" set "Uplay=[40;95m[ ][40;37m Uplay" && goto APPS_MENU
if "!choice!"=="28" if "!Battle.net!"=="[40;95m[ ][40;37m Battle.net" set "Battle.net=[40;95m[[40;33mx[40;95m][40;37m Battle.net" && goto APPS_MENU
if "!choice!"=="28" if "!Battle.net!"=="[40;95m[[40;33mx[40;95m][40;37m Battle.net" set "Battle.net=[40;95m[ ][40;37m Battle.net" && goto APPS_MENU
if "!choice!"=="29" if "!Origin!"=="[40;95m[ ][40;37m Origin" set "Origin=[40;95m[[40;33mx[40;95m][40;37m Origin" && goto APPS_MENU
if "!choice!"=="29" if "!Origin!"=="[40;95m[[40;33mx[40;95m][40;37m Origin" set "Origin=[40;95m[ ][40;37m Origin" && goto APPS_MENU
:: OTHERS
if "!choice!"=="30" if "!Dashlane!"=="[40;95m[ ][40;37m Dashlane" set "Dashlane=[40;95m[[40;33mx[40;95m][40;37m Dashlane" && goto APPS_MENU
if "!choice!"=="30" if "!Dashlane!"=="[40;95m[[40;33mx[40;95m][40;37m Dashlane" set "Dashlane=[40;95m[ ][40;37m Dashlane" && goto APPS_MENU
if "!choice!"=="31" if "!Vortex!"=="[40;95m[ ][40;37m Vortex" set "Vortex=[40;95m[[40;33mx[40;95m][40;37m Vortex" && goto APPS_MENU
if "!choice!"=="31" if "!Vortex!"=="[40;95m[[40;33mx[40;95m][40;37m Vortex" set "Vortex=[40;95m[ ][40;37m Vortex" && goto APPS_MENU
:: Recommended to install
if "!choice!"=="32" if "!Visual C++ Redistributables!"=="[40;95m[ ][40;37m Visual C++ Redistributables" set "Visual C++ Redistributables=[40;95m[[40;33mx[40;95m][40;37m Visual C++ Redistributables" && goto APPS_MENU
if "!choice!"=="32" if "!Visual C++ Redistributables!"=="[40;95m[[40;33mx[40;95m][40;37m Visual C++ Redistributables" set "Visual C++ Redistributables=[40;95m[ ][40;37m Visual C++ Redistributables" && goto APPS_MENU
if "!choice!"=="33" if "!DirectX!"=="[40;95m[ ][40;37m DirectX" set "DirectX=[40;95m[[40;33mx[40;95m][40;37m DirectX" && goto APPS_MENU
if "!choice!"=="33" if "!DirectX!"=="[40;95m[[40;33mx[40;95m][40;37m DirectX" set "DirectX=[40;95m[ ][40;37m DirectX" && goto APPS_MENU
if "!choice!"=="34" if "!.NET Framework 4.8!"=="[40;95m[ ][40;37m .NET Framework 4.8" set ".NET Framework 4.8=[40;95m[[40;33mx[40;95m][40;37m .NET Framework 4.8" && goto APPS_MENU
if "!choice!"=="34" if "!.NET Framework 4.8!"=="[40;95m[[40;33mx[40;95m][40;37m .NET Framework 4.8" set ".NET Framework 4.8=[40;95m[ ][40;37m .NET Framework 4.8" && goto APPS_MENU
if "!choice!"=="" (
    :: Web Browsers
    if "!Chromium!"=="[40;95m[[40;33mx[40;95m][40;37m Chromium" goto APPS_INSTALL
    if "!Mozilla Firefox!"=="[40;95m[[40;33mx[40;95m][40;37m Mozilla Firefox" goto APPS_INSTALL
    if "!Brave!"=="[40;95m[[40;33mx[40;95m][40;37m Brave" goto APPS_INSTALL
    if "!Opera GX!"=="[40;95m[[40;33mx[40;95m][40;37m Opera GX" goto APPS_INSTALL
    :: MEDIA
    if "!Deezer!"=="[40;95m[[40;33mx[40;95m][40;37m Deezer" goto APPS_INSTALL
    if "!Spotify!"=="[40;95m[[40;33mx[40;95m][40;37m Spotify" goto APPS_INSTALL
    if "!PotPlayer!"=="[40;95m[[40;33mx[40;95m][40;37m PotPlayer" goto APPS_INSTALL
    if "!VLC media player!"=="[40;95m[[40;33mx[40;95m][40;37m VLC media player" goto APPS_INSTALL
    :: IMAGING
    if "!ImageGlass!"=="[40;95m[[40;33mx[40;95m][40;37m ImageGlass" goto APPS_INSTALL
    if "!ShareX!"=="[40;95m[[40;33mx[40;95m][40;37m ShareX" goto APPS_INSTALL
    if "!GIMP!"=="[40;95m[[40;33mx[40;95m][40;37m GIMP" goto APPS_INSTALL
    :: MESSAGING
    if "!Discord!"=="[40;95m[[40;33mx[40;95m][40;37m Discord" goto APPS_INSTALL
    if "!Ripcord!"=="[40;95m[[40;33mx[40;95m][40;37m Ripcord" goto APPS_INSTALL
    if "!TeamSpeak!"=="[40;95m[[40;33mx[40;95m][40;37m TeamSpeak" goto APPS_INSTALL
    :: DOCUMENTS
    if "!Foxit Reader!"=="[40;95m[[40;33mx[40;95m][40;37m Foxit Reader" goto APPS_INSTALL
    if "!Microsoft Office!"=="[40;95m[[40;33mx[40;95m][40;37m Microsoft Office" goto APPS_INSTALL
    if "!Libre Office!"=="[40;95m[[40;33mx[40;95m][40;37m Libre Office" goto APPS_INSTALL
    :: COMPRESSION
    if "!Easy 7zip!"=="[40;95m[[40;33mx[40;95m][40;37m Easy 7zip" goto APPS_INSTALL
    if "!Winrar!"=="[40;95m[[40;33mx[40;95m][40;37m Winrar" goto APPS_INSTALL
    :: DEVELOPER TOOLS
    if "!Visual Studio Code!"=="[40;95m[[40;33mx[40;95m][40;37m Visual Studio Code" goto APPS_INSTALL
    if "!Sublime Text!"=="[40;95m[[40;33mx[40;95m][40;37m Sublime Text" goto APPS_INSTALL
    if "!FileZilla!"=="[40;95m[[40;33mx[40;95m][40;37m FileZilla" goto APPS_INSTALL
    if "!PuTTY!"=="[40;95m[[40;33mx[40;95m][40;37m PuTTY" goto APPS_INSTALL
    :: GAMES LAUNCHER
    if "!Steam!"=="[40;95m[[40;33mx[40;95m][40;37m Steam" goto APPS_INSTALL
    if "!GOG Galaxy!"=="[40;95m[[40;33mx[40;95m][40;37m GOG Galaxy" goto APPS_INSTALL
    if "!Epic Games!"=="[40;95m[[40;33mx[40;95m][40;37m Epic Games" goto APPS_INSTALL
    if "!Uplay!"=="[40;95m[[40;33mx[40;95m][40;37m Uplay" goto APPS_INSTALL
    if "!Battle.net!"=="[40;95m[[40;33mx[40;95m][40;37m Battle.net" goto APPS_INSTALL
    if "!Origin!"=="[40;95m[[40;33mx[40;95m][40;37m Origin" goto APPS_INSTALL
    :: OTHERS
    if "!Dashlane!"=="[40;95m[[40;33mx[40;95m][40;37m Dashlane" goto APPS_INSTALL
    if "!Vortex!"=="[40;95m[[40;33mx[40;95m][40;37m Vortex" goto APPS_INSTALL
    :: Recommended to install
    if "!Visual C++ Redistributables!"=="[40;95m[[40;33mx[40;95m][40;37m Visual C++ Redistributables" goto APPS_INSTALL
    if "!DirectX!"=="[40;95m[[40;33mx[40;95m][40;37m DirectX" goto APPS_INSTALL
    if "!.NET Framework 4.8!"=="[40;95m[[40;33mx[40;95m][40;37m .NET Framework 4.8" goto APPS_INSTALL
    echo                                                  [40;31mError : [40;33m"!choice!"[40;90m is not a valid choice...
    timeout /t 3 /nobreak >nul 2>&1
    goto APPS_MENU
)
if /i "!choice!"=="b" goto MAIN_MENU
if /i "!choice!"=="back" goto MAIN_MENU
echo                                                  [40;31mError : [40;33m"!choice!"[40;90m is not a valid choice...
timeout /t 3 /nobreak >nul 2>&1
goto APPS_MENU

:APPS_INSTALL
:: Web Browsers
if "!Chromium!"=="[40;95m[[40;33mx[40;95m][40;37m Chromium" call :CHOCO Chromium
if "!Mozilla Firefox!"=="[40;95m[[40;33mx[40;95m][40;37m Mozilla Firefox" call :CHOCO firefox
if "!Brave!"=="[40;95m[[40;33mx[40;95m][40;37m Brave" call :CHOCO brave
if "!Opera GX!"=="[40;95m[[40;33mx[40;95m][40;37m Opera GX" call :CHOCO opera-gx
:: MEDIA
if "!Deezer!"=="[40;95m[[40;33mx[40;95m][40;37m Deezer" call :CHOCO deezer
if "!Spotify!"=="[40;95m[[40;33mx[40;95m][40;37m Spotify" call :CHOCO spotify
if "!PotPlayer!"=="[40;95m[[40;33mx[40;95m][40;37m PotPlayer" call :CHOCO potplayer
if "!VLC media player!"=="[40;95m[[40;33mx[40;95m][40;37m VLC media player" call :CHOCO vlc
:: IMAGING
if "!ImageGlass!"=="[40;95m[[40;33mx[40;95m][40;37m ImageGlass" call :CHOCO imageglass
if "!ShareX!"=="[40;95m[[40;33mx[40;95m][40;37m ShareX" call :CHOCO sharex
if "!GIMP!"=="[40;95m[[40;33mx[40;95m][40;37m GIMP" call :CHOCO gimp
:: MESSAGING
if "!Discord!"=="[40;95m[[40;33mx[40;95m][40;37m Discord" call :CHOCO discord
if "!Ripcord!"=="[40;95m[[40;33mx[40;95m][40;37m Ripcord" call :CHOCO ripcord & call :SHORTCUT "Ripcord" "%UserProfile%\desktop" "%ProgramData%\chocolatey\lib\ripcord\tools\Ripcord.exe" "%ProgramData%\chocolatey\lib\ripcord\tools"
if "!TeamSpeak!"=="[40;95m[[40;33mx[40;95m][40;37m TeamSpeak" call :CHOCO teamspeak
:: DOCUMENTS
if "!Foxit Reader!"=="[40;95m[[40;33mx[40;95m][40;37m Foxit Reader" call :CHOCO foxitreader
if "!Microsoft Office!"=="[40;95m[[40;33mx[40;95m][40;37m Microsoft Office" call :CHOCO office-tool & call :SHORTCUT "Office Tool Plus" "%UserProfile%\desktop" "%LocalAppData%\Office Tool\Office Tool Plus.exe" "%LocalAppData%\Office Tool"
if "!Libre Office!"=="[40;95m[[40;33mx[40;95m][40;37m Libre Office" call :CHOCO libreoffice-fresh
:: COMPRESSION
if "!Easy 7zip!"=="[40;95m[[40;33mx[40;95m][40;37m Easy 7zip" call :CHOCO easy7zip
if "!Winrar!"=="[40;95m[[40;33mx[40;95m][40;37m Winrar" call :CHOCO winrar
:: DEVELOPER TOOLS
if "!Visual Studio Code!"=="[40;95m[[40;33mx[40;95m][40;37m Visual Studio Code" call :CHOCO vscode
if "!Sublime Text!"=="[40;95m[[40;33mx[40;95m][40;37m Sublime Text" call :CHOCO sublimetext3
if "!FileZilla!"=="[40;95m[[40;33mx[40;95m][40;37m FileZilla" call :CHOCO filezilla
if "!PuTTY!"=="[40;95m[[40;33mx[40;95m][40;37m PuTTY" call :CHOCO putty
:: GAMES LAUNCHER
if "!Steam!"=="[40;95m[[40;33mx[40;95m][40;37m Steam" call :CHOCO steam
if "!GOG Galaxy!"=="[40;95m[[40;33mx[40;95m][40;37m GOG Galaxy" call :CHOCO goggalaxy
if "!Epic Games!"=="[40;95m[[40;33mx[40;95m][40;37m Epic Games" call :CHOCO epicgameslauncher
if "!Uplay!"=="[40;95m[[40;33mx[40;95m][40;37m Uplay" call :CHOCO uplay
if "!Battle.net!"=="[40;95m[[40;33mx[40;95m][40;37m Battle.net" call :CHOCO battle.net
if "!Origin!"=="[40;95m[[40;33mx[40;95m][40;37m Origin" call :CHOCO origin & call :SHORTCUT "Origin" "%UserProfile%\desktop" "\Program Files (x86)\Origin\Origin.exe" "\Program Files (x86)\Origin"
:: OTHERS
if "!Dashlane!"=="[40;95m[[40;33mx[40;95m][40;37m Dashlane" call :CHOCO dashlane
if "!Vortex!"=="[40;95m[[40;33mx[40;95m][40;37m Vortex" call :CHOCO vortex
:: Recommended to install
if "!Visual C++ Redistributables!"=="[40;95m[[40;33mx[40;95m][40;37m Visual C++ Redistributables" call :CHOCO vcredist-all
if "!DirectX!"=="[40;95m[[40;33mx[40;95m][40;37m DirectX" call :CHOCO directx
IF "!.NET Framework 4.8!"=="[40;95m[[40;33mx[40;95m][40;37m .NET Framework 4.8" call :CHOCO dotnetfx
goto APPS_MENU_CLEAR



:TOOLS_MENU_CLEAR
:: UTILITIES
set "NSudo=[40;95m[ ][40;37m NSudo"
set "Autoruns=[40;95m[ ][40;37m Autoruns"
set "ServiWin=[40;95m[ ][40;37m ServiWin"
set "Memory Booster=[40;95m[ ][40;37m Memory Booster"
set "Device Cleanup=[40;95m[ ][40;37m Device Cleanup"
set "MSI Afterburner=[40;95m[ ][40;37m MSI Afterburner"
:: SYSTEM INFOS
set "CPU-Z=[40;95m[ ][40;37m CPU-Z"
set "GPU-Z=[40;95m[ ][40;37m GPU-Z"
set "HWiNFO=[40;95m[ ][40;37m HWiNFO"
set "CrystalDiskInfo=[40;95m[ ][40;37m CrystalDiskInfo"
:: DRIVERS
set "Snappy Driver Installer=[40;95m[ ][40;37m Snappy Driver Installer"
set "NVCleanstall=[40;95m[ ][40;37m NVCleanstall"
set "Radeon Software Slimmer=[40;95m[ ][40;37m Radeon Software Slimmer"
set "Display Driver Uninstaller=[40;95m[ ][40;37m Display Driver Uninstaller"
:: BENCHMARK & STRESS
set "Unigine Superposition=[40;95m[ ][40;37m Unigine Superposition"
set "CINEBENCH=[40;95m[ ][40;37m CINEBENCH"
set "AIDA64=[40;95m[ ][40;37m AIDA64"
set "OCCT=[40;95m[ ][40;37m OCCT"
:: TWEAKS
set "MSI Util v3=[40;95m[ ][40;37m MSI Util v3"
set "Interrupt Affinity=[40;95m[ ][40;37m Interrupt Affinity"
set "TCP Optimizer=[40;95m[ ][40;37m TCP Optimizer"
set "WLAN Optimizer=[40;95m[ ][40;37m WLAN Optimizer"
set "Nvidia Profile Inspector=[40;95m[ ][40;37m Nvidia Profile Inspector"
set "Nvlddmkm Patcher=[40;95m[ ][40;37m Nvlddmkm Patcher"
set "Custom Resolution Utility=[40;95m[ ][40;37m Custom Resolution Utility"
set "SweetLow Mouse Rate Changer=[40;95m[ ][40;37m SweetLow Mouse Rate Changer"

:TOOLS_MENU
cls
mode con lines=27 cols=150
echo [40;95m
echo                                ╔═════════════════════════════════════════════════════════════════════════════════════╗
echo                                ║                                        [40;33mTOOLS[40;95m                                        ║
echo                                ╚═════════════════════════════════════════════════════════════════════════════════════╝
echo.
echo              [40;93mUTILITIES                                    SYSTEM INFOS                                 DRIVERS
echo              [40;93m---------                                    ------------                                 -------
echo               [40;33m1 !NSudo!                                  [40;33m7 !CPU-Z!                                 [40;33m11 !Snappy Driver Installer!
echo               [40;33m2 !Autoruns!                               [40;33m8 !GPU-Z!                                 [40;33m12 !NVCleanstall!
echo               [40;33m3 !ServiWin!                               [40;33m9 !HWiNFO!                                [40;33m13 !Radeon Software Slimmer!
echo               [40;33m4 !Memory Booster!                        [40;33m10 !CrystalDiskInfo!                       [40;33m14 !Display Driver Uninstaller!
echo               [40;33m5 !Device Cleanup!
echo               [40;33m6 !MSI Afterburner!
echo.
echo              [40;93mBENCHMARK ^& STRESS                           TWEAKS
echo              [40;93m------------------                           ------
echo              [40;33m15 !Unigine Superposition!                 [40;33m19 !MSI Util v3!                           [40;33m23 !Nvidia Profile Inspector!
echo              [40;33m16 !CINEBENCH!                             [40;33m20 !Interrupt Affinity!                    [40;33m24 !Nvlddmkm Patcher!
echo              [40;33m17 !AIDA64!                                [40;33m21 !TCP Optimizer!                         [40;33m25 !Custom Resolution Utility!
echo              [40;33m18 !OCCT!                                  [40;33m22 !WLAN Optimizer!                        [40;33m26 !SweetLow Mouse Rate Changer!
echo.
echo                                                              [40;90mMake your choices or [40;33m"BACK"[40;90m
echo.
set choice=
set /p "choice=[40;33m                                                                          "
:: UTILITIES
if "!choice!"=="1" if "!NSudo!"=="[40;95m[ ][40;37m NSudo" set "NSudo=[40;95m[[40;33mx[40;95m][40;37m NSudo" && goto TOOLS_MENU
if "!choice!"=="1" if "!NSudo!"=="[40;95m[[40;33mx[40;95m][40;37m NSudo" set "NSudo=[40;95m[ ][40;37m NSudo" && goto TOOLS_MENU
if "!choice!"=="2" if "!Autoruns!"=="[40;95m[ ][40;37m Autoruns" set "Autoruns=[40;95m[[40;33mx[40;95m][40;37m Autoruns" && goto TOOLS_MENU
if "!choice!"=="2" if "!Autoruns!"=="[40;95m[[40;33mx[40;95m][40;37m Autoruns" set "Autoruns=[40;95m[ ][40;37m Autoruns" && goto TOOLS_MENU
if "!choice!"=="3" if "!ServiWin!"=="[40;95m[ ][40;37m ServiWin" set "ServiWin=[40;95m[[40;33mx[40;95m][40;37m ServiWin" && goto TOOLS_MENU
if "!choice!"=="3" if "!ServiWin!"=="[40;95m[[40;33mx[40;95m][40;37m ServiWin" set "ServiWin=[40;95m[ ][40;37m ServiWin" && goto TOOLS_MENU
if "!choice!"=="4" if "!Memory Booster!"=="[40;95m[ ][40;37m Memory Booster" set "Memory Booster=[40;95m[[40;33mx[40;95m][40;37m Memory Booster" && goto TOOLS_MENU
if "!choice!"=="4" if "!Memory Booster!"=="[40;95m[[40;33mx[40;95m][40;37m Memory Booster" set "Memory Booster=[40;95m[ ][40;37m Memory Booster" && goto TOOLS_MENU
if "!choice!"=="5" if "!Device Cleanup!"=="[40;95m[ ][40;37m Device Cleanup" set "Device Cleanup=[40;95m[[40;33mx[40;95m][40;37m Device Cleanup" && goto TOOLS_MENU
if "!choice!"=="5" if "!Device Cleanup!"=="[40;95m[[40;33mx[40;95m][40;37m Device Cleanup" set "Device Cleanup=[40;95m[ ][40;37m Device Cleanup" && goto TOOLS_MENU
if "!choice!"=="6" if "!MSI Afterburner!"=="[40;95m[ ][40;37m MSI Afterburner" set "MSI Afterburner=[40;95m[[40;33mx[40;95m][40;37m MSI Afterburner" && goto TOOLS_MENU
if "!choice!"=="6" if "!MSI Afterburner!"=="[40;95m[[40;33mx[40;95m][40;37m MSI Afterburner" set "MSI Afterburner=[40;95m[ ][40;37m MSI Afterburner" && goto TOOLS_MENU
:: SYSTEM INFOS
if "!choice!"=="7" if "!CPU-Z!"=="[40;95m[ ][40;37m CPU-Z" set "CPU-Z=[40;95m[[40;33mx[40;95m][40;37m CPU-Z" && goto TOOLS_MENU
if "!choice!"=="7" if "!CPU-Z!"=="[40;95m[[40;33mx[40;95m][40;37m CPU-Z" set "CPU-Z=[40;95m[ ][40;37m CPU-Z" && goto TOOLS_MENU
if "!choice!"=="8" if "!GPU-Z!"=="[40;95m[ ][40;37m GPU-Z" set "GPU-Z=[40;95m[[40;33mx[40;95m][40;37m GPU-Z" && goto TOOLS_MENU
if "!choice!"=="8" if "!GPU-Z!"=="[40;95m[[40;33mx[40;95m][40;37m GPU-Z" set "GPU-Z=[40;95m[ ][40;37m GPU-Z" && goto TOOLS_MENU
if "!choice!"=="9" if "!HWiNFO!"=="[40;95m[ ][40;37m HWiNFO" set "HWiNFO=[40;95m[[40;33mx[40;95m][40;37m HWiNFO" && goto TOOLS_MENU
if "!choice!"=="9" if "!HWiNFO!"=="[40;95m[[40;33mx[40;95m][40;37m HWiNFO" set "HWiNFO=[40;95m[ ][40;37m HWiNFO" && goto TOOLS_MENU
if "!choice!"=="10" if "!CrystalDiskInfo!"=="[40;95m[ ][40;37m CrystalDiskInfo" set "CrystalDiskInfo=[40;95m[[40;33mx[40;95m][40;37m CrystalDiskInfo" && goto TOOLS_MENU
if "!choice!"=="10" if "!CrystalDiskInfo!"=="[40;95m[[40;33mx[40;95m][40;37m CrystalDiskInfo" set "CrystalDiskInfo=[40;95m[ ][40;37m CrystalDiskInfo" && goto TOOLS_MENU
:: DRIVERS
if "!choice!"=="11" if "!Snappy Driver Installer!"=="[40;95m[ ][40;37m Snappy Driver Installer" set "Snappy Driver Installer=[40;95m[[40;33mx[40;95m][40;37m Snappy Driver Installer" && goto TOOLS_MENU
if "!choice!"=="11" if "!Snappy Driver Installer!"=="[40;95m[[40;33mx[40;95m][40;37m Snappy Driver Installer" set "Snappy Driver Installer=[40;95m[ ][40;37m Snappy Driver Installer" && goto TOOLS_MENU
if "!choice!"=="12" if "!NVCleanstall!"=="[40;95m[ ][40;37m NVCleanstall" set "NVCleanstall=[40;95m[[40;33mx[40;95m][40;37m NVCleanstall" && goto TOOLS_MENU
if "!choice!"=="12" if "!NVCleanstall!"=="[40;95m[[40;33mx[40;95m][40;37m NVCleanstall" set "NVCleanstall=[40;95m[ ][40;37m NVCleanstall" && goto TOOLS_MENU
if "!choice!"=="13" if "!Radeon Software Slimmer!"=="[40;95m[ ][40;37m Radeon Software Slimmer" set "Radeon Software Slimmer=[40;95m[[40;33mx[40;95m][40;37m Radeon Software Slimmer" && goto TOOLS_MENU
if "!choice!"=="13" if "!Radeon Software Slimmer!"=="[40;95m[[40;33mx[40;95m][40;37m Radeon Software Slimmer" set "Radeon Software Slimmer=[40;95m[ ][40;37m Radeon Software Slimmer" && goto TOOLS_MENU
if "!choice!"=="14" if "!Display Driver Uninstaller!"=="[40;95m[ ][40;37m Display Driver Uninstaller" set "Display Driver Uninstaller=[40;95m[[40;33mx[40;95m][40;37m Display Driver Uninstaller" && goto TOOLS_MENU
if "!choice!"=="14" if "!Display Driver Uninstaller!"=="[40;95m[[40;33mx[40;95m][40;37m Display Driver Uninstaller" set "Display Driver Uninstaller=[40;95m[ ][40;37m Display Driver Uninstaller" && goto TOOLS_MENU
:: BENCHMARK & STRESS
if "!choice!"=="15" if "!Unigine Superposition!"=="[40;95m[ ][40;37m Unigine Superposition" set "Unigine Superposition=[40;95m[[40;33mx[40;95m][40;37m Unigine Superposition" && goto TOOLS_MENU
if "!choice!"=="15" if "!Unigine Superposition!"=="[40;95m[[40;33mx[40;95m][40;37m Unigine Superposition" set "Unigine Superposition=[40;95m[ ][40;37m Unigine Superposition" && goto TOOLS_MENU
if "!choice!"=="16" if "!CINEBENCH!"=="[40;95m[ ][40;37m CINEBENCH" set "CINEBENCH=[40;95m[[40;33mx[40;95m][40;37m CINEBENCH" && goto TOOLS_MENU
if "!choice!"=="16" if "!CINEBENCH!"=="[40;95m[[40;33mx[40;95m][40;37m CINEBENCH" set "CINEBENCH=[40;95m[ ][40;37m CINEBENCH" && goto TOOLS_MENU
if "!choice!"=="17" if "!AIDA64!"=="[40;95m[ ][40;37m AIDA64" set "AIDA64=[40;95m[[40;33mx[40;95m][40;37m AIDA64" && goto TOOLS_MENU
if "!choice!"=="17" if "!AIDA64!"=="[40;95m[[40;33mx[40;95m][40;37m AIDA64" set "AIDA64=[40;95m[ ][40;37m AIDA64" && goto TOOLS_MENU
if "!choice!"=="18" if "!OCCT!"=="[40;95m[ ][40;37m OCCT" set "OCCT=[40;95m[[40;33mx[40;95m][40;37m OCCT" && goto TOOLS_MENU
if "!choice!"=="18" if "!OCCT!"=="[40;95m[[40;33mx[40;95m][40;37m OCCT" set "OCCT=[40;95m[ ][40;37m OCCT" && goto TOOLS_MENU
:: TWEAKS
if "!choice!"=="19" if "!MSI Util v3!"=="[40;95m[ ][40;37m MSI Util v3" set "MSI Util v3=[40;95m[[40;33mx[40;95m][40;37m MSI Util v3" && goto TOOLS_MENU
if "!choice!"=="19" if "!MSI Util v3!"=="[40;95m[[40;33mx[40;95m][40;37m MSI Util v3" set "MSI Util v3=[40;95m[ ][40;37m MSI Util v3" && goto TOOLS_MENU
if "!choice!"=="20" if "!Interrupt Affinity!"=="[40;95m[ ][40;37m Interrupt Affinity" set "Interrupt Affinity=[40;95m[[40;33mx[40;95m][40;37m Interrupt Affinity" && goto TOOLS_MENU
if "!choice!"=="20" if "!Interrupt Affinity!"=="[40;95m[[40;33mx[40;95m][40;37m Interrupt Affinity" set "Interrupt Affinity=[40;95m[ ][40;37m Interrupt Affinity" && goto TOOLS_MENU
if "!choice!"=="21" if "!TCP Optimizer!"=="[40;95m[ ][40;37m TCP Optimizer" set "TCP Optimizer=[40;95m[[40;33mx[40;95m][40;37m TCP Optimizer" && goto TOOLS_MENU
if "!choice!"=="21" if "!TCP Optimizer!"=="[40;95m[[40;33mx[40;95m][40;37m TCP Optimizer" set "TCP Optimizer=[40;95m[ ][40;37m TCP Optimizer" && goto TOOLS_MENU
if "!choice!"=="22" if "!WLAN Optimizer!"=="[40;95m[ ][40;37m WLAN Optimizer" set "WLAN Optimizer=[40;95m[[40;33mx[40;95m][40;37m WLAN Optimizer" && goto TOOLS_MENU
if "!choice!"=="22" if "!WLAN Optimizer!"=="[40;95m[[40;33mx[40;95m][40;37m WLAN Optimizer" set "WLAN Optimizer=[40;95m[ ][40;37m WLAN Optimizer" && goto TOOLS_MENU
if "!choice!"=="23" if "!Nvidia Profile Inspector!"=="[40;95m[ ][40;37m Nvidia Profile Inspector" set "Nvidia Profile Inspector=[40;95m[[40;33mx[40;95m][40;37m Nvidia Profile Inspector" && goto TOOLS_MENU
if "!choice!"=="23" if "!Nvidia Profile Inspector!"=="[40;95m[[40;33mx[40;95m][40;37m Nvidia Profile Inspector" set "Nvidia Profile Inspector=[40;95m[ ][40;37m Nvidia Profile Inspector" && goto TOOLS_MENU
if "!choice!"=="24" if "!Nvlddmkm Patcher!"=="[40;95m[ ][40;37m Nvlddmkm Patcher" set "Nvlddmkm Patcher=[40;95m[[40;33mx[40;95m][40;37m Nvlddmkm Patcher" && goto TOOLS_MENU
if "!choice!"=="24" if "!Nvlddmkm Patcher!"=="[40;95m[[40;33mx[40;95m][40;37m Nvlddmkm Patcher" set "Nvlddmkm Patcher=[40;95m[ ][40;37m Nvlddmkm Patcher" && goto TOOLS_MENU
if "!choice!"=="25" if "!Custom Resolution Utility!"=="[40;95m[ ][40;37m Custom Resolution Utility" set "Custom Resolution Utility=[40;95m[[40;33mx[40;95m][40;37m Custom Resolution Utility" && goto TOOLS_MENU
if "!choice!"=="25" if "!Custom Resolution Utility!"=="[40;95m[[40;33mx[40;95m][40;37m Custom Resolution Utility" set "Custom Resolution Utility=[40;95m[ ][40;37m Custom Resolution Utility" && goto TOOLS_MENU
if "!choice!"=="26" if "!SweetLow Mouse Rate Changer!"=="[40;95m[ ][40;37m SweetLow Mouse Rate Changer" set "SweetLow Mouse Rate Changer=[40;95m[[40;33mx[40;95m][40;37m SweetLow Mouse Rate Changer" && goto TOOLS_MENU
if "!choice!"=="26" if "!SweetLow Mouse Rate Changer!"=="[40;95m[[40;33mx[40;95m][40;37m SweetLow Mouse Rate Changer" set "SweetLow Mouse Rate Changer=[40;95m[ ][40;37m SweetLow Mouse Rate Changer" && goto TOOLS_MENU
if "!choice!"=="" (
    :: UTILITIES
    if "!NSudo!"=="[40;95m[[40;33mx[40;95m][40;37m NSudo" goto TOOLS_INSTALL
    if "!Autoruns!"=="[40;95m[[40;33mx[40;95m][40;37m Autoruns" goto TOOLS_INSTALL
    if "!ServiWin!"=="[40;95m[[40;33mx[40;95m][40;37m ServiWin" goto TOOLS_INSTALL
    if "!Memory Booster!"=="[40;95m[[40;33mx[40;95m][40;37m Memory Booster" goto TOOLS_INSTALL
    if "!Device Cleanup!"=="[40;95m[[40;33mx[40;95m][40;37m Device Cleanup" goto TOOLS_INSTALL
    if "!MSI Afterburner!"=="[40;95m[[40;33mx[40;95m][40;37m MSI Afterburner" goto TOOLS_INSTALL
    :: SYSTEM INFOS
    if "!CPU-Z!"=="[40;95m[[40;33mx[40;95m][40;37m CPU-Z" goto TOOLS_INSTALL
    if "!GPU-Z!"=="[40;95m[[40;33mx[40;95m][40;37m GPU-Z" goto TOOLS_INSTALL
    if "!HWiNFO!"=="[40;95m[[40;33mx[40;95m][40;37m HWiNFO" goto TOOLS_INSTALL
    if "!CrystalDiskInfo!"=="[40;95m[[40;33mx[40;95m][40;37m CrystalDiskInfo" goto TOOLS_INSTALL
    :: DRIVERS
    if "!Snappy Driver Installer!"=="[40;95m[[40;33mx[40;95m][40;37m Snappy Driver Installer" goto TOOLS_INSTALL
    if "!NVCleanstall!"=="[40;95m[[40;33mx[40;95m][40;37m NVCleanstall" goto TOOLS_INSTALL
    if "!Radeon Software Slimmer!"=="[40;95m[[40;33mx[40;95m][40;37m Radeon Software Slimmer" goto TOOLS_INSTALL
    if "!Display Driver Uninstaller!"=="[40;95m[[40;33mx[40;95m][40;37m Display Driver Uninstaller" goto TOOLS_INSTALL
    :: BENCHMARK & STRESS
    if "!Unigine Superposition!"=="[40;95m[[40;33mx[40;95m][40;37m Unigine Superposition" goto TOOLS_INSTALL
    if "!CINEBENCH!"=="[40;95m[[40;33mx[40;95m][40;37m CINEBENCH" goto TOOLS_INSTALL
    if "!AIDA64!"=="[40;95m[[40;33mx[40;95m][40;37m AIDA64" goto TOOLS_INSTALL
    if "!OCCT!"=="[40;95m[[40;33mx[40;95m][40;37m OCCT" goto TOOLS_INSTALL
    :: TWEAKS
    if "!MSI Util v3!"=="[40;95m[[40;33mx[40;95m][40;37m MSI Util v3" goto TOOLS_INSTALL
    if "!Interrupt Affinity!"=="[40;95m[[40;33mx[40;95m][40;37m Interrupt Affinity" goto TOOLS_INSTALL
    if "!TCP Optimizer!"=="[40;95m[[40;33mx[40;95m][40;37m TCP Optimizer" goto TOOLS_INSTALL
    if "!WLAN Optimizer!"=="[40;95m[[40;33mx[40;95m][40;37m WLAN Optimizer" goto TOOLS_INSTALL
    if "!Nvidia Profile Inspector!"=="[40;95m[[40;33mx[40;95m][40;37m Nvidia Profile Inspector" goto TOOLS_INSTALL
    if "!Nvlddmkm Patcher!"=="[40;95m[[40;33mx[40;95m][40;37m Nvlddmkm Patcher" goto TOOLS_INSTALL
    if "!Custom Resolution Utility!"=="[40;95m[[40;33mx[40;95m][40;37m Custom Resolution Utility" goto TOOLS_INSTALL
    if "!SweetLow Mouse Rate Changer!"=="[40;95m[[40;33mx[40;95m][40;37m SweetLow Mouse Rate Changer" goto TOOLS_INSTALL
    echo                                                          [40;31mError : [40;33m"!choice!"[40;90m is not a valid choice...
    timeout /t 3 /nobreak >nul 2>&1
    goto TOOLS_INSTALL
)
if /i "!choice!"=="b" goto MAIN_MENU
if /i "!choice!"=="back" goto MAIN_MENU
echo                                                          [40;31mError : [40;33m"!choice!"[40;90m is not a valid choice...
timeout /t 3 /nobreak >nul 2>&1
goto TOOLS_MENU

:TOOLS_INSTALL
set "OPENTOOLS=False"
:: UTILITIES
if "!NSudo!"=="[40;95m[[40;33mx[40;95m][40;37m NSudo" set "OPENTOOLS=True" & call :CURL -L --progress-bar "https://cdn.discordapp.com/attachments/595370063104573511/755786967660101702/NSudo.exe" --create-dirs -o "%UserProfile%\Documents\_Tools\NSudo.exe"
if "!Autoruns!"=="[40;95m[[40;33mx[40;95m][40;37m Autoruns" set "OPENTOOLS=True" & call :CURL -L --progress-bar "https://cdn.discordapp.com/attachments/595370063104573511/755789664627064902/Autoruns.exe" --create-dirs -o "%UserProfile%\Documents\_Tools\Autoruns.exe"
if "!ServiWin!"=="[40;95m[[40;33mx[40;95m][40;37m ServiWin" set "OPENTOOLS=True" & call :CURL -L --progress-bar "https://cdn.discordapp.com/attachments/595370063104573511/755791010893660190/ServiWin.exe" --create-dirs -o "%UserProfile%\Documents\_Tools\ServiWin.exe"
if "!Memory Booster!"=="[40;95m[[40;33mx[40;95m][40;37m Memory Booster" set "OPENTOOLS=True" & call :CURL -L --progress-bar "https://cdn.discordapp.com/attachments/595370063104573511/755787065974849638/MemoryBooster_2.1.exe" --create-dirs -o "%UserProfile%\Documents\_Tools\MemoryBooster.exe"
if "!Device Cleanup!"=="[40;95m[[40;33mx[40;95m][40;37m Device Cleanup" set "OPENTOOLS=True" & call :CURL -L --progress-bar "https://cdn.discordapp.com/attachments/595370063104573511/755790659356590080/DeviceCleanup.exe" --create-dirs -o "%UserProfile%\Documents\_Tools\DeviceCleanup.exe"
if "!MSI Afterburner!"=="[40;95m[[40;33mx[40;95m][40;37m MSI Afterburner" call :CHOCO msiafterburner
:: SYSTEM INFOS
if "!CPU-Z!"=="[40;95m[[40;33mx[40;95m][40;37m CPU-Z" set "OPENTOOLS=True" & call :CURL -L --progress-bar "https://cdn.discordapp.com/attachments/595370063104573511/755790662346997910/CPU-Z.exe" --create-dirs -o "%UserProfile%\Documents\_Tools\CPU-Z.exe"
if "!GPU-Z!"=="[40;95m[[40;33mx[40;95m][40;37m GPU-Z" set "OPENTOOLS=True" & call :CURL -L --progress-bar "https://nl1-dl.techpowerup.com/files/GPU-Z.2.34.0.exe#/GPU-Z.2.34.0.exe" --create-dirs -o "%UserProfile%\Documents\_Tools\GPU-Z.exe"
if "!HWiNFO!"=="[40;95m[[40;33mx[40;95m][40;37m HWiNFO" (
    set "OPENTOOLS=True"
    call :CURL -L --progress-bar "https://www.sac.sk/download/utildiag/hwi_630.zip" --create-dirs -o "%UserProfile%\Documents\_Tools\HWiNFO\hwi_630.zip"
    call "modules\7z.exe" x -aoa "%UserProfile%\Documents\_Tools\HWiNFO\hwi_630.zip" -O"%UserProfile%\Documents\_Tools\HWiNFO" >nul 2>&1
    del /f /q "%UserProfile%\Documents\_Tools\HWiNFO\hwi_630.zip" >nul 2>&1
)
if "!CrystalDiskInfo!"=="[40;95m[[40;33mx[40;95m][40;37m CrystalDiskInfo" (
    set "OPENTOOLS=True"
    call :CURL -L --progress-bar "https://dotsrc.dl.osdn.net/osdn/crystaldiskinfo/73507/CrystalDiskInfo8_8_7.zip" --create-dirs -o "%UserProfile%\Documents\_Tools\CrystalDiskInfo\CrystalDiskInfo8_8_7.zip"
    call "modules\7z.exe" x -aoa "%UserProfile%\Documents\_Tools\CrystalDiskInfo\CrystalDiskInfo8_8_7.zip"  -O"%UserProfile%\Documents\_Tools\CrystalDiskInfo">nul 2>&1
    del /f /q "%UserProfile%\Documents\_Tools\CrystalDiskInfo\CrystalDiskInfo8_8_7.zip" >nul 2>&1
)
:: DRIVERS
if "!Snappy Driver Installer!"=="[40;95m[[40;33mx[40;95m][40;37m Snappy Driver Installer" (
    set "OPENTOOLS=True"
    call :CURL -L --progress-bar "http://sdi-tool.org/releases/SDI_R2000.zip" --create-dirs -o "%UserProfile%\Documents\_Tools\Snappy Driver Installer\SDI.zip"
    call "modules\7z.exe" x -aoa "%UserProfile%\Documents\_Tools\Snappy Driver Installer\SDI.zip"  -O"%UserProfile%\Documents\_Tools\Snappy Driver Installer">nul 2>&1
    del /f /q "%UserProfile%\Documents\_Tools\Snappy Driver Installer\SDI.zip" >nul 2>&1
)
if "!NVCleanstall!"=="[40;95m[[40;33mx[40;95m][40;37m NVCleanstall" set "OPENTOOLS=True" & call :CURL -L --progress-bar "https://nl1-dl.techpowerup.com/files/NVCleanstall_1.7.0.exe#/NVCleanstall.exe" --create-dirs -o "%UserProfile%\Documents\_Tools\NVCleanstall.exe"
if "!Radeon Software Slimmer!"=="[40;95m[[40;33mx[40;95m][40;37m Radeon Software Slimmer" (
    set "OPENTOOLS=True"
    call :CURL -L --progress-bar "https://github.com/GSDragoon/RadeonSoftwareSlimmer/releases/download/1.0.0-beta.6/RadeonSoftwareSlimmer_1.0.0-beta.6_net48.zip" --create-dirs -o "%UserProfile%\Documents\_Tools\Radeon Software Slimmer\RadeonSoftwareSlimmer.zip"
    call "modules\7z.exe" x -aoa "%UserProfile%\Documents\_Tools\Radeon Software Slimmer\RadeonSoftwareSlimmer.zip"  -O"%UserProfile%\Documents\_Tools\Radeon Software Slimmer">nul 2>&1
    del /f /q "%UserProfile%\Documents\_Tools\Radeon Software Slimmer\RadeonSoftwareSlimmer.zip" >nul 2>&1
)
if "!Display Driver Uninstaller!"=="[40;95m[[40;33mx[40;95m][40;37m Display Driver Uninstaller" (
    set "OPENTOOLS=True"
    call :CURL -L --progress-bar "https://cdn.discordapp.com/attachments/595370063104573511/762442679254384690/DDU.exe" --create-dirs -o "%UserProfile%\Documents\_Tools\Display Driver Uninstaller\DDU.exe"
    call "modules\7z.exe" x -aoa "%UserProfile%\Documents\_Tools\Display Driver Uninstaller\DDU.exe" -O"%UserProfile%\Documents\_Tools\Display Driver Uninstaller" >nul 2>&1
    move "%UserProfile%\Documents\_Tools\Display Driver Uninstaller\DDU v18.0.3.3\*" "%UserProfile%\Documents\_Tools\Display Driver Uninstaller" >nul 2>&1
    rd /s /q "%UserProfile%\Documents\_Tools\Display Driver Uninstaller\DDU v18.0.3.3" >nul 2>&1
    del /f /q "%UserProfile%\Documents\_Tools\Display Driver Uninstaller\DDU.exe" >nul 2>&1
)
:: BENCHMARK & STRESS
if "!Unigine Superposition!"=="[40;95m[[40;33mx[40;95m][40;37m Unigine Superposition" call :CHOCO superposition-benchmark
if "!CINEBENCH!"=="[40;95m[[40;33mx[40;95m][40;37m CINEBENCH" (
    set "OPENTOOLS=True"
    call :CURL -L --progress-bar "http://http.maxon.net/pub/cinebench/CinebenchR20.zip" --create-dirs -o "%UserProfile%\Documents\_Tools\Cinebench\CinebenchR20.zip"
    call "modules\7z.exe" x -aoa "%UserProfile%\Documents\_Tools\Cinebench\CinebenchR20.zip" -O"%UserProfile%\Documents\_Tools\Cinebench" >nul 2>&1
    del /f /q "%UserProfile%\Documents\_Tools\Cinebench\CinebenchR20.zip" >nul 2>&1
)
if "!AIDA64!"=="[40;95m[[40;33mx[40;95m][40;37m AIDA64" (
    set "OPENTOOLS=True"
    call :CURL -L --progress-bar "https://download.aida64.com/aida64extreme625.zip" --create-dirs -o "%UserProfile%\Documents\_Tools\AIDA64\aida64extreme625.zip"
    call "modules\7z.exe" x -aoa "%UserProfile%\Documents\_Tools\AIDA64\aida64extreme625.zip" -O"%UserProfile%\Documents\_Tools\AIDA64" >nul 2>&1
    del /f /q "%UserProfile%\Documents\_Tools\AIDA64\aida64extreme625.zip" >nul 2>&1
)
if "!OCCT!"=="[40;95m[[40;33mx[40;95m][40;37m OCCT" set "OPENTOOLS=True" & call :CURL -L --progress-bar "https://www.ocbase.com/download" --create-dirs -o "%UserProfile%\Documents\_Tools\OCCT.exe"
:: TWEAKS
if "!MSI Util v3!"=="[40;95m[[40;33mx[40;95m][40;37m MSI Util v3" set "OPENTOOLS=True" & call :CURL -L --progress-bar "https://cdn.discordapp.com/attachments/595370063104573511/755786950610255896/MSI_util_v3.exe" --create-dirs -o "%UserProfile%\Documents\_Tools\MSI_util_v3.exe"
if "!Interrupt Affinity!"=="[40;95m[[40;33mx[40;95m][40;37m Interrupt Affinity" set "OPENTOOLS=True" & call :CURL -L --progress-bar "https://cdn.discordapp.com/attachments/595370063104573511/755786953223438346/InterruptAffinity.exe" --create-dirs -o "%UserProfile%\Documents\_Tools\InterruptAffinity.exe"
if "!TCP Optimizer!"=="[40;95m[[40;33mx[40;95m][40;37m TCP Optimizer" set "OPENTOOLS=True" & call :CURL -L --progress-bar "https://www.speedguide.net/files/TCPOptimizer.exe" --create-dirs -o "%UserProfile%\Documents\_Tools\TCPOptimizer.exe"
if "!WLAN Optimizer!"=="[40;95m[[40;33mx[40;95m][40;37m WLAN Optimizer" (
    set "OPENTOOLS=True"
    call :CURL -L --progress-bar "http://www.martin-majowski.de/downloads/wopt021.zip" --create-dirs -o "%UserProfile%\Documents\_Tools\WLAN Optimizer\wopt.zip"
    call "modules\7z.exe" x -aoa "%UserProfile%\Documents\_Tools\WLAN Optimizer\wopt.zip" -O"%UserProfile%\Documents\_Tools\WLAN Optimizer" >nul 2>&1
    del /f /q "%UserProfile%\Documents\_Tools\WLAN Optimizer\wopt.zip" >nul 2>&1
)
if "!Nvidia Profile Inspector!"=="[40;95m[[40;33mx[40;95m][40;37m Nvidia Profile Inspector" (
    set "OPENTOOLS=True"
    call :CURL -L --progress-bar "https://github.com/Orbmu2k/nvidiaProfileInspector/releases/download/2.3.0.12/nvidiaProfileInspector.zip" --create-dirs -o "%UserProfile%\Documents\_Tools\Nvidia Profile Inspector\nvidiaProfileInspector.zip"
    call "modules\7z.exe" x -aoa "%UserProfile%\Documents\_Tools\Nvidia Profile Inspector\nvidiaProfileInspector.zip" -O"%UserProfile%\Documents\_Tools\Nvidia Profile Inspector" >nul 2>&1
    del /f /q "%UserProfile%\Documents\_Tools\Nvidia Profile Inspector\nvidiaProfileInspector.zip" >nul 2>&1
)
if "!Nvlddmkm Patcher!"=="[40;95m[[40;33mx[40;95m][40;37m Nvlddmkm Patcher" (
    set "OPENTOOLS=True"
    call :CURL -L --progress-bar "https://www.monitortests.com/download/nvlddmkm-patcher/nvlddmkm-patcher-1.4.12.zip" --create-dirs -o "%UserProfile%\Documents\_Tools\nvlddmkm-patcher.zip"
    call "modules\7z.exe" x -aoa "%UserProfile%\Documents\_Tools\nvlddmkm-patcher.zip" -O"%UserProfile%\Documents\_Tools\" >nul 2>&1
    del /f /q "%UserProfile%\Documents\_Tools\nvlddmkm-patcher.zip" >nul 2>&1
)
if "!Custom Resolution Utility!"=="[40;95m[[40;33mx[40;95m][40;37m Custom Resolution Utility" (
    set "OPENTOOLS=True"
    call :CURL -L --progress-bar "https://www.monitortests.com/download/cru/cru-1.4.2.zip" --create-dirs -o "%UserProfile%\Documents\_Tools\Custom Resolution Utility\cru.zip"
    call "modules\7z.exe" x -aoa "%UserProfile%\Documents\_Tools\Custom Resolution Utility\cru.zip" -O"%UserProfile%\Documents\_Tools\Custom Resolution Utility" >nul 2>&1
    del /f /q "%UserProfile%\Documents\_Tools\Custom Resolution Utility\cru.zip" >nul 2>&1
)
if "!SweetLow Mouse Rate Changer!"=="[40;95m[[40;33mx[40;95m][40;37m SweetLow Mouse Rate Changer" (
    set "OPENTOOLS=True"
    call :CURL -L --progress-bar "https://raw.githubusercontent.com/LordOfMice/hidusbf/master/hidusbf.zip" --create-dirs -o "%UserProfile%\Documents\_Tools\SweetLow Mouse Rate Changer\hidusbf.zip"
    call "modules\7z.exe" x -aoa "%UserProfile%\Documents\_Tools\SweetLow Mouse Rate Changer\hidusbf.zip" -O"%UserProfile%\Documents\_Tools\SweetLow Mouse Rate Changer" >nul 2>&1
    del /f /q "%UserProfile%\Documents\_Tools\SweetLow Mouse Rate Changer\hidusbf.zip" >nul 2>&1
)
if "!OPENTOOLS!"=="True" start "" "explorer.exe" "%UserProfile%\Documents\_Tools\"
goto TOOLS_MENU_CLEAR


:CREDITS
call :MSGBOX "TheBATeam community - Coding help.\nRevision community - Learned a lot about PC Tweaking.\nMelody - For his tweaks guides and scripts.\nDanske - For his Windows Tweak guide.\nRiot - For his 'Hit-Reg and Network Latency' guide.\nFelip - Codes from his 'Tweaks for Gaming'.\nIBUZZARDl - Coding help.\n\nThanks to many other people for help with testing and suggestions \n                                                              Created by Artanis \n                                                      Copyright Artanis 2020" vbInformation "Credits"
goto MAIN_MENU

:HELP
call :MSGBOX "NOT DONE YET \nNOT DONE YET \nNOT DONE YET \nNOT DONE YET " vbInformation "Help"
goto MAIN_MENU

::      :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::      ::::::::::::::::::::::::::::::::     FONCTIONS     ::::::::::::::::::::::::::::::::
::      :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:SETVARIABLES
:: Check SSD
for /f %%i in ('call "modules\smartctl.exe" --scan') do call "modules\smartctl.exe" %%i -a^| findstr /i "Solid SSD RAID SandForce" >nul 2>&1 && set "SSD=True" || set "SSD=False"
:: Check Laptop
wmic path Win32_Battery get BatteryStatus | findstr "BatteryStatus" >nul 2>&1 && set "LAPTOP=True" || set "LAPTOP=False"
:: Check GPU
wmic path Win32_VideoController get Name | findstr "NVIDIA" >nul 2>&1 && set "GPU=NVIDIA"
wmic path Win32_VideoController get Name | findstr "AMD ATI Radeon" >nul 2>&1 && set "GPU=AMD"
:: Check CPU
wmic cpu get Name | findstr "Ryzen" >nul 2>&1 && set "CPU=RYZEN"
:: Monitor number
for /f "delims=DesktopMonitor, " %%i in ('wmic path Win32_DesktopMonitor get DeviceID^| findstr /l "DesktopMonitor"') do set MonitorAmount=%%i
:: Page file
for /f "skip=1" %%i in ('wmic os get TotalVisibleMemorySize') do (if not defined TOTAL_MEMORY set /a TOTAL_MEMORY=%%i/1024) & (if not defined TOTAL_MEMORYbis set /a TOTAL_MEMORYbis=%%i+1024000)
set /a PAGEFILE=!TOTAL_MEMORY!*2
:: Service token
for /f "tokens=*" %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services" /f "cdpusersvc_"^| findstr "HKEY"') do (
    set SERVICE=%%i
    set SERVICE=!SERVICE:HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\cdpusersvc_=!
)
goto :eof

:CHOCO [Package]
if not exist "%ProgramData%\chocolatey" (
    powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && set "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
    call "%ProgramData%\chocolatey\bin\RefreshEnv.cmd"
)
choco install %* -y --limit-output --ignore-checksums
goto :eof

:CURL
if not exist "%WinDir%\System32\curl.exe" (
    if not exist "%ProgramData%\chocolatey\lib\curl" call :CHOCO curl
)
curl %*
goto :eof

:MSGBOX [Text] [Argument] [Title]
echo WScript.Quit Msgbox(Replace("%~1","\n",vbCrLf),%~2,"%~3") > "%TMP%\msgbox.vbs"
cscript /nologo "%TMP%\msgbox.vbs"
set "exitCode=!ERRORLEVEL!" & del /f /q "%TMP%\msgbox.vbs"
exit /b %exitCode%

:SHORTCUT [Name] [Path] [TargetPath] [WorkingDirectory]
echo Set WshShell=WScript.CreateObject^("WScript.Shell"^) >"%TMP%\shortcut.vbs"
echo Set lnk=WshShell.CreateShortcut^("%~2\%~1.lnk"^) >>"%TMP%\shortcut.vbs"
echo lnk.TargetPath="%~3" >>"%TMP%\shortcut.vbs"
echo lnk.WorkingDirectory="%~4" >>"%TMP%\shortcut.vbs"
echo lnk.WindowStyle=4 >>"%TMP%\shortcut.vbs"
echo lnk.Save >>"%TMP%\shortcut.vbs"
cscript /nologo "%TMP%\shortcut.vbs" & del /f /q "%TMP%\shortcut.vbs"
goto :eof
