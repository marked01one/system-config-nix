{...}: {
  flake.nixosModules.dotnet-sdk = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [dotnet-sdk];
  };

  flake.homeModules.dotnet-sdk = {pkgs, ...}: {
    home.packages = with pkgs; [dotnet-sdk];
  };
}
