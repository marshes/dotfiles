{ config, pkgs, ... }:

{
  imports = [ ./macos.nix ];
  
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
      "python3"
      "rbenv"
      "shellcheck"
      "uv"
    ];

    casks 
    = [
     #"claude-code" #replacing with native install from anthropic
     "cmux"
     "font-meslo-lg-nerd-font"
     "iterm2"
     #"qlmarkdown"
	 "xykong/tap/flux-markdown"
     "markedit"
    ];

    taps = [
    "manaflow-ai/cmux" #cmux
    ];

    masApps = {
     WireGuard = 1451685025;
    };

  };
}
