@echo off

echo Installing Visual Studio Code...
curl -o vscode.exe -L https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user
start /wait vscode.exe /VERYSILENT /NORESTART

echo Installing GitHub Desktop...
curl -o githubdesktop.exe -L https://central.github.com/deployments/desktop/desktop/latest/win32
start /wait githubdesktop.exe /VERYSILENT /NORESTART

echo Installing VLC Media Player...
curl -o vlc.exe -L https://get.videolan.org/vlc/3.0.16/win64/vlc-3.0.16-win64.exe
start /wait vlc.exe /L=1033 /S

echo Installing Free Download Manager...
curl -o fdm.exe -L https://dn3.freedownloadmanager.org/6/latest/fdminstall_x64.exe
start /wait fdm.exe /S

echo Installing Thorium Browser...
curl -o thorium.exe -L https://github.com/Alex313031/Thorium-Win/releases/download/M121.0.6167.204/thorium_AVX2_mini_installer.exe
start /wait thorium.exe /S

echo Installation completed.
