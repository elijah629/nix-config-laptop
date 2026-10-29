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
    # ../modules/spotify
    { _module.args = { inherit inputs; }; }
  ];

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  gtk.enable = true;

  home.packages = with pkgs; [
    orca-slicer
    (
      let
        pname = "bambu-studio";
        version = "02.08.02.61";
        src = fetchurl {
          url = "https://github.com/bambulab/BambuStudio/releases/download/v${version}/BambuStudio_ubuntu24.04-v${version}-20260820225108.AppImage";
          hash = "sha256-1QGxA/rFQkUT7A6Na8FF+zBxneLH2U1zINcjdAyBp/0=";
        };
        contents = appimageTools.extract { inherit pname version src; };
      in
      appimageTools.wrapType2 {
        inherit pname version src;
        extraPkgs = pkgs: with pkgs; [
          webkitgtk_4_1
          glew
          curl
          gst_all_1.gst-plugins-good
          gst_all_1.gst-plugins-bad
        ];
        profile = ''
          export SSL_CERT_FILE=${cacert}/etc/ssl/certs/ca-bundle.crt
          export CURL_CA_BUNDLE="$SSL_CERT_FILE"
          export WEBKIT_DISABLE_COMPOSITING_MODE=1
          export WEBKIT_DISABLE_DMABUF_RENDERER=1
        '';
        extraInstallCommands = ''
          install -Dm444 ${contents}/BambuStudio.desktop $out/share/applications/BambuStudio.desktop
          substituteInPlace $out/share/applications/BambuStudio.desktop \
            --replace-fail "Exec=AppRun" "Exec=bambu-studio"
          install -Dm444 ${contents}/BambuStudio.png $out/share/icons/hicolor/192x192/apps/BambuStudio.png
        '';
        meta.mainProgram = "bambu-studio";
      }
    )

    zoom-us

    wireguard-tools
    protonvpn-gui

    inputs.chatgpt.packages.${pkgs.stdenv.hostPlatform.system}.codex-desktop

    btop

    unzip

    vlc
    moonlight-qt
    yt-dlp

    bun

    nodejs

    legcord
    qFlipper

    markdownlint-cli2 # Markdown LSP
    marksman

    inputs.toucanvim.packages.${pkgs.stdenv.hostPlatform.system}.default

    prismlauncher

    inputs.finamp-flake.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  fonts.fontconfig.enable = true;

  home.stateVersion = "24.05";
}
