#!/usr/bin/env python3
from pathlib import Path
import datetime
import shutil

# Target is the Bash config file
TARGET = Path.home() / ".bashrc"

START_MARK = "# >>> nobara-bash-workflow >>>"
END_MARK   = "# <<< nobara-bash-workflow <<<"

BLOCK = f"""{START_MARK}

# ---- zoxide (Smarter cd) ----
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init bash)"
fi

# ---- fd (Better find) ----
if command -v fd &> /dev/null; then
    alias find="fd"
fi

# ---- bat (Cat with syntax highlighting) ----
if command -v bat &> /dev/null; then
    # Fedora/Nobara sometimes names the binary 'batcat' or 'bat'
    alias cat="bat --paging=never"
fi

# ---- fzf (Fuzzy Finder integration) ----
if command -v fzf &> /dev/null; then
    export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"

    export FZF_DEFAULT_OPTS="
        --height=40%
        --layout=reverse
        --border
        --inline-info
        --preview 'bat --style=numbers --color=always --line-range :300 {{}}'
        --preview-window=right:60%
        --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
        --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
        --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
    "
fi

# ---- zi: Interactive Zoxide ----
if command -v zoxide &> /dev/null && command -v fzf &> /dev/null; then
    zi() {{
        local dir
        dir=$(zoxide query -l | fzf --height 40% --reverse)
        if [ -n "$dir" ]; then
            cd "$dir"
        fi
    }}
fi

# ---- eza (Modern ls) ----
#if command -v eza &> /dev/null; then
#    alias ls="eza --icons --group-directories-first"
#    alias ll="eza -lh --icons --git --group-directories-first"
#    alias la="eza -a --icons --group-directories-first"
#fi

{END_MARK}
"""

def main():
    if not TARGET.exists():
        print(f"[ERROR] Could not find {TARGET}. Are you sure you are on Bash?")
        return

    content = TARGET.read_text(encoding="utf-8")

    if START_MARK in content:
        print("[INFO] Workflow block already exists in .bashrc.")
        return

    # Create a timestamped backup
    ts = datetime.datetime.now().strftime("%Y%m%d-%H%M%S")
    backup = TARGET.with_suffix(f".bak.{ts}")
    shutil.copy2(TARGET, backup)
    print(f"[OK] Backup created: {backup}")

    # Append the new block
    new_content = content.rstrip() + "\n\n" + BLOCK + "\n"
    TARGET.write_text(new_content, encoding="utf-8")

    print("[OK] Nobara Bash workflow added successfully.")
    print("[HINT] Run 'source ~/.bashrc' to apply changes.")

if __name__ == "__main__":
    main()