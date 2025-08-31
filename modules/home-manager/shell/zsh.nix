{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    
    shellAliases =
      let
        flakeDir = "$HOME/.akame";
      in {
      rb = "nh os switch ${flakeDir}";
      upd = "nh os switch --update ${flakeDir}";

      grb = "sudo nix-collect-garbage";
      v = "nvim";
      ff = "fastfetch";
      y = "yazi";
      f = "nvim $(fzf)";
    };

    history = {
      expireDuplicatesFirst = true;
      save = 1000;
    };

    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" ];
    };
  };
}
