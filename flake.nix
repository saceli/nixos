{
  description = "saceli's flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    iloader = {
      url = "github:nab138/iloader";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wallpapers = {
      url = "github:saceli/wallpapers";
      flake = false; # just a repository with files not a flake
    };

  };

  outputs = {
    self,
    nixpkgs,
    hjem,
    lanzaboote,
    iloader,
    dms-plugin-registry,
    wallpapers,
    ...
  }:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    modules = import ./modules;
    hosts = import ./hosts;
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        # Editor
        vscodium

        # General tools
        git
        direnv

        # Nix
        nil
        nixfmt-rfc-style
        alejandra
        statix
        deadnix

        # Shell
        shfmt
        shellcheck

        # Misc
        jq
        ripgrep
        fd
        just
      ];

      shellHook = ''
        echo "╭─────────────────────────────────────────────╮"
        echo "│       Saceli Development Environment        │"
        echo "╰─────────────────────────────────────────────╯"
        echo
        echo "  System   : ${system}"
        echo "  Nix      : $(nix --version)"
        echo "  Git      : $(git --version | cut -d' ' -f3)"
        echo "  Shell    : $SHELL"
        echo "  Flake    : $(basename "$PWD")"
        echo "  Directory: $PWD"
        echo

        if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
          echo "  Branch   : $(git branch --show-current)"
          echo "  Status   : $(git status --short | wc -l) changed file(s)"
        fi
      '';
    };

    # ╞══════════════════════════════╡ LAPTOP-AMD64 ╞═══════════════════════════════╡

    nixosConfigurations.laptop-amd64 =
      nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit
            self
            iloader
            hjem
            wallpapers
            dms-plugin-registry;
        };

        modules = [
          # Boot
          lanzaboote.nixosModules.lanzaboote
          modules.boot.emulated
          modules.boot.kernel
          modules.boot.localization
          modules.boot.malloc
          modules.boot.secureboot
          modules.boot.systemd-boot
          modules.boot.users

          # Core
          modules.core.nix
          modules.core.packages
          modules.core.state

          # Applications
          modules.apps.brave
          modules.apps.git
          modules.apps.zathura
          modules.apps.bash

          # Desktop
          modules.desktop.dms-niri

          # Hardware
          modules.hardware

          # Networking
          modules.network.firewall
          modules.network.host
          modules.network.macchanger
          modules.network.networkmanager

          # Services
          modules.services.auditd
          modules.services.bluetooth
          modules.services.journald
          modules.services.pipewire
          modules.services.run0
          modules.services.timesyncd
          modules.services.upower

          # Host-specific
          hosts.hardware.laptop
          hosts.software.laptop

          # Home
          hjem.nixosModules.default
          modules.home.laptop
        ];
      };

    nixosConfigurations.laptop-iso = nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit
          self
          iloader
          hjem
          wallpapers
          dms-plugin-registry;
      };

      modules = [
        "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"

        # Boot
        modules.boot.emulated
        modules.boot.kernel
        modules.boot.localization
        modules.boot.malloc
        modules.boot.systemd-boot

        # Core
        modules.core.nix
        modules.core.packages
        modules.core.state

        # Applications
        modules.apps.brave
        modules.apps.git
        modules.apps.zathura
        modules.apps.bash

        # Desktop
        modules.desktop.dms-niri

        # Hardware
        modules.hardware

        # Networking
        modules.network.host
        modules.network.networkmanager

        # Services
        modules.services.bluetooth
        modules.services.pipewire
        modules.services.run0
        modules.services.timesyncd
        modules.services.upower

        # Host-specific
        hosts.hardware.laptop-iso
        hosts.software.laptop-iso

        # Home
        hjem.nixosModules.default
        modules.home.laptop-iso
      ];
    };

    packages.${system}.laptop-iso = self.nixosConfigurations.laptop-iso.config.system.build.isoImage;

    nixosConfigurations.raspi = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";

      specialArgs = {
        inherit
          nixpkgs
          self
          iloader
          hjem
          dms-plugin-registry;
      };

      modules = [

        # Apps
        modules.apps.git
        modules.apps.bash

        # Boot
        modules.boot.kernel
        modules.boot.localization
        modules.boot.malloc
        modules.boot.uboot
        modules.boot.users

        # Core
        modules.core.nix
        modules.core.packages
        modules.core.state

        # Hardware
        modules.hardware

        # Home
        hjem.nixosModules.default
        modules.home.raspi

        # Network
        modules.network.firewall
        modules.network.host
        modules.network.macchanger
        modules.network.networkmanager

        # Services
        modules.services.auditd
        modules.services.bluetooth
        modules.services.journald
        modules.services.pipewire
        modules.services.run0
        modules.services.sshd
        modules.services.timesyncd
        modules.services.upower

        # Host-specific
        hosts.software.raspi
        hosts.hardware.raspi

      ];
    };

    packages.aarch64-linux.raspi = self.nixosConfigurations.raspi.config.system.build.sdImage;

  };
}
