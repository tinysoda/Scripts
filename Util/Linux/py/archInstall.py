import shutil
import subprocess
import sys

def installArch():
    commandArch = ["paru", "-Sy","--noconfirm"]
    listToInstall = [
        "uv",
        "ab-download-manager",
        "zip",
        "kodi",
        "input-leap-bin",
        "okular",
        "syncthing",
        "github-cli",
        "lazygit",
        "antigravity",
        "telegram-desktop-bin",
        "fzf",
        "zoxide",
        "qbittorrent"
    ]
    commandArch.extend(listToInstall)
    if not shutil.which("paru"):
        subprocess.run(["pacman", "-Sy", "paru","--noconfirm"], check=True)
    subprocess.run(commandArch, check=True)
    print("\n✅ System update completed successfully.")
    sys.exit(0)
if __name__ == "__main__":
    installArch()
