{ config, pkgs, ... }:

{
  # macos.nix is composed by flake.nix's module list, so it is NOT imported here.

  networking.hostName = "work-laptop";
  
  # homebrew.enable + onActivation (autoUpdate/upgrade/cleanup) are set in macos.nix.
  # nix merges these list-valued options across modules, so we only add work-specific
  # brews/casks/taps/masApps here.
  homebrew = {
    brews = [
      "git-filter-repo" # split monorepo into per-surface packages w/ history preserved
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
     # Declared so homebrew.onActivation.cleanup = "zap" stops targeting them: with `mas`
     # present, zap enumerates ALL App Store apps and removes any not listed here. These two
     # are installed on this machine and were being deleted on every rebuild (Xcode survived
     # only because SIP blocked the removal). See macos.nix cleanup note.
     Xcode = 497799835;
     Gifski = 1351639930;
    };

  };
}
