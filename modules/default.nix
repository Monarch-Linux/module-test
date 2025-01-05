{
  config,
  lib,
  moduleLocation,
  ...
}:

{
  options.monarchModules = lib.mkOption {
    type = with lib.types; lazyAttrsOf deferredModule;
    default = { };
    apply = lib.mapAttrs (
      k: v: {
        _file = "${toString moduleLocation}#nixosModules.${k}";
        imports = [ v ];
      }
    );
  };

  config.flake.nixosModules = {
    default = {
      imports = builtins.attrValues config.monarchModules;
    };
  } // config.monarchModules;
}
