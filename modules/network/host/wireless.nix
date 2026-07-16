{
  networking.wireless.enable = true;
  networking.wireless.userControlled = true;
  users.users."elia".extraGroups = [
    "wpa_supplicant"
    "networkmanager"
  ];
}