fastfetch -c ~/.config/fastfetch/config-mine.jsonc

export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$HOME/.spicetify:$PATH"
export ZSH="$HOME/.oh-my-zsh"

# AI things
export AI_PROVIDER="gemini"
source $HOME/.config/tgpt/apikey.sh

COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="dd/mm/yyyy"

plugins=(
  git 
  zsh-bat 
  web-search 
  you-should-use 
  zsh-autosuggestions 
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Change default editor on ssh_connection
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

export MANPAGER='nvim +Man!'
export FZF_DEFAULT_OPTS=" \
  --color=bg+:#363a4f,spinner:#f4dbd6,hl:#ed8796 \
  --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
  --color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
  --color=selected-bg:#494d64 \
  --color=border:#363a4f,label:#cad3f5 \
  --border=rounded"

# Custom
alias fetch='fastfetch -c ~/.config/fastfetch/config-mine.jsonc'
alias cls='clear && fetch'

function reload_gtk_theme() {
  theme=$(gsettings get org.gnome.desktop.interface gtk-theme)
  gsettings set org.gnome.desktop.interface gtk-theme ''
  sleep 1
  gsettings set org.gnome.desktop.interface gtk-theme $theme
}

# Change existed commands
alias rm='rm --preserve-root'
alias sl='sl -e'
alias vim='nvim'
alias vi='nvim'
alias cd='z'
alias grep='rg'

# List Family
alias ls='exa --icons'
alias l='ls -lAh'
alias ll='ls -lh'
alias la='ls -Ah'
alias te='ls -T'
alias tea='la -T'

# Shorter Commands
alias t='tmux'
alias yz='yazi'
alias py='python3'
alias dfs='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Config files
alias zshrc="nvim ~/.zshrc"

# Starship
eval "$(starship init zsh)"

# Zoxide
eval "$(zoxide init zsh)"
