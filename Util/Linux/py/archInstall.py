import shutil
import subprocess
import sys

def installArch():
    listToInstall = [
        "uv",
        "freedownloadmanager",
        "zip",
        "kodi",
        "input-leap-bin",
        "protonup-qt-bin",
        "gamemode",
        "okular",
        "syncthing",
        "github-desktop-bin",
        "antigravity",
        "telegram-desktop-bin"
    ]

    if not shutil.which("paru"):
        try:
            subprocess.run(["pacman", "-Sy", "paru", "--noconfirm"], check=True)
        except subprocess.CalledProcessError:
            print("Failed to install paru. Exiting.")
            sys.exit(1)

    print("Syncing package database...")
    try:
        subprocess.run(["paru", "-Sy", "--noconfirm"], check=True)
    except subprocess.CalledProcessError:
        print("Warning: Database sync failed. Continuing with installation...")

    failed_packages = []
    for package in listToInstall:
        print(f"Installing {package}...")
        try:
            subprocess.run(["paru", "-S", package, "--noconfirm"], check=True)
        except subprocess.CalledProcessError:
            print(f"⚠️ Failed to install {package}")
            failed_packages.append(package)

    if failed_packages:
        print(f"\nCompleted with errors. Failed to install: {failed_packages}")
    else:
        print("\n✅ System update completed successfully.")
    
    sys.exit(0)
if __name__ == "__main__":
    installArch()
