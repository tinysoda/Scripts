import subprocess
import shutil
import sys
import os

def command_exists(command):
    """Check if a command is available."""
    return shutil.which(command) is not None

def run_command(cmd, shell=False):
    """Run a shell command and handle potential errors."""
    try:
        subprocess.run(cmd, check=True, shell=shell)
    except subprocess.CalledProcessError as e:
        print(f"Error executing command: {' '.join(cmd) if isinstance(cmd, list) else cmd}")
        print(f"Exit code: {e.returncode}")
        sys.exit(e.returncode)

def main():
    # Install paru if not installed
    if not command_exists("paru"):
        print("Installing paru...")
        run_command(["sudo", "pacman", "-S", "--noconfirm", "paru"])
    else:
        print("Paru already installed. Skipping installation.")

    # Install fcitx5 if not installed
    if not command_exists("fcitx5"):
        print("Installing fcitx5...")
        run_command(["sudo", "pacman", "-S", "fcitx5", "fcitx5-qt", "fcitx5-gtk", "fcitx5-unikey", "kcm-fcitx5", "--noconfirm"])
    else:
        print("fcitx5 already installed. Skipping installation.")

    # Add fcitx configurations to /etc/environment if not already added
    env_file = "/etc/environment"
    config_check = "GTK_IM_MODULE=fcitx"
    
    try:
        with open(env_file, 'r') as f:
            content = f.read()
    except FileNotFoundError:
        content = ""

    if config_check not in content:
        print("Adding fcitx configurations to /etc/environment...")
        configs = [
            'GTK_IM_MODULE=fcitx',
            'QT_IM_MODULE=fcitx',
            'XMODIFIERS=@im=fcitx'
        ]
        # Use sudo tee to append, similar to the original script
        for config in configs:
            cmd = f"echo '{config}' | sudo tee -a {env_file} > /dev/null"
            subprocess.run(cmd, shell=True, check=True)
    else:
        print("fcitx configurations already present in /etc/environment. Skipping addition.")

    print("\n✅ Unikey installation and configuration completed successfully.")

if __name__ == "__main__":
    main()
