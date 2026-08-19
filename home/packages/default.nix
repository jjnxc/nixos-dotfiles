{ pkgs, ... }:
(import ./core.nix { inherit pkgs; })
++ (import ./desktop.nix { inherit pkgs; })
