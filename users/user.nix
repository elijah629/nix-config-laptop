inputs:
{ pkgs, ... }:

{
  imports = [
    ../modules/git
    ../modules/zsh
    ../modules/librewolf
    ../modules/gh
    ../modules/catppuccin
    (import ../modules/spotify inputs)
  ];

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  gtk.enable = true;
  catppuccin.gtk = {
    gnomeShellTheme = true;
    enable = true;
    icon.enable = true;
    tweaks = [
      "rimless"
    ];
  };

  programs.brave.enable = true;
  home.packages = with pkgs; [
    vesktop
    prismlauncher
    nodejs-slim
    bun
    inputs.nixvim.packages.x86_64-linux.default
  ];

  fonts.fontconfig.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "24.05";
}
