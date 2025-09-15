eval "$(zoxide init bash)"
eval -- "$(starship init bash --print-full-init)"

alias reload='exec bash'
alias cls='clear && fastfetch'
alias ff='fastfetch'
alias vi='nvim'
alias y='yazi'
alias cg='cargo'
alias py='python'
alias cd='z'
alias grep='grep --color=auto'

alias ls='eza --icons'
alias l='ls -lAh'
alias ll='ls -lh'
alias la='ls -Ah'
alias te='ls -T --level=2'
alias tea='ls -AhT --level=2'

clear
fastfetch
