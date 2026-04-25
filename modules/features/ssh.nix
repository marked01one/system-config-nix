{...}: {
  flake.nixosModules.ssh = {...}: {
  };

  flake.homeModules.ssh = {...}: {
    programs.ssh = {
      enable = true;
    };

    programs.ssh-agent = {
      enable = true;
    };
  };
}
