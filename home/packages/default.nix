{ pkgs, ... }:
(import ./core.nix { inherit pkgs; })
++ (import ./desktop.nix { inherit pkgs; })
++ (import ./gaming.nix { inherit pkgs; })
