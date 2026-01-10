{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ../modules/git
    ../modules/nushell
    ../modules/librewolf
    ../modules/gh
    ../modules/catppuccin
    ../modules/spotify
    { _module.args = { inherit inputs; }; }
  ];

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  gtk.enable = true;

  home.packages = with pkgs; [
    vlc
    yt-dlp

    nodejs
    catppuccin

    legcord
    qFlipper

    markdownlint-cli2 # Markdown LSP
    marksman

    inputs.toucanvim.packages.${system}.default
  ];

  fonts.fontconfig.enable = true;

  home.stateVersion = "24.05";
}
