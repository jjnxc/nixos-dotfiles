{ inputs, pkgs, ... }:
let
  localModels = import ../../lib/local-models.nix;
in
{
  environment.systemPackages = [
    inputs.herdr.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  services.ollama = {
    loadModels = [
      localModels.default
      localModels.small
    ];

    environmentVariables = {
      # Ollama's small default context breaks agent tool use.
      OLLAMA_CONTEXT_LENGTH = toString localModels.contextLength;
      OLLAMA_FLASH_ATTENTION = "1";
      OLLAMA_KV_CACHE_TYPE = "q8_0"; # halves KV-cache VRAM
      # Auto would allow 3 resident models, which overcommits 8 GB.
      OLLAMA_MAX_LOADED_MODELS = "2";
    };
  };
}
