{
  pkgs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./boot.nix
    ./networking.nix
    ./nix.nix
    ./i18n.nix
    ./users.nix
    ../catppuccin
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  nixpkgs.config.allowUnfree = true;

  home-manager.backupFileExtension = "backup";

  programs.dconf.enable = true;
  programs.zsh.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    # baobab      # disk usage analyzer
    cheese # photo booth
    eog # image viewer
    epiphany # web browser
    gedit # text editor
    simple-scan # document scanner
    totem # video player
    yelp # help viewer
    evince # document viewer
    # file-roller # archive manager
    geary # email client
    seahorse # password manager

    # these should be self explanatory
    gnome-calculator
    gnome-calendar
    gnome-characters
    gnome-clocks
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    gnome-photos
    gnome-screenshot
    gnome-system-monitor
    gnome-weather
    # gnome-disk-utility
    gnome-connections
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
  ];

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    zsh
    git
    efibootmgr
    gcc
    (
      let
        base = pkgs.appimageTools.defaultFhsEnvArgs;
      in
      pkgs.buildFHSEnv (
        base
        // {
          name = "fhs";
          targetPkgs =
            pkgs:
            # pkgs.appimageTools provides basic packages required by most software.
            base.targetPkgs pkgs;
          profile = "export FHS=1";
          runScript = "zsh";
          extraOutputsToInstall = [ "dev" ];
        }
      )
    )
  ];

  system.stateVersion = "24.05";
}
