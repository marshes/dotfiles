{ config, pkgs, ... }:

{
  # macos.nix is composed by flake.nix's module list, so it is NOT imported here.

  networking.hostName = "work-laptop";
  
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap"; # <-- uncommment when setting up a new system, deletes anything installed manually, i.e. not declared in this file
    };

    brews = [
      "git-lfs"
      "lazygit"
      "node"
      "pandoc"
      "python3"
      "rbenv"
      "shellcheck"
      "uv"
    ];

    casks 
    = [
     #"claude-code" #replacing with native install from anthropic
     "cmux"
     #"sbx@0.25.0"
     "font-meslo-lg-nerd-font"
     "qlmarkdown"
     "markedit"
     "notunes"
    ];

    taps = [
    #"docker/tap" #needed for sbx
    "manaflow-ai/cmux" #cmux
    ];

    masApps = {
     WireGuard = 1451685025;
    };

  };
}
