{ pkgs, ... }:
{
  hardware.graphics = {
    enable32Bit = true;
    enable = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
    ];
  };
}
