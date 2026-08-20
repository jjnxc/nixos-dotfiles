{
  programs.nh = {
    enable = true;
    flake = "/home/jinx/nixos-dotfiles";
    clean = {
      enable = true;
      extraArgs = "--keep-since 14d --keep 5";
    };
  };
}
