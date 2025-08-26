{ config, pkgs, inputs, ... }: 
{
  programs.nh = {
    enable = true;
    flake = "${config.home.homeDirectory}/.akame";
    clean = {
      enable = true;
      extraArgs = "--keep-since 1w --keep 4";
    };
  };
}
