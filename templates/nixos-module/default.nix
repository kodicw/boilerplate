{
  lib,
  config,
  pkgs,
  ...
}:

let
  cfg = config.services.${config.moduleName};
in
{
  options = {
    services.${config.moduleName} = {
      enable = lib.mkEnableOption "${config.moduleName} service";

      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.${config.packageName};
        description = "The ${config.moduleName} package to use.";
      };

      port = lib.mkOption {
        type = lib.types.port;
        default = 8080;
        description = "Port to listen on.";
      };

      settings = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
        default = { };
        description = "Additional settings for ${config.moduleName}.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.${config.moduleName} = {
      description = "${config.moduleName} service";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${cfg.package}/bin/${config.binaryName} --port ${toString cfg.port}";
        Restart = "on-failure";
        RestartSec = "10";
        EnvironmentFile = cfg.settingsFile;
      };
    };
  };
}
