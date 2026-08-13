{
  programs.git = {
    enable = true;
    settings = {
      init = {
        defaultBranch = "main";
      };
      user = {
        name = "jjn";
        email = "jinx@local.dev";
      };
    };
    ignores = [
      ".envrc"
      ".direnv/"
    ];
  };
}
