{ pkgs, ... }:

{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
    loadModels = [ "qwen3:8b" "qwen3.5:4b" "qwen2.5:1.5b" ];
  };

  services.open-webui = {
    enable = true;
    host = "0.0.0.0";
    port = 8080;
  };

  networking.firewall.allowedTCPPorts = [ 8080 ];
}
