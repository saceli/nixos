# saceli's flake

Personal NixOS flake for a hardened laptop, a live USB installer, and a headless
Raspberry Pi server - all built from one modular, reusable configuration tree.

- **Primary system:** `x86_64-linux` (Raspberry Pi is `aarch64-linux`)
- **Channel:** `nixos-unstable`, `stateVersion = "26.05"`
- **Home management:** [hjem](https://github.com/feel-co/hjem)
- **Secure boot:** [lanzaboote](https://github.com/nix-community/lanzaboote)
- **Desktop:** niri + DankMaterialShell

---

## Table of Contents

- [Hosts](#hosts)
- [Flake Inputs](#flake-inputs)
- [Quick Start](#quick-start)
  - [First-time setup (required)](#first-time-setup-required)
  - [Rebuild the laptop](#rebuild-the-laptop)
  - [Build the live ISO](#build-the-live-iso)
  - [Build the Raspberry Pi SD image](#build-the-raspberry-pi-sd-image)
  - [Development shell](#development-shell)
- [Features](#features)
  - [Security hardening](#security-hardening)
  - [Privacy](#privacy)
  - [Desktop environment](#desktop-environment)
  - [Applications](#applications)
  - [System & services](#system--services)
- [Module Library](#module-library)
- [Repository Layout](#repository-layout)
- [Notes & Caveats](#notes--caveats)

---

## Hosts

| Configuration | System | Purpose | Build target |
|---|---|---|---|
| `laptop-amd64` | `x86_64-linux` | Main daily-driver laptop (LUKS-encrypted, secure boot, full desktop) | `nixos-rebuild` |
| `laptop-iso` | `x86_64-linux` | Bootable live USB with the full desktop, for installs & recovery | `.#laptop-iso` package |
| `raspi` | `aarch64-linux` | Headless Raspberry Pi server (SSH-only, hardened sshd) | `.#packages.aarch64-linux.raspi` package (or `.#raspi` if you're already in a aarch machine) |

All hosts share the same module library (`modules/`) and only differ in which
modules they compose, plus their host-specific files in `hosts/`.

## Flake Inputs

| Input | Used for |
|---|---|
| `nixpkgs` (`nixos-unstable`) | Base package set (`allowUnfree = true`) |
| `hjem` | Declarative home-file management for user `elia` (bulk rename for different users, I use `elia` on all my setups) |
| `lanzaboote` | UEFI Secure Boot on `laptop-amd64` |
| `iloader` | iOS sideloading tool (installed system-wide alongside `usbmuxd`)  |
| `dms-plugin-registry` | DankMaterialShell plugins (e.g. `dankBatteryAlerts`) |

---

## Quick Start

> Requires Nix with `nix-command` and `flakes` experimental features enabled.
> (The built systems enable these for themselves in `modules/core/nix`.)

### First-time setup (required)

The laptop and raspi use **immutable users** - passwords are set declaratively,
so you must create the password hash file **before** the first rebuild:

```bash
sudo mkdir -p /root/secrets
sudo mkpasswd | sudo tee /root/secrets/elia.hash   # (NOTE: This command doesn't have a confirmation window like `passwd` so make sure you spell correctly!)
sudo chmod 400 /root/secrets/elia.hash   # must be 0400 root:root
```

> **Warning:** create the hash in a GUI terminal, *not* a TTY: a keyboard
> layout mishap in a TTY can silently bake in a wrong password, and salting
> makes hashes impossible to eyeball-verify. If you lock yourself out, boot
> the live ISO (see below) and regenerate it. (any live nixos iso works aslong as you can nixos-enter into your system)

On the laptop, Secure Boot keys live in `/var/lib/sbctl` (lanzaboote PKI bundle):

```bash
sudo sbctl create-keys   # before rebuilding with secure boot enabled
```

### Edit the host-specific hardware file

If you haven't already, edit the host-specific hardware file to match your disks' UUID and options. If you don't your system won't boot
Simply put your disk partitions' UUID in the correct places in the file.

### Review all of the flake's file before rebuilding!

Before rebuilding review everything and adjust to your needs, this isn't a copy-paste kind of setup, you need to edit some stuff such as git config and more. You also might need to unblacklist or blacklist some more modules so read through all of the flake's file before rebuilding.

### Rebuild the laptop

```bash
sudo nixos-rebuild switch --flake .#laptop-amd64
```

Once built, `sudo` is aliased to `run0` on the system, so `run0 nixos-rebuild ...` works too.

### Build the live ISO ( ::: OPTIONAL ::: )

```bash
nix build .#laptop-iso
ls result/iso/          # the .iso image
sudo dd if=result/iso/nixos-*.iso of=/dev/sdX bs=4M status=progress oflag=sync
```

Live media credentials (mutable users, it's a live environment):

| User | Password |
|---|---|
| `elia` | `nixos` |
| `root` | `root` |

### Build the Raspberry Pi SD image

```bash
nix build .#raspi       # result/sd-image/*.img (uncompressed) [around 9GB]
```

Building an `aarch64-linux` image from the x86_64 laptop works out of the box:
the laptop enables `boot.binfmt.emulatedSystems` for aarch64 (module
`modules.boot.emulated`). The raspi host needs `srv/authorized_keys` at the
flake root for SSH access, and the `/root/secrets/elia.hash` file as described
above. The image intentionally builds with `max-jobs = 1` / `cores = 1` to
avoid thrashing the Pi ("anti raspi-bomber").

### Development shell (use when developing the flake, especially with vscodium)

```bash
nix develop
```

Drops you into a shell with a status banner and the full toolchain:

| Category | Tools |
|---|---|
| Editor | `vscodium` |
| General | `git`, `direnv` |
| Nix | `nil`, `nixfmt-rfc-style`, `alejandra`, `statix`, `deadnix` |
| Shell | `shfmt`, `shellcheck` |
| Misc | `jq`, `ripgrep`, `fd`, `just` |

---

## Features

### Security hardening

- **Secure Boot** via lanzaboote + `sbctl` (PKI bundle at `/var/lib/sbctl`)
- **Full-disk encryption** - LUKS root (`nixosroot`, XFS) plus a separately
  encrypted `/home` (`nixoshome`) unlocked via `/etc/crypttab` keyfile
- **Hardened kernel parameters** - `slab_nomerge`, `init_on_alloc/free`,
  `page_alloc.shuffle`, `pti=on`, `randomize_kstack_offset`, `vsyscall=none`,
  `debugfs=off`, `oops=panic`, `lockdown=confidentiality`, `module.sig_enforce`,
  Spectre v2 / SSBD mitigations, IOMMU on (Intel + AMD), `efi=disable_early_pci_dma`,
  `kvm.nx_huge_pages=force`, no trust in CPU/bootloader RNG
- **sysctl lockdown** - full ASLR, SysRq off, `kptr_restrict`, `dmesg_restrict`,
  unprivileged BPF/io_uring/userfaultfd off, `ptrace_scope=3`, kexec off,
  `perf_event_paranoid=3`, protected hardlinks/symlinks/FIFOs, BPF JIT off,
  SYN cookies, rp_filter, no ICMP redirects/source-routing, martian logging,
  TCP timestamps off
- **Kernel module blacklist** - ~60 modules: obsolete network protocols
  (dccp, sctp, rds, tipc, ax25, decnet, appletalk, ipx…), rare & network
  filesystems (cramfs, hfs, nfs, gfs2…), firewire, webcam (`uvcvideo`),
  integrated audio (`snd_hda_intel`), PC speaker, dirtyfrag mitigations
  (`esp4/esp6/rxrpc`) - all hard-blocked via modprobe `install … /bin/false`
- **graphene-hardened memory allocator** system-wide
- **Locked-down users** - immutable users, root account locked (`!`), core
  dumps disabled, emergency & rescue systemd targets disabled
- **run0 instead of sudo** - `sudo` aliased to `run0` (no inverted background),
  `su`/`sg`/`pkexec` SUID wrappers disabled, polkit enabled, wheel needs password
- **Bootloader protection** - systemd-boot editor disabled (no kernel-param
  tampering), max console resolution, max 20 entries
- **auditd** - logs every `execve`, with log rotation (5 × 500 MB) and an
  8192-event backlog
- **Nix daemon restrictions** - only `@wheel` may use nix, only `root` is
  trusted, signed binaries required, `accept-flake-config = false`,
  auto-optimise-store on, GC manual (server-grade GC config commented in
  `modules/core/nix/settings.nix`)

### Privacy

- **MAC address randomization** on every boot (systemd oneshot before NetworkManager)
- **Public Whonix machine-id** instead of a unique one (`b08dfa6083e7567a1921a715000001fb`)
- **IPv6 disabled** entirely (don't need it, enable it if you do.)
- **Cloudflare DNS** (`1.1.1.1`, `1.0.0.1`) via a static `resolv.conf`
  (`resolved`/`resolvconf` disabled)
- **Bash history wiped on logout** (global `/etc/bash_logout`)
- **PipeWire starts muted** (default sink volume 0.0)
- **Legal banner** in `/etc/issue` and `/etc/issue.net` (per Lynis)
- **Hardened Brave** (see below) and **hardened SSH** (see below)

### Desktop environment

- **niri** (scrollable-tiling Wayland compositor) with `xwayland-satellite`
- **DankMaterialShell** as a systemd user service, with:
  - system monitoring widgets (dgop), VPN widget, dynamic wallpaper-based
    theming (matugen), audio visualizer (cava), calendar events (khal)
  - clipboard history **disabled**
  - plugin: `dankBatteryAlerts` from `dms-plugin-registry`
- **dms-greeter** display manager running on niri
- Declarative home files via hjem: GTK 3/4 settings, DMS settings/session,
  niri `config.kdl`, dgop colors, fastfetch, fontconfig, neofetch, starship,
  `.bashrc`
- Catppuccin GTK theme, Papirus icons, Bibata cursors; Noto (+CJK +emoji),
  JetBrains Mono Nerd Font, IBM Plex, Adwaita fonts

### Applications

- **Brave** - managed through Chromium enterprise policies:
  - uBlock Origin **force-installed** with pre-seeded filter lists & rules
  - HTTPS-only forced, third-party cookies blocked, strict fingerprinting
    protection, De-AMP & debouncing, site isolation (`SitePerProcess`)
  - telemetry, safe-browsing reporting, sync, translate, spellcheck, media
    router, password manager & autofill all disabled
  - Brave anti-features removed: Rewards, Wallet, VPN, AI chat, News, Talk,
    Speedreader, Playlist
  - PDFs open externally, autoplay off, background mode off, full URLs shown,
    DoH off, WebRTC non-proxied UDP disabled - and yes, the dinosaur easter
    egg stays
  - default handler for `http`, `https` and `text/html`
- **Zathura** - default PDF viewer
- **Git** - identity `saceli`, GitHub noreply e-mail, SSH commit signing (set your own email and users!)
  (`~/.ssh/github`, `gpg.format = ssh`, `commit.gpgSign`)
- **Bash** - LS colors, completion, undistract-me with sound

### System & services

| Service | Config |
|---|---|
| **pipewire** | ALSA (+32-bit), JACK & Pulse backends, WirePlumber, rtkit, clock locked to 48 kHz / quantum 1024–8192 (fixes "drunk" audio, which is probably a problem only I have), starts muted, pavucontrol for user `elia` |
| **sshd** (raspi) | Public-key only (`AllowUsers elia`, no root, no passwords), post-quantum KEX first (`mlkem768x25519-sha256`, `sntrup761x25519-sha512`), tight cipher/MAC lists, `MaxAuthTries 2`, `LoginGraceTime 20`, no forwarding/tunneling, ed25519 host key only, waits for `network-online.target` |
| **fail2ban** (raspi) | 2 retries → 24 h ban, incrementing multipliers up to 1024 days |
| **auditd** | execve logging with rotation (see above) |
| **journald** | 2 GB cap (system + runtime) |
| **timesyncd** | `time.cloudflare.com`, `time.google.com` |
| **bluetooth** | bluez + blueman |
| **upower** | battery/power management |
| **firewall** | only the necessary ports open (TCP 22 for ssh for now, VaultWarden and SearXNG coming soon) |
| **networking** | NetworkManager (forced), wpa_supplicant user-controlled |

Localization: Italian keyboard (`it`, winkeys) & console keymap,
`en_US.UTF-8` locale with Italian regional formats, `Europe/Rome` timezone.
Hostname: `nixosaurus`. (see host-specific file)

Core package philosophy: **zero default packages**, then a curated minimal
toolset (coreutils, curl/wget, git, neovim, tmux, cryptsetup, sbctl, xfs,
wireguard-tools, tcpdump, age/signify/gnupg/openssl, jq/yq, strace, smartmontools…)
with `EDITOR=nvim` and `nix-ld` for dynamically-linked binaries.

<small>Credits to [github.com/sotormd/nixos](https://github.com/sotormd/nixos)</small>

---

## Module Library

Everything under `modules/` is a composable building block; hosts pick what
they need. Import paths mirror the tree, e.g. `modules.services.sshd`.

```
modules/
├── apps/        bash · brave · git · zathura
├── boot/        emulated (binfmt) · kernel (blacklist/params/sysctl/initrd)
│                localization · malloc (graphene) · secureboot (lanzaboote)
│                systemd-boot · uboot (extlinux) · users (immutable/locked-root)
├── core/        nix (settings, nix-ld, /etc/current-flake) · packages · state
├── desktop/     dms-niri (niri + DankMaterialShell + greeter) · niri
├── hardware/    redistributable firmware defaults
├── home/        hjem file trees per host (laptop · laptop-iso · raspi)
│                + universal-configs (fastfetch, starship, bashrc…)
├── network/     firewall · host (dns, issue, machine-id, wireless)
│                macchanger · networkmanager
└── services/    auditd · bluetooth · journald · pipewire · run0 · sshd
                 timesyncd · upower
```

Host-specific bits live in `hosts/`:

```
hosts/
├── hardware/    laptop (LUKS/XFS/AMD) · laptop-iso · raspi (sd-image)
└── software/    per-host package sets & programs (+ ISO live-user config)
```

## Notes & Caveats

- **Machine-specific disk UUIDs:** `hosts/hardware/laptop/hardware.nix` contains
  real LUKS/`/boot` UUIDs - regenerate with `nixos-generate-config` on new
  hardware and merge your values.
- **`/root/secrets/elia.hash` must exist before rebuilding** the laptop or
  raspi, or you'll get a user with no usable password.
- **Unfree packages** are allowed system-wide (VMware Workstation, Spotify…).
- **Secure boot + lanzaboote:** enroll keys with `sbctl` first; on the laptop
  `systemd-boot.enable` is force-disabled in favor of lanzaboote.
- **Wine works** with the graphene-hardened malloc but may print warnings.
- The raspi image is **uncompressed** (`sdImage.compressImage = false`) -
  flash the `.img` directly.

## License

This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
Copyright © 2026 saceli

## Credits

This flake was built from scratch for my own use, but parts of the configuration and several ideas were inspired by or adapted from:

- [github.com/sotormd/nixos](https://github.com/sotormd/nixos)

Many thanks to the author for making their configuration publicly available.
Also many thanks for helping me so much during the make of it. <3