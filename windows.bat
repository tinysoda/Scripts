@echo off

:: Define download URLs
set "vscode_url=https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user"
set "fdm_url=https://www.freedownloadmanager.org/download/fdm/latest/x64/freedownloadmanager.exe"
set "vlc_url=https://get.videolan.org/vlc/3.0.16/win64/vlc-3.0.16-win64.exe"
set "github_url=https://desktop.githubusercontent.com/releases/2.8.0-rc2.GitHubDesktopSetup.exe"
set "python_url=https://www.python.org/ftp/python/3.9.7/python-3.9.7-amd64.exe"

:: Define installation paths
set "install_dir=%TEMP%"
set "vscode_installer=%install_dir%\vscode_installer.exe"
set "fdm_installer=%install_dir%\fdm_installer.exe"
set "vlc_installer=%install_dir%\vlc_installer.exe"
set "github_installer=%install_dir%\github_installer.exe"
set "python_installer=%install_dir%\python_installer.exe"

:: Download software installers
echo Downloading Visual Studio Code...
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%vscode_url%', '%vscode_installer%')"
echo Downloading Free Download Manager...
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%fdm_url%', '%fdm_installer%')"
echo Downloading VLC Media Player...
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%vlc_url%', '%vlc_installer%')"
echo Downloading GitHub Desktop...
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%github_url%', '%github_installer%')"
echo Downloading Python...
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%python_url%', '%python_installer%')"

:: Install software
echo Installing Visual Studio Code...
start /wait "" "%vscode_installer%" /silent /norestart
echo Installing Free Download Manager...
start /wait "" "%fdm_installer%" /silent /norestart
echo Installing VLC Media Player...
start /wait "" "%vlc_installer%" /L=1033 /S
echo Installing GitHub Desktop...
start /wait "" "%github_installer%" /S
echo Installing Python...
start /wait "" "%python_installer%" /quiet PrependPath=1 Include_test=0

echo All installations completed.
