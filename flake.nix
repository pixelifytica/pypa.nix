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
      pypackages = [
        "fortranformat"
        "freeqdsk"
        "indica"
        "sal"
        "inference-tools"
        "tokamesh"
        "midas-fusion"
        "pyswarms"
        "triangle"
        "calcam"
        "imas-core"
        "imas-data-dictionaries"
        "imas-python"
        "imas-simdb"
        "imas-paraview"
      ];
    in
    {
      overlays.default = (
        final: prev:
        {
          calcam-qt5 = final.callPackage ./calcam-gui.nix { useQt6 = false; };
          calcam-qt6 = final.callPackage ./calcam-gui.nix { useQt6 = true; };
          calcam = final.calcam-qt6;
          simdb = final.python3Packages.toPythonApplication final.python3.pkgs.imas-simdb;
          imas-paraview = final.python3Packages.toPythonApplication final.python3.pkgs.imas-paraview;
        }
        // (builtins.listToAttrs (
          map (py: {
            name = py;
            value = prev.${py}.override {
              packageOverrides = pfinal: pprev: {
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
              }
              # // (builtins.listToAttrs (
              #   map (name: {
              #     inherit name;
              #     value = pfinal.callPackage (builtins.toPath "./${name}.nix") { };
              #   }) pypackages
              # ))
              ;
            };
          }) supportedPythons
        ))
      );
      packages = forAllSystems (
        system:
        {
          inherit (pkgs.${system})
            calcam-qt5
            calcam-qt6
            calcam
            simdb
            imas-paraview
            ;
        }
        // (builtins.listToAttrs (
          map (name: {
            name = "${name}-lib";
            value = pkgs.${system}.python3.pkgs.${name};
          }) pypackages
        ))
      );
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
