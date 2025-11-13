{ pkgs, self, config, ... }:

{
  # General Config
  # --------------
  system.primaryUser = "matmarsh";
  nix.settings.experimental-features = "nix-command flakes";        # Necessary for using flakes on this system.
  nixpkgs.hostPlatform = "aarch64-darwin";      # The platform the configuration will be used on.
  system.configurationRevision = self.rev or self.dirtyRev or null;     # Set Git commit hash for darwin-version.
  system.stateVersion = 6;     # Used for backwards compatibility, please read the changelog before changing.   # $ darwin-rebuild changelog

  # Security
  # --------
  security.pam.services.sudo_local.touchIdAuth = true;   # Enable Touch ID for sudo

  # System Packages
  # https://search.nixos.org/packages?channel=unstable
  # ---------------
  environment.systemPackages = with pkgs; [
     bat # replaces cat with prettier styling
     fzf # fuzzy search
     jq # to search json files through commandline
     micro # easier to use nano
     neofetch # system info
     pay-respects # fix typos quickly / update of thefuck
     tree # see folder structure
     wget #...wget
     zoxide # to quickly jump to directories -replaces cd
    ];

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap"; # <-- uncommment when setting up a new system, deletes anything installed manually, i.e. not declared in this file
    };

    brews = [
      "antidote"
      "FelixKratz/formulae/borders"
      "chezmoi" # <-- dot file manager
      "gawk" # <-- needed for antidote zsh plugin manager
      "gh" # <-- github auth helper
      "koekeishiya/formulae/skhd"
      "mas"
    ];

    casks 
    = [
     "nikitabobko/tap/aerospace"
     "alt-tab"
     "mocki-toki/formulae/barik"
     "bluesnooze"
     "clop" # <-- macos image clipboard compression
     "ghostty"
     "hammerspoon"
     "jordanbaird-ice"
     "mac-mouse-fix@2" # @2 to keep it to version 2.2.5 which is free
     "notunes"
     "obsidian"
     "pearcleaner"
     "raycast"
     "rectangle"
     "rocket"
     "shortcat"
     "shottr"
     "spotify"
     "sublime-text"
     "zen"
    ];

  taps = [
    "FelixKratz/formulae"
    "koekeishiya/formulae"
    "mocki-toki/formulae"
    "nikitabobko/tap"
  ];

    masApps = {
     Amphetamine = 937984704;
    };

  };

  programs.zsh = {
    enable = true;
    promptInit = ''
    if [[ "$TERM_PROGRAM" == "vscode" || "$TERM_PROGRAM" == "kiro" ]]; then
      # skips all custom prompts
    else
      # this act as your ~/.zshrc but for all users (/etc/zshrc)

      # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
      # Initialization code that may require console input (password prompts, [y/n]
      # confirmations, etc.) must go above this block; everything else may go below.
      # double single quotes to escape the dollar char

      eval "$(/opt/homebrew/bin/brew shellenv)"

      if [[ -r "''${XDG_CACHE_HOME:-''$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-''$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      # Lazy-load antidote and generate the static load file only when needed
      zsh_plugins=$HOME/.zsh_plugins
      if [[ ! ''${zsh_plugins}.zsh -nt ''${zsh_plugins}.txt ]]; then
        (
          source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
          antidote bundle <''${zsh_plugins}.txt >''${zsh_plugins}.zsh
        )
      fi

      # source plugins established by antidote's zsh_plugins.txt file
      source ''${zsh_plugins}.zsh

      # remove duplicates from up arrow autocomplete history
      setopt HIST_FIND_NO_DUPS

      # zsh settings
      # ZSH_AUTOSUGGEST_STRATEGY=(history completion)
      # ZSH_AUTOSUGGESTION_HISTORY_IGNORE="man *"

      #p10k config
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

      # pay respects -the updated thefuck
      eval "$(${pkgs.pay-respects}/bin/pay-respects zsh --alias)"

      # Zoxide
      eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"

      # setup micro as default editor
      export EDITOR="micro"

    # Aliases
      alias rebuild="sudo darwin-rebuild switch --flake ~/.config/nix-darwin/.#work-laptop"
      alias cd=z
      alias cat=bat
      alias sublime=subl
      alias cz=chezmoi

    # end vscode block 
    fi

    # backwards word delete, option backspace
    bindkey '^[[3;3~' kill-word

    # mapping fn+backspace to delete word in front of cursor
    bindkey "^[[3~" delete-char
    '';
  };

  # System defaults
  system.defaults = {
    dock = {
      autohide = true;
      autohide-delay = 0.0;
      orientation = "bottom";
      showAppExposeGestureEnabled = true;
      show-recents = false;
      wvous-tl-corner = 4;  # hot corner top left = desktop
      wvous-tr-corner = 4;  # hot corner top right = desktop
      wvous-bl-corner = 3;  # hot corner bottom left = application window
      wvous-br-corner = 2;  # hot corner bottom right = mission control
     # static-only = true;
     # tilesize = 32;
    };

    finder = {
      ShowPathbar = true;
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "Nlsv";
      FXRemoveOldTrashItems = true; # remove items in trash after 30 days
      ShowStatusBar = true;
    };

    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark"; # To set to light mode, set this to null and you’ll need to manually run defaults delete -g AppleInterfaceStyle. This option requires logging out and logging back in to apply.
      "com.apple.trackpad.forceClick" = false;
      "com.apple.trackpad.scaling" = 1.4;
    };
    trackpad = {
      #ActuationStrength = 0; # <--- this setting seems to be gone in newer macos versions
      Clicking = true;
      FirstClickThreshold = 0;
      ForceSuppressed = true;
      TrackpadThreeFingerTapGesture = 0;
    };
    WindowManager = {
      EnableStandardClickToShowDesktop = false;
    };
  };
}
