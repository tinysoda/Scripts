#!/usr/bin/env python3

import os
import subprocess
import sys

COMMANDS = [
    # System update
    ["sudo", "paru", "-Syu", "--noconfirm"],

    # Install packages
    [
        "sudo", "pacman", "-S", "--needed", "--noconfirm",
        "qemu-full",
        "virt-manager",
        "swtpm",
        "libvirt",
        "dnsmasq",
        "vde2",
        #"bridge-utils",
        "openbsd-netcat"
    ],

    # Add current user to libvirt group
    ["sudo", "usermod", "-aG", "libvirt", os.environ.get("USER", "")],

    # Enable libvirt services
    ["sudo", "systemctl", "enable", "--now", "libvirtd.service"],
    ["sudo", "systemctl", "enable", "--now", "libvirtd.socket"],

    # Enable default network
    ["sudo", "virsh", "net-autostart", "default"],
    ["sudo", "virsh", "net-start", "default"],
]


def run(cmd):
    print("\n>>>", " ".join(cmd))
    result = subprocess.run(cmd)

    if result.returncode != 0:
        print("\nCommand failed. Aborting.")
        sys.exit(result.returncode)


def main():
    if os.geteuid() == 0:
        print("Do NOT run this script as root.")
        print("Run it as your normal user (it will use sudo).")
        sys.exit(1)

    if not os.environ.get("USER"):
        print("Could not detect USER environment variable.")
        sys.exit(1)

    print("Virt-manager setup for CachyOS / Arch")
    print("You will be asked for your sudo password.\n")

    for cmd in COMMANDS:
        run(cmd)

    print("\nAll done!")
    print("IMPORTANT: Log out and log back in for the libvirt group change to take effect.")


if __name__ == "__main__":
    main()
