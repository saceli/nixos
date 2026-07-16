{ ... }:

{

  users.users.root.openssh.authorizedKeys.keyFiles = [
    ../../../srv/authorized_keys
  ];

}
