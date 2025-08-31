{ config, pkgs, pkgs-stable, username, lib, inputs, system, theme, ... }:

{ 
  colorScheme = inputs.nix-colors.colorSchemes."${theme}";

  imports = [
    inputs.nix-colors.homeManagerModules.default
    inputs.nixcord.homeModules.nixcord
    inputs.spicetify-nix.homeManagerModules.spicetify
    inputs.nixvim.homeManagerModules.nixvim
    ../modules/home-manager/shell/zsh.nix
    ../modules/home-manager/programs/bundle.nix
    ../modules/home-manager/hyprland/hyprland.nix
    ../modules/home-manager/waybar/default.nix
    ../modules/home-manager/rofi/default.nix
    ../modules/home-manager/pywal/pywal.nix
    ../modules/home-manager/fastfetch/fastfetch.nix
    ../modules/home-manager/nixvim/nixvim.nix
  ];
  
  home = {
    username = username;
    homeDirectory = "/home/"+username;
    stateVersion = "25.05"; # Please read the comment before changing.
    
    packages = (with pkgs; [
      #cli
      cmatrix

      #audio
      playerctl
      pamixer
      alsa-utils
      pavucontrol
      
      #clipboard
      cliphist
      wl-clipboard
      
      #screenshot
      slurp
      grimblast
      grim
      swappy

      #notif
      swaynotificationcenter
      libnotify
      
      #img
      swww
      imagemagick
      imv
      
      #hyprland
      hyprlock
      hypridle
      
      #other
      wlogout
      nwg-look
      jq
    ]) 

    ++

    (with pkgs-stable; [
      #drawing
      
    ]);

    file = {
      ".config/wal/templates".source = ../modules/home-manager/pywal/template;
      ".config/waybar/style.css".source = ../modules/home-manager/waybar/style.css; #waybar style css
      ".config/hypr/hyprlock.conf".source = ../modules/home-manager/hyprland/hyprlock.conf;
      ".config/hypr/hypridle.conf".source = ../modules/home-manager/hyprland/hypridle.conf;

      ".config/swaync/icons".source = ../modules/home-manager/swaync/icons;
      ".config/swaync/config.json".source = ../modules/home-manager/swaync/config.json;
      ".config/swaync/style.css".source = ../modules/home-manager/swaync/style.css;
      ".config/swaync/themes".source = ../modules/home-manager/swaync/themes;
      ".config/wlogout/icons".source = ../modules/home-manager/wlogout/icons;
      ".config/wlogout/layout".source = ../modules/home-manager/wlogout/layout;
      ".config/wlogout/nova.css".source = ../modules/home-manager/wlogout/nova.css;

      ".config/hypr/scripts/screenshot.sh".source = ../modules/home-manager/hyprland/scripts/screenshot.sh;
      ".config/hypr/scripts/screenshot.sh".executable = true;
    };

    sessionPath = [
      "$HOME/.config/hypr/scripts"
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      TERMINAL = "kitty";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
