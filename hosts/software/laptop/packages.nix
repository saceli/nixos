{ pkgs, iloader, ... }:

{
  environment.systemPackages = with pkgs; [

    # DEVELOPMENT
    gcc
    python3
    go
    vscodium
    neovim
    simulide
    kicad
    android-tools
    adb-sync

    # DESIGN & CREATIVE
    blender
    inkscape
    imagemagick
    figlet

    # AUDIO & MUSIC
    spotify
    spicetify-cli
    audacious
    audacity
    pavucontrol
    easyeffects
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
    obs-studio
    wf-recorder
    grim
    slurp
    eog

    # GAMING
    steam
    prismlauncher
    wine
    wine64
    lunar-client
    sidequest

    # COMMUNICATION
    vesktop

    # FILE MANAGEMENT
    nautilus
    peazip
    filezilla
    gvfs
    udisks2

    # NETWORKING & INTERNET
    proton-vpn
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
    blueman
    bluez

    # VIRTUALIZATION
    vmware-workstation

    # SYSTEM MONITORING
    htop
    btop
    fastfetch
    smartmontools

    # TERMINAL UTILITIES
    kitty
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
    gparted

    # DESKTOP & WAYLAND
    niri
    fuzzel
    wl-clipboard
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-user-dirs
    brightnessctl
    xwayland-satellite

    # AUDIO SESSION & PIPEWIRE
    pipewire
    wireplumber

    # THEMES, ICONS & CURSORS
    catppuccin-gtk
    catppuccin
    bibata-cursors
    papirus-icon-theme
    papirus-folders

    # FONTS
    dejavu_fonts
    liberation_ttf
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
    ibm-plex
    adwaita-fonts

    # SECURITY & AUTHENTICATION
    polkit
    fprintd
    sbsigntool

    # PRINTING
    cups-pk-helper

    # UTILITIES
    gedit
    qbittorrent
    man-db
    man-pages
    usbutils
    pciutils
    starship

    # iOS Sideloading
    iloader.packages.${system}.default
    usbmuxd

    # NixOS Ecosystem
    nix
    home-manager
  ];
}
