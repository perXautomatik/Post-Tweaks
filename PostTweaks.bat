@echo off &setlocal enableextensions enabledelayedexpansion
mode con lines=20 cols=125
mode con rate=32 delay=0
cd /d "%~dp0"
chcp 65001 >nul 2>&1

set VERSION=1.0
set VERSION_INFO=2020-09-31
title Post Tweaks

openfiles >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [40;90mYou are not running as [40;31mAdministrator[40;90m...
    echo This batch cannot do it's job without elevation!
    echo.
    echo Right-click and select [40;33m^'Run as Administrator^' [40;90mand try again...
    echo.
    echo Press any key to exit . . .
    pause >NUL
    exit
)

ping -n 1 "google.com" >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [40;31mERROR: [40;90mNo internet connection found
    echo.
    echo Please make sure you are connected to the internet and try again . . .
    pause >nul 2>&1
    exit
)

set "NEEDEDFILES=modules/7z.exe modules/7z.dll modules/choicebox.exe modules/smartctl.exe resources/ProcessExplorer.exe resources/ExtremePerformance.pow resources/SetTimerResolutionService.exe resources/NvidiaProfileInspector.exe resources/Performance.nip"
for %%i in (!NEEDEDFILES!) do (
    if not exist %%i (
        set "MISSINGFILES=true"
        echo [40;31mERROR: [40;33m%%i [40;90mis missing
        echo.
    )
)
if "!MISSINGFILES!"=="true" echo Downloading missing files please wait...[40;33m
for %%i in (!NEEDEDFILES!) do (
    if not exist %%i (
        call :CURL -L --progress-bar "https://raw.githubusercontent.com/ArtanisInc/Post-Tweaks/master/%%i" --create-dirs -o "%%i"
    )
)

set NVERSION=0
set NVERSION_INFO=0

call :CURL --silent "https://raw.githubusercontent.com/ArtanisInc/Post-Tweaks/master/version.txt" --create-dirs -o "version.txt"
if %ERRORLEVEL% equ 0 (
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
    echo Auto-download latest version now? [[40;33mYes[40;90m^/[40;33mNo[40;90m]
    choice /c yn /n /m "" /t 25 /d y
    if %ERRORLEVEL% equ 1 (
        cls
        echo.
        echo Updating to the latest version, please wait...[40;33m
        echo.
        call :CURL -L --progress-bar "https://github.com/ArtanisInc/Post-Tweaks/archive/master.zip" --create-dirs -o "master.zip"
        call "modules\7z.exe" x -aoa "master.zip" >nul 2>&1
        del /f /q master.zip >nul 2>&1
        rd /s /q modules >nul 2>&1
        rd /s /q resources >nul 2>&1
        move Post-Tweaks-master\modules modules >nul 2>&1
        move Post-Tweaks-master\resources resources >nul 2>&1
        move Post-Tweaks-master\PostTweaks.bat PostTweaks.bat >nul 2>&1
        rd /s /q Post-Tweaks-master >nul 2>&1
        del /f /q version.txt >nul 2>&1
        if exist "PostTweaks.bat" start "runas /user:administrator" cmd /k  "PostTweaks.bat"
        exit
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
call :SETVARIABLE

call :MSGBOX "Do you want to create a registry backup and a restore point ?" vbYesNo+vbQuestion "System Restore"
if %ERRORLEVEL% equ 6 (
    wmic /namespace:\\root\default path systemrestore call createrestorepoint "Post Tweaks", 100, 12
    regedit /e "%USERPROFILE%\desktop\Registry Backup.reg"
)

if "!SSD!"=="yes" (
    fsutil behavior set disabledeletenotify 0
)

:: Disable User Account Control
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableVirtualization" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableInstallerDetection" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableSecureUIAPaths" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "ValidateAdminCodeSignatures" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableUIADesktopToggle" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorUser" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "FilterAdministratorToken" /t REG_DWORD /d "0" /f >nul 2>&1


:: Services
for %%i IN (BITS BrokerInfrastructure BFE EventSystem CDPSvc CDPUserSvc_%service% CoreMessagingRegistrar
	CryptSvc DusmSvc DcomLaunch Dhcp Dnscache gpsvc LSM NlaSvc nsi Power PcaSvc RpcSs
	RpcEptMapper SamSs ShellHWDetection sppsvc SysMain OneSyncSvc_%service% SENS
	SystemEventsBroker Schedule Themes UserManager ProfSvc AudioSrv AudioEndpointBuilder Wcmsvc WinDefend
	MpsSvc SecurityHealthService EventLog FontCache Winmgmt WpnService WSearch LanmanWorkstation) DO (
	reg query "HKLM\SYSTEM\CurrentControlSet\Services\%%i" /ve >nul 2>&1
    if %ERRORLEVEL% equ 0 reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%i" /v "Start" /t REG_DWORD /d "2" /f >nul 2>&1
)
for %%i IN (AxInstSV AppReadiness AppIDSvc Appinfo AppXSVC BDESVC wbengine camsvc ClipSVC KeyIso
	COMSysApp Browser PimIndexMaintenanceSvc_%service% VaultSvc DsSvc DeviceAssociationService
	DeviceInstall DmEnrollmentSvc DsmSVC DevicesFlowUserSvc_%service% DevQueryBroker diagsvc
	WdiSystemHost MSDTC embeddedmode EFS EntAppSvc EapHost fhsvc fdPHost FDResPub GraphicsPerfSvc
	hidserv IKEEXT UI0Detect PolicyAgent KtmRm lltdsvc wlpasvc MessagingService_%service% wlidsvc
	NgcSvc NgcCtnrSvc swprv smphost Netman NcaSVC netprofm NetSetupSvc defragsvc PNRPsvc p2psvc
	p2pimsvc PerfHost pla PlugPlay PNRPAutoReg WPDBusEnum PrintNotify PrintWorkflowUserSvc_%service%
	wercplsupport QWAVE RmSvc RasAuto RasMan seclogon SstpSvc SharedRealitySvc svsvc SSDPSRV
	StateRepository WiaRpc StorSvc TieringEngineService lmhosts TapiSrv tiledatamodelsvc TimeBroker
	UsoSvc upnphost UserDataSvc_%service% UnistoreSvc_%service% vds VSS WalletService TokenBroker
	SDRSVC Sense WdNisSvc WEPHOSTSVC WerSvc Wecsvc StiSvc msiserver LicenseManager TrustedInstaller
	spectrum WpnUserService_%service% InstallService W32Time wuauserv WinHttpAutoProxySvc dot3svc
	WlanSvc wmiApSrv XboxGipSvc) do (
	reg query "HKLM\SYSTEM\CurrentControlSet\Services\%%i" /ve >nul 2>&1
	if %ERRORLEVEL% equ 0 reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%i" /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1
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
    if %ERRORLEVEL% equ 0 reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%i" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
)

call "modules\choicebox.exe" "Disable Windows Search; Disable OneDrive; Disable Windows Store; Disable Xbox Apps; Disable Wi-Fi; Disable Bluetooth; Disable Printer; Disable Hyper-V; Disable Remote Desktop; Disable Task Scheduler; Disable Compatibility Assistant; Disable Diagnostic; Disable Disk Management; Disable Windows Update; Disable Windows Defender; Disable Windows Firewall" " " "Services Manager" /C:2 >"%TMP%\services.txt"
findstr /c:"Disable Windows Search" "%TMP%\services.txt" >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo Disabling Windows Search...
    reg add "HKLM\System\CurrentControlSet\Services\wsearch" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\TabletInputService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchPrivacy" /t REG_DWORD /d 3 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWebOverMeteredConnections" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Experience\AllowCortana" /v "value" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CortanaEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CortanaEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CanCortanaBeEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "DeviceHistoryEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "HistoryViewEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
)
findstr /c:"Disable OneDrive" "%TMP%\services.txt" >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo Disabling OneDrive...
    taskkill /f /im OneDrive.exe >nul 2>&1
    if exist %SystemRoot%\System32\OneDriveSetup.exe start /wait %SystemRoot%\System32\OneDriveSetup.exe /uninstall >nul 2>&1
    rd "%UserProfile%\OneDrive" /q /s >nul 2>&1
    rd "%SystemDrive%\OneDriveTemp" /q /s >nul 2>&1
    rd "%LocalAppData%\Microsoft\OneDrive" /q /s >nul 2>&1
    rd "%ProgramData%\Microsoft OneDrive" /q /s >nul 2>&1
    reg delete "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
    reg delete "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSync" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableMeteredNetworkFileSync" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableLibrariesDefaultSaveToOneDrive" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\OneDrive" /v "DisablePersonalSync" /t REG_DWORD /d "1" /f >nul 2>&1
)
findstr /c:"Disable Windows Store" "%TMP%\services.txt" >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo Disabling Windows Store...
    reg add "HKLM\System\CurrentControlSet\Services\iphlpsvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\ClipSVC" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\AppXSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\LicenseManager" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\NgcSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\NgcCtnrSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\wlidsvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\TokenBroker" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\WalletService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /t REG_DWORD /d "2" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "DisableStoreApps" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "RemoveWindowsStore" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v "SystemSettingsDownloadMode" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "SystemSettingsDownloadMode" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DoSvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
)
findstr /c:"Disable Xbox Apps" "%TMP%\services.txt" >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo Disabling Xbox Apps...
    reg add "HKLM\System\CurrentControlSet\Services\XboxNetApiSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\XblGameSave" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\XblAuthManager" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\xbgm" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\XboxGipSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
)
findstr /c:"Disable Wi-Fi" "%TMP%\services.txt" >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo Disabling Wi-Fi...
    reg add "HKLM\System\CurrentControlSet\Services\WwanSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\WlanSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\wcncsvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\lmhosts" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\vwififlt" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\vwifibus" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
)
findstr /c:"Disable Bluetooth" "%TMP%\services.txt" >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo Disabling Bluetooth...
    reg add "HKLM\System\CurrentControlSet\Services\BTAGService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\bthserv" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\BthAvctpSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\NaturalAuthentication" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\BluetoothUserService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
)
findstr /c:"Disable Printer" "%TMP%\services.txt" >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo Disabling Printer...
    reg add "HKLM\System\CurrentControlSet\Services\LanmanServer" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\Fax" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\Spooler" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\PrintNotify" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\PrintWorkflowUserSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
)
findstr /c:"Disable Hyper-V" "%TMP%\services.txt" >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo Disabling Hyper-V...
    reg add "HKLM\System\CurrentControlSet\Services\HvHost" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\vmickvpexchange" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\vmicguestinterface" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\vmicshutdown" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\vmicheartbeat" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\vmicvmsession" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\vmicrdv" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\vmictimesync" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\vmicvss" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
)
findstr /c:"Disable Remote Desktop" "%TMP%\services.txt" >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo Disabling Remote Desktop...
    reg add "HKLM\System\CurrentControlSet\Services\RasAuto" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\RasMan" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\SessionEnv" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\TermService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\UmRdpService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\RemoteRegistry" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\RpcLocator" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
)
findstr /c:"Disable Task Scheduler" "%TMP%\services.txt" >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo Disabling Task Scheduler...
    reg add "HKLM\System\CurrentControlSet\Services\Schedule" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\TimeBrokerSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
)
findstr /c:"Disable Compatibility Assistant" "%TMP%\services.txt" >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo Disabling Compatibility Assistant...
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisablePCA" /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\PcaSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
)
findstr /c:"Disable Diagnostic" "%TMP%\services.txt" >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo Disabling Diagnostic...
    reg add "HKLM\System\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\diagsvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\DPS" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\WdiServiceHost" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\WdiSystemHost" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\dmwappushsvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\diagnosticshub.standardcollector.service" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\TroubleshootingSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\DsSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
)
findstr /c:"Disable Disk Management" "%TMP%\services.txt" >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo Disabling Disk Management...
    reg add "HKLM\System\CurrentControlSet\Services\defragsvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\vds" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
)
findstr /c:"Disable Windows Update" "%TMP%\services.txt" >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo Disabling Windows Update...
    reg add "HKLM\System\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\WaaSMedicSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\PeerDistSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\UsoSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\DoSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate" /v "BranchReadinessLevel" /t REG_DWORD /d "16" /f >nul 2>&1
    reg add "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate" /v "DeferFeatureUpdates" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate" /v "DeferFeatureUpdatesPeriodInDays" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate" /v "ManagePreviewBuilds" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate" /v "ManagePreviewBuildsPolicyValue" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate" /v "PauseFeatureUpdatesStartTime" /t REG_SZ /d "" /f >nul 2>&1
    reg add "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "DetectionFrequency" /t REG_DWORD /d "20" /f >nul 2>&1
    reg add "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "DetectionFrequencyEnabled" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "EnableFeaturedSoftware" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\Software\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState" /v "BranchReadinessLevel" /t REG_SZ /d "CB" /f >nul 2>&1
    reg add "HKLM\Software\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState" /v "DeferFeatureUpdates" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\Software\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState" /v "DeferQualityUpdates" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\Software\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState" /v "ExcludeWUDrivers" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\Software\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState" /v "FeatureUpdatesDeferralInDays" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\Software\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState" /v "IsDeferralIsActive" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\Software\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState" /v "IsWUfBConfigured" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\Software\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState" /v "IsWUfBDualScanActive" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\Software\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState" /v "PolicySources" /t REG_DWORD /d "2" /f >nul 2>&1
    reg add "HKLM\Software\Microsoft\PolicyManager\current\device\Update" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\Software\Microsoft\PolicyManager\default\Update" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\Software\Microsoft\PolicyManager\default\Update\ExcludeWUDriversInQualityUpdate" /v "value" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\Software\Microsoft\WindowsUpdate\UX\Settings" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d "1" /f >nul 2>&1
)
findstr /c:"Disable Windows Defender" "%TMP%\services.txt" >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo Disabling Windows Defender...
    reg add "HKLM\System\CurrentControlSet\Services\Sense" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\WdNisSvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\WinDefend" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\SamSs" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\wscsvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\SgrmBroker" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v "DisableBehaviorMonitoring" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v "DisableIOAVProtection" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v "DisableOnAccessProtection" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v "DisableRealtimeMonitoring" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v "DisableRoutinelyTakingAction" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v "ServiceKeepAlive" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\Software\WOW6432Node\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\Software\WOW6432Node\Policies\Microsoft\Windows Defender" /v "DisableRoutinelyTakingAction" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\Software\WOW6432Node\Policies\Microsoft\Windows Defender" /v "ServiceKeepAlive" /t REG_DWORD /d "0" /f >nul 2>&1
    reg delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\SPP\Clients" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\Wdboot" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\WdFilter" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\WdNisDrv" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\mpsdrv" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\Wdnsfltr" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
)
findstr /c:"Disable Windows Firewall" "%TMP%\services.txt" >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo Disabling Windows Firewall...
    reg add "HKLM\System\CurrentControlSet\Services\mpssvc" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\BFE" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile" /v "EnableFirewall" /t REG_DWORD /d 00000000 /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile" /v "DisableNotifications" /t REG_DWORD /d 00000001 /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile" /v "DoNotAllowExceptions" /t REG_DWORD /d 00000001 /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile" /v "EnableFirewall" /t REG_DWORD /d 00000000 /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile" /v "DisableNotifications" /t REG_DWORD /d 00000001 /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile" /v "DoNotAllowExceptions" /t REG_DWORD /d 00000001 /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile" /v "EnableFirewall" /t REG_DWORD /d 00000000 /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile" /v "DisableNotifications" /t REG_DWORD /d 00000001 /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile" /v "DoNotAllowExceptions" /t REG_DWORD /d 00000001 /f >nul 2>&1
)
del /f /q "%TMP%\services.txt"

:: drivers Services
reg add "HKLM\System\CurrentControlSet\Services\fvevol" /v "ErrorControl" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\Dhcp" /v "DependOnService" /t REG_MULTI_SZ /d "" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\hidserv" /v "DependOnService" /t REG_MULTI_SZ /d "" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\Audiosrv" /v "DependOnService" /t REG_MULTI_SZ /d "" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Control\Class\{4d36e96c-e325-11ce-bfc1-08002be10318}" /v "UpperFilters" /t REG_MULTI_SZ /d "" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Control\Class\{4d36e967-e325-11ce-bfc1-08002be10318}" /v "LowerFilters" /t REG_MULTI_SZ /d "" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Control\Class\{6bdd1fc6-810f-11d0-bec7-08002be2092f}" /v "UpperFilters" /t REG_MULTI_SZ /d "" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Control\Class\{71a27cdd-812a-11d0-bec7-08002be2092f}" /v "LowerFilters" /t REG_MULTI_SZ /d "" /f >nul 2>&1
for %%i in (AcpiDev CAD CldFlt FileCrypt GpuEnergyDrv PptpMiniport RapiMgr RasAgileVpn Rasl2tp
    RasSstp Wanarp wanarpv6 WcesComm Wcifs Wcnfs WindowsTrustedRT WindowsTrustedRTProxy
    bam cnghwassist iorate mssecflt tunnel acpipagr AcpiPmi Acpitime Beep bowser CLFS
    CompositeBus condrv CSC dam dfsc EhStorClass fastfat FileInfo fvevol kdnic KSecPkg
    lltdio luafv Modem MpsSvc mrxsmb Mrxsmb10 Mrxsmb20 MsLldp mssmbios NdisCap NdisTapi
    NdisVirtualBus NdisWan Ndproxy Ndu NetBIOS NetBT Npsvctrig PEAUTH Psched QWAVEdrv
    RasAcd RasPppoe rdbss rdpbus rdyboost rspndr spaceport srv2 Srvnet TapiSrv Tcpip6
    tcpipreg tdx TPM umbus vdrvroot Vid Volmgrx WmiAcpi ws2ifsl AFD) do (
    reg query "HKLM\SYSTEM\CurrentControlSet\Services\%%i" /ve >nul 2>&1
    if %ERRORLEVEL% equ 0 reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%i" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
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
reg add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableICMPRedirect" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters" /v "EnablePMTUDiscovery" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters" /v "Tcp1323Opts" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters" /v "GlobalMaxTcpWindowSize" /t REG_DWORD /d "5840" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpWindowSize" /t REG_DWORD /d "5840" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxConnectionsPerServer" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxUserPort" /t REG_DWORD /d "65534" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpTimedWaitDelay" /t REG_DWORD /d "32" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters" /v "EnablePMTUBHDetect" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters" /v "DefaultTTL" /t REG_DWORD /d "64" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters" /v "SackOpts" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpMaxDupAcks" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Winsock" /v "UseDelayedAcceptance" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Winsock" /v "MaxSockAddrLength" /t REG_DWORD /d "16" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Winsock" /v "MinSockAddrLength" /t REG_DWORD /d "16" /f >nul 2>&1
reg add "HKLM\Software\Microsoft\MSMQ\Parameters" /v "TCPNoDelay" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows\Psched" /v "MaxOutstandingSends" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows\Psched" /v "NonBestEffortLimit" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows\Psched" /v "TimerResolution" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\Software\WOW6432Node\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MAXCONNECTIONSPER1_0SERVER" /v "explorer.exe" /t REG_DWORD /d "10" /f >nul 2>&1
reg add "HKLM\Software\WOW6432Node\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MAXCONNECTIONSPER1_0SERVER" /v "iexplore.exe" /t REG_DWORD /d "10" /f >nul 2>&1
reg add "HKLM\Software\WOW6432Node\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MAXCONNECTIONSPERSERVER" /v "explorer.exe" /t REG_DWORD /d "10" /f >nul 2>&1
reg add "HKLM\Software\WOW6432Node\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MAXCONNECTIONSPERSERVER" /v "iexplore.exe" /t REG_DWORD /d "10" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "DnsPriority" /t REG_DWORD /d "6" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "HostsPriority" /t REG_DWORD /d "5" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "LocalPriority" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "NetbtPriority" /t REG_DWORD /d "7" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\AFD\Parameters" /v "DefaultReceiveWindow" /t REG_DWORD /d "16384" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\AFD\Parameters" /v "DefaultSendWindow" /t REG_DWORD /d "16384" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\AFD\Parameters" /v "DisableRawSecurity" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\AFD\Parameters" /v "DynamicSendBufferDisable" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\AFD\Parameters" /v "FastCopyReceiveThreshold" /t REG_DWORD /d "16384" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\AFD\Parameters" /v "FastSendDatagramThreshold" /t REG_DWORD /d "16384" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\AFD\Parameters" /v "IgnorePushBitOnReceives" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\AFD\Parameters" /v "NonBlockingSendSpecialBuffering" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\Tcpip6\Parameters" /v "DisabledComponents" /t REG_DWORD /d "255" /f >nul 2>&1
for /f %%i in ('wmic path win32_networkadapter get GUID ^| findstr "{"') do (
    reg add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%i" /v "TcpAckFrequency" /t REG_DWORD /d "1" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%i" /v "TcpDelAckTicks" /t REG_DWORD /d "0" /f >nul 2>&1
    reg add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%i" /v "TCPNoDelay" /t REG_DWORD /d "1" /f >nul 2>&1
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
powershell "Set-NetAdapterRSS -Name '*' -BaseProcessorNumber 1"
powershell "Set-NetAdapterRss -Name '*' -MaxProcessorNumber 1"
powershell "Disable-NetAdapterRsc -Name *" >nul 2>&1
powershell "Disable-NetAdapterLso -Name *" >nul 2>&1
powershell "Disable-NetAdapterIPsecOffload -Name *" >nul 2>&1
powershell "Disable-NetAdapterPowerManagement -Name *" >nul 2>&1
powershell "Disable-NetAdapterChecksumOffload -Name *" >nul 2>&1
powershell "Disable-NetAdapterEncapsulatedPacketTaskOffload -Name *" >nul 2>&1
powershell "Disable-NetAdapterQos -Name *" >nul 2>&1
for %%i in (ms_lldp ms_lltdio ms_msclient ms_rspndr ms_server ms_implat ms_pacer) do powershell "Disable-NetAdapterBinding -Name * -ComponentID %%i" >nul 2>&1
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
::wifi specific
powershell "Set-NetAdapterAdvancedProperty -Name 'Wi-Fi' -DisplayName 'ARP offload for WoWLAN' -DisplayValue 'Disabled'" >nul 2>&1
powershell "Set-NetAdapterAdvancedProperty -Name 'Wi-Fi' -DisplayName 'NS offloading for WoWLAN' -DisplayValue 'Disabled'" >nul 2>&1
powershell "Set-NetAdapterAdvancedProperty -Name 'Wi-Fi' -DisplayName 'GTK rekeying for WoWLAN' -DisplayValue 'Disabled'" >nul 2>&1
powershell "Set-NetAdapterAdvancedProperty -Name 'Wi-Fi' -DisplayName 'Roaming Aggressiveness' -DisplayValue '1. Lowest'" >nul 2>&1
powershell "Set-NetAdapterAdvancedProperty -Name 'Wi-Fi' -DisplayName 'Preferred Band' -DisplayValue '3. Prefer 5GHz band'" >nul 2>&1
powershell "Set-NetAdapterAdvancedProperty -Name 'Wi-Fi' -DisplayName 'Transmit Power' -DisplayValue '5. Highest'" >nul 2>&1
powershell "Set-NetAdapterAdvancedProperty -Name 'Wi-Fi' -DisplayName 'Throughput Booster' -DisplayValue 'Enabled'" >nul 2>&1

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

:: Disable Drivers
for %%i in ("Microsoft Kernel Debug Network Adapter" "WAN Miniport" "Teredo Tunneling"
    "UMBus Root Bus Enumerator" "Composite Bus Enumerator" "Microsoft Virtual Drive Enumerator"
    "NDIS Virtual Network Adapter Enumerator" "System Timer" "Programmable Interrupt Controller"
    "PCI standard RAM Controller" "PCI Simple Communications Controller" "Numeric Data Processor"
    "Intel Management Engine" "Intel SMBus" "AMD PSP" "SM Bus Controller" "Remote Desktop Device Redirector Bus"
    "Microsoft System Management BIOS Driver" "Microsoft GS Wavetable Synth" "NVIDIA High Definition Audio" "NVIDIA USB"
    "HID-compliant Consumer Control Device" "HID-compliant System Controller" "HID-compliant Vendor-Defined Device" "High Precision Event Timer") do powershell "Get-PnpDevice | Where-Object {$_.FriendlyName -match '%%i'} | Disable-PnpDevice -Confirm:$false" >nul 2>&1

:: Install AeroLite
IF EXIST "%WinDir%\Resources\Themes\aero\aerolite.msstyles" (
    powershell "$content = [System.IO.File]::ReadAllText('%WinDir%\Resources\Themes\aero.theme').Replace('%ResourceDir%\Themes\Aero\Aero.msstyles','%ResourceDir%\Themes\Aero\Aerolite.msstyles'); [System.IO.File]::WriteAllText('%WinDir%\Resources\Themes\aerolite.theme', $content)"
    IF EXIST "%WinDir%\Resources\Themes\light.theme" (
        powershell "$content = [System.IO.File]::ReadAllText('%WinDir%\Resources\Themes\light.theme').Replace('%ResourceDir%\Themes\Aero\Aero.msstyles','%ResourceDir%\Themes\Aero\Aerolite.msstyles'); [System.IO.File]::WriteAllText('%WinDir%\Resources\Themes\lightlite.theme', $content)"
    )
)

:: Import Power Plan
powercfg -query 33333333-3333-3333-3333-333333333333 >nul 2>&1
if %ERRORLEVEL% equ 0 powercfg -delete 33333333-3333-3333-3333-333333333333 >nul 2>&1
powercfg -import "%~dp0\resources\ExtremePerformance.pow" 33333333-3333-3333-3333-333333333333 >nul 2>&1
powercfg -setactive 33333333-3333-3333-3333-333333333333 >nul 2>&1
powercfg -h off >nul 2>&1

:: Import Nvidia profile
start "" "resources\NvidiaProfileInspector.exe" "resources\Performance.nip" -silentImport

:: Windows apps
call :MSGBOX "Would you like to remove Windows Applications ?" vbYesNo+vbQuestion "Windows Apps Remover"
if %ERRORLEVEL% equ 6 (
    powershell "Get-AppxPackage -AllUsers | Where {($_.Name -notlike '*store*')} | Where {($_.Name -notlike '*xbox*')} | Where {($_.Name -notlike '*calculator*')} | Where {($_.Name -notlike '*Search*')} | Where {($_.Name -notlike '*ExperienceHost*')} | Where {($_.Name -notlike '*immersive*')} | Where {($_.Name -notlike '*NET.Native*')} | Where {($_.Name -notlike '*VCLibs*')} | Where {($_.Name -notlike '*Language*')} | Remove-AppxPackage" >nul 2>&1
    powershell "Get-AppxProvisionedPackage -Online | Where {($_.Name -notlike '*store*')} | Where {($_.Name -notlike '*xbox*')} | Where {($_.Name -notlike '*calculator*')} | Where {($_.Name -notlike '*Search*')} | Where {($_.Name -notlike '*ExperienceHost*')} | Where {($_.Name -notlike '*immersive*')} | Where {($_.Name -notlike '*NET.Native*')} | Where {($_.Name -notlike '*VCLibs*')} | Where {($_.Name -notlike '*Language*')} | Remove-AppxProvisionedPackage -Online" >nul 2>&1
)

:: Fix Windows typing
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "ctfmon" /t REG_STRING /d "CTFMON.EXE" /f >nul 2>&1

:: Telemetry
reg add "HKCU\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v "value" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v "value" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DownloadMode" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v "UseActionCenterExperience" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HideSCAHealth" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows\EnhancedStorageDevices" /v "TCGSecurityActivationDisabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows\safer\codeidentifiers" /v "authenticodeenabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows\Windows Error Reporting" /v "DontSendAdditionalData" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f >nul 2>&1
for %%i in (AutoLogger-Diagtrack-Listener Diagtrack-Listener Audio LwtNetLog NetCfgTrace ReadyBoot SCM SQMLogger WiFiSession UserNotPresentTraceSession WindowsUpdate_trace_log) do (
    reg query "HKLM\System\CurrentControlSet\Control\WMI\AutoLogger\%%i" /ve >nul 2>&1
    if %ERRORLEVEL% equ 0 reg add "HKLM\System\CurrentControlSet\Control\WMI\AutoLogger\%%i" /v "Start" /t REG_DWORD /d "0" /f >nul 2>&1
)

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
schtasks /change /tn "USER_ESRV_SVC_QUEENCREEK" /disable

:: Hosts
call :CURL -L "https://gameindustry.eu/files/hosts.txt" --create-dirs -o "%systemroot%\System32\drivers\etc\hosts" >nul 2>&1

call :MSGBOX "Some registry changes may require a reboot to take effect.\n\nWould you like to restart now?" vbYesNo+vbQuestion "Shut Down Windows"
if %ERRORLEVEL% equ 6 shutdown -r -f -t 0
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
if "!Discord!"=="[40;95m[[40;33mx[40;95m][40;37m Discord" call :CHOCO discord.install
if "!Ripcord!"=="[40;95m[[40;33mx[40;95m][40;37m Ripcord" call :CHOCO ripcord & call :SHORTCUT "Ripcord" "%USERPROFILE%\desktop" "%PROGRAMDATA%\chocolatey\lib\ripcord\tools\Ripcord.exe" "%PROGRAMDATA%\chocolatey\lib\ripcord\tools"
if "!TeamSpeak!"=="[40;95m[[40;33mx[40;95m][40;37m TeamSpeak" call :CHOCO teamspeak
:: DOCUMENTS
if "!Foxit Reader!"=="[40;95m[[40;33mx[40;95m][40;37m Foxit Reader" call :CHOCO foxitreader
if "!Microsoft Office!"=="[40;95m[[40;33mx[40;95m][40;37m Microsoft Office" call :CHOCO office-tool & call :SHORTCUT "Office Tool Plus" "%USERPROFILE%\desktop" "%LOCALAPPDATA%\Office Tool\Office Tool Plus.exe" "%LOCALAPPDATA%\Office Tool"
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
if "!Origin!"=="[40;95m[[40;33mx[40;95m][40;37m Origin" call :CHOCO origin & call :SHORTCUT "Origin" "%USERPROFILE%\desktop" "\Program Files (x86)\Origin\Origin.exe" "\Program Files (x86)\Origin"
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
set "OPENTOOLS=false"
:: UTILITIES
if "!NSudo!"=="[40;95m[[40;33mx[40;95m][40;37m NSudo" set "OPENTOOLS=true" & call :CURL -L --progress-bar "https://cdn.discordapp.com/attachments/595370063104573511/755786967660101702/NSudo.exe" --create-dirs -o "%USERPROFILE%\Documents\_Tools\NSudo.exe"
if "!Autoruns!"=="[40;95m[[40;33mx[40;95m][40;37m Autoruns" set "OPENTOOLS=true" & call :CURL -L --progress-bar "https://cdn.discordapp.com/attachments/595370063104573511/755789664627064902/Autoruns.exe" --create-dirs -o "%USERPROFILE%\Documents\_Tools\Autoruns.exe"
if "!ServiWin!"=="[40;95m[[40;33mx[40;95m][40;37m ServiWin" set "OPENTOOLS=true" & call :CURL -L --progress-bar "https://cdn.discordapp.com/attachments/595370063104573511/755791010893660190/ServiWin.exe" --create-dirs -o "%USERPROFILE%\Documents\_Tools\ServiWin.exe"
if "!Memory Booster!"=="[40;95m[[40;33mx[40;95m][40;37m Memory Booster" set "OPENTOOLS=true" & call :CURL -L --progress-bar "https://cdn.discordapp.com/attachments/595370063104573511/755787065974849638/MemoryBooster_2.1.exe" --create-dirs -o "%USERPROFILE%\Documents\_Tools\MemoryBooster.exe"
if "!Device Cleanup!"=="[40;95m[[40;33mx[40;95m][40;37m Device Cleanup" set "OPENTOOLS=true" & call :CURL -L --progress-bar "https://cdn.discordapp.com/attachments/595370063104573511/755790659356590080/DeviceCleanup.exe" --create-dirs -o "%USERPROFILE%\Documents\_Tools\DeviceCleanup.exe"
if "!MSI Afterburner!"=="[40;95m[[40;33mx[40;95m][40;37m MSI Afterburner" call :CHOCO msiafterburner
:: SYSTEM INFOS
if "!CPU-Z!"=="[40;95m[[40;33mx[40;95m][40;37m CPU-Z" set "OPENTOOLS=true" & call :CURL -L --progress-bar "https://cdn.discordapp.com/attachments/595370063104573511/755790662346997910/CPU-Z.exe" --create-dirs -o "%USERPROFILE%\Documents\_Tools\CPU-Z.exe"
if "!GPU-Z!"=="[40;95m[[40;33mx[40;95m][40;37m GPU-Z" set "OPENTOOLS=true" & call :CURL -L --progress-bar "https://nl1-dl.techpowerup.com/files/GPU-Z.2.34.0.exe#/GPU-Z.2.34.0.exe" --create-dirs -o "%USERPROFILE%\Documents\_Tools\GPU-Z.exe"
if "!HWiNFO!"=="[40;95m[[40;33mx[40;95m][40;37m HWiNFO" (
    set "OPENTOOLS=true"
    call :CURL -L --progress-bar "https://www.sac.sk/download/utildiag/hwi_630.zip" --create-dirs -o "%USERPROFILE%\Documents\_Tools\HWiNFO\hwi_630.zip"
    call "modules\7z.exe" x -aoa "%USERPROFILE%\Documents\_Tools\HWiNFO\hwi_630.zip" -O"%USERPROFILE%\Documents\_Tools\HWiNFO" >nul 2>&1
    del /f /q "%USERPROFILE%\Documents\_Tools\HWiNFO\hwi_630.zip" >nul 2>&1
)
if "!CrystalDiskInfo!"=="[40;95m[[40;33mx[40;95m][40;37m CrystalDiskInfo" (
    set "OPENTOOLS=true"
    call :CURL -L --progress-bar "https://dotsrc.dl.osdn.net/osdn/crystaldiskinfo/73507/CrystalDiskInfo8_8_7.zip" --create-dirs -o "%USERPROFILE%\Documents\_Tools\CrystalDiskInfo\CrystalDiskInfo8_8_7.zip"
    call "modules\7z.exe" x -aoa "%USERPROFILE%\Documents\_Tools\CrystalDiskInfo\CrystalDiskInfo8_8_7.zip"  -O"%USERPROFILE%\Documents\_Tools\CrystalDiskInfo">nul 2>&1
    del /f /q "%USERPROFILE%\Documents\_Tools\CrystalDiskInfo\CrystalDiskInfo8_8_7.zip" >nul 2>&1
)
:: DRIVERS
if "!Snappy Driver Installer!"=="[40;95m[[40;33mx[40;95m][40;37m Snappy Driver Installer" (
    set "OPENTOOLS=true"
    call :CURL -L --progress-bar "http://sdi-tool.org/releases/SDI_R2000.zip" --create-dirs -o "%USERPROFILE%\Documents\_Tools\Snappy Driver Installer\SDI.zip"
    call "modules\7z.exe" x -aoa "%USERPROFILE%\Documents\_Tools\Snappy Driver Installer\SDI.zip"  -O"%USERPROFILE%\Documents\_Tools\Snappy Driver Installer">nul 2>&1
    del /f /q "%USERPROFILE%\Documents\_Tools\Snappy Driver Installer\SDI.zip" >nul 2>&1
)
if "!NVCleanstall!"=="[40;95m[[40;33mx[40;95m][40;37m NVCleanstall" set "OPENTOOLS=true" & call :CURL -L --progress-bar "https://nl1-dl.techpowerup.com/files/NVCleanstall_1.7.0.exe#/NVCleanstall.exe" --create-dirs -o "%USERPROFILE%\Documents\_Tools\NVCleanstall.exe"
if "!Radeon Software Slimmer!"=="[40;95m[[40;33mx[40;95m][40;37m Radeon Software Slimmer" (
    set "OPENTOOLS=true"
    call :CURL -L --progress-bar "https://github.com/GSDragoon/RadeonSoftwareSlimmer/releases/download/1.0.0-beta.6/RadeonSoftwareSlimmer_1.0.0-beta.6_net48.zip" --create-dirs -o "%USERPROFILE%\Documents\_Tools\Radeon Software Slimmer\RadeonSoftwareSlimmer.zip"
    call "modules\7z.exe" x -aoa "%USERPROFILE%\Documents\_Tools\Radeon Software Slimmer\RadeonSoftwareSlimmer.zip"  -O"%USERPROFILE%\Documents\_Tools\Radeon Software Slimmer">nul 2>&1
    del /f /q "%USERPROFILE%\Documents\_Tools\Radeon Software Slimmer\RadeonSoftwareSlimmer.zip" >nul 2>&1
)
if "!Display Driver Uninstaller!"=="[40;95m[[40;33mx[40;95m][40;37m Display Driver Uninstaller" (
    set "OPENTOOLS=true"
    call :CURL -L --progress-bar "http://download-eu2.guru3d.com/ddu/[Guru3D.com]-DDU.zip" --create-dirs -o "%USERPROFILE%\Documents\_Tools\Display Driver Uninstaller\DDU.zip"
    call "modules\7z.exe" x -aoa "%USERPROFILE%\Documents\_Tools\Display Driver Uninstaller\DDU.zip" -O"%USERPROFILE%\Documents\_Tools\Display Driver Uninstaller" >nul 2>&1
    del /f /q "%USERPROFILE%\Documents\_Tools\Display Driver Uninstaller\DDU.zip" >nul 2>&1
)
:: BENCHMARK & STRESS
if "!Unigine Superposition!"=="[40;95m[[40;33mx[40;95m][40;37m Unigine Superposition" call :CHOCO superposition-benchmark
if "!CINEBENCH!"=="[40;95m[[40;33mx[40;95m][40;37m CINEBENCH" (
    set "OPENTOOLS=true"
    call :CURL -L --progress-bar "http://http.maxon.net/pub/cinebench/CinebenchR20.zip" --create-dirs -o "%USERPROFILE%\Documents\_Tools\Cinebench\CinebenchR20.zip"
    call "modules\7z.exe" x -aoa "%USERPROFILE%\Documents\_Tools\Cinebench\CinebenchR20.zip" -O"%USERPROFILE%\Documents\_Tools\Cinebench" >nul 2>&1
    del /f /q "%USERPROFILE%\Documents\_Tools\Cinebench\CinebenchR20.zip" >nul 2>&1
)
if "!AIDA64!"=="[40;95m[[40;33mx[40;95m][40;37m AIDA64" (
    set "OPENTOOLS=true"
    call :CURL -L --progress-bar "https://download.aida64.com/aida64extreme625.zip" --create-dirs -o "%USERPROFILE%\Documents\_Tools\AIDA64\aida64extreme625.zip"
    call "modules\7z.exe" x -aoa "%USERPROFILE%\Documents\_Tools\AIDA64\aida64extreme625.zip" -O"%USERPROFILE%\Documents\_Tools\AIDA64" >nul 2>&1
    del /f /q "%USERPROFILE%\Documents\_Tools\AIDA64\aida64extreme625.zip" >nul 2>&1
)
if "!OCCT!"=="[40;95m[[40;33mx[40;95m][40;37m OCCT" set "OPENTOOLS=true" & call :CURL -L --progress-bar "https://www.ocbase.com/download" --create-dirs -o "%USERPROFILE%\Documents\_Tools\OCCT.exe"
:: TWEAKS
if "!MSI Util v3!"=="[40;95m[[40;33mx[40;95m][40;37m MSI Util v3" set "OPENTOOLS=true" & call :CURL -L --progress-bar "https://cdn.discordapp.com/attachments/595370063104573511/755786950610255896/MSI_util_v3.exe" --create-dirs -o "%USERPROFILE%\Documents\_Tools\MSI_util_v3.exe"
if "!Interrupt Affinity!"=="[40;95m[[40;33mx[40;95m][40;37m Interrupt Affinity" set "OPENTOOLS=true" & call :CURL -L --progress-bar "https://cdn.discordapp.com/attachments/595370063104573511/755786953223438346/InterruptAffinity.exe" --create-dirs -o "%USERPROFILE%\Documents\_Tools\InterruptAffinity.exe"
if "!TCP Optimizer!"=="[40;95m[[40;33mx[40;95m][40;37m TCP Optimizer" set "OPENTOOLS=true" & call :CURL -L --progress-bar "https://www.speedguide.net/files/TCPOptimizer.exe" --create-dirs -o "%USERPROFILE%\Documents\_Tools\TCPOptimizer.exe"
if "!WLAN Optimizer!"=="[40;95m[[40;33mx[40;95m][40;37m WLAN Optimizer" (
    set "OPENTOOLS=true"
    call :CURL -L --progress-bar "http://www.martin-majowski.de/downloads/wopt021.zip" --create-dirs -o "%USERPROFILE%\Documents\_Tools\WLAN Optimizer\wopt.zip"
    call "modules\7z.exe" x -aoa "%USERPROFILE%\Documents\_Tools\WLAN Optimizer\wopt.zip" -O"%USERPROFILE%\Documents\_Tools\WLAN Optimizer" >nul 2>&1
    del /f /q "%USERPROFILE%\Documents\_Tools\WLAN Optimizer\wopt.zip" >nul 2>&1
)
if "!Nvidia Profile Inspector!"=="[40;95m[[40;33mx[40;95m][40;37m Nvidia Profile Inspector" (
    set "OPENTOOLS=true"
    call :CURL -L --progress-bar "https://github.com/Orbmu2k/nvidiaProfileInspector/releases/download/2.3.0.12/nvidiaProfileInspector.zip" --create-dirs -o "%USERPROFILE%\Documents\_Tools\Nvidia Profile Inspector\nvidiaProfileInspector.zip"
    call "modules\7z.exe" x -aoa "%USERPROFILE%\Documents\_Tools\Nvidia Profile Inspector\nvidiaProfileInspector.zip" -O"%USERPROFILE%\Documents\_Tools\Nvidia Profile Inspector" >nul 2>&1
    del /f /q "%USERPROFILE%\Documents\_Tools\Nvidia Profile Inspector\nvidiaProfileInspector.zip" >nul 2>&1
)
if "!Nvlddmkm Patcher!"=="[40;95m[[40;33mx[40;95m][40;37m Nvlddmkm Patcher" (
    set "OPENTOOLS=true"
    call :CURL -L --progress-bar "https://www.monitortests.com/download/nvlddmkm-patcher/nvlddmkm-patcher-1.4.12.zip" --create-dirs -o "%USERPROFILE%\Documents\_Tools\nvlddmkm-patcher.zip"
    call "modules\7z.exe" x -aoa "%USERPROFILE%\Documents\_Tools\nvlddmkm-patcher.zip" -O"%USERPROFILE%\Documents\_Tools\" >nul 2>&1
    del /f /q "%USERPROFILE%\Documents\_Tools\nvlddmkm-patcher.zip" >nul 2>&1
)
if "!Custom Resolution Utility!"=="[40;95m[[40;33mx[40;95m][40;37m Custom Resolution Utility" (
    set "OPENTOOLS=true"
    call :CURL -L --progress-bar "https://www.monitortests.com/download/cru/cru-1.4.2.zip" --create-dirs -o "%USERPROFILE%\Documents\_Tools\Custom Resolution Utility\cru.zip"
    call "modules\7z.exe" x -aoa "%USERPROFILE%\Documents\_Tools\Custom Resolution Utility\cru.zip" -O"%USERPROFILE%\Documents\_Tools\Custom Resolution Utility" >nul 2>&1
    del /f /q "%USERPROFILE%\Documents\_Tools\Custom Resolution Utility\cru.zip" >nul 2>&1
)
if "!SweetLow Mouse Rate Changer!"=="[40;95m[[40;33mx[40;95m][40;37m SweetLow Mouse Rate Changer" (
    set "OPENTOOLS=true"
    call :CURL -L --progress-bar "https://raw.githubusercontent.com/LordOfMice/hidusbf/master/hidusbf.zip" --create-dirs -o "%USERPROFILE%\Documents\_Tools\SweetLow Mouse Rate Changer\hidusbf.zip"
    call "modules\7z.exe" x -aoa "%USERPROFILE%\Documents\_Tools\SweetLow Mouse Rate Changer\hidusbf.zip" -O"%USERPROFILE%\Documents\_Tools\SweetLow Mouse Rate Changer" >nul 2>&1
    del /f /q "%USERPROFILE%\Documents\_Tools\SweetLow Mouse Rate Changer\hidusbf.zip" >nul 2>&1
)
if "!OPENTOOLS!"=="true" (
    start "" "explorer.exe" "%USERPROFILE%\Documents\_Tools\"
)
goto TOOLS_MENU_CLEAR


:CREDITS
call :MSGBOX "TheBATeam community -  Coding help.\nRevision community -  Learned a lot about PC Tweaking.\nMelody - For his tweaks guides and scripts.\nRiot - For his 'Hit-Reg and Network Latency' guide.\nFelip - Codes from his 'Tweaks for Gaming' batch script.\nIBUZZARDl - Coding help.\n\nThanks to many other people for help with testing and suggestions \n                                                              Created by Artanis \n                                                      Copyright Artanis 2020" vbInformation "Credits"
goto MAIN_MENU

:HELP
call :MSGBOX "NOT DONE YET \nNOT DONE YET \nNOT DONE YET \nNOT DONE YET " vbInformation "Help"
goto MAIN_MENU

::      :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::      ::::::::::::::::::::::::::::::::     FONCTIONS     ::::::::::::::::::::::::::::::::
::      :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:SETVARIABLE
:: Check SSD
for /f %%i in ('call "modules\smartctl.exe" --scan') do call "modules\smartctl.exe" %%i -a | findstr /i "Solid SSD RAID SandForce" >nul 2>&1 && set "SSD=yes"
:: Check Laptop
for /f "tokens=*" %%A IN ('WMIC Path Win32_Battery Get BatteryStatus 2^>^&1 /Format:List ^| FIND "="') DO if %%A neq 0 set "LAPTOP=yes"
:: Service token
for /F "SKIP=2" %%a in ('reg query "HKLM\System\CurrentControlSet\Services" /f "cdpusersvc"^| findstr /v /c:"End of search:"') DO (
    set SERVICE=%%a
    set SERVICE=!SERVICE:HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\cdpusersvc_=!
)
goto :eof

:CHOCO [Package]
if not exist "%PROGRAMDATA%\chocolatey" (
	powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && set "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
	call "%PROGRAMDATA%\chocolatey\bin\RefreshEnv.cmd"
)
choco install %* -y --limit-output --ignore-checksums
goto :eof

:CURL
if not exist "%systemroot%\System32\curl.exe" (
    if not exist "%PROGRAMDATA%\chocolatey\lib\curl" call :CHOCO curl
)
curl %*
goto :eof

:MSGBOX [Text] [Argument] [Title]
echo WScript.Quit Msgbox(Replace("%~1","\n",vbCrLf),%~2,"%~3") > "%TMP%\msgbox.vbs"
cscript /nologo "%TMP%\msgbox.vbs"
set "exitCode=%errorlevel%" & del /f /q "%TMP%\msgbox.vbs"
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