@echo off

rem Define URLs and filenames for the installers
set "VS_CODE_URL=https://vscode.download.prss.microsoft.com/dbazure/download/stable/019f4d1419fbc8219a181fab7892ebccf7ee29a2/VSCodeUserSetup-x64-1.87.0.exe"
set "VS_CODE_FILE=vscode_installer.exe"

set "VLC_URL=https://get.videolan.org/vlc/3.0.16/win64/vlc-3.0.16-win64.exe"
set "VLC_FILE=vlc_installer.exe"

set "GIT_URL=https://github.com/git-for-windows/git/releases/download/v2.35.1.windows.2/Git-2.35.1.2-64-bit.exe"
set "GIT_FILE=git_installer.exe"

set "GITHUB_DESKTOP_URL=https://desktop.githubusercontent.com/github-desktop/releases/3.3.9-051b78a0/GitHubDesktopSetup-x64.exe"
set "GITHUB_DESKTOP_FILE=github_desktop_installer.exe"

set "PYTHON_URL=https://www.python.org/ftp/python/3.10.1/python-3.10.1-amd64.exe"
set "PYTHON_FILE=python_installer.exe"

set "FDM_URL=https://files2.freedownloadmanager.org/6/latest/fdm_x64_setup.exe"
set "FDM_FILE=fdm_installer.exe"

set "THORIUM_URL=https://github.com/Alex313031/Thorium-Win/releases/download/M121.0.6167.204/thorium_AVX2_mini_installer.exe"
set "THORIUM_FILE=thorium_installer.exe"

rem Define silent install commands
set "VS_CODE_COMMAND=%VS_CODE_FILE% /silent"
set "VLC_COMMAND=%VLC_FILE% /S"
set "GIT_COMMAND=%GIT_FILE% /VERYSILENT /NORESTART /NOCANCEL"
set "GITHUB_DESKTOP_COMMAND=%GITHUB_DESKTOP_FILE% /S"
set "PYTHON_COMMAND=%PYTHON_FILE% /quiet InstallAllUsers=1 PrependPath=1 Include_test=0"
set "FDM_COMMAND=%FDM_FILE% /S"
set "THORIUM_COMMAND=%THORIUM_FILE% /S"

rem Download and install VSCode
echo Downloading and installing VSCode...
curl -o %VS_CODE_FILE% -L %VS_CODE_URL%
start /wait %VS_CODE_COMMAND%

rem Download and install VLC
echo Downloading and installing VLC...
curl -o %VLC_FILE% -L %VLC_URL%
start /wait %VLC_COMMAND%

rem Download and install Git
echo Downloading and installing Git...
curl -o %GIT_FILE% -L %GIT_URL%
start /wait %GIT_COMMAND%

rem Download and install GitHub Desktop
echo Downloading and installing GitHub Desktop...
curl -o %GITHUB_DESKTOP_FILE% -L %GITHUB_DESKTOP_URL%
start /wait %GITHUB_DESKTOP_COMMAND%

rem Download and install Python
echo Downloading and installing Python...
curl -o %PYTHON_FILE% -L %PYTHON_URL%
start /wait %PYTHON_COMMAND%

rem Download and install Free Download Manager
echo Downloading and installing Free Download Manager...
curl -o %FDM_FILE% -L %FDM_URL%
start /wait %FDM_COMMAND%

rem Download and install Thorium Browser
echo Downloading and installing Thorium Browser...
curl -o %THORIUM_FILE% -L %THORIUM_URL%
start /wait %THORIUM_COMMAND%

echo Installation completed.
