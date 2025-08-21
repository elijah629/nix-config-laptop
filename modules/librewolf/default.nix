{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;

    profiles.default.extensions.force = true;
  };
}
