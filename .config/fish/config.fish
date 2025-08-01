if status is-interactive
    hyfetch --ascii-file ~/.config/fastfetch/logo.txt
end

set -g fish_greeting

# ENVs
set -Ux PATH "$PATH:$HOME/.local/bin"
set -Ux EDITOR nvim

set -Ux XDG_SESSION_TYPE wayland
set -Ux RTC_USE_PIPEWIRE true

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
alias deskreen='~/Documents/Deskreen-2.0.4.appimage --enable-features=WebRTCPipeWireCapturer'
alias fetch='fastfetch -c ~/.config/fastfetch/config-default.jsonc'
alias af='hyfetch --ascii-file ~/.config/fastfetch/logo.txt'
alias cls='clear && af'
alias reload 'source ~/.config/fish/config.fish'
abbr --add nv neovide
abbr --add vim nvim
abbr --add vi nvim
abbr --add y yazi
abbr --add cd z

# Misc
function md # create dir
    mkdir -pv "$argv[1]"
    cd "$argv[1]"
end

function tf # touch file with mkdir -p
    set file $argv[1]
    if test -z "$file"
        echo "Usage: tf <path/to/file>"
        return 1
    end

    set dir (dirname "$file")
    mkdir -pv "$dir"
    touch "$file"
    echo "touch: created file '$file'"
end

function cfp # copy file path
    readlink -f "$argv[1]" | wl-copy
end

alias cdp='pwd | wl-copy' # copy dir path
alias grep='grep --color=auto'
alias reboot='sudo /sbin/reboot'
alias poweroff='sudo /sbin/poweroff'
alias halt='sudo /sbin/halt'
alias shutdown='sudo /sbin/shutdown'

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
abbr --add gl 'git pull'
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

abbr --add cleanlog 'sudo journalctl --vacuum-time=7d'
abbr --add listpkg 'yay -Q | fzf -e --no-preview'
abbr --add clnpkg 'yay -Rns $(yay -Qtdq)'

# Starship
source (/usr/bin/starship init fish --print-full-init | psub)

# Zoxide
zoxide init fish | source
