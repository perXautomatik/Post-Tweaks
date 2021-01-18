@echo off
setlocal enabledelayedexpansion
mode con lines=20 cols=125
chcp 65001 >nul 2>&1
cd /d "%~dp0"
title Post Tweaks

set VERSION=1.2
set VERSION_INFO=18/01/2021

call:SETVARIABLES >nul 2>&1

ver | find "10." >nul 2>&1
if !ERRORLEVEL! neq 0 (
    echo ERROR: Your current Windows version is not supported
    echo.
    echo Press any key to exit . . .
    pause >nul && exit
)

openfiles >nul 2>&1
if !ERRORLEVEL! neq 0 (
    echo !S_GRAY!You are not running as !RED!Administrator!S_GRAY!...
    echo This batch cannot do it's job without elevation!
    echo.
    echo Right-click and select !S_GREEN!^'Run as Administrator^' !S_GRAY!and try again...
    echo.
    echo Press any key to exit . . .
    pause >nul && exit
)

ping -n 1 "google.com" >nul 2>&1
if !ERRORLEVEL! neq 0 (
    echo !RED!ERROR: !S_GRAY!No internet connection found
    echo.
    echo Please make sure you are connected to the internet and try again . . .
    pause >nul && exit
)

set "NEEDEDFILES=modules/7z.exe modules/7z.dll modules/choicebox.exe modules/nsudo.exe modules/devicecleanup.exe resources/procexp.exe resources/ExtremePerformance.pow resources/SetTimerResolutionService.exe resources/SDL.dll resources/nvdrsdb0.bin resources/nvdrsdb1.bin"
for %%i in (!NEEDEDFILES!) do (
    if not exist %%i (
        set "MISSINGFILES=True"
        echo !RED!ERROR: !S_GREEN!%%i !S_GRAY!is missing
    )
)
if "!MISSINGFILES!"=="True" echo. & echo Downloading missing files please wait...!S_GREEN!
for %%i in (!NEEDEDFILES!) do if not exist %%i call:CURL "0" "https://raw.githubusercontent.com/ArtanisInc/Post-Tweaks/main/%%i" "%%i"

whoami /user | find /i "S-1-5-18" >nul 2>&1
if !ERRORLEVEL! neq 0 call "modules\nsudo.exe" -U:T -P:E -UseCurrentConsole "%~dpnx0" && exit

call:CURL "1" "https://raw.githubusercontent.com/ArtanisInc/Post-Tweaks/main/version.txt" "version.txt"
if !ERRORLEVEL! equ 0 (
    for /f "tokens=1 delims= " %%i in (version.txt) do set LATEST_VERSION=%%i
    for /f "tokens=1,2 delims= " %%i in (version.txt) do set LATEST_VERSION_INFO=%%j
)
if exist "version.txt" del /f /q "version.txt" >nul 2>&1

if /i !VERSION! lss !LATEST_VERSION! (
    cls
    echo.
    echo    !S_GRAY!A new version of Post Tweaks is available.
    echo.
    echo    Current version:   !S_GREEN!!VERSION!!S_GRAY! - !S_GREEN!!VERSION_INFO!!S_GRAY!
    echo    Latest version:    !S_GREEN!!LATEST_VERSION!!S_GRAY! - !S_GREEN!!LATEST_VERSION_INFO!!S_GRAY!
    echo.
    echo    Update to the latest version now? [!S_GREEN!Yes!S_GRAY!^/!S_GREEN!No!S_GRAY!]!S_GREEN!
    choice /c yn /n /m "" /t 25 /d y
    if !ERRORLEVEL! equ 1 (
        cls
        echo.
        echo Updating to the latest version, please wait...
        echo.
        call:CURL "0" "https://github.com/ArtanisInc/Post-Tweaks/archive/main.zip" "main.zip"
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
mode con lines=27 cols=125
echo.
echo.
echo                   !RED!██████!S_GRAY!╗  !RED!██████!S_GRAY!╗ !RED!███████!S_GRAY!╗!RED!████████!S_GRAY!╗    !RED!████████!S_GRAY!╗!RED!██!S_GRAY!╗    !RED!██!S_GRAY!╗!RED!███████!S_GRAY!╗ !RED!█████!S_GRAY!╗ !RED!██!S_GRAY!╗  !RED!██!S_GRAY!╗!RED!███████!S_GRAY!╗
echo                   !RED!██!S_GRAY!╔══!RED!██!S_GRAY!╗!RED!██!S_GRAY!╔═══!RED!██!S_GRAY!╗!RED!██!S_GRAY!╔════╝╚══!RED!██!S_GRAY!╔══╝    ╚══!RED!██!S_GRAY!╔══╝!RED!██!S_GRAY!║    !RED!██!S_GRAY!║!RED!██!S_GRAY!╔════╝!RED!██!S_GRAY!╔══!RED!██!S_GRAY!╗!RED!██!S_GRAY!║ !RED!██!S_GRAY!╔╝!RED!██!S_GRAY!╔════╝
echo                   !RED!██████!S_GRAY!╔╝!RED!██!S_GRAY!║   !RED!██!S_GRAY!║!RED!███████!S_GRAY!╗   !RED!██!S_GRAY!║          !RED!██!S_GRAY!║   !RED!██!S_GRAY!║ !RED!█!S_GRAY!╗ !RED!██!S_GRAY!║!RED!█████!S_GRAY!╗  !RED!███████!S_GRAY!║!RED!█████!S_GRAY!╔╝ !RED!███████!S_GRAY!╗
echo                   !RED!██!S_GRAY!╔═══╝ !RED!██!S_GRAY!║   !RED!██!S_GRAY!║╚════!RED!██!S_GRAY!║   !RED!██!S_GRAY!║          !RED!██!S_GRAY!║   !RED!██!S_GRAY!║!RED!███!S_GRAY!╗!RED!██!S_GRAY!║!RED!██!S_GRAY!╔══╝  !RED!██!S_GRAY!╔══!RED!██!S_GRAY!║!RED!██!S_GRAY!╔═!RED!██!S_GRAY!╗ !S_GRAY!╚════!RED!██!S_GRAY!║
echo                   !RED!██!S_GRAY!║     ╚!RED!██████!S_GRAY!╔╝!RED!███████!S_GRAY!║   !RED!██!S_GRAY!║          !RED!██!S_GRAY!║   ╚!RED!███!S_GRAY!╔!RED!███!S_GRAY!╔╝!RED!███████!S_GRAY!╗!RED!██!S_GRAY!║  !RED!██!S_GRAY!║!RED!██!S_GRAY!║  !RED!██!S_GRAY!╗!RED!███████!S_GRAY!║
echo                   !S_GRAY!╚═╝      ╚═════╝ ╚══════╝   ╚═╝          ╚═╝    ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝
echo.
echo                    !S_MAGENTA!╔═════════════════════════════════════════════════════════════════════════════════════╗
echo                                     !UNDERLINE!!S_RED!v!version!!_UNDERLINE!                !RED!█!B_YELLOW! MAIN MENU !B_BLACK!!RED!█        !UNDERLINE!!S_RED!Welcome %username%!S_MAGENTA!!_UNDERLINE!
echo                    ╚═════════════════════════════════════════════════════════════════════════════════════╝
echo.
echo                            [ !S_GREEN!1!S_MAGENTA! ] !S_WHITE!SYSTEM TWEAKS!S_MAGENTA!                            [ !S_GREEN!2!S_MAGENTA! ] !S_WHITE!SOFTWARE INSTALLER!S_MAGENTA!
echo.
echo                                                         [ !S_GREEN!3!S_MAGENTA! ] !S_WHITE!TOOLS!S_MAGENTA!
echo.
echo                    ╔══════════════════════════════════════════╦══════════════════════════════════════════╗
echo                    ║     !S_GREEN!C!S_MAGENTA!  ^>  !S_WHITE!Credits!S_MAGENTA!                        ║              !S_GREEN!G!S_MAGENTA!  ^>  !UNDERLINE!!S_RED!Github repository!S_MAGENTA!!_UNDERLINE!     ║
echo                    ╚══════════════════════════════════════════╩══════════════════════════════════════════╝
echo.
echo                                                  !S_GRAY!Make your choices or !S_GREEN!"HELP"!S_GRAY!
echo.
set choice=
set /p "choice=!S_GREEN!                                                              "
if "!choice!"=="1" goto SYSTWEAKS
if "!choice!"=="2" goto APPS_MENU_CLEAR
if "!choice!"=="3" goto TOOLS_MENU_CLEAR
if /i "!choice!"=="c" goto CREDITS
if /i "!choice!"=="g" start "" "https://github.com/ArtanisInc/Post-Tweaks" && goto MAIN_MENU
if /i "!choice!"=="h" goto HELP
if /i "!choice!"=="help" goto HELP
echo                                             !RED!Error : !S_GREEN!"!choice!"!S_GRAY! is not a valid choice...
timeout /t 3 /nobreak >nul 2>&1
goto MAIN_MENU

:SYSTWEAKS
call:MSGBOX "Do you want to create a registry backup and a restore point ?" vbYesNo+vbQuestion "System Restore"
if !ERRORLEVEL! equ 6 (
    wmic /namespace:\\root\default path systemrestore call createrestorepoint "Post Tweaks", 100, 12 >nul 2>&1
    regedit /e "%UserProfile%\desktop\Registry Backup.reg" >nul 2>&1
)

echo Disabling UAC
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

echo Disabling Windows synchronization
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSync" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSyncUserOverride" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableAppSyncSettingSync" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableAppSyncSettingSyncUserOverride" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableApplicationSettingSync" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableApplicationSettingSyncUserOverride" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableCredentialsSettingSync" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableCredentialsSettingSyncUserOverride" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableDesktopThemeSettingSync" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableDesktopThemeSettingSyncUserOverride" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisablePersonalizationSettingSync" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisablePersonalizationSettingSyncUserOverride" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableStartLayoutSettingSync" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableStartLayoutSettingSyncUserOverride" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSyncOnPaidNetwork" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWebBrowserSettingSync" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWebBrowserSettingSyncUserOverride" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWindowsSettingSync" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWindowsSettingSyncUserOverride" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" /v "SyncPolicy" /t REG_DWORD /d "5" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Accessibility" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\AppSync" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\BrowserSettings" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Credentials" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\DesktopTheme" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\PackageState" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Personalization" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\StartLayout" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Windows" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1

echo Enabling Windows Components
dism /online /enable-feature /featurename:DesktopExperience /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:LegacyComponents /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:DirectPlay /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:NetFx4-AdvSrvs /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:NetFx3 /all /norestart >nul 2>&1

echo BCDEDIT
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

echo Process Scheduling
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "38" /f >nul 2>&1

echo Disabling Mitigations
call:POWERSHELL "ForEach($v in (Get-Command -Name \"Set-ProcessMitigation\").Parameters[\"Disable\"].Attributes.ValidValues){Set-ProcessMitigation -System -Disable $v.ToString()}"

echo Removing Kernel Blacklist
reg delete "HKLM\System\CurrentControlSet\Control\GraphicsDrivers\BlockList\Kernel" /va /reg:64 /f >nul 2>&1

echo Disabling Memory compression
call:POWERSHELL "Disable-MMAgent -MemoryCompression -ApplicationPreLaunch"

echo Removing MicrocodeUpdate
del /f /q"%WinDir%\System32\mcupdate_GenuineIntel.dll" >nul 2>&1
del /f /q "%WinDir%\System32\mcupdate_AuthenticAMD.dll" >nul 2>&1

echo Disabling DMA memory protection and cores isolation
reg add "HKLM\SOFTWARE\Policies\Microsoft\FVE" /v "DisableExternalDMAUnderLock" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "HVCIMATRequired" /t REG_DWORD /d "0" /f >nul 2>&1

echo Power settings
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CsEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnergyEstimationEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "PerfCalculateActualUtilization" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "SleepReliabilityDetailedDiagnostics" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EventProcessorEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "QosManagesIdleProcessors" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableVsyncLatencyUpdate" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableSensorWatchdog" /t REG_DWORD /d "1" /f >nul 2>&1

echo MMCSS
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d "10" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "10" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NoLazyMode" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "LazyModeTimeout" /t REG_DWORD /d "150000" /f >nul 2>&1

echo Disabling automatic folder type discovery
reg add "HKCU\SOFTWARE\Classes\Local Settings\SOFTWARE\Microsoft\Windows\Shell\Bags\AllFolders\Shell" /v "FolderType" /t REG_SZ /d "NotSpecified" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Classes\Local Settings\SOFTWARE\Microsoft\Windows\Shell\Bags" /f >nul 2>&1

echo Disabling Aero shake
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisallowShaking" /t REG_DWORD /d "1" /f >nul 2>&1

echo Do not use AutoPlay for all media and devices
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" /v "DisableAutoplay" /t REG_DWORD /d "1" /f >nul 2>&1

echo Disabling automatic maintenance
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d "1" /f >nul 2>&1

echo Disabling Hibernation
reg add "HKLM\System\CurrentControlSet\Control\Power" /v "HibernateEnabled" /t REG_DWORD /d "0" /f >nul 2>&1

echo Disabling Downloads blocking
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v "SaveZoneInformation" /t REG_DWORD /d "1" /f >nul 2>&1

echo Disabling Malicious SOFTWARE removal tool from installing
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v "DontOfferThroughWUAU" /t REG_DWORD /d "1" /f >nul 2>&1

echo Change Windows feedback to Never
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d "0" /f >nul 2>&1

echo Disabling SigninInfo
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\UserARSO\!USER_SID!" /v OptOut /t REG_DWORD /d "1" /f >nul 2>&1

echo Show BSOD details instead of the sad smiley
reg add "HKLM\System\CurrentControlSet\Control\CrashControl" /v "DisplayParameters" /t REG_DWORD /d "1" /f >nul 2>&1

echo Disabling Keyboard Toggle
reg add "HKCU\Keyboard Layout\Toggle" /v "Language Hotkey" /t REG_SZ /d "3" /f >nul 2>&1
reg add "HKCU\Keyboard Layout\Toggle" /v "Hotkey" /t REG_SZ /d "3" /f >nul 2>&1
reg add "HKCU\Keyboard Layout\Toggle" /v "Layout Hotkey" /t REG_SZ /d "3" /f >nul 2>&1

echo Disabling Snap Assist
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SnapAssist" /t REG_DWORD /d "0" /f >nul 2>&1

echo Disabling Administrative shares
reg add "HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareWks" /t REG_DWORD /d "0" /f >nul 2>&1

echo Turn off sleep and lock in power options
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" /v "ShowSleepOption" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" /v "ShowLockOption" /t REG_DWORD /d "0" /f >nul 2>&1

echo Sound communications do nothing
reg add "HKCU\SOFTWARE\Microsoft\Multimedia\Audio" /v "UserDuckingPreference" /t REG_DWORD /d "3" /f >nul 2>&1

echo Speed up start time
reg add "HKCU\AppEvents\Schemes" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "DelayedDesktopSwitchTimeout" /t REG_DWORD /d "0" /f >nul 2>&1

echo Disabling KB4524752 support notifications
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Gwx" /v "DisableGwx" /t REG_DWORD /d "1" /f >nul 2>&1

echo Disabling KB4524752 support notifications
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableOSUpgrade" /t REG_DWORD /d "1" /f >nul 2>&1

echo Disabling FSO Globally and GameDVR
reg add "HKCU\SOFTWARE\Microsoft\GameBar" /v "ShowStartupPanel" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\GameBar" /v "GamePanelStartupTipIndex" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\GameBar" /v "UseNexusForGameBarEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehavior" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_DSEBehavior" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKU\.DEFAULT\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg delete "HKCU\System\GameConfigStore\Children" /f >nul 2>&1
reg delete "HKCU\System\GameConfigStore\Parents" /f >nul 2>&1

echo Disabling power throttling
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d "1" /f >nul 2>&1

echo Mouse options
reg add "HKCU\Control Panel\Mouse" /v "SmoothMouseXCurve" /t REG_BINARY /d "0000000000000000c0cc0c0000000000809919000000000040662600000000000033330000000000" /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "SmoothMouseYCurve" /t REG_BINARY /d "0000000000000000000038000000000000007000000000000000a800000000000000e00000000000" /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "MouseSensitivity" /t REG_SZ /d "10" /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f >nul 2>&1

echo Disabling DWM composition
reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "CompositionPolicy" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "Composition" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "EnableWindowColorization" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "EnableAeroPeek" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\DWM" /v "AlwaysHibernateThumbnails" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DWM" /v "DisallowComposition" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DWM" /v "DWMWA_TRANSITIONS_FORCEDISABLED" /t REG_DWORD /d "1" /f >nul 2>&1

echo Disabling FTH
reg add "HKLM\SOFTWARE\Microsoft\FTH" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\FTH\State" /f >nul 2>&1

echo Disabling Startup Sound
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\BootAnimation" /v "DisableStartupSound" /t REG_DWORD /d "1" /f >nul 2>&1

echo Mouse and Keyboard Buffering
reg add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d "16" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "KeyboardDataQueueSize" /t REG_DWORD /d "16" /f >nul 2>&1

echo Disabling system energy-saving
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\Memory Management" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\kernel" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\Executive" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\ModernSleep" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul 2>&1

echo Make desktop faster
reg add "HKU\.DEFAULT\Control Panel\Desktop" /v "ForegroundLockTimeout" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKU\.DEFAULT\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKU\.DEFAULT\Control Panel\Desktop" /v "MouseWheelRouting" /t REG_DWORD /d "0" /f >nul 2>&1

echo Acessibility keys
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

echo SvcHostSplitThreshold
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "!SVCHOST!" /f >nul 2>&1

echo Memory and disk
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
reg add "HKLM\SYSTEM\currentcontrolset\control\filesystem" /v "NtfsDisableLastAccessUpdate" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\filesystem" /v "UdfsSoftwareDefectManagement" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\filesystem" /v "Win31FileSystem" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\executive" /v "AdditionalCriticalWorkerThreads" /t REG_DWORD /d "16" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\executive" /v "AdditionalDelayedWorkerThreads" /t REG_DWORD /d "16" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\i/o system" /v "CountOperations" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\memory management" /v "ClearPageFileAtShutdown" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\memory management" /v "IoPageLockLimit" /t REG_DWORD /d "8000000" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\memory management" /v "LargeSystemCache" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\memory management" /v "SystemPages" /t REG_DWORD /d "4294967295" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\memory management" /v "DisablePagingExecutive" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\memory management\prefetchparameters" /v "EnableBoottrace" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\memory management\prefetchparameters" /v "EnablePrefetcher" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\memory management\prefetchparameters" /v "EnableSuperfetch" /t REG_DWORD /d "0" /f >nul 2>&1

echo Disabling NTFS/ReFS mitigations
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager" /v "ProtectionMode" /t REG_DWORD /d "0" /f >nul 2>&1

echo Disabling Windows attempt to save as much RAM as possible, such as sharing pages for images, copy-on-write for data pages, and compression
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\Memory Management" /v "DisablePagingCombining" /t REG_DWORD /d "1" /f >nul 2>&1

echo Disabling Tsx/Meltdown/Spectre patches
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\Kernel" /v "DisableTsx" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\Memory Management" /v "EnableCfg" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\Memory Management" /v "FeatureSettings" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d "3" /f >nul 2>&1

echo Kernel settings
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\kernel" /v "DpcWatchdogProfileOffset" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\kernel" /v "DisableExceptionChainValidation" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\kernel" /v "KernelSEHOPEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\kernel" /v "DpcWatchdogPeriod" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\kernel" /v "MitigationOptions" /t REG_BINARY /d "22222222222222222002000000200000" /f >nul 2>&1
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\kernel" /v "MitigationAuditOptions" /t REG_BINARY /d "20000020202022220000000000000000" /f >nul 2>&1

echo Disabling fast startup
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d "0" /f >nul 2>&1

echo Disabling Sleep study
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\Power" /v "SleepStudyDisabled" /t REG_DWORD /d "1" /f >nul 2>&1

echo Disabling Windows Customer Experience Improvement Program
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient" /v "CorporateSQMURL" /t REG_SZ /d "0.0.0.0" /f >nul 2>&1

echo Disabling Biometrics
reg add "HKLM\SOFTWARE\Policies\Microsoft\Biometrics" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1

echo Disabling SmartScreen
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f >nul 2>&1
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "0" /f >nul 2>&1

echo Clean Image File Execution Options and set csrss to realtime
for /f "tokens=*" %%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options"') do reg delete "%%i" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "3" /f >nul 2>&1

echo Disabling performance counter
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

echo Removing ProcessorAffinityMask
for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services" /s /f "ProcessorAffinityMask"^| findstr "HKEY"') do reg delete "%%i" /v "ProcessorAffinityMask" /f >nul 2>&1

echo Set all IoLatencyCaps to 0
for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services" /s /f "IoLatencyCap"^| findstr "HKEY"') do reg add "%%i" /v "IoLatencyCap" /t REG_DWORD /d "0" /f >nul 2>&1

echo Disabling Link power management mode
for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services" /s /f "EnableHIPM"^| findstr "HKEY"') do reg add "%%i" /v "EnableHIPM" /t REG_DWORD /d "0" /f >nul 2>&1
for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services" /s /f "EnableDIPM"^| findstr "HKEY"') do reg add "%%i" /v "EnableDIPM" /t REG_DWORD /d "0" /f >nul 2>&1

echo USB Hubs against power saving
for /f "tokens=*" %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum" /s /f "EnhancedPowerManagementEnabled"^| findstr "HKEY"') do (
    reg add "%%i" /v "EnhancedPowerManagementEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "%%i" /v "AllowIdleIrpInD3" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "%%i" /v "EnableSelectiveSuspend" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "%%i" /v "DeviceSelectiveSuspended" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "%%i" /v "SelectiveSuspendEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "%%i" /v "SelectiveSuspendOn" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "%%i" /v "fid_D1Latency" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "%%i" /v "fid_D2Latency" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "%%i" /v "fid_D3Latency" /t REG_DWORD /d "0" /f >nul 2>&1
)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\usbflags" /v "fid_D1Latency" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\usbflags" /v "fid_D2Latency" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\usbflags" /v "fid_D3Latency" /t REG_DWORD /d "0" /f >nul 2>&1

echo StorPort against power saving
for /f "tokens=*" %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum" /s /f "StorPort"^| findstr "StorPort"') do reg add "%%i" /v "EnableIdlePowerManagement" /t REG_DWORD /d "0" /f >nul 2>&1

echo Removing IRQ Priorities
for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /f "irq"^| findstr "irq"') do reg delete "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "%%i" /f >nul 2>&1

echo Enabling MSI mode for PCI devices except sound
for /f %%i in ('wmic path Win32_IDEController get PNPDeviceID^| findstr /L "PCI\VEN_"') do reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d "1" /f >nul 2>&1
for /f %%i in ('wmic path Win32_USBController get PNPDeviceID^| findstr /L "PCI\VEN_"') do reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d "1" /f >nul 2>&1
for /f %%i in ('wmic path Win32_VideoController get PNPDeviceID^| findstr /L "PCI\VEN_"') do reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d "1" /f >nul 2>&1
for /f %%i in ('wmic path Win32_NetworkAdapter get PNPDeviceID^| findstr /L "PCI\VEN_"') do reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d "1" /f >nul 2>&1
for /f %%i in ('wmic path Win32_SoundDevice get PNPDeviceID^| findstr /L "PCI\VEN_"') do reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d "0" /f >nul 2>&1

echo Removing DevicePriority and setting affinity policy
for /f "tokens=*" %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum" /s /f "Affinity Policy"^| findstr /l "VEN_"') do (
    reg delete "%%i" /v "DevicePriority" /f >nul 2>&1
    reg add "%%i" /v "DevicePolicy" /t REG_DWORD /d "5" /f >nul 2>&1
)
for /f "tokens=*" %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum" /s /f "Affinity Policy"^| findstr /v "VEN_"') do reg add "%%i" /v "DevicePolicy" /t REG_DWORD /d "3" /f >nul 2>&1

echo Removing affinity mask
for /f "tokens=*" %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum" /s /f "AssignmentSetOverride"^| findstr "HKEY"') do reg delete "%%i" /v "AssignmentSetOverride" /f >nul 2>&1

echo DedicatedSegmentSize in Intel iGPU
for /f %%i in ('reg query "HKLM\SOFTWARE\Intel" /s /f "GMM"^| findstr "HKEY"') do reg add "%%i" /v "DedicatedSegmentSize" /t REG_DWORD /d "4132" /f >nul 2>&1

echo Use big page file
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False >nul 2>&1
wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=!PAGEFILE!,MaximumSize=!PAGEFILE! >nul 2>&1

echo Text Improvements Avalon
for %%i in (HKLM\SOFTWARE HKLM\SOFTWARE\WOW6432Node HKCU\SOFTWARE) do (
    reg query "%%i\Microsoft\Avalon.Graphics" /ve >nul 2>&1
    if !ERRORLEVEL! equ 0 (
        reg add "%%i\Microsoft\Avalon.Graphics" /v "ClearTypeLevel" /t REG_DWORD /d "100" /f >nul 2>&1
        reg add "%%i\Microsoft\Avalon.Graphics" /v "EnhancedContrastLevel" /t REG_DWORD /d "0" /f >nul 2>&1
        reg add "%%i\Microsoft\Avalon.Graphics" /v "GammaLevel" /t REG_DWORD /d "1600" /f >nul 2>&1
        reg add "%%i\Microsoft\Avalon.Graphics" /v "GrayscaleEnhancedContrastLevel" /t REG_DWORD /d "0" /f >nul 2>&1
        reg add "%%i\Microsoft\Avalon.Graphics" /v "PixelStructure" /t REG_DWORD /d "1" /f >nul 2>&1
        reg add "%%i\Microsoft\Avalon.Graphics" /v "TextContrastLevel" /t REG_DWORD /d "6" /f >nul 2>&1
    )
)

echo Disabling event windows
reg add "HKLM\SOFTWARE\Microsoft\Wbem\CIMOM" /v "EnableEvents" /t REG_DWORD /d "0" /f >nul 2>&1

echo Disabling Preemption and V-Sync Idle Timeout for gpu
reg add "HKLM\System\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "VsyncIdleTimeout" /t REG_DWORD /d "0" /f >nul 2>&1

echo GPU scheduling
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchedMode" /t REG_DWORD /d "2" /f >nul 2>&1

echo Display tweaks
for /f "delims=DesktopMonitor, " %%i in ('wmic path Win32_DesktopMonitor get DeviceID^| findstr /l "DesktopMonitor"') do reg add "!VIDEO_ADAPTER_PATH!" /v Display%%i_PipeOptimizationEnable /t REG_DWORD /d "1" /f >nul 2>&1

if "!GPU!"=="NVIDIA" (
    echo Unhide silk smooth
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v "EnableRID61684" /t REG_DWORD /d "1" /f >nul 2>&1
    echo Enabling kboost
    reg add "!VIDEO_ADAPTER_PATH!" /v "EnableCoreSlowdown" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "!VIDEO_ADAPTER_PATH!" /v "EnableMClkSlowdown" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "!VIDEO_ADAPTER_PATH!" /v "EnableNVClkSlowdown" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "!VIDEO_ADAPTER_PATH!" /v "PerfLevelSrc" /t REG_DWORD /d "2222" /f >nul 2>&1
    reg add "!VIDEO_ADAPTER_PATH!" /v "powermizerenable" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "!VIDEO_ADAPTER_PATH!" /v "powermizerlevel" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "!VIDEO_ADAPTER_PATH!" /v "powermizerlevelac" /t REG_DWORD /d "1" /f >nul 2>&1
    echo Melody GPU tweaks
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "DpiMapIommuContiguous" /t REG_DWORD /d "1" /f >nul 2>&1
    for %%i in (DefaultD3TransitionLatencyActivelyUsed DefaultD3TransitionLatencyIdleLongTime DefaultD3TransitionLatencyIdleMonitorOff DefaultD3TransitionLatencyIdleNoContext
        DefaultD3TransitionLatencyIdleShortTime DefaultD3TransitionLatencyIdleVeryLongTime DefaultLatencyToleranceIdle0 DefaultLatencyToleranceIdle0MonitorOff
        DefaultLatencyToleranceIdle1 DefaultLatencyToleranceIdle1MonitorOff DefaultLatencyToleranceMemory DefaultLatencyToleranceNoContext DefaultLatencyToleranceNoContextMonitorOff
        DefaultLatencyToleranceOther DefaultLatencyToleranceTimerPeriod DefaultMemoryRefreshLatencyToleranceActivelyUsed DefaultMemoryRefreshLatencyToleranceMonitorOff
        DefaultMemoryRefreshLatencyToleranceNoContext Latency MaxIAverageGraphicsLatencyInOneBucket MiracastPerfTrackGraphicsLatency MonitorLatencyTolerance
        MonitorRefreshLatencyTolerance TransitionLatency) do reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "%%i" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "!VIDEO_ADAPTER_PATH!" /v "D3PCLatency" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "!VIDEO_ADAPTER_PATH!" /v "F1TransitionLatency" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "!VIDEO_ADAPTER_PATH!" /v "PciLatencyTimerControl" /t REG_DWORD /d "32" /f >nul 2>&1
    reg add "!VIDEO_ADAPTER_PATH!" /v "RMDeepL1EntryLatencyUsec" /t REG_DWORD /d "0" /f >nul 2>&1
    for %%i in (PreferSystemMemoryContiguous LOWLATENCY Node3DLowLatency RmGspcMaxFtuS
        RmGspcMinFtuS RmGspcPerioduS RMLpwrEiIdleThresholduS RMLpwrGrIdleThresholduS
        RMLpwrGrRgIdleThresholduS RMLpwrMsIdleThresholduS VRDirectFlipDPCDelayuS
        VRDirectFlipTimingMarginuS VRDirectJITFlipMsHybridFlipDelayuS vrrCursorMarginuS
        vrrDeflickerMarginuS vrrDeflickerMaxUs) do reg add "!VIDEO_ADAPTER_PATH!" /v "%%i" /t REG_DWORD /d "1" /f >nul 2>&1
    echo Import Nvidia settings
    taskkill /f /im "nvcplui.exe" >nul 2>&1
    copy /y "resources\nvdrsdb0.bin" "%ProgramData%\NVIDIA Corporation\Drs" >nul 2>&1
    copy /y "resources\nvdrsdb1.bin" "%ProgramData%\NVIDIA Corporation\Drs" >nul 2>&1
)

if "!GPU!"=="AMD" (
    echo General AMD GPU settings
    reg add "!VIDEO_ADAPTER_PATH!" /v "EnableUlps" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "!VIDEO_ADAPTER_PATH!" /v "DisableDMACopy" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "!VIDEO_ADAPTER_PATH!" /v "DisableBlockWrite" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "!VIDEO_ADAPTER_PATH!" /v "DisableDrmdmaPowerGating" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "!VIDEO_ADAPTER_PATH!" /v "StutterMode" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "!VIDEO_ADAPTER_PATH!" /v "PP_SclkDeepSleepDisable" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "!VIDEO_ADAPTER_PATH!" /v "PP_ThermalAutoThrottlingEnable" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "!VIDEO_ADAPTER_PATH!\UMD" /v "Main3D_DEF" /t REG_STRING /d "1" /f >nul 2>&1
    reg add "!VIDEO_ADAPTER_PATH!\UMD" /v "Main3D" /t REG_BINARY /d "3100" /f >nul 2>&1
    reg add "!VIDEO_ADAPTER_PATH!\UMD" /v "ShaderCache" /t REG_BINARY /d "3200" /f >nul 2>&1
    reg add "!VIDEO_ADAPTER_PATH!\UMD" /v "Tessellation_OPTION" /t REG_BINARY /d "3200" /f >nul 2>&1
    reg add "!VIDEO_ADAPTER_PATH!\UMD" /v "Tessellation" /t REG_BINARY /d "3100" /f >nul 2>&1
    reg add "!VIDEO_ADAPTER_PATH!\UMD" /v "VSyncControl" /t REG_BINARY /d "3000" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdlog" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    echo Melody GPU tweaks
    for %%i in (LTRSnoopL1Latency LTRSnoopL0Latency LTRNoSnoopL1Latency LTRMaxNoSnoopLatency KMD_RpmComputeLatency
        DalUrgentLatencyNs memClockSwitchLatency PP_RTPMComputeF1Latency PP_DGBMMMaxTransitionLatencyUvd
        PP_DGBPMMaxTransitionLatencyGfx DalNBLatencyForUnderFlow DalDramClockChangeLatencyNs
        BGM_LTRSnoopL1Latency BGM_LTRSnoopL0Latency BGM_LTRNoSnoopL1Latency BGM_LTRNoSnoopL0Latency
        BGM_LTRMaxSnoopLatencyValue BGM_LTRMaxNoSnoopLatencyValue) do reg add "!VIDEO_ADAPTER_PATH!" /v "%%i" /t REG_DWORD /d "1" /f >nul 2>&1
)

echo Disabling Services
for %%i in (AarSvc AeLookupSvc BcastDVRUserService CaptureService cbdhsvc CDPSvc CDPUserSvc
    ConsentUxUserSvc CredentialEnrollmentManagerUserSvc DcpSvc DeviceAssociationBrokerSvc
    DeviceAssociationService DevicePickerUserSvc DevicesFlowUserSvc diagnosticshub.standardcollector.service
    diagsvc DiagTrack DmWapPushService DoSvc DPS DsSvc HPTouchpointAnalyticsService IEEtwCollectorService
    InstallService lfsvc LxpSvc MessagingService NcaSvc NetMsmqActivator OneSyncSvc
    PimIndexMaintenanceSvc PushToInstall RetailDemo shpamsvc SmsRouter srv SSDPSRV StorSvc TrkWks
    UevAgentService UnistoreSvc upnphost UserDataSvc VDWFP VisualDiscovery W32Time WdiServiceHost
    WdiSystemHost WebClient wercplsupport WerSvc WinHttpAutoProxySvc WinRM wisvc wlidsvc WMPNetworkSvc WpnService WpnUserService) do (
    reg query "HKLM\SYSTEM\CurrentControlSet\Services\%%i" /ve >nul 2>&1
    if !ERRORLEVEL! equ 0 reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%i" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
)

call "modules\choicebox.exe" "Disable Windows Search;Disable OneDrive;Disable Windows Store;Disable Xbox Apps;Disable Wi-Fi;Disable Bluetooth;Disable Printer;Disable Hyper-V;Disable Remote features;Disable Task Scheduler;Disable Compatibility Assistant;Disable Disk Management;Disable Windows Update;Disable Windows Defender;Disable Windows Firewall" " " "Services" /C:2 >"%TMP%\services.txt"
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
        taskkill /f /im "SearchUI.exe" >nul 2>&1
        rd /s /q "%WinDir%\SystemApps\Microsoft.Windows.Cortana_cw5n1h2txyewy" >nul 2>&1
    )
    if exist "%WinDir%\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy" (
        taskkill /f /im "SearchApp.exe" >nul 2>&1
        rd /s /q "%WinDir%\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy" >nul 2>&1
    )
)
findstr /c:"Disable OneDrive" "%TMP%\services.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    taskkill /f /im "OneDrive.exe" >nul 2>&1
    if exist "%WinDir%\System32\OneDriveSetup.exe" start /wait "%WinDir%\System32\OneDriveSetup.exe" /uninstall >nul 2>&1
    rd /s /q "%UserProfile%\OneDrive" >nul 2>&1
    rd /s /q "%SystemDrive%\OneDriveTemp">nul 2>&1
    rd /s /q "%LocalAppData%\Microsoft\OneDrive" >nul 2>&1
    rd /s /q "%ProgramData%\Microsoft OneDrive" >nul 2>&1
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
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\TokenBroker" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WalletService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /t REG_DWORD /d "2" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "DisableStoreApps" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "RemoveWindowsStore" /t REG_DWORD /d "1" /f >nul 2>&1
    call:POWERSHELL "Get-AppxPackage -allusers *store* | Remove-AppxPackage"
    call:POWERSHELL "Get-AppxProvisionedPackage -online | where displayname -eq *store* | Remove-AppxProvisionedPackage -online"
)
findstr /c:"Disable Xbox Apps" "%TMP%\services.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\XboxNetApiSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\XblGameSave" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\XblAuthManager" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\xbgm" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\XboxGipSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    call:POWERSHELL "Get-AppxPackage -allusers *Xbox* | Remove-AppxPackage"
    call:POWERSHELL "Get-AppxProvisionedPackage -online | where displayname -eq *Xbox* | Remove-AppxProvisionedPackage -online"
)
findstr /c:"Disable Wi-Fi" "%TMP%\services.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WwanSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WlanSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\wcncsvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\lmhosts" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\vwififlt" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\vwifibus" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\CSC" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
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
findstr /c:"Disable Remote features" "%TMP%\services.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\RasAuto" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
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

echo Disabling drivers Services
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
    CompositeBus condrv dam dfsc EhStorClass fastfat FileInfo fvevol kdnic KSecPkg
    lltdio luafv Modem MpsSvc mrxdav mrxsmb Mrxsmb10 Mrxsmb20 MsLldp mssmbios NdisCap NdisTapi
    NdisVirtualBus NdisWan Ndproxy Ndu NetBIOS NetBT Npsvctrig PEAUTH Psched QWAVEdrv
    RasAcd RasPppoe rdbss rdpbus rdyboost rspndr spaceport srv2 Srvnet TapiSrv Tcpip6
    tcpipreg tdx TPM umbus vdrvroot Vid Volmgrx WmiAcpi ws2ifsl) do (
    reg query "HKLM\SYSTEM\CurrentControlSet\Services\%%i" /ve >nul 2>&1
    if !ERRORLEVEL! equ 0 reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%i" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
)

echo Set large page drivers
reg add "HKLM\SYSTEM\currentcontrolset\control\session manager\Memory Management" /v "LargePageDrivers" /t REG_MULTI_SZ /d "!DRIVERLIST!!NIC_SERVICE!" /f >nul 2>&1

echo Clean and set Thread Prioritys for drivers
for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services" /s /f "ThreadPriority"^| findstr "HKEY"') do reg delete "%%i" /v "ThreadPriority" /f >nul 2>&1
for %%i in (AFD Audiosrv disk iaStorAC iaStorAVC NDIS Ntfs storahci stornvme Tcpip TCPIP6) do (
    reg query "HKLM\SYSTEM\CurrentControlSet\Services\%%i" /ve >nul 2>&1
    if !ERRORLEVEL! equ 0 reg add "HKLM\System\CurrentControlSet\Services\%%i\Parameters" /v "ThreadPriority" /t REG_DWORD /d "0" /f >nul 2>&1
)
for %%i in (amdkmdag atikmpag atikmdag nvlddmkm DXGKrnl HDAudBus HidUsb igdkmd64 kbdhid monitor mouhid usbccgp usbehci usbhub USBHUB3 usbohci usbuhci USBXHCI) do (
    reg query "HKLM\SYSTEM\CurrentControlSet\Services\%%i" /ve >nul 2>&1
    if !ERRORLEVEL! equ 0 reg add "HKLM\System\CurrentControlSet\services\%%i\Parameters" /v "ThreadPriority" /t REG_DWORD /d "15" /f >nul 2>&1
)
for /f "tokens=3" %%i in ('reg query "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}" /s /f "Service"^| findstr "Service"^| findstr /v "kdnic vwifimp RasSstp RasAgileVpn Rasl2tp PptpMiniport RasPppoe NdisWan"') do reg add "HKLM\System\CurrentControlSet\services\%%i\Parameters" /v "ThreadPriority" /t REG_DWORD /d "15" /f >nul 2>&1

echo Disabling devices
for %%i in ("Microsoft Kernel Debug Network Adapter" "WAN Miniport" "Teredo Tunneling"
    "UMBus Root Bus Enumerator" "Composite Bus Enumerator" "Microsoft Virtual Drive Enumerator"
    "NDIS Virtual Network Adapter Enumerator" "System Timer" "System speaker" "Programmable Interrupt Controller" "NVIDIA USB"
    "PCI standard RAM Controller" "PCI Memory Controller" "PCI Simple Communications Controller" "Numeric Data Processor"
    "Intel Management Engine" "Intel SMBus" "AMD PSP" "SM Bus Controller" "Remote Desktop Device Redirector Bus"
    "Microsoft System Management BIOS Driver" "Microsoft GS Wavetable Synth" "Microsoft Wi-Fi Direct Virtual Adapter" "HID-compliant Consumer Control Device"
    "Microsoft Windows Management Interface for ACPI" "Microsoft Storage Spaces Controller" "NVIDIA High Definition Audio" "High Precision Event Timer") do call:POWERSHELL "Get-PnpDevice | Where-Object {$_.FriendlyName -match '%%i'} | Disable-PnpDevice -Confirm:$false"

echo Clean non-present devices
call "modules\devicecleanup.exe" * -s -n >nul 2>&1

echo Disabling devices power management
call:POWERSHELL "$devices = Get-WmiObject Win32_PnPEntity; $powerMgmt = Get-WmiObject MSPower_DeviceEnable -Namespace root\wmi; foreach ($p in $powerMgmt){$IN = $p.InstanceName.ToUpper(); foreach ($h in $devices){$PNPDI = $h.PNPDeviceID; if ($IN -like \"*$PNPDI*\"){$p.enable = $False; $p.psbase.put()}}}"

echo Import Power Plan
powercfg -delete 77777777-7777-7777-7777-777777777777 >nul 2>&1
powercfg -import "%~dp0\resources\ExtremePerformance.pow" 77777777-7777-7777-7777-777777777777 >nul 2>&1
powercfg -setactive 77777777-7777-7777-7777-777777777777 >nul 2>&1

echo Auto disable FSO and set High DPI scaling override by Application for apps/games
echo Dim oldflags : newflags = "~ DISABLEDXMAXIMIZEDWINDOWEDMODE HIGHDPIAWARE" >"%WinDir%\globalflags.vbs"
echo Const HKU = 2147483651 : Const SEMISYNCHRONOUS = 48 >>"%WinDir%\globalflags.vbs"
echo layerskey = "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" >>"%WinDir%\globalflags.vbs"
echo querytext = "SELECT ExecutablePath FROM Win32_Process WHERE ProcessID=" ^& TargetEvent.ProcessID >>"%WinDir%\globalflags.vbs"
echo Set mExec = GetObject^("winmgmts:{impersonationLevel=impersonate}!\\.\root\CIMv2"^).ExecQuery^(querytext,,SEMISYNCHRONOUS^) >>"%WinDir%\globalflags.vbs"
echo Set rProv = GetObject^("winmgmts:{impersonationLevel=impersonate}!\\.\root\default:StdRegProv"^) >>"%WinDir%\globalflags.vbs"
echo Set regEx = New RegExp : regEx.Global = False : regEx.IgnoreCase = True >>"%WinDir%\globalflags.vbs"
echo filterprg = "^.:\\Program Files(?:\\| \(x86\)\\)(Common |dotnet|Microsoft |Windows |WindowsApps|MSBuild)" >>"%WinDir%\globalflags.vbs"
echo regEx.Pattern = "^.:\\Windows\\|^.\\ProgramData\\Package |\\AppData\\Local\\Temp\\|\\AppData\\Local\\Microsoft\\|" ^& filterprg >>"%WinDir%\globalflags.vbs"
echo For Each process in mExec >>"%WinDir%\globalflags.vbs"
echo     If Not IsNull^(process.ExecutablePath^) And Not regEx.Test^(process.ExecutablePath^) Then >>"%WinDir%\globalflags.vbs"
echo         process.GetOwnerSid sid : compatkey = sid ^& "\\" ^& layerskey >>"%WinDir%\globalflags.vbs"
echo         ret = rProv.GetStringValue^(HKU, compatkey, process.ExecutablePath, oldflags^) >>"%WinDir%\globalflags.vbs"
echo         If ^(ret ^<^> 0^) Then >>"%WinDir%\globalflags.vbs"
echo             rProv.CreateKey HKU, compatkey : rProv.SetStringValue HKU, compatkey, process.ExecutablePath, newflags >>"%WinDir%\globalflags.vbs"
echo         ElseIf ^(newflags = "~ "^) Then >>"%WinDir%\globalflags.vbs"
echo             rProv.DeleteValue HKU, compatkey, process.ExecutablePath >>"%WinDir%\globalflags.vbs"
echo         End If >>"%WinDir%\globalflags.vbs"
echo     End If >>"%WinDir%\globalflags.vbs"
echo Next >>"%WinDir%\globalflags.vbs"

set "SESSIONID=SessionID^!=0"
for %%i in (cvtres csc svchost DllHost RuntimeBroker backgroundTaskHost
    rundll32 find findstr reg PING timeout taskkill Conhost cmd cscript
    wscript powershell explorer OpenWith SearchProtocolHost SpeechRuntime
    browser_broker MicrosoftEdgeCP firefox chrome steamwebhelper) do set "FILTER=!FILTER! AND ProcessName^!='%%i.exe'"
wmic /NAMESPACE:"\\root\subscription" PATH __EventFilter CREATE Name="GlobalAppCompatFlags", EventNameSpace="root\cimv2",QueryLanguage="WQL", Query="SELECT * from Win32_ProcessStartTrace WHERE !SESSIONID!!FILTER!" >nul 2>&1
wmic /NAMESPACE:"\\root\subscription" PATH ActiveScriptEventConsumer CREATE Name="GlobalAppCompatFlags", ScriptingEngine="VBScript",ScriptFileName="C:\Windows\globalflags.vbs" >nul 2>&1
wmic /NAMESPACE:"\\root\subscription" PATH __FilterToConsumerBinding CREATE Filter="__EventFilter.Name=\"GlobalAppCompatFlags\"", Consumer="ActiveScriptEventConsumer.Name=\"GlobalAppCompatFlags\"" >nul 2>&1

echo Removing Windows bloatware
call:MSGBOX "Remove unnecessary built-in Windows 10 apps ?" vbYesNo+vbQuestion "Bloatware"
if !ERRORLEVEL! equ 6 (
    set "SAFE_APPS=AAD.brokerplugin accountscontrol apprep.chxapp assignedaccess asynctext bioenrollment capturepicker cloudexperience contentdelivery desktopappinstaller ecapp getstarted immersivecontrolpanel lockapp net.native oobenet parentalcontrols PPIProjection sechealth secureas shellexperience startmenuexperience vclibs xaml XGpuEject calculator xbox store IntelGraphics NVIDIAControlPanel RealtekAudioControl AdvancedMicroDevicesInc"
    for %%i in (!SAFE_APPS!) do (
        set "REMOVE_BLOAT=!REMOVE_BLOAT! where-object {$_.name –notlike '*%%i*'} |"
        set "REMOVE_BLOAT_PACK=!REMOVE_BLOAT_PACK! where-object {$_.packagename -notlike '*%%i*'} |"
    )
    call:POWERSHELL "Get-AppxPackage -allusers |!REMOVE_BLOAT! Remove-AppxPackage"
    call:POWERSHELL "Get-AppxProvisionedPackage -online |!REMOVE_BLOAT_PACK! Remove-AppxProvisionedPackage -online"
)

echo Enabling HRTF
echo hrtf ^= true > "%appdata%\alsoft.ini"
echo hrtf ^= true > "%ProgramData%\alsoft.ini"

echo Install Simple DirectMedia Layer
if not exist "%WinDir%\System32\SDL.dll" copy "resources\SDL.dll" "%WinDir%\System32" >nul 2>&1
if not exist "%WinDir%\SysWOW64\SDL.dll" copy "resources\SDL.dll" "%WinDir%\SysWOW64" >nul 2>&1

echo Install Timer resolution service
if not exist "%WinDir%\SetTimerResolutionService.exe" copy "resources\SetTimerResolutionService.exe" "%WinDir%" >nul 2>&1
call "%WinDir%\SetTimerResolutionService.exe" -Install >nul 2>&1

::                                      =====================================================
::                                      ==================     NETWORK     ==================
::                                      =====================================================

echo Set static ip
set DNS1=1.1.1.1
set DNS2=1.0.0.1
for /f "tokens=4" %%i in ('netsh int show interface^| findstr "Connected"') do set INTERFACE=%%i
for /f "tokens=3 delims=: " %%i in ('netsh int ip show config name^="!INTERFACE!"^| findstr "IP Address"^| findstr [0-9]') do set IP=%%i
for /f "tokens=2 delims=()" %%i in ('netsh int ip show config name^="!INTERFACE!"^| findstr /r "(.*)"') do for %%j in (%%i) do set MASK=%%j
for /f "tokens=3 delims=: " %%i in ('netsh int ip show config name^="!INTERFACE!"^| findstr "Default"^| findstr [0-9]') do set GATEWAY=%%i
netsh int ipv4 set address name="!INTERFACE!" static !IP! !MASK! !GATEWAY! >nul 2>&1
netsh int ipv4 set dns name="!INTERFACE!" static !DNS1! primary validate=no >nul 2>&1
netsh int ipv4 add dns name="!INTERFACE!" !DNS2! index=2 validate=no >nul 2>&1
for /f "tokens=3 delims=: " %%i in ('netsh int ip show config name^="!INTERFACE!"^| findstr "DHCP"^| findstr [a-z]') do set DHCP=%%i
if "!DHCP!"=="Yes" (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD" /v "Start" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dhcp" /v "Start" /t REG_DWORD /d "2" /f >nul 2>&1
) else (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dhcp" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
)

echo Network tweaks
netsh winsock reset >nul 2>&1
ipconfig /flushdns >nul 2>&1
netsh interface ip delete arpcache >nul 2>&1
netsh interface teredo set state disabled >nul 2>&1
netsh interface 6to4 set state disabled >nul 2>&1
netsh int isatap set state disable >nul 2>&1
netsh int tcp set global autotuninglevel=disabled >nul 2>&1
netsh int tcp set heuristics disabled >nul 2>&1
netsh int tcp set supplemental internet congestionprovider=CUBIC >nul 2>&1
netsh int tcp set global ecncapability=disabled >nul 2>&1
netsh int tcp set global dca=enabled >nul 2>&1
netsh int tcp set global netdma=enabled >nul 2>&1
netsh int tcp set global nonsackrttresiliency=disabled >nul 2>&1
netsh int tcp set global rsc=disabled >nul 2>&1
netsh int tcp set global rss=enabled >nul 2>&1
netsh int tcp set global timestamps=disabled >nul 2>&1
netsh int tcp set security mpp=disabled >nul 2>&1
netsh int tcp set security profiles=disabled >nul 2>&1
netsh int tcp set global initialRto=2000 >nul 2>&1
netsh int tcp set global maxsynretransmissions=2 >nul 2>&1
netsh int ip set global taskoffload=disabled >nul 2>&1
netsh int ip set global neighborcachelimit=4096 >nul 2>&1
call:POWERSHELL "Set-NetOffloadGlobalSetting -Chimney Disabled"
call:POWERSHELL "Set-NetTCPSetting -SettingName InternetCustom -MinRto 300"
call:POWERSHELL "Set-NetTCPSetting -SettingName InternetCustom -InitialCongestionWindow 10"
wmic nicconfig where TcpipNetbiosOptions=0 call SetTcpipNetbios 2 >nul 2>&1
wmic nicconfig where TcpipNetbiosOptions=1 call SetTcpipNetbios 2 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableICMPRedirect" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnablePMTUDiscovery" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "Tcp1323Opts" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "GlobalMaxTcpWindowSize" /t REG_DWORD /d "5840" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpWindowSize" /t REG_DWORD /d "5840" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxConnectionsPerServer" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxUserPort" /t REG_DWORD /d "65534" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpTimedWaitDelay" /t REG_DWORD /d "30" /f >nul 2>&1
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
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v "EnableICSIPv6" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v "DisabledComponents" /t REG_DWORD /d "255" /f >nul 2>&1
for /f %%i in ('wmic path win32_networkadapter get GUID^| findstr "{"') do (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%i" /v "TcpAckFrequency" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%i" /v "TcpDelAckTicks" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%i" /v "TCPNoDelay" /t REG_DWORD /d "1" /f >nul 2>&1
)
echo Network Adapter settings
for /f %%i in ('reg query "HKLM\SYSTEM\ControlSet001\Control\Class\{4D36E972-E325-11CE-BFC1-08002bE10318}" /f "PCI\VEN_" /d /s^| findstr "HKEY"') do (
    reg add "%%i" /v "*EEE" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "*FlowControl" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "*HeaderDataSplit" /t REG_SZ /d "1" /f >nul 2>&1
    reg add "%%i" /v "*InterruptModeration" /t REG_SZ /d "1" /f >nul 2>&1
    reg add "%%i" /v "*IPChecksumOffloadIPv4" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "*JumboPacket" /t REG_SZ /d "1514" /f >nul 2>&1
    reg add "%%i" /v "*LsoV1IPv4" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "*LsoV2IPv4" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "*LsoV2IPv6" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "*ModernStandbyWoLMagicPacket" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "*PMARPOffload" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "*PMNSOffload" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "*PriorityVLANTag" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "*PtpHardwareTimestamp" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "*RSS" /t REG_SZ /d "1" /f >nul 2>&1
    reg add "%%i" /v "*RssBaseProcNumber" /t REG_SZ /d "1" /f >nul 2>&1
    reg add "%%i" /v "*RssMaxProcNumber" /t REG_SZ /d "1" /f >nul 2>&1
    reg add "%%i" /v "*RssProfile" /t REG_SZ /d "4" /f >nul 2>&1
    reg add "%%i" /v "*SoftwareTimestamp" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "*SpeedDuplex" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "*TCPChecksumOffloadIPv4" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "*TCPChecksumOffloadIPv6" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "*UDPChecksumOffloadIPv4" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "*UDPChecksumOffloadIPv6" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "*WakeOnMagicPacket" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "*WakeOnPattern" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "AdaptiveIFS" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "AdvancedEEE" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "AutoDisableGigabit" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "EEELinkAdvertisement" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "EnableGreenEthernet" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "EnablePME" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "EnableTss" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "GigaLite" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "ITR" /t REG_SZ /d "950" /f >nul 2>&1
    reg add "%%i" /v "LinkNegotiationProcess" /t REG_SZ /d "1" /f >nul 2>&1
    reg add "%%i" /v "LogLinkStateEvent" /t REG_SZ /d "16" /f >nul 2>&1
    reg add "%%i" /v "MasterSlave" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "PowerSavingMode" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "ReduceSpeedOnPowerDown" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "S5WakeOnLan" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "SipsEnabled" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "TxIntDelay" /t REG_SZ /d "5" /f >nul 2>&1
    reg add "%%i" /v "ULPMode" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "WaitAutoNegComplete" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "WakeOnLink" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "WakeOnSlot" /t REG_SZ /d "0" /f >nul 2>&1
    reg add "%%i" /v "WolShutdownLinkSpeed" /t REG_SZ /d "2" /f >nul 2>&1
)
call:POWERSHELL "$NetAdapters = Get-NetAdapterHardwareInfo | Get-NetAdapter | Where-Object {$_.Status -eq 'Up'};foreach ($NetAdapter in $NetAdapters) {$MaxNumRssQueues = [int](($NetAdapter | Get-NetAdapterAdvancedProperty -RegistryKeyword '*NumRssQueues').ValidRegistryValues | Measure-Object -Maximum).Maximum;$NetAdapter | Set-NetAdapterAdvancedProperty -RegistryKeyword '*NumRssQueues' -RegistryValue $MaxNumRssQueues}"
call:POWERSHELL "$NetAdapters = Get-NetAdapterHardwareInfo | Get-NetAdapter | Where-Object {$_.Status -eq 'Up'};foreach ($NetAdapter in $NetAdapters) {$iReceiveBuffers = [int]($NetAdapter | Get-NetAdapterAdvancedProperty -RegistryKeyword '*ReceiveBuffers').NumericParameterMaxValue;$iTransmitBuffers = [int]($NetAdapter | Get-NetAdapterAdvancedProperty -RegistryKeyword '*TransmitBuffers').NumericParameterMaxValue;$NetAdapter | Set-NetAdapterAdvancedProperty -RegistryKeyword '*ReceiveBuffers' -RegistryValue $iReceiveBuffers;$NetAdapter | Set-NetAdapterAdvancedProperty -RegistryKeyword '*TransmitBuffers' -RegistryValue $iTransmitBuffers}"
call:POWERSHELL "Disable-NetAdapterRsc -Name *"
call:POWERSHELL "Disable-NetAdapterLso -Name *"
call:POWERSHELL "Disable-NetAdapterIPsecOffload -Name *"
call:POWERSHELL "Disable-NetAdapterPowerManagement -Name *"
call:POWERSHELL "Disable-NetAdapterChecksumOffload -Name *"
call:POWERSHELL "Disable-NetAdapterEncapsulatedPacketTaskOffload -Name *"
call:POWERSHELL "Disable-NetAdapterQos -Name *"
if "!NETWORK!"=="WIFI" (
    netsh int tcp set supplemental internet congestionprovider=newreno >nul 2>&1
    for /f %%i in ('reg query "HKLM\SYSTEM\ControlSet001\Control\Class\{4D36E972-E325-11CE-BFC1-08002bE10318}" /f "PCI\VEN_" /d /s^| findstr "HKEY"') do (
        reg add "%%i" /v "*DeviceSleepOnDisconnect" /t REG_SZ /d "0" /f >nul 2>&1
        reg add "%%i" /v "*PacketCoalescing" /t REG_SZ /d "0" /f >nul 2>&1
        reg add "%%i" /v "*PMWiFiRekeyOffload" /t REG_SZ /d "0" /f >nul 2>&1
        reg add "%%i" /v "BgScanGlobalBlocking" /t REG_SZ /d "2" /f >nul 2>&1
        reg add "%%i" /v "CtsToItself" /t REG_SZ /d "1" /f >nul 2>&1
        reg add "%%i" /v "FatChannelIntolerant" /t REG_SZ /d "0" /f >nul 2>&1
        reg add "%%i" /v "IbssQosEnabled" /t REG_SZ /d "0" /f >nul 2>&1
        reg add "%%i" /v "IbssTxPower" /t REG_SZ /d "100" /f >nul 2>&1
        reg add "%%i" /v "MIMOPowerSaveMode" /t REG_SZ /d "0" /f >nul 2>&1
        reg add "%%i" /v "RoamAggressiveness" /t REG_SZ /d "1" /f >nul 2>&1
        reg add "%%i" /v "RoamingPreferredBandType" /t REG_SZ /d "3" /f >nul 2>&1
        reg add "%%i" /v "ThroughputBoosterEnabled" /t REG_SZ /d "1" /f >nul 2>&1
        reg add "%%i" /v "uAPSDSupport" /t REG_SZ /d "0" /f >nul 2>&1
        reg add "%%i" /v "WirelessMode" /t REG_SZ /d "34" /f >nul 2>&1
    )
)
echo Disabling Network Adapter bindings
for %%i in (ms_lldp ms_lltdio ms_msclient ms_rspndr ms_server ms_implat ms_pacer ms_tcpip6) do call:POWERSHELL "Disable-NetAdapterBinding -Name * -ComponentID %%i"
for %%i in (ms_pppoe ms_rdma_ndk ms_ndisuio ms_wfplwf_upper ms_wfplwf_lower ms_netbt ms_netbios ms_ndiscap) do call:POWERSHELL "Disable-NetAdapterBinding -Name * -ComponentID %%i"

::                                      =====================================================
::                                      ==================     PRIVACY     ==================
::                                      =====================================================

echo Turn off microsoft peer-to-peer networking services
reg add "HKLM\SOFTWARE\Policies\Microsoft\Peernet" /v "Disabled" /t REG_DWORD /d "0" /f >nul 2>&1

echo Turn off data execution prevention
reg add "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" /v "DEPOff" /t REG_DWORD /d "1" /f >nul 2>&1

echo Trick to make system Startup faster
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v "StartupDelayInMSec" /t REG_DWORD /d "0" /f >nul 2>&1

echo Display highly detailed status messages
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "VerboseStatus" /t REG_DWORD /d "1" /f >nul 2>&1

echo Turn off Pen feedback
reg add "HKLM\SOFTWARE\Policies\Microsoft\TabletPC" /v "TurnOffPenFeedback" /t REG_DWORD /d "1" /f >nul 2>&1

echo Do not offer tailored experiences based on the diagnostic data setting
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "0" /f >nul 2>&1

echo Disabling Remote assistance connections
reg add "HKLM\System\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d "0" /f >nul 2>&1

echo Do not allow apps to use advertising ID
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1

echo Do not let apps on other devices open and message apps on this device
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP" /v "RomeSdkChannelUserAuthzPolicy" /t REG_DWORD /d "0" /f >nul 2>&1

echo Do not show the Windows welcome experiences after updates
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d "0" /f >nul 2>&1

echo Do not get tip, trick, and suggestions as you use Windows
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d "0" /f >nul 2>&1

echo Do not show suggested content in the Settings app
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /d "0" /f >nul 2>&1

echo Do not show app suggestions in the Start menu
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d "0" /f >nul 2>&1

echo Do not show recently added apps in the Start menu
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "HideRecentlyAddedApps" /t REG_DWORD /d "1" /f >nul 2>&1

echo Turn off automatic installing suggested apps
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d "0" /f >nul 2>&1

echo Do not suggest ways I can finish setting up my device to get the most out of Windows
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v "ScoobeSystemSettingEnabled" /t REG_DWORD /d "0" /f >nul 2>&1

echo Removing Metadata Tracking
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Device Metadata" /f >nul 2>&1

echo Removing Storage Sense
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\StorageSense" /f >nul 2>&1

echo Disabling Delivery Optimization
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DoSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "SystemSettingsDownloadMode" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v "SystemSettingsDownloadMode" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d "0" /f >nul 2>&1

echo Error Reporting
reg add "HKLM\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" /v "DoReport" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" /v "ForceQueueMode" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting\DW" /v "DWFileTreeRoot" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting\DW" /v "DWNoExternalURL" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting\DW" /v "DWNoFileCollection" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting\DW" /v "DWNoSecondLevelCollection" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting\DW" /v "DWReporteeName" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "MachineID" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "AutoApproveOSDumps" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "ConfigureArchive" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "DisableArchive" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "DontSendAdditionalData" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "LoggingDisabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting\Consent" /v "DefaultConsent" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting\Consent" /v "NewUserDefaultConsent" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting\WMR" /v "Disable" /t REG_DWORD /d "1" /f >nul 2>&1

echo Telemetry
reg add "HKCU\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v "value" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v "value" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v "UseActionCenterExperience" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HideSCAHealth" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowClipboardHistory" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowCrossDeviceClipboard" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\EnhancedStorageDevices" /v "TCGSecurityActivationDisabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\codeidentifiers" /v "authenticodeenabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\Circular Kernel Context Logger" /v "Start" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WUDF" /v "LogEnable" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WUDF" /v "LogLevel" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa\Credssp" /v "DebugLogLevel" /t REG_DWORD /d "0" /f >nul 2>&1
for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger" /s /f "start"^| findstr "HKEY"') do reg add "%%i" /v "Start" /t REG_DWORD /d "0" /f >nul 2>&1

echo Scheduled tasks
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
schtasks /change /tn "Microsoft\Windows\ErrorDetails\EnableErrorDetailsUpdate" /disable >nul 2>&1
schtasks /change /tn "Microsoft\Windows\Windows Error Reporting\QueueReporting" /disable >nul 2>&1
schtasks /change /tn "Microsoft\Windows\WindowsUpdate\Automatic App Update" /disable >nul 2>&1
schtasks /change /tn "Microsoft\Windows\Device Information\Device" /disable >nul 2>&1
schtasks /change /tn "USER_ESRV_SVC_QUEENCREEK" /disable >nul 2>&1
for %%i in (GWX FamilySafety UpdateOrchestrator Media Office NvTm NvProfile Intel) do for /f "tokens=1 delims=," %%a in ('schtasks /query /fo csv^| findstr /v "TaskName"^| findstr "%%i"') do schtasks /change /tn "%%a" /disable >nul 2>&1

echo Hosts
call:CURL -L "https://gist.githubusercontent.com/ArtanisInc/74081e8f0548105412e8082ed47c4c97/raw/fce96a4ad8175249b7b8965af623d25c3c99659a/hosts" "%WinDir%\System32\drivers\etc\hosts" >nul 2>&1

::                                      =======================================================
::                                      ==================     INTERFACE     ==================
::                                      =======================================================

echo Visual effects
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShellState" /t REG_BINARY /d "240000003E28000000000000000000000000000001000000130000000000000072000000" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "IconsOnly" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewAlphaSelect" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewShadow" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAnimations" /t REG_DWORD /d "0" /f >nul 2>&1

echo Interface tweaks
call "modules\choicebox.exe" "Remove 3D Objects from File Explorer;Remove library from File Explorer;Remove Favorites from File Explorer;Remove family group from File Explorer;Remove network from File Explorer;Remove OneDrive from File Explorer;Remove Quick Access from File Explorer;Remove all folders in 'This PC' from File Explorer;Hide Search box in taskbar;Hide Taskview in taskbar;Hide Action Center Tray in taskbar;Hide Contact in taskbar;Hide language bar in taskbar;Hide Windows Ink Workspace in taskbar;Disable animations in taskbar;Use small icons in taskbar;Show all icons in the notification area in taskbar;Show seconds on the clock in taskbar;Theme disable transparency (blur);Theme enable Dark Mode;Reduce size of buttons close minimize maximize;Show file extensions;Show Hidden folders;Disable Recent items and Frequent Places;Remove <Shortcut> suffix to the created shortcuts;Enable classic volume control;Enable classic alt tab;Enable windows 8 network flayout" " " "Interface" /C:2 >"%TMP%\interface.txt"
findstr /c:"Remove 3D Objects from File Explorer" "%TMP%\interface.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f >nul 2>&1
    reg delete "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f >nul 2>&1
)
findstr /c:"Remove library from File Explorer" "%TMP%\interface.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKCR\CLSID\{031E4825-7B94-4dc3-B131-E946B44C8DD5}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2962227469" /f >nul 2>&1
    reg add "HKCR\WOW6432Node\CLSID\{031E4825-7B94-4dc3-B131-E946B44C8DD5}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2962227469" /f >nul 2>&1
)
findstr /c:"Remove Favorites from File Explorer" "%TMP%\interface.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKCR\CLSID\{323CA680-C24D-4099-B94D-446DD2D7249E}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2696937728" /f >nul 2>&1
    reg add "HKCR\WOW6432Node\CLSID\{323CA680-C24D-4099-B94D-446DD2D7249E}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2696937728" /f >nul 2>&1
)
findstr /c:"Remove family group from File Explorer" "%TMP%\interface.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKCR\CLSID\{B4FB3F98-C1EA-428d-A78A-D1F5659CBA93}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2962489612" /f >nul 2>&1
    reg add "HKCR\WOW6432Node\CLSID\{B4FB3F98-C1EA-428d-A78A-D1F5659CBA93}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2962489612" /f >nul 2>&1
)
findstr /c:"Remove network from File Explorer" "%TMP%\interface.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKCR\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2954100836" /f >nul 2>&1
    reg add "HKCR\WOW6432Node\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2954100836" /f >nul 2>&1
)
findstr /c:"Remove OneDrive from File Explorer" "%TMP%\interface.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder" /v "Attributes" /t REG_DWORD /d "4035969101" /f >nul 2>&1
    reg add "HKCR\WOW6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder" /v "Attributes" /t REG_DWORD /d "4035969101" /f >nul 2>&1
)
findstr /c:"Remove Quick Access from File Explorer" "%TMP%\interface.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKCR\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2689597440" /f >nul 2>&1
    reg add "HKCR\WOW6432Node\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder" /v "Attributes" /t REG_DWORD /d "2689597440" /f >nul 2>&1
)
findstr /c:"Remove all folders in 'This PC' from File Explorer" "%TMP%\interface.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f >nul 2>&1
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f >nul 2>&1
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f >nul 2>&1
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f >nul 2>&1
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f >nul 2>&1
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f >nul 2>&1
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f >nul 2>&1
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f >nul 2>&1
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f >nul 2>&1
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f >nul 2>&1
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f >nul 2>&1
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f >nul 2>&1
)
findstr /c:"Hide Search box in taskbar" "%TMP%\interface.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d "0" /f >nul 2>&1
)
findstr /c:"Hide Taskview in taskbar" "%TMP%\interface.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d "0" /f >nul 2>&1
)
findstr /c:"Hide Action Center Tray in taskbar" "%TMP%\interface.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /t REG_DWORD /d "1" /f >nul 2>&1
)
findstr /c:"Hide Contact in taskbar" "%TMP%\interface.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v "PeopleBand" /t REG_DWORD /d "0" /f >nul 2>&1
)
findstr /c:"Hide language bar in taskbar" "%TMP%\interface.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKCU\SOFTWARE\Microsoft\CTF\LangBar" /v "ShowStatus" /t REG_DWORD /d "3" /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\CTF\LangBar" /v "ExtraIconsOnMinimized" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\CTF\LangBar" /v "Transparency" /t REG_DWORD /d "255" /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\CTF\LangBar" /v "Label" /t REG_DWORD /d "0" /f >nul 2>&1
)
findstr /c:"Hide Windows Ink Workspace in taskbar" "%TMP%\interface.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\PenWorkspace" /v "PenWorkspaceButtonDesiredVisibility" /t REG_DWORD /d "0" /f >nul 2>&1
)
findstr /c:"Disable animations in taskbar" "%TMP%\interface.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAnimations" /t REG_DWORD /d "0" /f >nul 2>&1
)
findstr /c:"Use small icons in taskbar" "%TMP%\interface.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarSmallIcons" /t REG_DWORD /d "1" /f >nul 2>&1
)
findstr /c:"Show all icons in the notification area in taskbar" "%TMP%\interface.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "EnableAutoTray" /t REG_DWORD /d "0" /f >nul 2>&1
)
findstr /c:"Show seconds on the clock in taskbar" "%TMP%\interface.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSecondsInSystemClock" /t REG_DWORD /d "1" /f >nul 2>&1
)
findstr /c:"Theme disable transparency (blur)" "%TMP%\interface.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d "0" /f >nul 2>&1
)
findstr /c:"Theme enable Dark Mode" "%TMP%\interface.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d "0" /f >nul 2>&1
)
findstr /c:"Reduce size of buttons close minimize maximize" "%TMP%\interface.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "CaptionWidth" /t REG_SZ /d "-270" /f >nul 2>&1
    reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "CaptionHeight" /t REG_SZ /d "-270" /f >nul 2>&1
)
findstr /c:"Show file extensions" "%TMP%\interface.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d "0" /f >nul 2>&1
)
findstr /c:"Show Hidden folders" "%TMP%\interface.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d "1" /f >nul 2>&1
)
findstr /c:"Disable Recent items and Frequent Places" "%TMP%\interface.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d "0" /f >nul 2>&1
)
findstr /c:"Remove <Shortcut> suffix to the created shortcuts" "%TMP%\interface.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "link" /t REG_BINARY /d "0" /f >nul 2>&1
)
findstr /c:"Enable classic volume control" "%TMP%\interface.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\MTCUVC" /v "EnableMtcUvc" /t REG_DWORD /d "0" /f >nul 2>&1
)
findstr /c:"Enable classic alt tab" "%TMP%\interface.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "AltTabSettings" /t REG_DWORD /d "1" /f >nul 2>&1
)
findstr /c:"Enable windows 8 network flayout" "%TMP%\interface.txt" >nul 2>&1
if !ERRORLEVEL! equ 0 (
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Settings\Network" /v "ReplaceVan" /t REG_DWORD /d "2" /f >nul 2>&1
)
del /f /q "%TMP%\interface.txt"

echo Process Explorer
call:MSGBOX "Replace Task Manager with Process Explorer?" vbYesNo+vbQuestion "Task Manager"
if !ERRORLEVEL! equ 6 (
    taskkill /f /im "procexp.exe" >nul 2>&1
    if not exist "%WinDir%\procexp.exe" copy "resources\procexp.exe" "%WinDir%" >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\taskmgr.exe" /v "Debugger" /t REG_SZ /d "%WinDir%\procexp.exe" /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "AlwaysOntop" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "OneInstance" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "ConfirmKill" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\pcw" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
)

echo Install Openshell
call:MSGBOX "Replace Start Menu with OpenShell?" vbYesNo+vbQuestion "Start Menu"
if !ERRORLEVEL! equ 6 (
    call:CHOCO open-shell
    reg add "HKU\!USER_SID!\SOFTWARE\OpenShell" /t REG_SZ "" /f >nul 2>&1
    reg add "HKU\!USER_SID!\SOFTWARE\OpenShell\OpenShell" /t REG_SZ "" /f >nul 2>&1
    reg add "HKU\!USER_SID!\SOFTWARE\OpenShell\OpenShell\Settings" /t REG_SZ "" /f >nul 2>&1
    reg add "HKU\!USER_SID!\SOFTWARE\OpenShell\ClassicExplorer" /t REG_SZ "" /f >nul 2>&1
    reg add "HKU\!USER_SID!\SOFTWARE\OpenShell\ClassicExplorer" /v "ShowedToolbar" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKU\!USER_SID!\SOFTWARE\OpenShell\ClassicExplorer" /v "NewLine" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKU\!USER_SID!\SOFTWARE\OpenShell\ClassicExplorer\Settings" /t REG_SZ "" /f >nul 2>&1
    reg add "HKU\!USER_SID!\SOFTWARE\OpenShell\ClassicExplorer\Settings" /v "ShowStatusBar" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKU\!USER_SID!\SOFTWARE\OpenShell\StartMenu" /t REG_SZ "" /f >nul 2>&1
    reg add "HKU\!USER_SID!\SOFTWARE\OpenShell\StartMenu" /v "ShowedStyle2" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKU\!USER_SID!\SOFTWARE\OpenShell\StartMenu" /v "CSettingsDlg" /t REG_BINARY /d "c80100001a0100000000000000000000360d00000100000000000000" /f >nul 2>&1
    reg add "HKU\!USER_SID!\SOFTWARE\OpenShell\StartMenu" /v "OldItems" /t REG_BINARY "" /f >nul 2>&1
    reg add "HKU\!USER_SID!\SOFTWARE\OpenShell\StartMenu" /v "ItemRanks" /t REG_BINARY /d "0" /f >nul 2>&1
    reg add "HKU\!USER_SID!\SOFTWARE\OpenShell\StartMenu\MRU" /v "0" /t REG_SZ /d "C:\Windows\regedit.exe" /f >nul 2>&1
    reg add "HKU\!USER_SID!\SOFTWARE\OpenShell\StartMenu\Settings" /t REG_SZ "" /f >nul 2>&1
    reg add "HKU\!USER_SID!\SOFTWARE\OpenShell\StartMenu\Settings" /v "Version" /t REG_DWORD /d "04040098" /f >nul 2>&1
    reg add "HKU\!USER_SID!\SOFTWARE\OpenShell\StartMenu\Settings" /v "AllProgramsMetro" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKU\!USER_SID!\SOFTWARE\OpenShell\StartMenu\Settings" /v "RecentMetroApps" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKU\!USER_SID!\SOFTWARE\OpenShell\StartMenu\Settings" /v "StartScreenShortcut" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKU\!USER_SID!\SOFTWARE\OpenShell\StartMenu\Settings" /v "SearchInternet" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKU\!USER_SID!\SOFTWARE\OpenShell\StartMenu\Settings" /v "GlassOverride" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKU\!USER_SID!\SOFTWARE\OpenShell\StartMenu\Settings" /v "GlassColor" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKU\!USER_SID!\SOFTWARE\OpenShell\StartMenu\Settings" /v "SkinW7" /t REG_SZ /d "Midnight" /f >nul 2>&1
    reg add "HKU\!USER_SID!\SOFTWARE\OpenShell\StartMenu\Settings" /v "SkinVariationW7" /t REG_SZ "" /f >nul 2>&1
    reg add "HKU\!USER_SID!\SOFTWARE\OpenShell\StartMenu\Settings" /v "SkinOptionsW7" /t REG_MULTI_SZ /d "USER_IMAGE=1"\0"SMALL_ICONS=0"\0"LARGE_FONT=0"\0"DISABLE_MASK=0"\0"OPAQUE=0"\0"TRANSPARENT_LESS=0"\0"TRANSPARENT_MORE=1"\0"WHITE_SUBMENUS2=0" /f >nul 2>&1
    reg add "HKU\!USER_SID!\SOFTWARE\OpenShell\StartMenu\Settings" /v "SkipMetro" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKU\!USER_SID!\SOFTWARE\OpenShell\StartMenu\Settings" /v "MenuItems7" /t REG_MULTI_SZ /d "!MENUITEMS!" /f >nul 2>&1
)

call:MSGBOX "Some registry changes may require a reboot to take effect.\n\nWould you like to restart now?" vbYesNo+vbExclamation "Shut Down Windows"
if !ERRORLEVEL! equ 6 shutdown -r -f -t 0
timeout /t 1 /nobreak >nul 2>&1
goto MAIN_MENU

:APPS_MENU_CLEAR
set APPS_MENU="Chromium" "Mozilla Firefox" "Brave" "Opera GX" "Deezer" "Spotify" "iTunes" "PotPlayer" "VLC media player" "Audacity" "ImageGlass" "ShareX" "GIMP" "Discord" "Ripcord" "TeamSpeak" "Skype" "Zoom" "Foxit Reader" "Microsoft Office" "Libre Office" "Easy 7zip" "Winrar" "Visual Studio Code" "Notepad++" "FileZilla" "PuTTY" "Python" "Steam" "GOG Galaxy" "Epic Games" "Uplay" "Battle.net" "Origin" "qBittorrent" "TeamViewer" "Revo Uninstaller" "Everything" "Vortex" "Visual C++ Redistributables" "DirectX" ".NET Framework 4.8"
for %%i in (!APPS_MENU!) do set "%%~i=!S_MAGENTA![ ]!S_WHITE! %%~i"

:APPS_MENU
cls
mode con lines=42 cols=133
echo !S_MAGENTA!
echo                        ╔═════════════════════════════════════════════════════════════════════════════════════╗
echo                        ║                                  !S_GREEN!SOFTWARE INSTALLER!S_MAGENTA!                                 ║
echo                        ╚═════════════════════════════════════════════════════════════════════════════════════╝
echo.
echo              !S_YELLOW!WEB BROWSERS                                 MEDIA                                        IMAGING
echo              ------------                                 -----                                        -------
echo               !S_GREEN!1 !Chromium!                               !S_GREEN!5 !Deezer!                                !S_GREEN!11 !ImageGlass!
echo               !S_GREEN!2 !Mozilla Firefox!                        !S_GREEN!6 !Spotify!                               !S_GREEN!12 !ShareX!
echo               !S_GREEN!3 !Brave!                                  !S_GREEN!7 !iTunes!                                !S_GREEN!13 !GIMP!
echo               !S_GREEN!4 !Opera GX!                               !S_GREEN!8 !PotPlayer!
echo                                                            !S_GREEN!9 !VLC media player!
echo                                                           !S_GREEN!10 !Audacity!
echo.
echo              !S_YELLOW!MESSAGING                                    DOCUMENTS                                    COMPRESSION
echo              ---------                                    ---------                                    -----------
echo              !S_GREEN!14 !Discord!                               !S_GREEN!19 !Foxit Reader!                          !S_GREEN!22 !Easy 7zip!
echo              !S_GREEN!15 !Ripcord!                               !S_GREEN!20 !Microsoft Office!                      !S_GREEN!23 !Winrar!
echo              !S_GREEN!16 !TeamSpeak!                             !S_GREEN!21 !Libre Office!
echo              !S_GREEN!17 !Skype!
echo              !S_GREEN!18 !Zoom!
echo.
echo              !S_YELLOW!DEVELOPER TOOLS                              GAMES LAUNCHER                               OTHERS
echo              ---------------                              --------------                               ------
echo              !S_GREEN!24 !Visual Studio Code!                    !S_GREEN!29 !Steam!                                 !S_GREEN!35 !qBittorrent!
echo              !S_GREEN!25 !Notepad++!                             !S_GREEN!30 !GOG Galaxy!                            !S_GREEN!36 !TeamViewer!
echo              !S_GREEN!26 !FileZilla!                             !S_GREEN!31 !Epic Games!                            !S_GREEN!37 !Revo Uninstaller!
echo              !S_GREEN!27 !PuTTY!                                 !S_GREEN!32 !Uplay!                                 !S_GREEN!38 !Everything!
echo              !S_GREEN!28 !Python!                                !S_GREEN!33 !Battle.net!                            !S_GREEN!39 !Vortex!
echo                                                           !S_GREEN!34 !Origin!
echo              !S_RED!Recommended to install
echo              ----------------------
echo              !S_GREEN!40 !Visual C++ Redistributables!
echo              !S_GREEN!41 !DirectX!
echo              !S_GREEN!42 !.NET Framework 4.8!
echo.
echo                                                      !S_GRAY!Make your choices or !S_GREEN!"BACK"!S_GRAY!
echo.
set choice=
set /p "choice=!S_GREEN!                                                                 "
:: WEB BROWSERS
if "!choice!"=="1" if "!Chromium!"=="!S_MAGENTA![ ]!S_WHITE! Chromium" (set "Chromium=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Chromium" && goto APPS_MENU) else set "Chromium=!S_MAGENTA![ ]!S_WHITE! Chromium" && goto APPS_MENU
if "!choice!"=="2" if "!Mozilla Firefox!"=="!S_MAGENTA![ ]!S_WHITE! Mozilla Firefox" (set "Mozilla Firefox=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Mozilla Firefox" && goto APPS_MENU) else set "Mozilla Firefox=!S_MAGENTA![ ]!S_WHITE! Mozilla Firefox" && goto APPS_MENU
if "!choice!"=="3" if "!Brave!"=="!S_MAGENTA![ ]!S_WHITE! Brave" (set "Brave=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Brave" && goto APPS_MENU) else set "Brave=!S_MAGENTA![ ]!S_WHITE! Brave" && goto APPS_MENU
if "!choice!"=="4" if "!Opera GX!"=="!S_MAGENTA![ ]!S_WHITE! Opera GX" (set "Opera GX=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Opera GX" && goto APPS_MENU) else set "Opera GX=!S_MAGENTA![ ]!S_WHITE! Opera GX" && goto APPS_MENU
:: MEDIA
if "!choice!"=="5" if "!Deezer!"=="!S_MAGENTA![ ]!S_WHITE! Deezer" (set "Deezer=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Deezer" && goto APPS_MENU) else set "Deezer=!S_MAGENTA![ ]!S_WHITE! Deezer" && goto APPS_MENU
if "!choice!"=="6" if "!Spotify!"=="!S_MAGENTA![ ]!S_WHITE! Spotify" (set "Spotify=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Spotify" && goto APPS_MENU) else set "Spotify=!S_MAGENTA![ ]!S_WHITE! Spotify" && goto APPS_MENU
if "!choice!"=="7" if "!iTunes!"=="!S_MAGENTA![ ]!S_WHITE! iTunes" (set "iTunes=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! iTunes" && goto APPS_MENU) else set "iTunes=!S_MAGENTA![ ]!S_WHITE! iTunes" && goto APPS_MENU
if "!choice!"=="8" if "!PotPlayer!"=="!S_MAGENTA![ ]!S_WHITE! PotPlayer" (set "PotPlayer=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! PotPlayer" && goto APPS_MENU) else set "PotPlayer=!S_MAGENTA![ ]!S_WHITE! PotPlayer" && goto APPS_MENU
if "!choice!"=="9" if "!VLC media player!"=="!S_MAGENTA![ ]!S_WHITE! VLC media player" (set "VLC media player=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! VLC media player" && goto APPS_MENU) else set "VLC media player=!S_MAGENTA![ ]!S_WHITE! VLC media player" && goto APPS_MENU
if "!choice!"=="10" if "!Audacity!"=="!S_MAGENTA![ ]!S_WHITE! Audacity" (set "Audacity=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Audacity" && goto APPS_MENU) else set "Audacity=!S_MAGENTA![ ]!S_WHITE! Audacity" && goto APPS_MENU
:: IMAGING
if "!choice!"=="11" if "!ImageGlass!"=="!S_MAGENTA![ ]!S_WHITE! ImageGlass" (set "ImageGlass=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! ImageGlass" && goto APPS_MENU) else set "ImageGlass=!S_MAGENTA![ ]!S_WHITE! ImageGlass" && goto APPS_MENU
if "!choice!"=="12" if "!ShareX!"=="!S_MAGENTA![ ]!S_WHITE! ShareX" (set "ShareX=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! ShareX" && goto APPS_MENU) else set "ShareX=!S_MAGENTA![ ]!S_WHITE! ShareX" && goto APPS_MENU
if "!choice!"=="13" if "!GIMP!"=="!S_MAGENTA![ ]!S_WHITE! GIMP" (set "GIMP=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! GIMP" && goto APPS_MENU) else set "GIMP=!S_MAGENTA![ ]!S_WHITE! GIMP" && goto APPS_MENU
:: MESSAGING
if "!choice!"=="14" if "!Discord!"=="!S_MAGENTA![ ]!S_WHITE! Discord" (set "Discord=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Discord" && goto APPS_MENU) else set "Discord=!S_MAGENTA![ ]!S_WHITE! Discord" && goto APPS_MENU
if "!choice!"=="15" if "!Ripcord!"=="!S_MAGENTA![ ]!S_WHITE! Ripcord" (set "Ripcord=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Ripcord" && goto APPS_MENU) else set "Ripcord=!S_MAGENTA![ ]!S_WHITE! Ripcord" && goto APPS_MENU
if "!choice!"=="16" if "!TeamSpeak!"=="!S_MAGENTA![ ]!S_WHITE! TeamSpeak" (set "TeamSpeak=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! TeamSpeak" && goto APPS_MENU) else set "TeamSpeak=!S_MAGENTA![ ]!S_WHITE! TeamSpeak" && goto APPS_MENU
if "!choice!"=="17" if "!Skype!"=="!S_MAGENTA![ ]!S_WHITE! Skype" (set "Skype=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Skype" && goto APPS_MENU) else set "Skype=!S_MAGENTA![ ]!S_WHITE! Skype" && goto APPS_MENU
if "!choice!"=="18" if "!Zoom!"=="!S_MAGENTA![ ]!S_WHITE! Zoom" (set "Zoom=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Zoom" && goto APPS_MENU) else set "Zoom=!S_MAGENTA![ ]!S_WHITE! Zoom" && goto APPS_MENU
:: DOCUMENTS
if "!choice!"=="19" if "!Foxit Reader!"=="!S_MAGENTA![ ]!S_WHITE! Foxit Reader" (set "Foxit Reader=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Foxit Reader" && goto APPS_MENU) else set "Foxit Reader=!S_MAGENTA![ ]!S_WHITE! Foxit Reader" && goto APPS_MENU
if "!choice!"=="20" if "!Microsoft Office!"=="!S_MAGENTA![ ]!S_WHITE! Microsoft Office" (set "Microsoft Office=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Microsoft Office" && goto APPS_MENU) else set "Microsoft Office=!S_MAGENTA![ ]!S_WHITE! Microsoft Office" && goto APPS_MENU
if "!choice!"=="21" if "!Libre Office!"=="!S_MAGENTA![ ]!S_WHITE! Libre Office" (set "Libre Office=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Libre Office" && goto APPS_MENU) else set "Libre Office=!S_MAGENTA![ ]!S_WHITE! Libre Office" && goto APPS_MENU
:: COMPRESSION
if "!choice!"=="22" if "!Easy 7zip!"=="!S_MAGENTA![ ]!S_WHITE! Easy 7zip" (set "Easy 7zip=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Easy 7zip" && goto APPS_MENU) else set "Easy 7zip=!S_MAGENTA![ ]!S_WHITE! Easy 7zip" && goto APPS_MENU
if "!choice!"=="23" if "!Winrar!"=="!S_MAGENTA![ ]!S_WHITE! Winrar" (set "Winrar=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Winrar" && goto APPS_MENU) else set "Winrar=!S_MAGENTA![ ]!S_WHITE! Winrar" && goto APPS_MENU
:: DEVELOPER TOOLS
if "!choice!"=="24" if "!Visual Studio Code!"=="!S_MAGENTA![ ]!S_WHITE! Visual Studio Code" (set "Visual Studio Code=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Visual Studio Code" && goto APPS_MENU) else set "Visual Studio Code=!S_MAGENTA![ ]!S_WHITE! Visual Studio Code" && goto APPS_MENU
if "!choice!"=="25" if "!Notepad++!"=="!S_MAGENTA![ ]!S_WHITE! Notepad++" (set "Notepad++=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Notepad++" && goto APPS_MENU) else set "Notepad++=!S_MAGENTA![ ]!S_WHITE! Notepad++" && goto APPS_MENU
if "!choice!"=="26" if "!FileZilla!"=="!S_MAGENTA![ ]!S_WHITE! FileZilla" (set "FileZilla=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! FileZilla" && goto APPS_MENU) else set "FileZilla=!S_MAGENTA![ ]!S_WHITE! FileZilla" && goto APPS_MENU
if "!choice!"=="27" if "!PuTTY!"=="!S_MAGENTA![ ]!S_WHITE! PuTTY" (set "PuTTY=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! PuTTY" && goto APPS_MENU) else set "PuTTY=!S_MAGENTA![ ]!S_WHITE! PuTTY" && goto APPS_MENU
if "!choice!"=="28" if "!Python!"=="!S_MAGENTA![ ]!S_WHITE! Python" (set "Python=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Python" && goto APPS_MENU) else set "Python=!S_MAGENTA![ ]!S_WHITE! Python" && goto APPS_MENU
:: GAMES LAUNCHER
if "!choice!"=="29" if "!Steam!"=="!S_MAGENTA![ ]!S_WHITE! Steam" (set "Steam=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Steam" && goto APPS_MENU) else set "Steam=!S_MAGENTA![ ]!S_WHITE! Steam" && goto APPS_MENU
if "!choice!"=="30" if "!GOG Galaxy!"=="!S_MAGENTA![ ]!S_WHITE! GOG Galaxy" (set "GOG Galaxy=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! GOG Galaxy" && goto APPS_MENU) else set "GOG Galaxy=!S_MAGENTA![ ]!S_WHITE! GOG Galaxy" && goto APPS_MENU
if "!choice!"=="31" if "!Epic Games!"=="!S_MAGENTA![ ]!S_WHITE! Epic Games" (set "Epic Games=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Epic Games" && goto APPS_MENU) else set "Epic Games=!S_MAGENTA![ ]!S_WHITE! Epic Games" && goto APPS_MENU
if "!choice!"=="32" if "!Uplay!"=="!S_MAGENTA![ ]!S_WHITE! Uplay" (set "Uplay=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Uplay" && goto APPS_MENU) else set "Uplay=!S_MAGENTA![ ]!S_WHITE! Uplay" && goto APPS_MENU
if "!choice!"=="33" if "!Battle.net!"=="!S_MAGENTA![ ]!S_WHITE! Battle.net" (set "Battle.net=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Battle.net" && goto APPS_MENU) else set "Battle.net=!S_MAGENTA![ ]!S_WHITE! Battle.net" && goto APPS_MENU
if "!choice!"=="34" if "!Origin!"=="!S_MAGENTA![ ]!S_WHITE! Origin" (set "Origin=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Origin" && goto APPS_MENU) else set "Origin=!S_MAGENTA![ ]!S_WHITE! Origin" && goto APPS_MENU
:: OTHERS
if "!choice!"=="35" if "!qBittorrent!"=="!S_MAGENTA![ ]!S_WHITE! qBittorrent" (set "qBittorrent=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! qBittorrent" && goto APPS_MENU) else set "qBittorrent=!S_MAGENTA![ ]!S_WHITE! qBittorrent" && goto APPS_MENU
if "!choice!"=="36" if "!TeamViewer!"=="!S_MAGENTA![ ]!S_WHITE! TeamViewer" (set "TeamViewer=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! TeamViewer" && goto APPS_MENU) else set "TeamViewer=!S_MAGENTA![ ]!S_WHITE! TeamViewer" && goto APPS_MENU
if "!choice!"=="37" if "!Revo Uninstaller!"=="!S_MAGENTA![ ]!S_WHITE! Revo Uninstaller" (set "Revo Uninstaller=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Revo Uninstaller" && goto APPS_MENU) else set "Revo Uninstaller=!S_MAGENTA![ ]!S_WHITE! Revo Uninstaller" && goto APPS_MENU
if "!choice!"=="38" if "!Everything!"=="!S_MAGENTA![ ]!S_WHITE! Everything" (set "Everything=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Everything" && goto APPS_MENU) else set "Everything=!S_MAGENTA![ ]!S_WHITE! Everything" && goto APPS_MENU
if "!choice!"=="39" if "!Vortex!"=="!S_MAGENTA![ ]!S_WHITE! Vortex" (set "Vortex=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Vortex" && goto APPS_MENU) else set "Vortex=!S_MAGENTA![ ]!S_WHITE! Vortex" && goto APPS_MENU
:: Recommended to install
if "!choice!"=="40" if "!Visual C++ Redistributables!"=="!S_MAGENTA![ ]!S_WHITE! Visual C++ Redistributables" (set "Visual C++ Redistributables=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Visual C++ Redistributables" && goto APPS_MENU) else set "Visual C++ Redistributables=!S_MAGENTA![ ]!S_WHITE! Visual C++ Redistributables" && goto APPS_MENU
if "!choice!"=="41" if "!DirectX!"=="!S_MAGENTA![ ]!S_WHITE! DirectX" (set "DirectX=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! DirectX" && goto APPS_MENU) else set "DirectX=!S_MAGENTA![ ]!S_WHITE! DirectX" && goto APPS_MENU
if "!choice!"=="42" if "!.NET Framework 4.8!"=="!S_MAGENTA![ ]!S_WHITE! .NET Framework 4.8" (set ".NET Framework 4.8=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! .NET Framework 4.8" && goto APPS_MENU) else set ".NET Framework 4.8=!S_MAGENTA![ ]!S_WHITE! .NET Framework 4.8" && goto APPS_MENU
if "!choice!"=="" (
    for %%i in (!APPS_MENU!) do if "!%%~i!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! %%~i" goto APPS_INSTALL
    echo                                                  !RED!Error : !S_GREEN!"!choice!"!S_GRAY! is not a valid choice...
    timeout /t 3 /nobreak >nul 2>&1
    goto APPS_MENU
)
if /i "!choice!"=="b" goto MAIN_MENU
if /i "!choice!"=="back" goto MAIN_MENU
echo                                                  !RED!Error : !S_GREEN!"!choice!"!S_GRAY! is not a valid choice...
timeout /t 3 /nobreak >nul 2>&1
goto APPS_MENU

:APPS_INSTALL
:: WEB BROWSERS
if "!Chromium!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Chromium" call:CHOCO Chromium
if "!Mozilla Firefox!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Mozilla Firefox" call:CHOCO firefox
if "!Brave!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Brave" call:CHOCO brave
if "!Opera GX!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Opera GX" call:CHOCO opera-gx
:: MEDIA
if "!Deezer!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Deezer" call:CHOCO deezer
if "!Spotify!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Spotify" call:CHOCO spotify
if "!iTunes!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! iTunes" call:CHOCO itunes
if "!PotPlayer!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! PotPlayer" call:CHOCO potplayer
if "!VLC media player!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! VLC media player" call:CHOCO vlc
if "!Audacity!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Audacity" call:CHOCO audacity
:: IMAGING
if "!ImageGlass!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! ImageGlass" call:CHOCO imageglass
if "!ShareX!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! ShareX" call:CHOCO sharex
if "!GIMP!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! GIMP" call:CHOCO gimp
:: MESSAGING
if "!Discord!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Discord" call:CHOCO discord
if "!Ripcord!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Ripcord" call:CHOCO ripcord & call:SHORTCUT "Ripcord" "%UserProfile%\desktop" "%ProgramData%\chocolatey\lib\ripcord\tools\Ripcord.exe" "%ProgramData%\chocolatey\lib\ripcord\tools"
if "!TeamSpeak!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! TeamSpeak" call:CHOCO teamspeak
if "!Skype!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Skype" call:CHOCO skype
if "!Zoom!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Zoom" call:CHOCO zoom
:: DOCUMENTS
if "!Foxit Reader!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Foxit Reader" call:CHOCO foxitreader
if "!Microsoft Office!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Microsoft Office" call:CHOCO office-tool & call:SHORTCUT "Office Tool Plus" "%UserProfile%\desktop" "%LocalAppData%\Office Tool\Office Tool Plus.exe" "%LocalAppData%\Office Tool"
if "!Libre Office!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Libre Office" call:CHOCO libreoffice-fresh
:: COMPRESSION
if "!Easy 7zip!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Easy 7zip" call:CHOCO easy7zip
if "!Winrar!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Winrar" call:CHOCO winrar
:: DEVELOPER TOOLS
if "!Visual Studio Code!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Visual Studio Code" call:CHOCO vscode
if "!Notepad++!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Notepad++" call:CHOCO notepadplusplus
if "!FileZilla!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! FileZilla" call:CHOCO filezilla
if "!PuTTY!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! PuTTY" call:CHOCO putty
if "!Python!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Python" call:CHOCO Python
:: GAMES LAUNCHER
if "!Steam!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Steam" call:CHOCO steam
if "!GOG Galaxy!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! GOG Galaxy" call:CHOCO goggalaxy
if "!Epic Games!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Epic Games" call:CHOCO epicgameslauncher
if "!Uplay!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Uplay" call:CHOCO uplay
if "!Battle.net!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Battle.net" call:CHOCO battle.net
if "!Origin!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Origin" call:CHOCO origin & call:SHORTCUT "Origin" "%UserProfile%\desktop" "\Program Files (x86)\Origin\Origin.exe" "\Program Files (x86)\Origin"
:: OTHERS
if "!qBittorrent!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! qBittorrent" call:CHOCO qbittorrent & call:SHORTCUT "qBittorrent" "%UserProfile%\desktop" "\Program Files\qBittorrent\qbittorrent.exe" "\Program Files\qBittorrent"
if "!TeamViewer!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! TeamViewer" call:CHOCO teamviewer
if "!Revo Uninstaller!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Revo Uninstaller" call:CHOCO revo-uninstaller
if "!Everything!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Everything" call:CHOCO everything
if "!Vortex!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Vortex" call:CHOCO vortex
:: Recommended to install
if "!Visual C++ Redistributables!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Visual C++ Redistributables" call:CHOCO vcredist-all
if "!DirectX!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! DirectX" call:CHOCO directx
IF "!.NET Framework 4.8!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! .NET Framework 4.8" call:CHOCO dotnetfx
goto APPS_MENU_CLEAR

:TOOLS_MENU_CLEAR
set TOOLS="NSudo" "Autoruns" "ServiWin" "Memory Booster" "Device Cleanup" "MSI Afterburner" "CPU-Z" "GPU-Z" "HWiNFO" "CrystalDiskInfo" "Snappy Driver Installer" "NVCleanstall" "Radeon Software Slimmer" "Display Driver Uninstaller" "Unigine Superposition" "CINEBENCH" "AIDA64" "OCCT" "LatencyMon" "MSI Util v3" "Interrupt Affinity" "TCP Optimizer" "WLAN Optimizer" "DNS Jumper" "Nvidia Profile Inspector" "GPU Pixel Clock Patcher" "Custom Resolution Utility" "SweetLow Mouse Rate Changer" "ThrottleStop"
for %%i in (!TOOLS!) do set "%%~i=!S_MAGENTA![ ]!S_WHITE! %%~i"

:TOOLS_MENU
cls
mode con lines=28 cols=150
echo !S_MAGENTA!
echo                                ╔═════════════════════════════════════════════════════════════════════════════════════╗
echo                                ║                                        !S_GREEN!TOOLS!S_MAGENTA!                                        ║
echo                                ╚═════════════════════════════════════════════════════════════════════════════════════╝
echo.
echo              !S_YELLOW!UTILITIES                                    SYSTEM INFOS                                 DRIVERS
echo              ---------                                    ------------                                 -------
echo               !S_GREEN!1 !NSudo!                                  !S_GREEN!7 !CPU-Z!                                 !S_GREEN!11 !Snappy Driver Installer!
echo               !S_GREEN!2 !Autoruns!                               !S_GREEN!8 !GPU-Z!                                 !S_GREEN!12 !NVCleanstall!
echo               !S_GREEN!3 !ServiWin!                               !S_GREEN!9 !HWiNFO!                                !S_GREEN!13 !Radeon Software Slimmer!
echo               !S_GREEN!4 !Memory Booster!                        !S_GREEN!10 !CrystalDiskInfo!                       !S_GREEN!14 !Display Driver Uninstaller!
echo               !S_GREEN!5 !Device Cleanup!
echo               !S_GREEN!6 !MSI Afterburner!
echo.
echo              !S_YELLOW!BENCHMARK ^& STRESS                           TWEAKS
echo              ------------------                           ------
echo              !S_GREEN!15 !Unigine Superposition!                 !S_GREEN!20 !MSI Util v3!                           !S_GREEN!25 !Nvidia Profile Inspector!
echo              !S_GREEN!16 !CINEBENCH!                             !S_GREEN!21 !Interrupt Affinity!                    !S_GREEN!26 !GPU Pixel Clock Patcher!
echo              !S_GREEN!17 !AIDA64!                                !S_GREEN!22 !TCP Optimizer!                         !S_GREEN!27 !Custom Resolution Utility!
echo              !S_GREEN!18 !OCCT!                                  !S_GREEN!23 !WLAN Optimizer!                        !S_GREEN!28 !SweetLow Mouse Rate Changer!
echo              !S_GREEN!19 !LatencyMon!                            !S_GREEN!24 !DNS Jumper!                            !S_GREEN!29 !ThrottleStop!
echo.
echo                                                              !S_GRAY!Make your choices or !S_GREEN!"BACK"!S_GRAY!
echo.
set choice=
set /p "choice=!S_GREEN!                                                                          "
:: UTILITIES
if "!choice!"=="1" if "!NSudo!"=="!S_MAGENTA![ ]!S_WHITE! NSudo" (set "NSudo=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! NSudo" && goto TOOLS_MENU) else set "NSudo=!S_MAGENTA![ ]!S_WHITE! NSudo" && goto TOOLS_MENU
if "!choice!"=="2" if "!Autoruns!"=="!S_MAGENTA![ ]!S_WHITE! Autoruns" (set "Autoruns=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Autoruns" && goto TOOLS_MENU) else set "Autoruns=!S_MAGENTA![ ]!S_WHITE! Autoruns" && goto TOOLS_MENU
if "!choice!"=="3" if "!ServiWin!"=="!S_MAGENTA![ ]!S_WHITE! ServiWin" (set "ServiWin=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! ServiWin" && goto TOOLS_MENU) else set "ServiWin=!S_MAGENTA![ ]!S_WHITE! ServiWin" && goto TOOLS_MENU
if "!choice!"=="4" if "!Memory Booster!"=="!S_MAGENTA![ ]!S_WHITE! Memory Booster" (set "Memory Booster=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Memory Booster" && goto TOOLS_MENU) else set "Memory Booster=!S_MAGENTA![ ]!S_WHITE! Memory Booster" && goto TOOLS_MENU
if "!choice!"=="5" if "!Device Cleanup!"=="!S_MAGENTA![ ]!S_WHITE! Device Cleanup" (set "Device Cleanup=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Device Cleanup" && goto TOOLS_MENU) else set "Device Cleanup=!S_MAGENTA![ ]!S_WHITE! Device Cleanup" && goto TOOLS_MENU
if "!choice!"=="6" if "!MSI Afterburner!"=="!S_MAGENTA![ ]!S_WHITE! MSI Afterburner" (set "MSI Afterburner=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! MSI Afterburner" && goto TOOLS_MENU) else set "MSI Afterburner=!S_MAGENTA![ ]!S_WHITE! MSI Afterburner" && goto TOOLS_MENU
:: SYSTEM INFOS
if "!choice!"=="7" if "!CPU-Z!"=="!S_MAGENTA![ ]!S_WHITE! CPU-Z" (set "CPU-Z=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! CPU-Z" && goto TOOLS_MENU) else set "CPU-Z=!S_MAGENTA![ ]!S_WHITE! CPU-Z" && goto TOOLS_MENU
if "!choice!"=="8" if "!GPU-Z!"=="!S_MAGENTA![ ]!S_WHITE! GPU-Z" (set "GPU-Z=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! GPU-Z" && goto TOOLS_MENU) else set "GPU-Z=!S_MAGENTA![ ]!S_WHITE! GPU-Z" && goto TOOLS_MENU
if "!choice!"=="9" if "!HWiNFO!"=="!S_MAGENTA![ ]!S_WHITE! HWiNFO" (set "HWiNFO=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! HWiNFO" && goto TOOLS_MENU) else set "HWiNFO=!S_MAGENTA![ ]!S_WHITE! HWiNFO" && goto TOOLS_MENU
if "!choice!"=="10" if "!CrystalDiskInfo!"=="!S_MAGENTA![ ]!S_WHITE! CrystalDiskInfo" (set "CrystalDiskInfo=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! CrystalDiskInfo" && goto TOOLS_MENU) else set "CrystalDiskInfo=!S_MAGENTA![ ]!S_WHITE! CrystalDiskInfo" && goto TOOLS_MENU
:: DRIVERS
if "!choice!"=="11" if "!Snappy Driver Installer!"=="!S_MAGENTA![ ]!S_WHITE! Snappy Driver Installer" (set "Snappy Driver Installer=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Snappy Driver Installer" && goto TOOLS_MENU) else set "Snappy Driver Installer=!S_MAGENTA![ ]!S_WHITE! Snappy Driver Installer" && goto TOOLS_MENU
if "!choice!"=="12" if "!NVCleanstall!"=="!S_MAGENTA![ ]!S_WHITE! NVCleanstall" (set "NVCleanstall=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! NVCleanstall" && goto TOOLS_MENU) else set "NVCleanstall=!S_MAGENTA![ ]!S_WHITE! NVCleanstall" && goto TOOLS_MENU
if "!choice!"=="13" if "!Radeon Software Slimmer!"=="!S_MAGENTA![ ]!S_WHITE! Radeon Software Slimmer" (set "Radeon Software Slimmer=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Radeon Software Slimmer" && goto TOOLS_MENU) else set "Radeon Software Slimmer=!S_MAGENTA![ ]!S_WHITE! Radeon Software Slimmer" && goto TOOLS_MENU
if "!choice!"=="14" if "!Display Driver Uninstaller!"=="!S_MAGENTA![ ]!S_WHITE! Display Driver Uninstaller" (set "Display Driver Uninstaller=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Display Driver Uninstaller" && goto TOOLS_MENU) else set "Display Driver Uninstaller=!S_MAGENTA![ ]!S_WHITE! Display Driver Uninstaller" && goto TOOLS_MENU
:: BENCHMARK & STRESS
if "!choice!"=="15" if "!Unigine Superposition!"=="!S_MAGENTA![ ]!S_WHITE! Unigine Superposition" (set "Unigine Superposition=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Unigine Superposition" && goto TOOLS_MENU) else set "Unigine Superposition=!S_MAGENTA![ ]!S_WHITE! Unigine Superposition" && goto TOOLS_MENU
if "!choice!"=="16" if "!CINEBENCH!"=="!S_MAGENTA![ ]!S_WHITE! CINEBENCH" (set "CINEBENCH=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! CINEBENCH" && goto TOOLS_MENU) else set "CINEBENCH=!S_MAGENTA![ ]!S_WHITE! CINEBENCH" && goto TOOLS_MENU
if "!choice!"=="17" if "!AIDA64!"=="!S_MAGENTA![ ]!S_WHITE! AIDA64" (set "AIDA64=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! AIDA64" && goto TOOLS_MENU) else set "AIDA64=!S_MAGENTA![ ]!S_WHITE! AIDA64" && goto TOOLS_MENU
if "!choice!"=="18" if "!OCCT!"=="!S_MAGENTA![ ]!S_WHITE! OCCT" (set "OCCT=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! OCCT" && goto TOOLS_MENU) else set "OCCT=!S_MAGENTA![ ]!S_WHITE! OCCT" && goto TOOLS_MENU
if "!choice!"=="19" if "!LatencyMon!"=="!S_MAGENTA![ ]!S_WHITE! LatencyMon" (set "LatencyMon=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! LatencyMon" && goto TOOLS_MENU) else set "LatencyMon=!S_MAGENTA![ ]!S_WHITE! LatencyMon" && goto TOOLS_MENU
:: TWEAKS
if "!choice!"=="20" if "!MSI Util v3!"=="!S_MAGENTA![ ]!S_WHITE! MSI Util v3" (set "MSI Util v3=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! MSI Util v3" && goto TOOLS_MENU) else set "MSI Util v3=!S_MAGENTA![ ]!S_WHITE! MSI Util v3" && goto TOOLS_MENU
if "!choice!"=="21" if "!Interrupt Affinity!"=="!S_MAGENTA![ ]!S_WHITE! Interrupt Affinity" (set "Interrupt Affinity=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Interrupt Affinity" && goto TOOLS_MENU) else set "Interrupt Affinity=!S_MAGENTA![ ]!S_WHITE! Interrupt Affinity" && goto TOOLS_MENU
if "!choice!"=="22" if "!TCP Optimizer!"=="!S_MAGENTA![ ]!S_WHITE! TCP Optimizer" (set "TCP Optimizer=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! TCP Optimizer" && goto TOOLS_MENU) else set "TCP Optimizer=!S_MAGENTA![ ]!S_WHITE! TCP Optimizer" && goto TOOLS_MENU
if "!choice!"=="23" if "!WLAN Optimizer!"=="!S_MAGENTA![ ]!S_WHITE! WLAN Optimizer" (set "WLAN Optimizer=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! WLAN Optimizer" && goto TOOLS_MENU) else set "WLAN Optimizer=!S_MAGENTA![ ]!S_WHITE! WLAN Optimizer" && goto TOOLS_MENU
if "!choice!"=="24" if "!DNS Jumper!"=="!S_MAGENTA![ ]!S_WHITE! DNS Jumper" (set "DNS Jumper=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! DNS Jumper" && goto TOOLS_MENU) else set "DNS Jumper=!S_MAGENTA![ ]!S_WHITE! DNS Jumper" && goto TOOLS_MENU
if "!choice!"=="25" if "!Nvidia Profile Inspector!"=="!S_MAGENTA![ ]!S_WHITE! Nvidia Profile Inspector" (set "Nvidia Profile Inspector=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Nvidia Profile Inspector" && goto TOOLS_MENU) else set "Nvidia Profile Inspector=!S_MAGENTA![ ]!S_WHITE! Nvidia Profile Inspector" && goto TOOLS_MENU
if "!choice!"=="26" if "!GPU Pixel Clock Patcher!"=="!S_MAGENTA![ ]!S_WHITE! GPU Pixel Clock Patcher" (set "GPU Pixel Clock Patcher=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! GPU Pixel Clock Patcher" && goto TOOLS_MENU) else set "GPU Pixel Clock Patcher=!S_MAGENTA![ ]!S_WHITE! GPU Pixel Clock Patcher" && goto TOOLS_MENU
if "!choice!"=="27" if "!Custom Resolution Utility!"=="!S_MAGENTA![ ]!S_WHITE! Custom Resolution Utility" (set "Custom Resolution Utility=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Custom Resolution Utility" && goto TOOLS_MENU) else set "Custom Resolution Utility=!S_MAGENTA![ ]!S_WHITE! Custom Resolution Utility" && goto TOOLS_MENU
if "!choice!"=="28" if "!SweetLow Mouse Rate Changer!"=="!S_MAGENTA![ ]!S_WHITE! SweetLow Mouse Rate Changer" (set "SweetLow Mouse Rate Changer=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! SweetLow Mouse Rate Changer" && goto TOOLS_MENU) else set "SweetLow Mouse Rate Changer=!S_MAGENTA![ ]!S_WHITE! SweetLow Mouse Rate Changer" && goto TOOLS_MENU
if "!choice!"=="29" if "!ThrottleStop!"=="!S_MAGENTA![ ]!S_WHITE! ThrottleStop" (set "ThrottleStop=!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! ThrottleStop" && goto TOOLS_MENU) else set "ThrottleStop=!S_MAGENTA![ ]!S_WHITE! ThrottleStop" && goto TOOLS_MENU
if "!choice!"=="" (
    for %%i in (!TOOLS!) do if "!%%~i!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! %%~i" goto TOOLS_INSTALL
    echo                                                          !RED!Error : !S_GREEN!"!choice!"!S_GRAY! is not a valid choice...
    timeout /t 3 /nobreak >nul 2>&1
    goto TOOLS_MENU
)
if /i "!choice!"=="b" goto MAIN_MENU
if /i "!choice!"=="back" goto MAIN_MENU
echo                                                          !RED!Error : !S_GREEN!"!choice!"!S_GRAY! is not a valid choice...
timeout /t 3 /nobreak >nul 2>&1
goto TOOLS_MENU

:TOOLS_INSTALL
:: UTILITIES
if "!NSudo!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! NSudo" set "OPENTOOLS=True" & call:CURL "0" "https://cdn.discordapp.com/attachments/595370063104573511/755786967660101702/NSudo.exe" "%UserProfile%\Documents\_Tools\NSudo.exe"
if "!Autoruns!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Autoruns" set "OPENTOOLS=True" & call:CURL "0" "https://cdn.discordapp.com/attachments/595370063104573511/755789664627064902/Autoruns.exe" "%UserProfile%\Documents\_Tools\Autoruns.exe"
if "!ServiWin!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! ServiWin" set "OPENTOOLS=True" & call:CURL "0" "https://cdn.discordapp.com/attachments/595370063104573511/755791010893660190/ServiWin.exe" "%UserProfile%\Documents\_Tools\ServiWin.exe"
if "!Memory Booster!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Memory Booster" set "OPENTOOLS=True" & call:CURL "0" "https://cdn.discordapp.com/attachments/595370063104573511/755787065974849638/MemoryBooster_2.1.exe" "%UserProfile%\Documents\_Tools\MemoryBooster.exe"
if "!Device Cleanup!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Device Cleanup" set "OPENTOOLS=True" & call:CURL "0" "https://cdn.discordapp.com/attachments/595370063104573511/755790659356590080/DeviceCleanup.exe" "%UserProfile%\Documents\_Tools\DeviceCleanup.exe"
if "!MSI Afterburner!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! MSI Afterburner" call:CHOCO msiafterburner
:: SYSTEM INFOS
if "!CPU-Z!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! CPU-Z" set "OPENTOOLS=True" & call:CURL "0" "https://cdn.discordapp.com/attachments/595370063104573511/755790662346997910/CPU-Z.exe" "%UserProfile%\Documents\_Tools\CPU-Z.exe"
if "!GPU-Z!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! GPU-Z" set "OPENTOOLS=True" & call:CURL "0" "https://nl1-dl.techpowerup.com/files/GPU-Z.2.34.0.exe#/GPU-Z.2.34.0.exe" "%UserProfile%\Documents\_Tools\GPU-Z.exe"
if "!HWiNFO!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! HWiNFO" (
    set "OPENTOOLS=True"
    call:CURL "0" "https://www.sac.sk/download/utildiag/hwi_630.zip" "%UserProfile%\Documents\_Tools\HWiNFO\hwi.zip"
    call "modules\7z.exe" x -aoa "%UserProfile%\Documents\_Tools\HWiNFO\hwi.zip" -O"%UserProfile%\Documents\_Tools\HWiNFO" >nul 2>&1
    del /f /q "%UserProfile%\Documents\_Tools\HWiNFO\hwi.zip" >nul 2>&1
)
if "!CrystalDiskInfo!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! CrystalDiskInfo" (
    set "OPENTOOLS=True"
    call:CURL "0" "https://dotsrc.dl.osdn.net/osdn/crystaldiskinfo/73507/CrystalDiskInfo8_8_7.zip" "%UserProfile%\Documents\_Tools\CrystalDiskInfo\CrystalDiskInfo.zip"
    call "modules\7z.exe" x -aoa "%UserProfile%\Documents\_Tools\CrystalDiskInfo\CrystalDiskInfo.zip"  -O"%UserProfile%\Documents\_Tools\CrystalDiskInfo">nul 2>&1
    del /f /q "%UserProfile%\Documents\_Tools\CrystalDiskInfo\CrystalDiskInfo.zip" >nul 2>&1
)
:: DRIVERS
if "!Snappy Driver Installer!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Snappy Driver Installer" (
    set "OPENTOOLS=True"
    call:CURL "0" "http://sdi-tool.org/releases/SDI_R2000.zip" "%UserProfile%\Documents\_Tools\Snappy Driver Installer\SDI.zip"
    call "modules\7z.exe" x -aoa "%UserProfile%\Documents\_Tools\Snappy Driver Installer\SDI.zip"  -O"%UserProfile%\Documents\_Tools\Snappy Driver Installer">nul 2>&1
    del /f /q "%UserProfile%\Documents\_Tools\Snappy Driver Installer\SDI.zip" >nul 2>&1
)
if "!NVCleanstall!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! NVCleanstall" set "OPENTOOLS=True" & call:CURL "0" "https://nl1-dl.techpowerup.com/files/NVCleanstall_1.7.0.exe#/NVCleanstall.exe" "%UserProfile%\Documents\_Tools\NVCleanstall.exe"
if "!Radeon Software Slimmer!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Radeon Software Slimmer" (
    set "OPENTOOLS=True"
    call:CURL "0" "https://github.com/GSDragoon/RadeonSoftwareSlimmer/releases/download/1.0.0-beta.6/RadeonSoftwareSlimmer_1.0.0-beta.6_net48.zip" "%UserProfile%\Documents\_Tools\Radeon Software Slimmer\RadeonSoftwareSlimmer.zip"
    call "modules\7z.exe" x -aoa "%UserProfile%\Documents\_Tools\Radeon Software Slimmer\RadeonSoftwareSlimmer.zip"  -O"%UserProfile%\Documents\_Tools\Radeon Software Slimmer">nul 2>&1
    del /f /q "%UserProfile%\Documents\_Tools\Radeon Software Slimmer\RadeonSoftwareSlimmer.zip" >nul 2>&1
)
if "!Display Driver Uninstaller!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Display Driver Uninstaller" (
    set "OPENTOOLS=True"
    call:CURL "0" "https://cdn.discordapp.com/attachments/595370063104573511/762442679254384690/DDU.exe" "%UserProfile%\Documents\_Tools\DDU.exe"
    call "modules\7z.exe" x -aoa "%UserProfile%\Documents\_Tools\DDU.exe" -O"%UserProfile%\Documents\_Tools" >nul 2>&1
    move "%UserProfile%\Documents\_Tools\DDU v18.0.3.3" "%UserProfile%\Documents\_Tools\Display Driver Uninstaller" >nul 2>&1
    del /f /q "%UserProfile%\Documents\_Tools\DDU.exe" >nul 2>&1
)
:: BENCHMARK & STRESS
if "!Unigine Superposition!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Unigine Superposition" call:CHOCO superposition-benchmark
if "!CINEBENCH!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! CINEBENCH" (
    set "OPENTOOLS=True"
    call:CURL "0" "http://http.maxon.net/pub/cinebench/CinebenchR20.zip" "%UserProfile%\Documents\_Tools\Cinebench\CinebenchR20.zip"
    call "modules\7z.exe" x -aoa "%UserProfile%\Documents\_Tools\Cinebench\CinebenchR20.zip" -O"%UserProfile%\Documents\_Tools\Cinebench" >nul 2>&1
    del /f /q "%UserProfile%\Documents\_Tools\Cinebench\CinebenchR20.zip" >nul 2>&1
)
if "!AIDA64!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! AIDA64" (
    set "OPENTOOLS=True"
    call:CURL "0" "https://download.aida64.com/aida64extreme625.zip" "%UserProfile%\Documents\_Tools\AIDA64\aida64extreme.zip"
    call "modules\7z.exe" x -aoa "%UserProfile%\Documents\_Tools\AIDA64\aida64extreme.zip" -O"%UserProfile%\Documents\_Tools\AIDA64" >nul 2>&1
    del /f /q "%UserProfile%\Documents\_Tools\AIDA64\aida64extreme.zip" >nul 2>&1
)
if "!OCCT!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! OCCT" set "OPENTOOLS=True" & call:CURL "0" "https://www.ocbase.com/download" "%UserProfile%\Documents\_Tools\OCCT.exe"
if "!LatencyMon!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! LatencyMon" (
    set "OPENTOOLS=True"
    call:CURL "0" "https://cdn.discordapp.com/attachments/211892706547466241/774329811019497472/LatencyMon.zip" "%UserProfile%\Documents\_Tools\LatencyMon.zip"
    call "modules\7z.exe" x -aoa "%UserProfile%\Documents\_Tools\LatencyMon.zip" -O"%UserProfile%\Documents\_Tools\" >nul 2>&1
    del /f /q "%UserProfile%\Documents\_Tools\LatencyMon.zip" >nul 2>&1
)
:: TWEAKS
if "!MSI Util v3!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! MSI Util v3" set "OPENTOOLS=True" & call:CURL "0" "https://cdn.discordapp.com/attachments/595370063104573511/755786950610255896/MSI_util_v3.exe" "%UserProfile%\Documents\_Tools\MSI_util_v3.exe"
if "!Interrupt Affinity!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Interrupt Affinity" set "OPENTOOLS=True" & call:CURL "0" "https://cdn.discordapp.com/attachments/595370063104573511/755786953223438346/InterruptAffinity.exe" "%UserProfile%\Documents\_Tools\InterruptAffinity.exe"
if "!TCP Optimizer!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! TCP Optimizer" set "OPENTOOLS=True" & call:CURL "0" "https://www.speedguide.net/files/TCPOptimizer.exe" "%UserProfile%\Documents\_Tools\TCPOptimizer.exe"
if "!WLAN Optimizer!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! WLAN Optimizer" (
    set "OPENTOOLS=True"
    call:CURL "0" "http://www.martin-majowski.de/downloads/wopt021.zip" "%UserProfile%\Documents\_Tools\WLAN Optimizer\wopt.zip"
    call "modules\7z.exe" x -aoa "%UserProfile%\Documents\_Tools\WLAN Optimizer\wopt.zip" -O"%UserProfile%\Documents\_Tools\WLAN Optimizer" >nul 2>&1
    del /f /q "%UserProfile%\Documents\_Tools\WLAN Optimizer\wopt.zip" >nul 2>&1
)
if "!DNS Jumper!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! DNS Jumper" (
    set "OPENTOOLS=True"
    call:CURL "0" "https://www.sordum.org/files/download/dns-jumper/DnsJumper.zip" "%UserProfile%\Documents\_Tools\DnsJumper.zip"
    call "modules\7z.exe" x -aoa "%UserProfile%\Documents\_Tools\DnsJumper.zip" -O"%UserProfile%\Documents\_Tools" >nul 2>&1
    del /f /q "%UserProfile%\Documents\_Tools\DnsJumper.zip" >nul 2>&1
)
if "!Nvidia Profile Inspector!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Nvidia Profile Inspector" (
    set "OPENTOOLS=True"
    call:CURL "0" "https://github.com/Orbmu2k/nvidiaProfileInspector/releases/download/2.3.0.12/nvidiaProfileInspector.zip" "%UserProfile%\Documents\_Tools\Nvidia Profile Inspector\nvidiaProfileInspector.zip"
    call "modules\7z.exe" x -aoa "%UserProfile%\Documents\_Tools\Nvidia Profile Inspector\nvidiaProfileInspector.zip" -O"%UserProfile%\Documents\_Tools\Nvidia Profile Inspector" >nul 2>&1
    del /f /q "%UserProfile%\Documents\_Tools\Nvidia Profile Inspector\nvidiaProfileInspector.zip" >nul 2>&1
)
if "!GPU Pixel Clock Patcher!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! GPU Pixel Clock Patcher" (
    set "OPENTOOLS=True"
    call:CURL "0" "https://www.monitortests.com/download/nvlddmkm-patcher/nvlddmkm-patcher-1.4.12.zip" "%UserProfile%\Documents\_Tools\GPU Pixel Clock Patcher\Nvidia\nvlddmkm-patcher.zip"
    call:CURL "0" "https://www.monitortests.com/download/atikmdag-patcher/atikmdag-patcher-1.4.8.zip" "%UserProfile%\Documents\_Tools\GPU Pixel Clock Patcher\AMD\atikmdag-patcher.zip"
    call "modules\7z.exe" x -aoa "%UserProfile%\Documents\_Tools\GPU Pixel Clock Patcher\Nvidia\nvlddmkm-patcher.zip" -O"%UserProfile%\Documents\_Tools\GPU Pixel Clock Patcher\Nvidia" >nul 2>&1
    call "modules\7z.exe" x -aoa "%UserProfile%\Documents\_Tools\GPU Pixel Clock Patcher\AMD\atikmdag-patcher.zip" -O"%UserProfile%\Documents\_Tools\GPU Pixel Clock Patcher\AMD" >nul 2>&1
    del /f /q "%UserProfile%\Documents\_Tools\GPU Pixel Clock Patcher\Nvidia\nvlddmkm-patcher.zip" >nul 2>&1 & del /f /q "%UserProfile%\Documents\_Tools\GPU Pixel Clock Patcher\AMD\atikmdag-patcher.zip" >nul 2>&1
)
if "!Custom Resolution Utility!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! Custom Resolution Utility" (
    set "OPENTOOLS=True"
    call:CURL "0" "https://www.monitortests.com/download/cru/cru-1.4.2.zip" "%UserProfile%\Documents\_Tools\Custom Resolution Utility\cru.zip"
    call "modules\7z.exe" x -aoa "%UserProfile%\Documents\_Tools\Custom Resolution Utility\cru.zip" -O"%UserProfile%\Documents\_Tools\Custom Resolution Utility" >nul 2>&1
    del /f /q "%UserProfile%\Documents\_Tools\Custom Resolution Utility\cru.zip" >nul 2>&1
)
if "!SweetLow Mouse Rate Changer!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! SweetLow Mouse Rate Changer" (
    set "OPENTOOLS=True"
    call:CURL "0" "https://raw.githubusercontent.com/LordOfMice/hidusbf/master/hidusbf.zip" "%UserProfile%\Documents\_Tools\SweetLow Mouse Rate Changer\hidusbf.zip"
    call "modules\7z.exe" x -aoa "%UserProfile%\Documents\_Tools\SweetLow Mouse Rate Changer\hidusbf.zip" -O"%UserProfile%\Documents\_Tools\SweetLow Mouse Rate Changer" >nul 2>&1
    del /f /q "%UserProfile%\Documents\_Tools\SweetLow Mouse Rate Changer\hidusbf.zip" >nul 2>&1
)
if "!ThrottleStop!"=="!S_MAGENTA![!S_GREEN!x!S_MAGENTA!]!S_WHITE! ThrottleStop" (
    set "OPENTOOLS=True"
    call:CURL "0" "https://softpedia-secure-download.com/dl/1ad11b28607fe3f799da081a5e82c23b/5fad898d/100163602/software/system/bench/ThrottleStop_9.2.zip" "%UserProfile%\Documents\_Tools\ThrottleStop\ThrottleStop.zip"
    call "modules\7z.exe" x -aoa "%UserProfile%\Documents\_Tools\ThrottleStop\ThrottleStop.zip" -O"%UserProfile%\Documents\_Tools\ThrottleStop" >nul 2>&1
    del /f /q "%UserProfile%\Documents\_Tools\ThrottleStop\ThrottleStop.zip" >nul 2>&1
)
if "!OPENTOOLS!"=="True" start "" "explorer.exe" "%UserProfile%\Documents\_Tools\"
goto TOOLS_MENU_CLEAR

:CREDITS
call:MSGBOX "Revision community - Learned a lot about PC Tweaking\nTheBATeam community - Coding help\nMathieu Squidward - Coding help\nMelody - For her tweaks guides and scripts\nDanske - For his Windows Tweak guide\nFelip - Code inspirations from his 'Tweaks for Gaming' batch\n\nThanks to many other people for help with testing and suggestions.\n                                                                         Created by Artanis\n                                                                 Copyright Artanis 2021" vbInformation "Credits"
goto MAIN_MENU

:HELP
call:MSGBOX "Post Tweaks aims to improve the responsiveness, performance and privacy of Windows. It also allows automatic installation of essentials programs in the background.\n\nOptions:\n\n• SYSTEM TWEAKS\n   - Services optimization\n   - Network optimization\n   - Improve privacy\n   - Global system and visual optimization\n\n• SOFTWARE INSTALLER\nDisplay a selection menu that let you downloads and installs essentials programs automatically in the background.\n\n• TOOLS\nDisplay a selection menu that let you downloads useful tools." vbInformation "Help"
goto MAIN_MENU

::                                      =======================================================
::                                      ==================     FONCTIONS     ==================
::                                      =======================================================

:SETVARIABLES
:: Colors and text format
set "CMDLINE=RED=[31m,S_GRAY=[90m,S_RED=[91m,S_GREEN=[92m,S_YELLOW=[93m,S_MAGENTA=[95m,S_WHITE=[97m,B_BLACK=[40m,B_YELLOW=[43m,UNDERLINE=[4m,_UNDERLINE=[24m"
set "%CMDLINE:,=" & set "%"
:: Check GPU
wmic path Win32_VideoController get Name | findstr "NVIDIA" >nul 2>&1 && set "GPU=NVIDIA"
wmic path Win32_VideoController get Name | findstr "AMD ATI Radeon" >nul 2>&1 && set "GPU=AMD"
:: Video adapter class
for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}" /s /v "DriverDesc"^| findstr "HKEY"') do set VIDEO_ADAPTER_PATH=%%i
:: Check Wi-Fi usage
netsh wlan show networks | findstr "Wi-Fi" >nul 2>&1 && set "NETWORK=WIFI"
:: Page file & SvcHost
for /f "skip=1" %%i in ('wmic os get TotalVisibleMemorySize') do if not defined PAGEFILE (set /a PAGEFILE=%%i/1024*2) & if not defined SVCHOST (set /a SVCHOST=%%i+1024000)
:: Large page drivers
set WHITELIST=ACPI AcpiDev AcpiPmi AFD AMDPCIDev amdgpio2 amdgpio3 amdkmdag AmdPPM amdpsp amdsata amdsbs amdxata asmtxhci atikmpag atikmdag BasicDisplay BasicRender dc1-controll Disk DXGKrnl e1iexpress e1rexpress genericusbfn hwpolicy iagpio igdkmd64 IntcAzAudAdd intelppm kbdclass kbdhid MMCSS monitor mouclass mouhid mountmgr mt7612US MTConfig NDIS nvdimm nvlddmkm pci PktMon Psched RTCore64 Tcpip usbehci usbhub USBHUB3 USBXHCI Wdf01000 xboxgip xinputhid xusb22
for /f %%i in ('driverquery^| findstr "!WHITELIST!"') do set "DRIVERLIST=!DRIVERLIST!%%i\0"
for /f "tokens=3" %%i in ('reg query "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}" /s /f "Service"^| findstr "Service"^| findstr /v "kdnic vwifimp RasSstp RasAgileVpn Rasl2tp PptpMiniport RasPppoe NdisWan"') do set "NIC_SERVICE=!NIC_SERVICE!%%i\0"
:: Open shell
for %%i in ("Item1.Command=user_files" "Item1.Settings=NOEXPAND" "Item2.Command=user_documents" "Item2.Settings=NOEXPAND"
    "Item3.Command=user_pictures" "Item3.Settings=NOEXPAND" "Item4.Command=user_music" "Item4.Settings=NOEXPAND" "Item5.Command=user_videos"
    "Item5.Settings=NOEXPAND" "Item6.Command=downloads" "Item6.Settings=NOEXPAND" "Item7.Command=homegroup" "Item7.Settings=ITEM_DISABLED"
    "Item8.Command=separator" "Item9.Command=games" "Item9.Settings=TRACK_RECENT|NOEXPAND|ITEM_DISABLED" "Item10.Command=favorites"
    "Item10.Settings=ITEM_DISABLED" "Item11.Command=recent_documents" "Item12.Command=computer" "Item12.Settings=NOEXPAND" "Item13.Command=network"
    "Item13.Settings=ITEM_DISABLED" "Item14.Command=network_connections" "Item14.Settings=ITEM_DISABLED" "Item15.Command=separator" "Item16.Command=control_panel"
    "Item16.Settings=TRACK_RECENT" "Item17.Command=pc_settings" "Item17.Settings=TRACK_RECENT" "Item18.Command=admin" "Item18.Settings=TRACK_RECENT|ITEM_DISABLED"
    "Item19.Command=devices" "Item19.Settings=ITEM_DISABLED" "Item20.Command=defaults" "Item20.Settings=ITEM_DISABLED" "Item21.Command=help" "Item21.Settings=ITEM_DISABLED"
    "Item22.Command=run" "Item23.Command=apps" "Item23.Settings=ITEM_DISABLED" "Item24.Command=windows_security" "Item24.Settings=ITEM_DISABLED") do set "MENUITEMS=!MENUITEMS!%%i\0"
:: User SID
for /f "tokens=* USEBACKQ" %%i in (`wmic useraccount where "name="%username%"" get sid^| findstr "S-"`) do set USER_SID=%%i
set USER_SID=!USER_SID:~0,-3!
goto:eof

:POWERSHELL
chcp 437 >nul 2>&1
powershell -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command %* >nul 2>&1
chcp 65001 >nul 2>&1
goto:eof

:CHOCO [Package]
if not exist "%ProgramData%\chocolatey" (
    call:POWERSHELL "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && set "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
    call "%ProgramData%\chocolatey\bin\RefreshEnv.cmd"
)
choco install -y --limit-output --ignore-checksums %*
goto:eof

:CURL [Argument] [URL] [Directory]
if not exist "%WinDir%\System32\curl.exe" if not exist "%ProgramData%\chocolatey\lib\curl" call:CHOCO curl
if "%~1"=="0" curl -k -L --progress-bar "%~2" --create-dirs -o "%~3"
if "%~1"=="1" curl --silent "%~2" --create-dirs -o "%~3"
goto:eof

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
goto:eof
