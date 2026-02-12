{
  description = "Collection of Python packages that aren't in nixpkgs";
  outputs =
    { self, nixpkgs, ... }:
    let
      supportedSystems = [
        "x86_64-linux"
        "x86_64-darwin"
      ];
      supportedPythons = [
        "python310"
        "python311"
        "python312"
        "python313"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      pkgs = forAllSystems (system: (nixpkgs.legacyPackages.${system}.extend self.overlays.default));
    in
    {
      overlays.default = (
        final: prev:
        {
          calcam-qt5 = final.libsForQt5.callPackage ./calcam-gui.nix { useQt6 = false; };
          calcam-qt6 = final.qt6Packages.callPackage ./calcam-gui.nix { useQt6 = true; };
          calcam = final.calcam-qt6;
          simdb = final.python3Packages.toPythonApplication final.python3.pkgs.imas-simdb;
          imas-paraview = final.python3Packages.toPythonApplication final.python3.pkgs.imas-paraview;
        }
        // (builtins.listToAttrs (
          map (name: {
            inherit name;
            value = prev.${name}.override {
              packageOverrides = pfinal: pprev: {
                corner = (pprev.corner.override { arviz = null; });
                fortranformat = pfinal.callPackage ./fortranformat.nix { };
                freeqdsk = pfinal.callPackage ./freeqdsk.nix { };
                indica = pfinal.callPackage ./indica.nix { };
                sal = pfinal.callPackage ./sal.nix { };
                inference-tools = pfinal.callPackage ./inference-tools.nix { };
                pyswarms = pfinal.callPackage ./pyswarms.nix { };
                triangle = pfinal.callPackage ./triangle.nix { };
                calcam = pfinal.callPackage ./calcam-lib.nix { };
                imas-core = pfinal.callPackage ./imas-core.nix { };
                imas-data-dictionaries = pfinal.callPackage ./imas-data-dictionaries.nix { };
                imas-python = pfinal.callPackage ./imas-python.nix { };
                imas-simdb = pfinal.callPackage ./imas-simdb.nix { };
                imas-paraview = pfinal.callPackage ./imas-paraview.nix { };
              };
            };
          }) supportedPythons
        ))
      );
      packages = forAllSystems (system: {
        inherit (pkgs.${system})
          calcam-qt5
          calcam-qt6
          calcam
          simdb
          imas-paraview
          ;
        default = self.packages.${system}.calcam;
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
