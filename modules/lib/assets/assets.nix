{...}: let
  getAssets = {
    get = name: "./${name}";
    getIcon = name: "./icons/${name}";
    getFont = name: "./fonts/${name}";
    getWallpaper = name: "./wallpapers/${name}";
  };
in {
  flake.nixosModules.default = {
    _module.args.assets = getAssets;
  };
  flake.homeModules.default = {
    _module.args.assets = getAssets;
  };
}
