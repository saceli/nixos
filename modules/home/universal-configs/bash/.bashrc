# ~/.bashrc

# Only run for interactive shells.
[[ $- == *i* ]] || return

# -----------------------------------------------------------------------------
# History (set the following 2 options to 0 if you wanna completely disable history (you can't use up arrow to go back))
# NOTE: the history already gets deleted on logout via /etc/bash_logout
# -----------------------------------------------------------------------------

HISTSIZE=100000
HISTFILESIZE=100000
export HISTCONTROL=ignoredups:erasedups

shopt -s histappend

# -----------------------------------------------------------------------------
# Shell options
# -----------------------------------------------------------------------------

shopt -s autocd
shopt -s cdspell
shopt -s checkjobs
shopt -s extglob
shopt -s globstar

# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------

alias -- airplay='uxplay -p -vsync -vs waylandsink'
alias -- clr='clear'
alias -- cls='clear'
alias -- cpuinfo='lscpu'
alias -- matrix='cmatrix'
alias -- meminfo='free -h'
alias -- mk='touch'
alias -- neovim='nvim'
alias -- niri-restart='systemctl --user restart niri'
alias -- niri-start='systemctl --user start niri'
alias -- now='date +%s'
alias -- play_wind='echo cGFjdGwgc2V0LXNpbmstdm9sdW1lIEBERUZBVUxUX1NJTktAIDkwJSAmJiBwYWNhdCAvZGV2L3VyYW5kb20= | base64 -d | sh'
alias -- ports='ss -tuln'
alias -- swww='awww'
alias -- swww-daemon='awww-daemon'
alias -- wttr='curl wttr.in'
alias -- yt='yt-dlp -t mp3'

# Permissions (apparently directories need the executable bit to be able to be traversable (mandela effect for some ppl))
alias -- chmodfiles644='find . -type f -exec chmod 644 {} +'
alias -- chmoddirs755='find . -type d -exec chmod 755 {} +'

# -----------------------------------------------------------------------------
# Functions
# -----------------------------------------------------------------------------

listall() { # mainly used for LLMs
    shopt -s nullglob

    for ext in "$@"; do
        for file in *"$ext"; do
            echo "=== $file ==="
            cat "$file"
            echo
        done
    done
}

listallrecursively() {
    local dir="."
    # Optional first arg: a directory to search
    if [[ -d "$1" ]]; then
        dir="$1"; shift
    fi

    # Normalize extensions: ".nix" and "nix" are both accepted
    local exts=() ext
    for ext in "$@"; do
        exts+=("${ext#.}")
    done

    # Build find predicates: ( -iname "*.ext1" -o -iname "*.ext2" ... )
    local -a find_args=()
    if ((${#exts[@]} > 0)); then
        local i
        find_args+=(\( )
        for i in "${!exts[@]}"; do
            (( i > 0 )) && find_args+=(-o)
            find_args+=(-iname "*.${exts[i]}")
        done
        find_args+=(\) )
    fi

    find "$dir" -type f "${find_args[@]}" | sort | while IFS= read -r file; do
        printf '=== %s ===\n' "${file#./}"
        cat "$file"
        printf '\n'
    done
}

# Usage: buildnix <package-output> (e.g. buildnix raspi :: Produces a results/isos/raspi)
buildnix() {
    nix build /home/elia/nixos#$1
}

# Usage: rebuildnixos <flake-output>
rebuildnixos() {
    sudo nixos-rebuild switch --flake /home/elia/nixos#$1
}

# -----------------------------------------------------------------------------
# Prompt
# -----------------------------------------------------------------------------

eval "$(starship init bash)"

# -----------------------------------------------------------------------------
# Kitty shell integration
# -----------------------------------------------------------------------------

if [[ -n "$KITTY_INSTALLATION_DIR" ]]; then
    export KITTY_SHELL_INTEGRATION="no-rc"
    source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"
fi
