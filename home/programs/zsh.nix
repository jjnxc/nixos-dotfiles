{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      la = "ls -la";
      edit = "sudo -e";
      update = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#desktop-nvidia";
      collect = "sudo nix-collect-garbage -d";
    };

    history = {
      size = 10000;
      ignoreAllDups = true;
      path = "$HOME/.zsh_history";
      ignorePatterns = [
        "rm *"
        "pkill *"
        "cp *"
      ];
    };

    initContent = ''
      eval "$(starship init zsh)"
    '';
  };
}
