if status is-interactive
    ## ── Greeting ───────────────────────────
    set fish_greeting

    ## ── Prompt ─────────────────────────────
    zoxide init fish | source
    starship init fish | source

    ## ── Aliases & Abbr ─────────────────────
    # Core shortcuts
    alias reload 'exec fish'
    alias ff fastfetch
    alias vi nvim
    alias c code
    alias cg cargo
    alias py python

    # Git
    alias g git
    alias lg lazygit

    abbr --add gcm 'git commit -m'
    abbr --add ga 'git add'
    abbr --add gp 'git push'
    abbr --add gl 'git pull'
    abbr --add gst 'git status'
    abbr --add gco 'git checkout'
    abbr --add gb 'git branch'
    abbr --add grm 'git rm'

    # Search & Files
    abbr --add f fzf
    abbr --add ffind 'fd --type f'
    alias rg 'rg --color=always'
    alias grep 'grep --color=auto'

    # LS family (using eza)
    alias ls 'eza --icons'
    abbr --add l 'ls -lAh'
    abbr --add ll 'ls -lh'
    abbr --add la 'ls -Ah'
    abbr --add te 'ls -T --level=2'
    abbr --add tea 'ls -AhT --level=2'

    # Safety
    alias r 'gio trash'

    # System maintenanc
    alias clnt 'gio trash --empty'

    ## ── Functions ──────────────────────────
    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end

    function extract
        # auto detect file and extract it
        if test -z "$argv[1]"
            echo "Usage: extract <path/to/file>"
            return 1
        end
        switch $argv[1]
            case '*.tar.gz' '*.tgz'
                tar -xvzf $argv[1]
            case '*.tar.bz2'
                tar -xvjf $argv[1]
            case '*.tar'
                tar -xvf $argv[1]
            case '*.zip'
                unzip $argv[1]
            case '*.gz'
                gunzip $argv[1]
            case '*.bz2'
                bunzip2 $argv[1]
            case '*'
                echo "Unknown archive: $argv[1]"
        end
    end

    function md
        # mkdir + cd
        if test -z "$argv[1]"
            echo "Usage: md <path/to/dir>"
            return 1
        end
        mkdir -pv "$argv[1]"
        cd "$argv[1]"
    end

    function tf
        # touch file with auto create dirs
        # if not dirs exsit
        if test -z "$argv[1]"
            echo "Usage: tf <path/to/file>"
            return 1
        end
        mkdir -pv (dirname "$argv[1]")
        touch "$argv[1]"
        echo "touch: created file '$argv[1]'"
    end

    function tfc
        # same as tf but cd into it
        if test -z "$argv[1]"
            echo "Usage: tf <path/to/file>"
            return 1
        end
        mkdir -pv (dirname "$argv[1]")
        touch "$argv[1]"
        echo "touch: created file '$argv[1]'"
        cd (dirname "$argv[1]")
    end

    function gc
        # clone + cd
        if test (count $argv) -lt 1
            echo "Usage: gc <repo-url> [target-dir]"
            return 1
        end

        if test (count $argv) -ge 2
            set repo $argv[2]
        else
            set repo (basename (string replace -r '\.git$' '' $argv[1]))
        end

        git clone $argv[1] $repo
        cd $repo
    end

    ## ── Env Specific ───────────────────────
    if set -q TERMUX_VERSION
        ### ── TERMUX ONLY ─────────────────────
        alias cls 'clear && fastfetch'
        abbr --add listpkg 'pkg list-installed | fzf -e --no-preview'

        clear
        fastfetch
    else
        ### ── LINUX ONLY ──────────────────────
        ## ── Aliases & Abbr ───────────────────
        alias cls 'clear && hyfetch'
        alias cdp 'pwd | wl-copy'

        abbr --add cleanlog 'sudo journalctl --vacuum-time=7d'
        abbr --add listpkg 'yay -Q | fzf -e --no-preview'
        abbr --add clnpkg 'yay -Rns (yay -Qtdq)'

        ## ── Functions ────────────────────────
        function cfp
            # copy file path
            readlink -f "$argv[1]" | wl-copy
        end

        clear
        hyfetch
    end
end

## ── Global ENVs ──────────────────────────
set -Ux EDITOR nvim
set -Ux FZF_DEFAULT_OPTS "\
--layout=reverse \
--border \
--no-preview"

fish_add_path $HOME/.local/bin

if not set -q TERMUX_VERSION
    fish_add_path $HOME/.spicetify
end
