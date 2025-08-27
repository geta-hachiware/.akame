{
  description = "akame system flake";

  inputs = {
    nixpkgs.url =  "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05"; 

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:Sly-Harvey/nixvim";
    };

    nixcord = {
      url = "github:kaylorben/nixcord";
    };

    textfox = {
      url = "github:adriankarlen/textfox";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = 
    { 
      self,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      nixvim,
      nixcord,
      textfox,
      spicetify-nix,
      aagl,
      ...
    }@inputs:
    let
      username = "nate";
      system = "x86_64-linux";
      theme = "black-metal-burzum";

      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
        inherit system;
        overlays = overlays;
        config.allowUnfree = true;
      };
      pkgs-stable = import nixpkgs-stable { 
        inherit system;
        config.allowUnfree = true;
      };
      overlays = [
        (import ./pkgs)
      ];
    in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        specialArgs = {
          inherit pkgs-stable;
          inherit username inputs system;
        };
        modules = with inputs; [
          ./host/akame/configuration.nix
          spicetify-nix.nixosModules.default
         ];
      };
    };
    homeConfigurations = {
      ${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit pkgs-stable;
          inherit username system theme inputs;
          inherit (inputs.nix-colors.lib-contrib {inherit pkgs;}) gtkThemeFromScheme;
        };
        modules = with inputs; [
          ./host/akame/home.nix
          nixcord.homeModules.nixcord
          textfox.homeManagerModules.default
          nix-colors.homeManagerModules.default
        ];
      };
    };
  };
}
