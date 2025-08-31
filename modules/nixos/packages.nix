{ config, pkgs, pkgs-stable, ... }:
{
  environment.systemPackages = (with pkgs; [
    #cli
    git
    vim
    tree

    #format
    nixfmt-rfc-style

    #imgs
    ffmpeg

    #editor
    shotcut

    #network
    networkmanagerapplet
  ])

  ++

  (with pkgs-stable; [
    #imgs 
  ]);

  services.flatpak.enable = true;

  # Fonts system
  fonts.fontDir.enable = true;
  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.lekton
      nerd-fonts.comic-shanns-mono
      nerd-fonts.shure-tech-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      noto-fonts-color-emoji
      dejavu_fonts
      corefonts
      material-icons
      font-awesome
      fira-code-symbols
    ];

    fontconfig = {
      defaultFonts = {
        serif = ["Lekton Nerd Font"];
        sansSerif = ["Lekton Nerd Font"];
        monospace = ["Lekton Nerd Font Mono"];
      };
    };
  };
}
