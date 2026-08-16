{
  programs.git = {
    enable = true;
    settings = {
      init = {
        defaultBranch = "main";
      };
      user = {
        name = "jjn";
        email = "295684389+jjnxc@users.noreply.github.com";
      };
    };
    ignores = [
      ".envrc"
      ".direnv/"
    ];
  };
}
