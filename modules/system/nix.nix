{ pkgs, ... }:
{
  nix = {
    package = pkgs.nixVersions.latest;
    settings = {
      auto-optimise-store = true;
      allowed-users = [ "@wheel" ];
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
