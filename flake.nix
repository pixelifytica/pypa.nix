{
  description = "Collection of Python packages that aren't in nixpkgs";
  outputs =
    { self, nixpkgs, ... }:
    let
      supportedSystems = [
        "x86_64-linux"
        "x86_64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      pkgs = forAllSystems (system: (nixpkgs.legacyPackages.${system}.extend self.overlays.default));
    in
    {
      overlays.default = (
        final: prev: {
          pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
            (pfinal: pprev: {
              corner = (pprev.corner.override { arviz = null; });
              fortranformat = pfinal.callPackage ./fortranformat.nix { };
              freeqdsk = pfinal.callPackage ./freeqdsk.nix { };
              indica = pfinal.callPackage ./indica.nix { };
              sal = pfinal.callPackage ./sal.nix { };
              inference-tools = pfinal.callPackage ./inference-tools.nix { };
              tokamesh = pfinal.callPackage ./tokamesh.nix { };
              midas-fusion = pfinal.callPackage ./midas-fusion.nix { };
              pyswarms = pfinal.callPackage ./pyswarms.nix { };
              triangle = pfinal.callPackage ./triangle.nix { };
              calcam = pfinal.callPackage ./calcam-lib.nix { };
              imas-core = pfinal.callPackage ./imas-core.nix { };
              imas-data-dictionaries = pfinal.callPackage ./imas-data-dictionaries.nix { };
              imas-python = pfinal.callPackage ./imas-python.nix { };
              imas-simdb = pfinal.callPackage ./imas-simdb.nix { };
              imas-paraview = pfinal.callPackage ./imas-paraview.nix { };
            })
          ];
          calcam-qt5 = final.callPackage ./calcam-gui.nix { useQt6 = false; };
          calcam-qt6 = final.callPackage ./calcam-gui.nix { useQt6 = true; };
          calcam = final.calcam-qt6;
          simdb = final.python3Packages.toPythonApplication final.python3.pkgs.imas-simdb;
          imas-paraview = final.python3Packages.toPythonApplication final.python3.pkgs.imas-paraview;
        }
      );
      packages = forAllSystems (system: {
        inherit (pkgs.${system})
          calcam-qt5
          calcam-qt6
          calcam
          simdb
          imas-paraview
          ;
      });
      apps = forAllSystems (system: {
        simdb = {
          type = "app";
          program = "${self.packages.${system}.simdb}/bin/simdb";
          meta.description = "SimDB CLI";
        };
        calcam = {
          type = "app";
          program = "${self.packages.${system}.calcam}/bin/calcam";
          meta.description = "Calcam";
        };
      });
    };
}
