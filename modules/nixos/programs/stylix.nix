{ pkgs, ... }:
{
  stylix = {
    enable = true;
    autoEnable = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    targets = {
      nixos-icons.enable = true;
      spicetify.enable = true;
    };

    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
    };

    cursor = {
      package = pkgs.openzone-cursors;
      name = "OpenZone_White_Slim";
      size = 28;
    };

    fonts = {
      serif = {
        package = pkgs.nerd-fonts.lekton;
        name = "Lekton Nerd Font";
      };

      sansSerif = {
        package = pkgs.nerd-fonts.lekton;
        name = "Lekton Nerd Font";
      };

      monospace = {
        package = pkgs.nerd-fonts.lekton;
        name = "Lekton Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 13;
        desktop = 13;
        popups = 14;
        terminal = 13;
      };
    };
    opacity = {
      terminal = 0.90;
      popups = 0.85;
      desktop = 0.80;
    };
  };
}
