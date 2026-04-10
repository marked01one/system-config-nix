{...}: {
  perSystem = {pkgs, ...}: let
    templates = {
      clients = pkgs.writeText "template-clients.nix" ''
        {self, inputs, ...}: {
          imports = [inputs.home-manager.flakeModules.home-manager];

          flake.nixosConfigurations.FILENAME = inputs.nixpkgs.lib.nixosSystem {
            modules = [
              self.nixosModules.FILENAME
              self.nixosModules.FILENAME-hardware
            ];
          };

          flake.nixosModules.FILENAME = {...}: {
            imports = with self.nixosModules; [
              home-manager
            ];
          };

          flake.nixosModules.FILENAME-hardware = {};
        }
      '';
      features = pkgs.writeText "template-features.nix" ''
        {...}: {
          flake.nixosModules.FILENAME = {...}: {
          };

          flake.homeModules.FILENAME = {...}: {
          };
        }
      '';
      nixos = pkgs.writeText "template-nixos.nix" ''
        {...}: {
          flake.nixosModules.FILENAME = {...}: {
          };
        }
      '';
      scripts = pkgs.writeText "template-scripts.nix" ''
        {...}: {
          perSystem = {pkgs, ...}: {
            packages.FILENAME = pkgs.writeShellApplication {
              name = "FILENAME";
              runtimeInputs = with pkgs; [];
              text = "";
            };
          };
        }
      '';
    };

    usageText = ''

      Usage: flake-parts-init <filename>

      Create a new '<filename>.nix' starter template file for dendritic flakes.
    '';

    greets.preset = ''
      ------------------------------
      [C] clients
      [F] features
      [N] nixos-modules
      [S] scripts
      ------------------------------
      Choose a preset. (C|F|N|S): '';
  in {
    packages.flake-parts-init = pkgs.writeShellApplication {
      name = "flake-parts-init";
      runtimeInputs = with pkgs; [neovim alejandra];
      text = ''
        # syntax: shell
        function usage {
          echo "${usageText}"
          exit 1
        }

        function check_module {
          local module="$1"
          exists=$(find "$(pwd)" -name "$module.nix" -print -quit)

          if [ -n "$exists" ]; then
            echo "Error: File '$module.nix' already exists in this flake!"
            echo "Exiting..."
            usage
          fi
        }

        if [ ! -f "$(pwd)/flake.nix" ]; then
          echo "Error: No 'flake.nix' file found! Exiting..."
          usage
        fi

        NEW_MOD="$1"
        check_module "$NEW_MOD"

        read -rp "${greets.preset}" preset

        case $preset in
          c|C)
            mkdir -p "$(pwd)/modules/clients"
            pushd "$(pwd)/modules/clients" > "/dev/null"
            sed "s/FILENAME/$NEW_MOD/g" ${templates.clients} > "$NEW_MOD.nix"
            ;;
          f|F)
            mkdir -p "$(pwd)/modules/features"
            pushd "$(pwd)/modules/features" > "/dev/null"
            sed "s/FILENAME/$NEW_MOD/g" ${templates.features} > "$NEW_MOD.nix"
            ;;
          n|N)
            mkdir -p "$(pwd)/modules/nixos"
            pushd "$(pwd)/modules/nixos" > "/dev/null"
            sed "s/FILENAME/$NEW_MOD/g" ${templates.nixos} > "$NEW_MOD.nix"
            ;;
          s|S)
            mkdir -p "$(pwd)/modules/packages/scripts"
            pushd "$(pwd)/modules/packages/scripts" > "/dev/null"
            sed "s/FILENAME/$NEW_MOD/g" ${templates.scripts} > "$NEW_MOD.nix"
            ;;
          *)
            echo "Invalid input! Exiting..."
            exit 1
            ;;
        esac

        nvim "$NEW_MOD.nix"
        alejandra "$NEW_MOD.nix"

        popd > "/dev/null"
      '';
    };
  };
}
