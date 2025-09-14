if status is-interactive
  ## ── Greeting ───────────────────────────
  set fish_greeting

  ## ── Prompt ─────────────────────────────
  zoxide init fish | source
  starship init fish | source

  ## ── Aliases & Abbr ─────────────────────
  # Core shortcuts
  alias reload 'exec fish'
  alias cls 'clear'
  alias ff 'fastfetch'
  alias vi 'nvim'
  alias y 'yazi'
  alias cg 'cargo'
  alias py 'python'
  alias cd 'z'
  alias grep 'grep --color=auto'

  # Git
  alias g 'git'
  alias lg 'lazygit'

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

  # Search & Files
  abbr --add f 'fzf'
  abbr --add ffind 'fd --type f'
  abbr --add rg 'rg --color=always'

  # Archive
  abbr --add untar 'tar -xvf'
  abbr --add ungz 'gunzip'
  abbr --add unbz2 'bunzip2'
  abbr --add unzipr 'unzip -d'

  # LS family (using eza)
  alias ls 'eza --icons'
  abbr --add l 'ls -lAh'
  abbr --add ll 'ls -lh'
  abbr --add la 'ls -Ah'
  abbr --add te 'ls -T --level=2'
  abbr --add tea 'ls -AhT --level=2'

  # Safety
  alias rm 'gio trash'

  ## ── Functions ──────────────────────────
  function md
    # mkdir + cd
    mkdir -pv "$argv[1]"
    cd "$argv[1]"
  end

  function tf
    # touch file with auto create dir ig not exsit
    set file $argv[1]
    if test -z "$file"
      echo "Usage: tf <path/to/file>"
      return 1
    end
    mkdir -pv (dirname "$file")
    touch "$file"
    echo "touch: created file '$file'"
    cd (dirname "$file")
  end

  function gc
    # clone repo + cd เข้า dir
    git clone $argv[1]
    set repo (basename (string replace -r '\.git$' '' $argv[1]))
    cd $repo
  end

  ## ── Env Specific ───────────────────────
  if set -q TERMUX_VERSION
    ### ── TERMUX ONLY ─────────────────────
  else
    ### ── LINUX ONLY ──────────────────────
    ## ── Aliases & Abbr ───────────────────
    alias cdp 'pwd | wl-copy'

    abbr --add cleanlog 'sudo journalctl --vacuum-time=7d'
    abbr --add listpkg 'yay -Q | fzf -e --no-preview'
    abbr --add clnpkg 'yay -Rns (yay -Qtdq)'

    ## ── Functions ────────────────────────
    function cfp
      # copy file path
      readlink -f "$argv[1]" | wl-copy
    end
  end

  clear
end

## ── Global ENVs ──────────────────────────
set -x EDITOR nvim

fish_add_path $HOME/.local/bin

if not set -q TERMUX_VERSION
  fish_add_path $HOME/.spicetify

  set -x FZF_DEFAULT_OPTS "\
  --layout=reverse \
  --border"
end
