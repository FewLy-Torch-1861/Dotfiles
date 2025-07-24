if status is-interactive
    hyfetch --ascii-file ~/.config/fastfetch/logo.txt
end

set -g fish_greeting

# ENVs
set -x EDITOR nvim
set -x PATH "$PATH:$HOME/.local/bin"

# Custom
alias fetch='fastfetch -c ~/.config/fastfetch/config-default.jsonc'
alias af='hyfetch --ascii-file ~/.config/fastfetch/logo.txt'
alias cls='clear && af'
abbr --add cavabg 'kitty -o background_opacity=0 --class=cava "cava"'
abbr --add reload 'source ~/.config/fish/config.fish'

# Shorter commands
abbr --add y yazi

# Change existed commands
alias rm='rm --preserve-root'
abbr --add sl 'sl -e'
abbr --add vim nvim
abbr --add vi nvim
abbr --add cd z

# List Family
alias ls='exa --icons'
abbr --add l 'ls -lAh'
abbr --add ll 'ls -lh'
abbr --add la 'ls -Ah'
abbr --add te 'ls -T'
abbr --add tea 'la -T'

# Gemini
set -x GEMINI_API_KEY "$(cat $HOME/.config/geminiapikey)"
alias gc="gemini"

# Git
alias df='/usr/bin/lazygit --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias g='git'
alias lg='lazygit'
abbr --add gc 'git commit -m'
abbr --add ga 'git add'
abbr --add gp 'git push'
abbr --add gst 'git status'

# Starship
source (/usr/bin/starship init fish --print-full-init | psub)

# Zoxide
zoxide init fish | source
