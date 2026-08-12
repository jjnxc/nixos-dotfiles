{ ... }:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      preview = {
        image_filter = "kitty";
      };
    };
  };
}
