{ config, pkgs, pkgs-stable, ... }:
{
  environment.systemPackages = (with pkgs; [
    #cli
    nano
    git
    vim

    #network
    wireplumber
    iproute2
    wirelesstools
    iputils
    networkmanagerapplet

    #other
    qt6.qtsvg
    qt6.qtvirtualkeyboard
    qt6.qtmultimedia
  ])

  ++

  (with pkgs-stable; [
    #imgs
    ffmpeg 
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
