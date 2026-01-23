import subprocess
import sys
import shutil

def update_system():
    """
    Updates Arch Linux packages using paru.
    Runs 'paru -Syu --noconfirm'
    """
    commandArch = ["paru", "-Syu", "--noconfirm"]
    commandDebian = ["apt", "update", "full-upgrade", "-y"]
    commandFedora = ["dnf", "update", "-y"]
    
    try:
        # We use subprocess.run without capture_output to allow the 
        # interactive/streaming output of paru to show in the terminal.
        # Determine which package manager is available
        package_manager = next((pkg for pkg in ["paru", "apt", "dnf"] if shutil.which(pkg)), None)

        match package_manager:
            case "paru":
                print(f"🚀 Starting system update: {' '.join(commandArch)}")
                subprocess.run(commandArch, check=True)
            case "apt":
                print(f"🚀 Starting system update: {' '.join(commandDebian)}")
                subprocess.run(commandDebian, check=True)
            case "dnf":
                print(f"🚀 Starting system update: {' '.join(commandFedora)}")
                subprocess.run(commandFedora, check=True)
            case _:
                print("\n❌ Error: 'paru', 'apt', or 'dnf' command not found.", file=sys.stderr)
                sys.exit(1)

        print("\n✅ System update completed successfully.")
        
    except subprocess.CalledProcessError as e:
        print(f"\n❌ Error occurred during system update (Exit Code: {e.returncode})", file=sys.stderr)
        sys.exit(e.returncode)
    except KeyboardInterrupt:
        print("\n⚠️ Update interrupted by user.")
        sys.exit(1)

if __name__ == "__main__":
    update_system()
