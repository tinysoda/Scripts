import subprocess
import shutil
import sys

def installDebian():
    """
    Installs packages on Debian-based systems using apt.
    """
    if not shutil.which("apt"):
        print("❌ Error: 'apt' command not found. This script is intended for Debian-based systems.")
        sys.exit(1)

    # Update package lists first
    print("🚀 Updating package lists...")
    subprocess.run(["sudo", "apt", "update"], check=True)

    listToInstall = [
        "uv",
        "zip",
        "kodi",
        "gamemode",
        "okular",
        "syncthing",
        "telegram-desktop",
        "input-leap",
        "protonup-qt"
    ]

    print(f"🚀 Installing packages: {', '.join(listToInstall)}")
    
    command = ["sudo", "apt", "install", "-y"] + listToInstall
    
    try:
        subprocess.run(command, check=True)
        print("\n✅ Installation completed successfully.")
    except subprocess.CalledProcessError as e:
        print(f"\n❌ Error occurred during installation (Exit Code: {e.returncode})", file=sys.stderr)
        sys.exit(e.returncode)

if __name__ == "__main__":
    installDebian()
