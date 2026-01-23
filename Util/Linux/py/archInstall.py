import shutil
import subprocess
import sys

def installArch():
    commandArch = ["paru", "-Sy","--noconfirm"]
    listToInstall = [
        "uv",
        "freedownloadmanager",
        "spotify",
        "zip",
        "kodi",
        "input-leap-bin",
        "protonup-qt-bin",
        "gamemode",
        "okular",
        "syncthing",
        "github-desktop-bin",
        "antigravity",
        "telegram-desktop-bin",
        ""
    ]
    commandArch.extend(listToInstall)
    if not shutil.which("paru"):
        subprocess.run(["pacman", "-Sy", "paru","--noconfirm"], check=True)
    subprocess.run(commandArch, check=True)
    print("\n✅ System update completed successfully.")
    sys.exit(0)
if __name__ == "__main__":
    installArch()
