{ config, pkgs, username, inputs, ... }:
{
  imports = [ inputs.textfox.homeManagerModules.default ];

  textfox = {
      enable = true;
      profile = "${username}";
      config = {
      # Optional config
        displayWindowControls = true;
        displayNavButtons = true;
        displayUrlbarIcons = true;
        displaySidebarTools = false;
        displayTitles = true;
        font = { 
          family = "FiraCode";
          size = "15px";
        };
        sidebery = {
          margin = "1.0rem";
        };
      };
  };
}
