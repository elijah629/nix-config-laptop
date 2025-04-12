{ ... }:
{
  programs.git = {
    enable = true;
    delta.enable = true;
    extraConfig = {
      user = {
        name = "Elijah629";
        email = "62805599+elijah629@users.noreply.github.com";
      };

      credential.helper = "store";
    };
  };
}
