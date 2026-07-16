{ ... }:

{
  # configuration for the main user and their group

  users.users."elia" = {

    home = "/home/elia";

    isNormalUser = true;
    hashedPasswordFile = "/root/secrets/elia.hash"; # MAKE THE FILE 0400 ROOT:ROOT AND MAKE IT BEFORE REBUILDING
    # NOTE: I spent 1 day fixing the hash file. My wonky keyboard kept misspelling in tty and there isnt even a confirmation for mkpasswd
    #       so please make the file before and possibly in a GUI environment and not a tty. if you fuck it up boot a live env (you can build
    #       it with `buildnix laptop-iso` if you already rebuilt this flake atleast once) then run `sudo mkpasswd | tee /path/to/hashfile`.
    #       The shittiest part is the hash comes different every single time because of salting, so you can't really manually verify it easily

    extraGroups = [ "networkmanager" "wheel" "libvirtd" "kvm" "dialout" ];

  };

}
