{ config, ... }:

let
  user = "elia";
  home = "/home/${user}";
in
{
  xdg.mime.enable = true;
  environment.sessionVariables = {
    XDG_DOCUMENTS_DIR = "${home}/Documents";
    XDG_DOWNLOAD_DIR = "${home}/Downloads";
    XDG_PICTURES_DIR = "${home}/Pictures";
    XDG_DESKTOP_DIR = "${home}/Desktop";
    XDG_MUSIC_DIR = "${home}/Music";
    XDG_PUBLICSHARE_DIR = null;
    XDG_TEMPLATES_DIR = null;
    XDG_VIDEOS_DIR = null;
  };
}
