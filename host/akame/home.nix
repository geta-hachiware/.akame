{ config, pkgs, pkgs-stable, username, lib, inputs, system, theme, ... }:

{ 
  colorScheme = inputs.nix-colors.colorSchemes."${theme}";

  imports = [
    inputs.nix-colors.homeManagerModules.default
    inputs.nixcord.homeModules.nixcord
    inputs.textfox.homeManagerModules.default
    ../../modules/home-manager/shell/zsh.nix
    ../../modules/home-manager/desktop/hyprland/default.nix
    ../../modules/home-manager/desktop/waybar/default.nix
    ../../modules/home-manager/rofi/default.nix
    ../../modules/home-manager/programs/bundle.nix
    ../../modules/home-manager/pywal/pywal.nix
    ../../modules/home-manager/fastfetch/fastfetch.nix
  ];
  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.05"; # Please read the comment before changing.
    
    packages = (with pkgs; [
      inputs.nixvim.packages.${system}.default
      #cli
      cmatrix
      btop
      #neovim

      #audio
      playerctl
      pamixer
      alsa-utils
      pavucontrol

      #img
      swww
      imagemagick
      imv

      #code
      python3
      blender

      #editor

      #screenshot
      slurp
      grimblast
      grim
      swappy

      #office
      libreoffice-qt6-fresh

      #drawing
      krita

      #clipboard
      cliphist
      wl-clipboard

      #notif
      swaynotificationcenter
      libnotify

      #other
      wlogout
      hyprlock
      hypridle
      nwg-look
      xdg-user-dirs
      jq
    ]) 

    ++

    (with pkgs-stable; [

    ]);

    file = {
      ".config/wal/templates".source = ../../modules/home-manager/pywal/template;
      ".config/waybar/style.css".source = ../../modules/home-manager/desktop/waybar/style.css; #waybar style css
      ".config/hypr/hyprlock.conf".source = ../../modules/home-manager/desktop/hyprland/hyprlock.conf;
      ".config/hypr/hypridle.conf".source = ../../modules/home-manager/desktop/hyprland/hypridle.conf;
      ".config/swaync/icons".source = ../../modules/home-manager/desktop/swaync/icons;
      ".config/swaync/config.json".source = ../../modules/home-manager/desktop/swaync/config.json;
      ".config/swaync/style.css".source = ../../modules/home-manager/desktop/swaync/style.css;
      ".config/swaync/themes".source = ../../modules/home-manager/desktop/swaync/themes;
      ".config/wlogout/icons".source = ../../modules/home-manager/desktop/wlogout/icons;
      ".config/wlogout/layout".source = ../../modules/home-manager/desktop/wlogout/layout;
      ".config/wlogout/nova.css".source = ../../modules/home-manager/desktop/wlogout/nova.css;
      ".config/hypr/scripts/screenshot.sh".source = ../../modules/home-manager/desktop/hyprland/scripts/screenshot.sh;
      ".config/hypr/scripts/screenshot.sh".executable = true;
    };

    sessionPath = [
      "$HOME/.config/hypr/scripts"
    ];

    sessionVariables = {
    # EDITOR = "emacs";
    };
  };

  nixpkgs.config.allowUnfree = true;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
