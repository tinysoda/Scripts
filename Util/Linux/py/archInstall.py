import shutil
import subprocess
import sys

def installArch():
    commandArch = ["paru", "-Sy"]
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
        "syncthing"
    ]
    commandArch.extend(listToInstall)
    commandArch.extend(["--noconfirm"])
    if not shutil.which("paru"):
        subprocess.run(["yay", "-Sy", "paru","--noconfirm"], check=True)
    subprocess.run(commandArch, check=True)
    print("\n✅ System update completed successfully.")
    sys.exit(0)
if __name__ == "__main__":
    installArch()
