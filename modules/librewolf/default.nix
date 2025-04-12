{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;

    profiles = {
      default = {
        name = "default";
        search = {
          default = "Brave";
          privateDefault = "Brave";

          engines = {
            "Brave" = {
              urls = [
                {
                  template = "https://search.brave.com/search?q={searchTerms}";
                }
              ];
              icon = "https://cdn.search.brave.com/serp/v2/_app/immutable/assets/favicon-32x32.B2iBzfXZ.png";
              definedAliases = [ "@br" ];
            };
          };
          force = true;
        };

        bookmarks = [
          {
            name = "NixOS";
            toolbar = true;
            bookmarks = [
              {
                name = "Appendix A. Home Manager Configuration Options";
                url = "https://nix-community.github.io/home-manager/options.xhtml";
              }
            ];
          }
        ];

        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          proton-pass
          firefox-color
          stylus
          canvasblocker # [1]
        ];

        settings = {
          "extensions.autoDisableScopes" = 0;
          "webgl.disabled" = false; # See [1], WebGL is nice
          "browser.download.lastDir" = "~/Downloads";
        };
      };
    };
  };
}
