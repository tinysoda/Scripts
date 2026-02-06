source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

# zoxide
if type -q zoxide
    zoxide init fish | source
end

# fd instead of find
if type -q fd
    alias find fd
end

# bat instead of cat
if type -q bat
    alias cat "bat --paging=never"
end

# fzf defaults with colors + bat preview
if type -q fzf
    set -Ux FZF_DEFAULT_COMMAND "fd --type f --hidden --follow --exclude .git"
    set -Ux FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
    set -Ux FZF_ALT_C_COMMAND "fd --type d --hidden --follow --exclude .git"

    set -Ux FZF_DEFAULT_OPTS "
        --height=40%
        --layout=reverse
        --border
        --inline-info
        --preview 'bat --style=numbers --color=always --line-range :300 {}'
        --preview-window=right:60%
        --color=bg+:#2a2a2a,bg:#1e1e1e,spinner:#89b4fa,hl:#f38ba8
        --color=fg:#cdd6f4,header:#89b4fa,info:#a6e3a1,pointer:#f38ba8
        --color=marker:#f38ba8,fg+:#ffffff,prompt:#89b4fa,hl+:#f38ba8
    "
end

# zi equivalent for fish
function zi
    zoxide query -l | fzf | read -l dir
    if test -n "$dir"
        cd "$dir"
    end
end

# eza (ls replacement on 'l')
if type -q eza
    alias l "eza -lh --icons --git --group-directories-first"
end
