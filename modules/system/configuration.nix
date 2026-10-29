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

  programs.helium = {
    enable = true;
    flags = [
      "--ozone-platform-hint=auto"
    ];
  };

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
    # gnome-photos
    gnome-screenshot
    gnome-system-monitor
    gnome-weather
    # gnome-disk-utility
    gnome-connections
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
  ];

  services.tailscale.enable = true;

  services.udev.packages = [
    (pkgs.writeTextDir "lib/udev/rules.d/50-numworks-calculator.rules" ''
      SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="a291", TAG+="uaccess"
      SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="df11", TAG+="uaccess"
      SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="a51a", TAG+="uaccess"
    '')
  ];

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
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
          runScript = "nu";
          extraOutputsToInstall = [ "dev" ];
        }
      )
    )
  ];

  system.stateVersion = "24.05";
}
