if status is-interactive
    # Commands to run in interactive sessions can go here
    fastfetch -c ~/.config/fastfetch/config-mine.jsonc
end

set -g fish_greeting

# AI Things
function ai
    tgpt --key (cat $HOME/.config/geminiapikey) --provider gemini -w $argv | glow
end

# PATH
set -x PATH "$PATH:$HOME/.local/bin"

# Custom
alias fetch='fastfetch -c ~/.config/fastfetch/config-mine.jsonc'
alias cls='clear && fetch'
abbr --add cavabg 'kitty -o background_opacity=0 --class=cava "cava"'

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

# Git
alias df='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias g='git'
abbr --add gc 'git commit'

# Starship
source (/usr/bin/starship init fish --print-full-init | psub)

# Zoxide
zoxide init fish | source
