if status is-interactive
    hyfetch --ascii-file ~/.config/fastfetch/logo.txt
end

set -g fish_greeting

# ENVs
set -x EDITOR neovide
set -x PATH "$PATH:$HOME/.local/bin"
set -Ux FZF_DEFAULT_OPTS "\
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#313244,label:#CDD6F4 \
--layout=reverse \
--border \
--preview 'bat --style=numbers --color=always {}'"

# Shortcut
alias fetch='fastfetch -c ~/.config/fastfetch/config-default.jsonc'
alias af='hyfetch --ascii-file ~/.config/fastfetch/logo.txt'
alias cls='clear && af'
abbr --add reload 'source ~/.config/fish/config.fish'
abbr --add nv neovide
abbr --add vim nvim
abbr --add vi nvim
abbr --add y yazi
abbr --add cd z

# Misc
function md # create dir
    mkdir -p "$argv[1]"
    cd "$argv[1]"
    echo "created $(pwd)"
end

function tf # touch file with mkdir -p
    set file $argv[1]
    if test -z "$file"
        echo "Usage: tf <path/to/file>"
        return 1
    end

    set dir (dirname "$file")
    mkdir -p "$dir"
    touch "$file"
    echo "touched $file"
end

function cfp # copy file path
    readlink -f "$argv[1]" | wl-copy
end

alias cdp='pwd | wl-copy' # copy dir path

# Gemini
set -x GEMINI_API_KEY "$(cat $HOME/.config/geminiapikey)"
alias gem='gemini'

# Git
alias df='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias ldf='/usr/bin/lazygit --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias g='git'
alias lg='lazygit'
abbr --add gcm 'git commit -m'
abbr --add ga 'git add'
abbr --add gp 'git push'
abbr --add gst 'git status'

# List Family
alias ls='exa --icons'
abbr --add l 'ls -lAh'
abbr --add ll 'ls -lh'
abbr --add la 'ls -Ah'
abbr --add te 'ls -T'
abbr --add tea 'la -T'

# Files navigation
abbr --add .. 'cd ..'
abbr --add ... 'cd ../..'
abbr --add .... 'cd ../../..'

function up
    set count (math "$argv[1]")
    set path .
    for i in (seq 1 $count)
        set path "../$path"
    end
    cd $path
end

# Safety
alias rm='gio trash'
abbr --add sl 'sl -e'

# System Maintenance
function cleanlog
    sudo journalctl --vacuum-time=7d
end

function update
    echo "[*] Updating pacman and aur..."
    yay -Syyu

    echo "[*] Updating flatpak..."
    flatpak update

    echo "[*] Commiting dotfiles change..."
    set date_string $(date +%Y-%m-%d_%H-%M-%S)
    /usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" commit -a -m "update: $date_string" || echo "[*] Nothing to commit!"

    echo "[*] Doned exiting..."
end

abbr --add listpkg 'yay -Q | fzf -e --no-preview'

# Starship
source (/usr/bin/starship init fish --print-full-init | psub)

# Zoxide
zoxide init fish | source
