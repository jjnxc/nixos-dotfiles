{ pkgs, ... }:
{
  imports = [
    ./programs/git.nix
    # ./programs/foot.nix
    ./programs/zsh.nix
    ./programs/direnv.nix
    ./programs/kitty.nix
    ./programs/starship.nix
    ./programs/yazi.nix
    ./programs/dunst.nix
    ./programs/neovim.nix
    ./desktop/dconf.nix
    ./desktop/portals.nix
    ./desktop/dotfiles.nix
  ];

  home = {
    username = "jinx";
    homeDirectory = "/home/jinx";
    stateVersion = "26.05";
    packages = import ./packages { inherit pkgs; };
    file."Pictures/Screenshots/.keep".text = "";
    file."Pictures/Wallpapers/drawn.jpg".source = ./assets/wallpapers/drawn.jpg;
  };

  catppuccin = {
    enable = true;
    flavor = "mocha";
  };
}
