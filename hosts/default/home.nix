{ config, pkgs, ... }:

{

nixpkgs.config.allowUnfree = true;
 # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "neo";
  home.homeDirectory = "/home/neo";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.
# The home.packages option allows you to install Nix packages into your
  # environment.
# home.nix

  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    riseup-vpn
    jq
    ddgr
    goose
    sqlc
    cloudflare-warp
    simplescreenrecorder
    yt-dlp
    kdePackages.francis
    gnome-solanum
    bat
    ripgrep
    fzf
    p7zip
    tldr
    zoxide
    tmux
    fish
    btop
    tree
    telegram-desktop
    starship
    go
    nodejs_20
    ghostty
    lazygit
    deno
    rustc
    libGL
    mesa
    xorg.libXi
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXinerama
    wayland
    libxkbcommon
    pnpm_10
    yarn
    spotify
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/neo/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };


  programs.home-manager.enable = true;



  programs.ssh = {
    enable = true;
    # extraConfig = ''
    #   Host github.com
    #     HostName ssh.github.com
    #     Port 443
    #     User git
    #     IdentityFile ~/.ssh/github_id_ed25519
    #     IdentitiesOnly yes
    #
    #   Host awura.tech
    #     HostName git.awura.tech
    #     Port 443
    #     User git
    #     IdentityFile ~/.ssh/awura_gitlab_id_ed25519
    #     IdentitiesOnly yes
    #   Host 91.99.186.71
    #     Port 22
    #     User root
    #     IdentityFile ~/.ssh/awura_gitlab_id_ed25519
    #     IdentitiesOnly yes
    # '';
    matchBlocks = {
    "github.com" = {
      hostname = "ssh.github.com";
      port = 443;
      user = "git";
      identityFile = "~/.ssh/github_id_ed25519";
      identitiesOnly = true;
    };
    "gitlab.com" = {
      hostname = "ssh.gitlab.com";
      port = 443;
      user = "git";
      identityFile = "~/.ssh/gitlab_id_ed25519";
      identitiesOnly = true;
    };
    "git.awura.tech awura.tech" = {
      hostname = "git.awura.tech";
      port = 22;
      user = "git";
      identityFile = "~/.ssh/awura_gitlab_id_ed25519";
      identitiesOnly = true;
    };
    "awura-vps" = { # You can use an alias here!
      hostname = "91.99.186.71"; 
      port = 22;
      user = "root";
      identityFile = "~/.ssh/awura_gitlab_id_ed25519"; # Reusing the same key
      identitiesOnly = true;
    };
  };
  };

  # programs.keychain = {
  #   enable = true;
  #   keys = [ "github_id_ed25519" ];
  #   agents = [ "ssh" ];
  #   enableBashIntegration = true;
  # };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita-dark";
    };
  };

}
