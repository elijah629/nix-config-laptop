{ pkgs, ... }:
{
  programs = {
    nushell = {
      enable = true;
      configFile.source = ./config.nu;
    };
    # carapace.enable = true;
    # carapace.enableNushellIntegration = true;

    starship = {
      enable = true;

      settings = pkgs.lib.importTOML ./starship.toml;
    };
  };
}
