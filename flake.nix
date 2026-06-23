{
  description = "Personal collection of Python packages that aren't in nixpkgs";
  inputs = {
    imas-nix.url = "github:pixelifytica/imas.nix";
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
                crayon = pfinal.callPackage ./crayon.nix { };
                dime-sampler = pfinal.callPackage ./dime-sampler.nix { };
                fortranformat = pfinal.callPackage ./fortranformat.nix { };
                freeqdsk = pfinal.callPackage ./freeqdsk.nix { };
                indica = pfinal.callPackage ./indica.nix { };
                inference-tools = pfinal.callPackage ./inference-tools.nix { };
                midas-fusion = pfinal.callPackage ./midas-fusion.nix { };
                pyswarms = pfinal.callPackage ./pyswarms.nix { };
                scikit-optimize = pfinal.callPackage ./skopt.nix { };
                schwimmbad = pfinal.callPackage ./schwimmbad.nix { };
                tokamesh = pfinal.callPackage ./tokamesh.nix { };
              })
            ];
        }
      );
    };
}
