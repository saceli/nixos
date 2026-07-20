{ pkgs, ... }:

{
  # version control that doesn't suck
  programs.git.enable = true;
  
  environment.systemPackages = [
    pkgs.git-filter-repo 
    pkgs.gh # github cli (i use it, it won't impact anything in this flake if you remove it)
  ];
}
