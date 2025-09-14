if status is-interactive # Commands to run in interactive sessions can go here
  set fish_greeting

  # Init Zoxide
  zoxide init fish | source

  # Init Starship
  if test -d "/data/data/com.termux/files/home"
    # Termux
    source (/data/data/com.termux/files/usr/bin/starship init fish --print-full-init | psub)
  else
    # Linux
    source (/usr/bin/starship init fish --print-full-init | psub)
  end

  # Shortcut
  alias reload 'exec fish'
  alias cls='clear'
  alias ff='fastfetch'
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


  if not test -d "/data/data/com.termux/files/home"
    alias cdp='pwd | wl-copy' # copy dir path
  end
  alias grep='grep --color=auto'

  # Search
  abbr --add f 'fzf'
  abbr --add ffind 'fd --type f'
  abbr --add rg 'rg --color=always'

  # Archive shortcuts
  abbr --add untar 'tar -xvf'
  abbr --add ungz 'gunzip'
  abbr --add unbz2 'bunzip2'
  abbr --add unzipr 'unzip -d'

  # Pastel
  if not test -d "/data/data/com.termux/files/home"
    alias p='pastel'
    alias pf='pastel format'
    alias pc='pastel color'
    alias pg='pastel gradient'
  end

  # Development
  alias g='git'
  alias lg='lazygit'
  alias cg='cargo'
  alias py='python'
  abbr --add pvenv 'python3 -m venv .venv'
  abbr --add pactv 'source .venv/bin/activate.fish'
  abbr --add pipi 'pip install -U pip'
  abbr --add pipr 'pip install -r requirements.txt'

  function gc # TODO: make also work when specifying dir
    git clone $argv[1]
    set repo (basename (string replace -r '\.git$' '' $argv[1]))
    cd $repo
  end

  abbr --add gcm 'git commit -m'
  abbr --add ga 'git add'
  abbr --add gp 'git push'
  abbr --add gl 'git pull'
  abbr --add gst 'git status'
  abbr --add gc 'git checkout'
  abbr --add gb 'git branch'
  abbr --add grs 'git restore'
  abbr --add grm 'git rm'
  abbr --add gamend 'git commit --amend --no-edit'
  abbr --add gundo 'git reset --soft HEAD~1'
  abbr --add gclean 'git clean -fd'

  # List Family
  alias ls='eza --icons'
  abbr --add l 'ls -lAh'
  abbr --add ll 'ls -lh'
  abbr --add la 'ls -Ah'
  abbr --add te 'ls -T --level=2'
  abbr --add tea 'ls -AhT --level=2'

  # Safety
  alias rm='gio trash'

  # System Maintenance
  if not test -d "/data/data/com.termux/files/home"
    abbr --add cleanlog 'sudo journalctl --vacuum-time=7d'
    abbr --add listpkg 'yay -Q | fzf -e --no-preview'
    abbr --add clnpkg 'yay -Rns $(yay -Qtdq)'
  end

  clear
end

# ENVs
if not test -d "/data/data/com.termux/files/home"
  fish_add_path $HOME/.spicetify
  set -x FZF_DEFAULT_OPTS "\
  --layout=reverse \
  --border"
end

fish_add_path $HOME/.local/bin
set -x EDITOR nvim
