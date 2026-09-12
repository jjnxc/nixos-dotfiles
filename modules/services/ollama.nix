{ pkgs, ... }:

{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
  };

  # Localhost only: Open WebUI makes the first account to sign up the admin,
  # so on the LAN anyone could claim it first.
  services.open-webui = {
    enable = true;
    host = "127.0.0.1";
    port = 8080;
  };
}
