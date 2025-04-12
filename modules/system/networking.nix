{ ... }:
{
  networking = {
    hostName = "nixos-laptop";
  enableIPv6 = true;
    networkmanager.enable = true;
  };
}
