{ inputs, ... }:
let
  localModels = import ../../lib/local-models.nix;
  herdrIntegrationAssets = "${inputs.herdr}/src/integration/assets/opencode";
in
{
  # herdr reads its TUI plugin entry only from tui.jsonc and matches it
  # literally, so catppuccin's tui.json is disabled and its theme set there.
  catppuccin.opencode.enable = false;

  programs.opencode = {
    enable = true;
    settings = {
      autoupdate = false;
      share = "disabled";
      model = "ollama/${localModels.default}";
      small_model = "ollama/${localModels.small}";
      provider.ollama = {
        npm = "@ai-sdk/openai-compatible";
        name = "Ollama (local)";
        options.baseURL = "http://127.0.0.1:11434/v1";
        models = {
          ${localModels.default} = {
            name = localModels.default;
          };
          ${localModels.small} = {
            name = localModels.small;
          };
        };
      };
    };
  };

  xdg.configFile = {
    "opencode/plugins/herdr-agent-state.js".source = "${herdrIntegrationAssets}/herdr-agent-state.js";
    "opencode/herdr-tui-session.js".source = "${herdrIntegrationAssets}/herdr-tui-session.js";
    "opencode/tui.jsonc".text = builtins.toJSON {
      theme = "catppuccin";
      plugin = [ "./herdr-tui-session.js" ];
    };
  };
}
