{ wallpapers, ... }:

{
  files = {
    
    # wallpaper folder: DankMaterialShell takes this folder (which gets updated each rebuild IF NEEDED)
    # and it uses it to rotate between wallpapers using the vanilla option (for live-cd it doesnt since there's 1 wallpaper)
    ".local/share/wallpapers/live-cd".source = "${wallpapers}/live-cd"; 

  };
}
