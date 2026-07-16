{ ... }:

{
  # configuration for the main user and their group

  users.users."elia" = {

    home = "/home/elia";

    isNormalUser = true;
    password = "nixos"; # Password: nixos

    extraGroups = [ "networkmanager" "wheel" "libvirtd" "kvm" "dialout" ];

  };

}
