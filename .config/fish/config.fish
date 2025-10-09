set TTY1 (tty)
[ "$TTY1" = /dev/tty1 ] && exec sway

## ── Global ENVs ──────────────────────────
set -Ux EDITOR nvim
set -Ux TERM kitty
set -Ux FZF_DEFAULT_OPTS "\
--layout=reverse \
--border \
--no-preview"

set -Ux GOPATH $HOME/.go

set -Ux QT_AUTO_SCREEN_SCALE_FACTOR 1
set -Ux QT_QPA_PLATFORM wayland
set -Ux QT_QPA_PLATFORM "wayland;xcb"

set -Ux XDG_CURRENT_DESKTOP Sway
set -Ux XDG_SESSION_TYPE wayland
set -Ux XDG_SESSION_DESKTOP Sway

fish_add_path $HOME/.local/bin
fish_add_path $HOME/.spicetify

if status is-interactive
    ## ── Greeting ───────────────────────────
    set fish_greeting

    ## ── Prompt ─────────────────────────────
    zoxide init fish | source
    starship init fish | source

    ## ── Aliases & Abbr ─────────────────────
    # Core shortcuts
    alias c clear
    alias reload 'exec fish'
    alias ts tailscale
    alias cdp 'pwd | wl-copy'

    abbr --add chafa 'chafa -f symbols'

    # Dev
    alias v nvim
    alias cg cargo
    alias py python
    alias dk docker
    alias dkc 'docker compose'
    alias dkps 'docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"'

    # Git
    alias g git
    alias lg lazygit
    alias dot "git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
    alias ld "lazygit --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

    # Search & Files
    abbr --add ffind 'fd --type f'
    alias f fzf
    alias cat 'bat -Pp'
    alias rg 'rg --color=always'
    alias grep 'grep --color=auto'

    # LS family (using eza)
    alias ls 'eza --icons'
    alias l 'ls -lAh'
    alias 'ls -lh'
    alias la 'ls -Ah'
    abbr --add te 'ls -T --level=2'
    abbr --add tea 'ls -AhT --level=2'

    # Safety
    alias r 'gio trash'

    # System maintenanc
    alias clnt 'gio trash --empty'
    abbr --add updmirror 'sudo reflector --country Thailand,Singapore,Japan --latest 10 --sort rate --save /etc/pacman.d/mirrorlist && yay -Syy'
    abbr --add clnlog 'sudo journalctl --vacuum-time=7d'
    abbr --add lpkg 'yay -Q | fzf -e'
    abbr --add lupkg 'yay -Qet | fzf -e'
    abbr --add clnpkg 'yay -Rns (yay -Qtdq)'

    ## ── Functions ──────────────────────────
    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end

    function yc
        set tmp (mktemp -t "yazi-chooser.XXXXXX")
        yazi $argv --chooser-file="$tmp"
        if test -s "$tmp"
            cat "$tmp"
        end
        rm -f -- "$tmp"
    end

    function ext
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

    function cfp
        # copy file path
        readlink -f "$argv[1]" | wl-copy
    end

    clear
end
