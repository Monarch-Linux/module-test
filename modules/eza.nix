{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.programs.eza;
in
{
  options = {
    programs.eza = {
      enable = lib.mkEnableOption "eza";
      package = lib.mkOption {
        description = "The eza package to use.";
        type = lib.types.package;
        default = pkgs.eza;
      };
      lsAlias = lib.mkEnableOption "eza alias";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    environment.shellAliases = lib.mkIf cfg.lsAlias {
      "ls" = "eza";
    };
  };
}
