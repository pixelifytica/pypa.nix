{
  description = "Collection of Python packages that aren't in nixpkgs";
  inputs = {
    imas-nix.url = "git+ssh://git@git.ccfe.ac.uk/elitherl/imas.nix?shallow=1";
    calcam.url = "github:pixelifytica/calcam.nix";
    sal.url = "github:pixelifytica/simple-access-layer";
  };
  outputs =
    {
      imas-nix,
      calcam,
      sal,
      ...
    }:
    {
      overlays.default = (
        final: prev: {
          pythonPackagesExtensions =
            prev.pythonPackagesExtensions
            ++ (imas-nix.overlays.default final prev).pythonPackagesExtensions
            ++ (calcam.overlays.default final prev).pythonPackagesExtensions
            ++ (sal.overlays.default final prev).pythonPackagesExtensions
            ++ [
              (pfinal: pprev: {
                corner = (pprev.corner.override { arviz = null; });
                fortranformat = pfinal.callPackage ./fortranformat.nix { };
                freeqdsk = pfinal.callPackage ./freeqdsk.nix { };
                indica = pfinal.callPackage ./indica.nix { };
                inference-tools = pfinal.callPackage ./inference-tools.nix { };
                midas-fusion = pfinal.callPackage ./midas-fusion.nix { };
                pyswarms = pfinal.callPackage ./pyswarms.nix { };
                tokamesh = pfinal.callPackage ./tokamesh.nix { };
              })
            ];
        }
      );
    };
}
