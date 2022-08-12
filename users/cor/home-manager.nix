{ config, lib, pkgs, ... }:

{
  xdg.enable = true;

  #---------------------------------------------------------------------
  # Packages
  #---------------------------------------------------------------------

  # Packages I always want installed. Most packages I install using
  # per-project flakes sourced with direnv and nix-shell, so this is
  # not a huge list.
  home.packages = with pkgs; [
    # pkgs.bat
    fd
    firefox
    fzf
    htop
    jq
    ripgrep
    rofi
    tree
    watch
    kitty
    openssh
    feh
    zip
    curl
    pamixer
    wget
    git
    scrot
    git-lfs
    coreutils-full
    binutils
    gnome3.gnome-control-center
    xclip
    gtkmm3 # needed for the vmware user tools clipboard
    neofetch
    pinentry
    pinentry-curses
    pick-colour-picker
    (writeShellScriptBin "feh-bg-fill" ''
      feh --bg-fill /home/cor/.background-image
    '')
    (writeShellScriptBin "xr-mbp" ''
      xrandr --newmode "3024x1890_60.00"  488.50  3024 3264 3592 4160  1890 1893 1899 1958 -hsync +vsync
      xrandr --addmode Virtual-1 3024x1890_60.00
      xrandr -s 3024x1890_60.00
      polybar-msg cmd restart
      feh-bg-fill
    '')
    (writeShellScriptBin "xr-mbp-1.5" ''
      xrandr --newmode "4536x2835_60.00"  1111.25  4536 4928 5424 6312  2835 2838 2848 2935 -hsync +vsync
      xrandr --addmode Virtual-1 4536x2835_60.00
      xrandr -s 4536x2835_60.00
      polybar-msg cmd restart
      feh-bg-fill
    '')
    (writeShellScriptBin "xr-uw" ''
      xrandr --newmode "6600x2880_60.00"  1644.25  6600 7168 7896 9192  2880 2883 2893 2982 -hsync +vsync
      xrandr --addmode Virtual-1 6600x2880_60.00
      xrandr -s 6600x2880_60.00
      polybar-msg cmd restart
      feh-bg-fill
    '')
    (writeShellScriptBin "xr-5120" ''
      xrandr --newmode "5120x2880_60.00"  1275.49  5120 5560 6128 7136  2880 2881 2884 2979  -hsync +vsync
      xrandr --addmode Virtual-1 5120x2880_60.00
      xrandr -s 5120x2880_60.00
      polybar-msg cmd restart
      feh-bg-fill
    '')
    (writeShellScriptBin "xr-3840" ''
      xrandr --newmode "3840x2160_60.00"  712.75  3840 4160 4576 5312  2160 2163 2168 2237 -hsync +vsync
      xrandr --addmode Virtual-1 3840x2160_60.00
      xrandr -s 3840x2160_60.00
      polybar-msg cmd restart
      feh-bg-fill
    '')
    (writeShellScriptBin "xr-5760" ''
      xrandr --newmode "5760x3240_60.00"  1619.25  5760 6264 6904 8048  3240 3243 3248 3354 -hsync +vsync
      xrandr --addmode Virtual-1 5760x3240_60.00
      xrandr -s 5760x3240_60.00
      polybar-msg cmd restart
      feh-bg-fill
    '')    
    (writeShellScriptBin "xr-6400" ''
      xrandr --newmode "6400x3600_60.00"  2003.00  6400 6968 7680 8960  3600 3603 3608 3726 -hsync +vsync
      xrandr --addmode Virtual-1 6400x3600_60.00
      xrandr -s 6400x3600_60.00
      polybar-msg cmd restart
      feh-bg-fill
    '')
    (writeShellScriptBin "reload-config" ''
       sudo NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1 nixos-rebuild switch --flake \"/nix-config#vm-aarch64-prl\" \
    '')
    # pkgs.zathura
    # pkgs._1password
  ];


  home.file.".background-image".source = ../../wallpapers/purple.png;

  #---------------------------------------------------------------------
  # Env vars and dotfiles
  #---------------------------------------------------------------------

  # home.sessionVariables = {
  #   LANG = "en_US.UTF-8";
  #   LC_CTYPE = "en_US.UTF-8";
  #   LC_ALL = "en_US.UTF-8";
  #   EDITOR = "nvim";
  #   PAGER = "less -FirSwX";
  #   MANPAGER = "sh -c 'col -bx | ${pkgs.bat}/bin/bat -l man -p'";
  # };

  # home.file.".gdbinit".source = ./gdbinit;
  # home.file.".inputrc".source = ./inputrc;

  # xdg.configFile."i3/config".text = builtins.readFile ./i3;
  xdg.configFile."rofi/config.rasi".text = builtins.readFile ./rofi;
  # xdg.configFile."devtty/config".text = builtins.readFile ./devtty;

  #---------------------------------------------------------------------
  # Programs
  #---------------------------------------------------------------------

  # programs.bash = {
  #   enable = true;
  #   shellOptions = [];
  #   historyControl = [ "ignoredups" "ignorespace" ];
  #   # initExtra = builtins.readFile ./bashrc;
  # };

  programs.direnv = {
    enable = true;

    # config = {
    #   whitelist = {
    #     prefix= [
    #       "$HOME/code/go/src/github.com/hashicorp"
    #       "$HOME/code/go/src/github.com/mitchellh"
    #     ];

    #     exact = ["$HOME/.envrc"];
    #   };
    # };
  };

  programs.git = {
    enable = true;
    userName = "cor";
    userEmail = "cor@pruijs.dev";
    lfs.enable = true;
    signing = {
      signByDefault = true;
      key = "06A6337C2BDD1365883C0668DB347466107E589F";
    };
    extraConfig = {
      # branch.autosetuprebase = "always";
      color.ui = true;
      # core.askPass = ""; # needs to be empty to use terminal for ask pass
      # credential.helper = "store"; # want to make this more secure
      github.user = "cor";
      # push.default = "tracking";
      # init.defaultBranch = "main";
    };
  };

  programs.zsh = {
    enable = true;
    prezto = {
      enable = true;
      pmodules = [
        "git"
        "environment"
        "terminal"
        "editor"
        "history"
        "directory"
        "spectrum"
        "utility"
        "completion"
        "syntax-highlighting"
        "history-substring-search"
        "prompt"
      ];
    };
    shellAliases = {
      fzf-nix = "nix-env -qa | fzf";
    };
    # initExtra = ''
    # if [ -n "''${commands[fzf-share]}" ]; then
    #   source "''$(fzf-share)/key-bindings.zsh"
    #   source "''$(fzf-share)/completion.zsh"
    # fi
    # '';
  };

  programs.gpg = {
    enable = true;
    settings = {
      default-key = "06A6337C2BDD1365883C0668DB347466107E589F";
    };
  };

  programs.rofi = {
    enable = true;
    terminal = "${pkgs.kitty}/bin/kitty";
    # theme = /etc/nixos/rofi/theme.rafi;
    # plugins = [ pkgs.rofi-emoji ];
  };

  programs.kitty = {
    enable = true;
    extraConfig = builtins.readFile ./kitty.conf;
  };


  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "tty";

    # cache the keys forever so we don't get asked for a password
    defaultCacheTtl = 31536000;
    maxCacheTtl = 31536000;
  };

  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      mpdSupport = true;
      pulseSupport = true;
    };
    config = ./polybar.ini;
    script = ''
      polybar main &
    '';
  };


  xresources.extraConfig = builtins.readFile ./Xresources;

  # Make cursor not tiny on HiDPI screens
  home.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 128;
    x11.enable = true;
  };
}