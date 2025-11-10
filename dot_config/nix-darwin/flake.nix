{
  description = "nix-darwin system flake for macos 25-10-20";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  {
    darwinConfigurations = {
      # Your existing config - use this for personal machines
      "macos" = nix-darwin.lib.darwinSystem {
        modules = [ ./macos.nix ];
        specialArgs = { inherit self; };
      };
      
      # New work laptop config
      "work-laptop" = nix-darwin.lib.darwinSystem {
        modules = [ 
          ./macos.nix 
          ./work-laptop.nix
        ];
        specialArgs = { inherit self; };
      };
    };
  };
}
