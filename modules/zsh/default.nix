{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      upgrade = "sudo nix flake update --flake /etc/nixos";
      update = "sudo nixos-rebuild switch --flake /etc/nixos#nixos-laptop";
      config = "cd /etc/nixos; nvim .";
    };
  };

  programs.starship = {
    enable = true;

    settings = pkgs.lib.importTOML ./starship.toml;
  };
}
