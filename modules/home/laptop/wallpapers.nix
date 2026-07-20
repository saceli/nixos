{ wallpapers, ... }:

{
  files = {
    
    # wallpaper folder: DankMaterialShell takes this folder (which gets updated each rebuild IF NEEDED)
    # and it uses it to rotate between wallpapers using the vanilla option
    # NOTE: This makes folders inside ~/.local/share/wallpapers like laptop, live-cd, and hacktop. if you dont want this use something like:
    # ".local/share/wallpapers/live-cd".source = "${wallpapers}/live-cd"; 
    # BTW live-cd and hacktop don't contain a lot of wallpapers, but laptop/ does, it's like 250Mb...
    ".local/share/wallpapers".source = "${wallpapers}"; 

  };
}