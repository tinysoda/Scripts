#!/bin/bash
# Detect and add Windows Boot Manager to GRUB on CachyOS (Arch-based)

set -e

echo ">>> Checking for Windows Boot Manager..."

# Check for EFI boot entries
if efibootmgr | grep -qi "Windows Boot Manager"; then
    echo "Windows Boot Manager found in EFI entries."
else
    echo "Windows Boot Manager not found in EFI entries."
fi

echo ">>> Installing os-prober if not present..."
if ! pacman -Qi os-prober &>/dev/null; then
    sudo pacman -S --noconfirm os-prober
fi

echo ">>> Enabling os-prober in GRUB..."
GRUB_DEFAULTS="/etc/default/grub"
if grep -q "^#GRUB_DISABLE_OS_PROBER" "$GRUB_DEFAULTS"; then
    sudo sed -i 's/^#GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=false/' "$GRUB_DEFAULTS"
fi

if ! grep -q "GRUB_DISABLE_OS_PROBER=false" "$GRUB_DEFAULTS"; then
    echo "GRUB_DISABLE_OS_PROBER=false" | sudo tee -a "$GRUB_DEFAULTS"
fi

echo ">>> Running grub-mkconfig..."
sudo grub-mkconfig -o /boot/grub/grub.cfg

echo ">>> Done! Windows should now appear in your GRUB boot menu."
