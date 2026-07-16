{ pkgs, iloader, ... }:

{
  environment.systemPackages = with pkgs; [

    # DEVELOPMENT
    gcc
    python3
    go
    vscodium
    neovim

    # DESIGN & CREATIVE
    imagemagick

    # AUDIO & MUSIC
    playerctl
    mpd
    alsa-lib
    pulseaudio
    jack2

    # VIDEO & MEDIA
    mpv
    vlc
    ffmpeg
    yt-dlp
    eog

    # FILE MANAGEMENT
    gvfs
    udisks2

    # NETWORKING & INTERNET
    networkmanager
    networkmanagerapplet
    openssh
    inetutils
    dnsutils
    nmap
    tailscale
    curl
    wget

    # BLUETOOTH
    bluez

    # SYSTEM MONITORING
    htop
    btop
    fastfetch
    smartmontools

    # TERMINAL UTILITIES
    cowsay
    tmux
    ripgrep
    fd
    fzf
    bat
    eza
    zoxide
    jq
    tree
    rsync
    stow
    upower

    # ARCHIVES & COMPRESSION
    unzip
    zip
    unrar
    p7zip

    # FILESYSTEMS & STORAGE
    ntfs3g
    exfatprogs
    dosfstools
    btrfs-progs
    udftools
    parted

    # DESKTOP
    brightnessctl

    # AUDIO SESSION & PIPEWIRE
    pipewire
    wireplumber

    # FONTS
    nerd-fonts.jetbrains-mono

    # SECURITY & AUTHENTICATION
    polkit
    fprintd
    sbsigntool

    # PRINTING
    cups-pk-helper

    # UTILITIES
    qbittorrent
    man-db
    man-pages
    usbutils
    pciutils
    starship

  ];
}