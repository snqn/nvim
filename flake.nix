{
  description = "snqn.nvim";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      forAllSystems = f:
        nixpkgs.lib.genAttrs systems (system:
          f (import nixpkgs { inherit system; }));
    in {
      packages = forAllSystems (pkgs:
        let
          snqn = pkgs.vimUtils.buildVimPlugin {
            pname = "snqn.nvim";
            version = "0.1.0";
            src = self;
          };
        in {
          default = snqn;
          snqn-nvim = snqn;
        });

      legacyPackages = forAllSystems (pkgs: {
        snqn = pkgs.vimUtils.buildVimPlugin {
          pname = "snqn.nvim";
          version = "0.1.0";
          src = self;
        };
      });
    };
}
