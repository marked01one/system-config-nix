{...}: {
  flake.nixosModules.dotnet-sdk = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [dotnet-sdk_10];
  };

  flake.homeModules.dotnet-sdk = {pkgs, ...}: {
    home.packages = with pkgs; [dotnet-sdk_10];
  };
}
