{ inputs, ... }:

{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem.treefmt = {
    projectRootFile = "flake.nix";
    programs.nixfmt.enable = true;
  };
}