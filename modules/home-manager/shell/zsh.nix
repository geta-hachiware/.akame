{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    
    shellAliases =
      let
        flakeDir = "${config.home.homeDirectory}/.akame";
      in {
      rb = "nh os switch ${flakeDir}";
      upd = "nh os switch --update ${flakeDir}";

      hms = "nh home switch ${flakeDir}";

      v = "nvim";
      ff = "fastfetch";
      sy = "sudo yazi";
    };

    history = {
      expireDuplicatesFirst = true;
      save = 1000;
    };

    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" "sudo" ];
    };
  };
}
