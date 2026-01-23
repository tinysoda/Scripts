import subprocess
import shutil
import sys

def installFedora():
    """
    Installs packages on Fedora-based systems using dnf.
    """
    if not shutil.which("dnf"):
        print("❌ Error: 'dnf' command not found. This script is intended for Fedora-based systems.")
        sys.exit(1)

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
    
    command = ["sudo", "dnf", "install", "-y"] + listToInstall
    
    try:
        subprocess.run(command, check=True)
        print("\n✅ Installation completed successfully.")
    except subprocess.CalledProcessError as e:
        print(f"\n❌ Error occurred during installation (Exit Code: {e.returncode})", file=sys.stderr)
        sys.exit(e.returncode)

if __name__ == "__main__":
    installFedora()
