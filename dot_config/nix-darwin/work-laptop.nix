{ config, pkgs, ... }:

{
  imports = [ ./macos.nix ];
  
  networking.hostName = "work-laptop";
  
  homebrew.brews = [
    "node"
  ];
  homebrew.cask =[
  	"qlmarkdown"
  ]

}
