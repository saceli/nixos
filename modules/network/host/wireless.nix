{
  networking.wireless.enable = true;
  networking.wireless.userControlled = true;
  users.users."elia".extraGroups = [
    "networkmanager"
  ];
}