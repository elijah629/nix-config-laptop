_: {
  programs.git = {
    enable = true;
    delta.enable = true;
    extraConfig = {
      user = {
        name = "elijah629";
        email = "62805599+elijah629@users.noreply.github.com";
      };

      init.defaultBranch = "main";

      credential.helper = "store";
    };
  };
}
