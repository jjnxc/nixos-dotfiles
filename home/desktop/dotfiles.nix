{ config, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/home/config";

  configs = {
    hypr = "hypr";
  };
in
{
  xdg.configFile = builtins.mapAttrs (_: subpath: {
    source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;
}
