{ config, pkgs, pkgs-stable, inputs, system, ... }: 
{
 imports = [
   ./programs/bundle.nix
   ./boot.nix
   ./hyprland.nix
   ./steam.nix
   ./xserver.nix
   ./packages.nix
   ./nvidia.nix
   #./amdgpu.nix
   #./intel.nix
 ];
}
