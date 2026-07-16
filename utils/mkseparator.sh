#!/usr/bin/env bash

nixos_flake_header() {
    local text=" $1 "
    local width=${2:-80}
    local left="╞"
    local right="╡"
    
    # Use wc -m for character count, not byte count
    local text_len
    text_len=$(echo -n "$text" | wc -m)
    
    local line_len=$((width - text_len - 4))
    local left_len=$((line_len / 2))
    local right_len=$((line_len - left_len))

    local left_line=""
    for ((i=0; i<left_len; i++)); do
        left_line+="═"
    done

    local right_line=""
    for ((i=0; i<right_len; i++)); do
        right_line+="═"
    done

    echo "# ${left}${left_line}${right}${text}${left}${right_line}${right}"
}

while true; do
    read -rp "Text? " input
    result=$(nixos_flake_header "$input")
    echo "$result"
    echo "$result" | wl-copy 2>/dev/null || echo "$result" | xclip -selection clipboard 2>/dev/null || echo "clipboard tool not found"
done
