{
  description = ''
    doctrine - declarative configuration of all of @doctorn's machines.
  '';

  inputs = {
    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "master";
    };

    home-manager = {
      type = "github";
      owner = "rycee";
      repo = "home-manager";
      ref = "master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, ... } @ inputs:
    with inputs.nixpkgs.lib;
    let
      forEachSystem = genAttrs [ "x86_64-linux" "aarch64-linux" ];
      pkgsBySystem = forEachSystem (system:
        import inputs.nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            allowBroken = true;
          };
        }
      );

      mkNixOsConfiguration = name: { system, config }:
        nameValuePair name (nixosSystem {
          inherit system;
          modules = [
            ({ inputs, ... }: {
              nixpkgs = { pkgs = pkgsBySystem."${system}"; };
              environment.etc.nixpkgs.source = inputs.nixpkgs;
              nix.nixPath = [ "nixpkgs=/etc/nixpkgs" ];
            })
            ({ pkgs, ... }: {
              nix = {
                package = pkgs.nixFlakes;
                extraOptions = ''
                  experimental-features = nix-command flakes
                  keep-outputs = true
                  keep-derivations = true
                '';
              };
            })
            ({ inputs, ... }: {
              nix.registry = {
                nixpkgs = {
                  from = { id = "nixpkgs"; type = "indirect"; };
                  flake = inputs.nixpkgs;
                };
              };
            })
            (import ./nixos/profile.nix)
            (import ./nixos/config)
            (import config)
          ];
          specialArgs = { inherit name inputs; };
        });
    in
    {
      nixosConfigurations = mapAttrs' mkNixOsConfiguration {
        melvin = { system = "x86_64-linux"; config = ./nixos/hosts/melvin.nix; };

        mithridate = { system = "x86_64-linux"; config = ./nixos/hosts/mithridate.nix; };
      };
    };
}
