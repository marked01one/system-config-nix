{...}: {
  flake.nixosModules.mysql = {pkgs, ...}: {
    services.mysql = {
      enable = true;
      package = pkgs.mysql84;
    };

    environment.systemPackages = with pkgs; [mysql_jdbc];

    environment.sessionVariables = {
      CLASSPATH = ".:/run/current-system/sw/share/java/mysql-connector-j.jar";
    };
  };

  flake.homeModules.mysql = {...}: {
  };
}
