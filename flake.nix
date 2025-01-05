{
  description = "testing repo for nixos modules";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    inputs@{ self, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./treefmt.nix
        ./modules
      ];
      systems = [ "x86_64-linux" ];

      monarchModules = {
        virtualization = ./modules/virtualization.nix;
        eza = ./modules/eza.nix;
      };
    };
}
