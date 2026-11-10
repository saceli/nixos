{ lib, ... }:

{
  options.cfg.boot.enableIpv6 = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = ''
      Whether to enable IPv6 networking. When false, the kernel parameter
      "ipv6.disable=1" is set and networking.enableIPv6 is disabled.
    '';
  };
}
