{
  description = "akame";

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

     nix-colors = {
      url = "github:misterio77/nix-colors";
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

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = 
    { 
      self,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      nixcord,
      textfox,
      spicetify-nix,
      ...
    }@inputs:
    let
      username = "nate";
      system = "x86_64-linux";
      theme = "black-metal-burzum";

      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-stable = import nixpkgs-stable { 
        inherit system;
        config.allowUnfree = true;
      };
    in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        specialArgs = {
          inherit pkgs-stable;
          inherit username inputs system;
        };
        modules = with inputs; [
          ./hosts/akame/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              users.${username} = import ./hosts/home.nix;
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              extraSpecialArgs = {
              inherit username inputs theme system pkgs-stable;
              inherit (inputs.nix-colors.lib-contrib {inherit pkgs;}) gtkThemeFromScheme;
              };
            };
          }
        ];
      };
    };
  };
}
