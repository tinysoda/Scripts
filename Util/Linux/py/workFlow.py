#!/usr/bin/env python3
from pathlib import Path
import datetime
import shutil

TARGET = Path.home() / ".config" / "fish" / "config.fish"

START_MARK = "# >>> cachyos-workflow-tools >>>"
END_MARK   = "# <<< cachyos-workflow-tools <<<"

BLOCK = f"""{START_MARK}

# ---- zoxide ----
if type -q zoxide
    zoxide init fish | source
end

# ---- fd instead of find ----
if type -q fd
    alias find="fd"
end

# ---- bat instead of cat ----
if type -q bat
    alias cat="bat --paging=never"
end

# ---- fzf defaults (colors + bat preview) ----
if type -q fzf
    set -x FZF_DEFAULT_COMMAND "fd --type f --hidden --follow --exclude .git"
    set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
    set -x FZF_ALT_C_COMMAND "fd --type d --hidden --follow --exclude .git"

    set -x FZF_DEFAULT_OPTS "
        --height=40%
        --layout=reverse
        --border
        --inline-info
        --preview 'bat --style=numbers --color=always --line-range :300 {{}}'
        --preview-window=right:60%
        --color=bg+:#2a2a2a,bg:#1e1e1e,spinner:#89b4fa,hl:#f38ba8
        --color=fg:#cdd6f4,header:#89b4fa,info:#a6e3a1,pointer:#f38ba8
        --color=marker:#f38ba8,fg+:#ffffff,prompt:#89b4fa,hl+:#f38ba8
    "
end

# ---- zi : zoxide + fzf ----
if type -q zoxide; and type -q fzf
    function zi
        set dir (zoxide query -l | fzf)
        if test -n "$dir"
            cd "$dir"
        end
    end
end

{END_MARK}
"""


def main():
    TARGET.parent.mkdir(parents=True, exist_ok=True)

    if TARGET.exists():
        content = TARGET.read_text(encoding="utf-8")
    else:
        content = ""

    if START_MARK in content and END_MARK in content:
        print("[INFO] Workflow block already present. Nothing to do.")
        return

    ts = datetime.datetime.now().strftime("%Y%m%d-%H%M%S")
    backup = TARGET.with_suffix(TARGET.suffix + f".bak.{ts}")

    if TARGET.exists():
        shutil.copy2(TARGET, backup)
        print(f"[OK] Backup created: {backup}")

    new_content = content.rstrip() + ("\n\n" if content.strip() else "") + BLOCK + "\n"
    TARGET.write_text(new_content, encoding="utf-8")

    print("[OK] Workflow configuration added to fish.")
    print("Restart fish or run: exec fish")


if __name__ == "__main__":
    main()
