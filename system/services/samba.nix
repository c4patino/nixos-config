{
  lib,
  config,
  ...
}: let
  types = lib.types;
in {
  options = {
    samba.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable samba";
    };
    samba.folders = lib.mkOption {
      type = types.listOf types.str;
      default = [];
      description = "List of folder shares to create with samba";
    };
  };

  config = lib.mkIf config.samba.enable {
    services.samba = {
      enable = true;
      openFirewall = true;
      settings = {
        global = {
          "workgroup" = "WORKGROUP";
          "server string" = "smbnix";
          "netbios name" = "smbnix";
          "security" = "user";
        };
        "shared" = {
          "path" = "/mnt/samba/shared";
          "browsable" = "yes";
          "read only" = "no";
          "guest ok" = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
          "force user" = "c4patino";
          "force group" = "users";
        };
      };
    };

    services.samba-wsdd = {
      enable = true;
      openFirewall = true;
    };

    environment.sessionVariables = {
      SAMBA = "/mnt/samba";
    };
  };
}
