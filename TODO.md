#Cleanup roadmap

1. Clean flake.nix
 * make inputs prettieradd
 * add specialArgs
 * maybe support multiple hosts
2. Clean configuration.nix
 * make it only host-specific things
3. Create proper module files
 * system/nix.nix
 * system/users.nix
 * hardware/nvidia.nix
 * desktop/hyprland.nix
 * etc.
4. Clean Home Manager
 * split packages
 * split programs
 * move dotfiles correctly
5. Add quality-of-life stuff
 * formatter
 * rebuild script
 * README
 * maybe justfile or Makefile
