import shutil
import subprocess
import sys

def installArch():
    commandArch = ["yay", "-Sy","--noconfirm"]
    listToInstall = [        
        "zip",
        "input-leap-bin",
        "okular",
        "syncthing",
        "github-cli",
        "lazygit",
        "vscodium-bin",
        "telegram-desktop-bin",
        "fzf",
        "zoxide",
        "qbittorrent",
    ]
    commandArch.extend(listToInstall)
    if not shutil.which("yay"):
        subprocess.run(["pacman", "-Sy", "yay","--noconfirm"], check=True)
    subprocess.run(commandArch, check=True)
    print("\n✅ System update completed successfully.")
    sys.exit(0)
if __name__ == "__main__":
    installArch()
