{ config, pkgs, ... }:

{
  # macos.nix is composed by flake.nix's module list, so it is NOT imported here.
  # This is the personal mac mini overlay: hostname + photography stack + its own masApps.

  networking.hostName = "mac-mini";

  # homebrew.enable + onActivation (autoUpdate/upgrade/cleanup) are set in macos.nix.
  # nix merges these list-valued options across modules, so we only add mac-mini-specific
  # brews/casks/masApps here. cmux + the nerd font live in the shared macos.nix.
  homebrew = {
    casks = [
      # --- Adobe photography stack ---
      # There is NO Homebrew (or Nix) package for Photoshop or Lightroom Classic on their own.
      # Adobe only ships those through the Creative Cloud desktop app as subscription installs.
      # This cask installs the CC *launcher*; the individual apps are a one-time manual step:
      #   1. Rebuild, then open "Creative Cloud" from /Applications.
      #   2. Sign in with your Adobe ID (needs an active Photography or full CC plan).
      #   3. Inside CC, install "Lightroom Classic" and "Photoshop".
      # Those installed apps are NOT brew- or mas-managed, so homebrew.onActivation.cleanup
      # ("uninstall") will NOT touch them on rebuild — only this launcher cask is managed.
      "adobe-creative-cloud"

      # Free RAW -> DNG converter (standalone cask, unlike LrC/Ps). Handy for camera imports.
      "adobe-dng-converter"
    ];

    # Because `mas` is declared in macos.nix and cleanup = "uninstall", every rebuild removes
    # any Mac App Store app NOT listed here (mas enumerates all installed App Store apps). Add
    # this machine's App Store apps below, or they get deleted on the next rebuild.
    # See macos.nix / work-laptop.nix cleanup notes.
    masApps = {
      # Amphetamine is declared in the shared macos.nix, so no need to repeat it here.
      # Add mac-mini App Store apps as you install them, e.g.:
      # Pixelmator = 1289583905;
    };
  };
}
