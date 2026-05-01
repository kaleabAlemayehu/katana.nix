# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      inputs.xremap-flake.nixosModules.default
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  # time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.cloudflare-warp = {
    enable = true;
  };

  # enable finger print
  services.fprintd.enable = true;

  # Enable docker
  virtualisation.docker.enable = true;

  # Enable the XFCE Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id == "se.leap.bitmask.policy" ||
          action.id == "org.freedesktop.policykit.exec" && 
          action.lookup("program").indexOf("bitmask-root") !== -1) {
        if (subject.isInGroup("wheel")) {
          return polkit.Result.YES;
        }
      }
    });
  '';
 hardware.graphics.extraPackages = with pkgs; [
    mesa.opencl 
  ];
environment.variables = {
    RUSTICL_ENABLE = "radeonsi";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;

  # adding automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.neo = {
    isNormalUser = true;
    description = "neo";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      neovim
     thunderbird
    ];
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;

  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = {inherit inputs;};
    users = {
     "neo" = import ./home.nix;
    };
  };

  # Dynamic linking
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
    stdenv.cc.cc.lib
    zlib
  ];

  # Install firefox.
  programs.firefox.enable = true;

  # Enable dconf for theme switching
  programs.dconf.enable = true;

  # Enable automatic timezoned  
  services.automatic-timezoned.enable = true;

  # ENABLE CRON for the checkin request
  services.cron = {
    enable= true;
    systemCronJobs = [
      "0 9 * * 1-5 root /home/neo/Documents/projects/go-concurrency-exercises/script.sh IN"
      "0 17 * * 1-5 root /home/neo/Documents/projects/go-concurrency-exercises/script.sh OUT"
    ];
  };

  # Enable AMD GPU drivers
  services.xserver.videoDrivers = [ "amdgpu" ];
  # Enable OpenGL and OpenCL support
  hardware.opengl.enable = true;

  # bluetooth enable
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  # Optional: enable experimental features like battery level monitoring
  # hardware.bluetooth.settings = { General = { Experimental = true; }; };
  # Allow unfree packages
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    mattermost
    # android-studio-full
    ngrok
    wineWowPackages.unstableFull
    obs-studio
    antigravity
    exercism
    cargo
    clinfo
    postman
    efibootmgr
    dbeaver-bin
    uv
    nmap
    kdePackages.okular
    obsidian
    vicinae
    slack
    slack-cli
    code-cursor
    vscode
    coreutils
    libnotify
    rofi-power-menu
    davinci-resolve
    pgadmin4
    valkey
    hugo
    ffmpeg-full
    sqlite
    air
    mise
    trayer
    polkit_gnome
    materia-theme # For DeepOcean-like dark theme
    arc-theme 
    # zeal
    brightnessctl
    pulseaudio    # or pipewire if you're using that
    xorg.xev   # optional, for checking key symbols
    superfile
    feh
    rofi           # app launcher
    picom          # compositor for transparency/shadows
    lxappearance   # theme switcher for GTK
    dunst          # notifications
    i3status       # status bar
    inetutils
    busybox
    openssl
    lsof
    zip
    rlwrap
    minimal-bootstrap.mescc-tools-extra
    mescc-tools-extra
    qimgv
    clipqr
    signal-desktop
    tinygo
    unzipNLS
    stow
    glibcInfo
    lazydocker
    qbittorrent
    toybox
    python3
    safeeyes
    gdb
    evince
    xarchiver
    ntfs3g
    gparted
    gnumake
    haruna
    vlc
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    sl
    google-chrome
    file
    git
    libgccjit
    libgcc
    clang
    gcc
    glibc
    glibc.dev
    # neofetch
    fastfetch
    discord
    wayland
    wayland-protocols
    libxkbcommon
    xorg.libX11
    xorg.libXrandr
    xorg.libXinerama
    xorg.libXcursor
    xorg.libXxf86vm
    mesa
    pkg-config
    copyq
    xclip
    wireshark
home-manager
  ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

   programs.ssh.startAgent = true;
   services.gnome.gcr-ssh-agent.enable = false;

  # enable editor to be vim
  environment.variables = {
    EDITOR = "vim";
    SSH_AUTH_SOCK = "/run/user/1000/ssh-agent";
  };
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
services.xremap = {
  enable = true;
  withHypr = true;
  userName = "neo";
  yamlConfig = ''
    keymap:
      - name: "main remaps"
        remap:
          capslock: esc
          esc: capslock
  '';
};
  
services.xserver.windowManager.i3.enable = true;

 fonts.packages = with pkgs; [
    jetbrains-mono
  ];
}
