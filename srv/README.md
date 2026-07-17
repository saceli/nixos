# srv

Server-specific configuration files used by the flake.

## SSH Authorized Keys

`authorized_keys` contains the SSH public keys that are allowed to authenticate to server hosts.
This file is only needed if your host has the module: `modules.services.sshd`.

The file is imported by the NixOS configuration:

```nix
users.users.elia.openssh.authorizedKeys.keyFiles = [
  ../../../srv/authorized_keys
];
````

To add access, create or edit:

```text
srv/authorized_keys
```

and add your SSH **public key** contents, one key per line.

Example:

```text
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB7examplekeydatahere123456789 user@hostname
```

You can get your public key with:

```bash
cat ~/.ssh/keyName.pub
```

## Important

::: NEVER SHARE YOUR NON-`.pub` FILES :::

Private keys (for example `~/.ssh/id_ed25519`) are confidential and must never be committed, uploaded, or shared.

Only `.pub` files contain public keys and are safe to add here. 
> (even though I gitignored `srv/authorized_keys`, it is safe to share and I only did so because it is useless for others to know which keys can access my homelab and because if i someday put something sensitive (like an email or info) in the file I don't accidentally push it.)

If a private key is exposed, assume it is compromised and replace it immediately.