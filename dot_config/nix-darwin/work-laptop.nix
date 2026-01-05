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
      "lazygit"
      "node"
      "uv"
    ];

    casks 
    = [
     "claude-code"
     "qlmarkdown"
    ];

    taps = [
    #"acsandmann/tap" #placeholder
    ];
  };
}
