# Welcome message
if [ -t 1 ]; then
    echo
    printf "\033[1;36m"
    echo "========================"
    echo "= SacEli NixOS Live CD ="
    echo "========================"
    printf "\033[0m"
    echo "::: Temporary read-only environment :::"
    echo "::: All changes will be lost after shutdown. :::"
    echo

    printf "\033[1;32mSystem Statistics\033[0m\n"
    echo "  Kernel       : $(uname -r)"
    echo "  Architecture : $(uname -m)"
    echo "  CPUs         : $(nproc)"
    echo "  Memory       : $(free -h | awk '/Mem:/ {print $3 "/" $2}')"
    echo "  NixOS        : $(nixos-version 2>/dev/null || echo Live CD)"
    echo

    printf "\033[1;33mSource\033[0m\n"
    echo "https://github.com/saceli/nixos"
    echo "License: MIT (FOSS)"
    echo
fi