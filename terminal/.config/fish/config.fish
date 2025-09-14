if status is-interactive # Commands to run in interactive sessions can go here
  set fish_greeting

  # Init Zoxide
  zoxide init fish | source

  # Init Starship
  source (/usr/bin/starship init fish --print-full-init | psub)

  # Shortcut
  alias reload 'exec fish'
  alias cls='clear'
  alias c=code
  alias k=kate
  alias vi=nvim
  alias y=yazi
  alias cd=z

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
    cd "$dir"
  end

  function cfp # copy file path
    readlink -f "$argv[1]" | wl-copy
  end

  alias cdp='pwd | wl-copy' # copy dir path
  alias grep='grep --color=auto'

  # Pastel
  alias p='pastel'
  alias pf='pastel format'
  alias pc='pastel color'
  alias pg='pastel gradient'

  # Development
  alias g='git'
  alias lg='lazygit'
  alias cg='cargo'

  function gc
    git clone $argv[1]
    set repo (basename (string replace -r '\.git$' '' $argv[1]))
    cd $repo
  end

  abbr --add gcm 'git commit -m'
  abbr --add ga 'git add'
  abbr --add gp 'git push'
  abbr --add gl 'git pull'
  abbr --add gst 'git status'

  # List Family
  alias ls='eza --icons'
  abbr --add l 'ls -lAh'
  abbr --add ll 'ls -lh'
  abbr --add la 'ls -Ah'
  abbr --add te 'ls -T'
  abbr --add tea 'la -T'

  # Safety
  alias rm='gio trash'

  # System Maintenance
  abbr --add cleanlog 'sudo journalctl --vacuum-time=7d'
  abbr --add listpkg 'yay -Q | fzf -e --no-preview'
  abbr --add clnpkg 'yay -Rns $(yay -Qtdq)'
end

# ENVs
fish_add_path /home/nutt/.spicetify
fish_add_path /home/nutt/.local/bin
set -Ux EDITOR nvim
set -Ux TERMINAL "kitty -1"

set -Ux FZF_DEFAULT_OPTS "\
  --layout=reverse \
  --border \
  --preview 'bat --style=numbers --color=always {}'"
