{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.monarch.virtualization;
in
{
  options = {
    monarch.virtualization = {
      enable = lib.mkEnableOption "virtualization";
      users = lib.mkOption {
        description = "Users to add to libvirt group";
        type = with lib.types; listOf str;
        default = [ ];
      };
    };
  };

  config = lib.mkIf cfg.enable {
    virtualisation.libvirtd = {
      enable = true;
      qemu.vhostUserPackages = [ pkgs.virtiofsd ];
    };

    programs.virt-manager.enable = true;

    users.groups.libvirtd.members = cfg.users;
  };
}
