# ~/.bashrc

# Only run for interactive shells.
[[ $- == *i* ]] || return

# -----------------------------------------------------------------------------
# History (set the following 2 options to 0 if you wanna completely disable history (you can't use up arrow to go back))
# NOTE: the history already gets deleted on logout via modules.apps.bash (systemd Unit)
# -----------------------------------------------------------------------------

HISTSIZE=100000
HISTFILESIZE=100000
export HISTCONTROL=ignoredups:erasedups:ignorespace

shopt -s histappend

# -----------------------------------------------------------------------------
# Shell options
# -----------------------------------------------------------------------------

shopt -s autocd
shopt -s cdspell
shopt -s checkjobs
shopt -s extglob
shopt -s globstar
shopt -s checkwinsize
shopt -s nullglob

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
alias -- o='less'
alias -- ..='cd ..'
alias -- ...='cd ../..'

if test "$is" != "ksh" ; then
    alias -- +='pushd .'
    alias -- -='popd'
fi

alias -- rd=rmdir

if type -p tput >/dev/null 2>&1 && test -n "$TERM" -a -t 1 && test "$(tput colors)" -ge 8 ; then
    alias -- egrep='grep -E --color=auto'
    alias -- fgrep='grep -F --color=auto'
    alias -- grep='grep --color=auto'
    if ip --color=auto -V >/dev/null 2>&1 ; then
	alias -- ip='ip --color=auto'
    fi
else
    alias -- egrep='grep -E'
    alias -- fgrep='grep -F'
fi
alias -- md='mkdir -p'

if test "$is" = "bash" -a ! -x /usr/bin/which ; then
    #
    # Other shells use the which command in path (e.g. ash) or
    # their own builtin for the which command (e.g. ksh and zsh).
    #
    _which () {
	local file=$(type -p ${1+"$@"} 2>/dev/null)
	if test -n "$file" -a -x "$file"; then
	    echo "$file"
	    return 0
	fi
	hash -r
	type -P ${1+"$@"}
    }
    alias -- which=_which
fi
alias -- rehash='hash -r'
if test "$is" != "ksh" ; then
    alias -- beep='echo -en "\007"' 
else
    alias -- beep='echo -en "\x07"'
fi

alias -- unmount='echo "Error: Wrong command dumbass haha. use umount" 1>&2; false'

alias -- cd..='cd ..'
alias -- ports='ss -tuln'
alias -- swww='awww'
alias -- swww-daemon='awww-daemon'
alias -- wttr='curl wttr.in'
alias -- yt='yt-dlp -t mp3'

# Permissions (apparently directories need the executable bit to be able to be traversable
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

# usage: destroy [filepath] - Destroys a file overwriting it with random bytes 3 times and
#			      once with 0s, then renames it a bunch of times and deletes
#			      it from the disk. (using `shred`)
destroy() {
    if [ "$#" -eq 0 ]; then
        echo "Usage: destroy <file> [file...]"
        return 1
    fi

    printf 'The following will be securely deleted:\n'
    printf '  %s\n' "$@"
    printf 'Continue? [y/N] '
    read -r reply

    case "$reply" in
        [Yy]|[Yy][Ee][Ss])
            shred -v -z -u -- "$@"
            ;;
        *)
            echo "Cancelled."
            ;;
    esac
}

# Usage: buildnix <package-output> (e.g. buildnix raspi :: Produces a results/sd-image/whatever.img)
buildnix() {
    nix build $HOME/nixos#$1
}

# Usage: rebuildnixos <flake-output>
rebuildnixos() {
    sudo nixos-rebuild switch --flake $HOME/nixos#$1
}

# jump to the directory where the file is (e.g., xd $(location something))
xd () {
    cd "$(dirname "$(readlink -f "$1")")"
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
