_: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "elijah629";
        email = "62805599+elijah629@users.noreply.github.com";
      };

      init.defaultBranch = "main";

      credential.helper = "store";
    };
  };

  programs.delta.enable = true;
}
