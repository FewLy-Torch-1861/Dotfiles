fastfetch -c ~/.config/fastfetch/config-hutao.jsonc

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$HOME/.spicetify:$PATH"
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
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
--color=border:#363a4f,label:#cad3f5"

# Custom
alias hufetch='fastfetch -c ~/.config/fastfetch/config-hutao.jsonc'
alias tuxsay='cowsay -f tux'
alias cls='clear && hufetch'

# Change existed commands
alias sl='sl -e'
alias vim='nvim'
alias vi='nvim'

function sudo() {
  if [[ "$1 $2 $3 $4" == "rm -rf / --no-preserve-root" ]]; then
    echo "nice try"

    return 1
  fi
  command sudo "$@"
}

# List Family
alias ls='lsd'
alias ll='ls -lh'
alias la='ls -Ah'
alias lal='ls -lAh'

# Shorter Commands
alias dir='ll'
alias cs='cowsay'
alias ts='tuxsay'
alias np='goplaying'
alias c='tty-clock -c'
alias t='tmux'
alias th='countryfetch th'
alias z='yazi'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
