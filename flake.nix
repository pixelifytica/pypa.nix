{
  description = "Personal collection of Python packages that aren't in nixpkgs";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-25.11";
    imas-nix = {
      url = "github:pixelifytica/imas.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    calcam = {
      url = "github:pixelifytica/calcam.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sal = {
      url = "github:pixelifytica/simple-access-layer";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      imas-nix,
      calcam,
      sal,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ self.overlays.default ];
      };
    in
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
                dime-sampler = pfinal.callPackage ./dime-sampler.nix { };
                fortranformat = pfinal.callPackage ./fortranformat.nix { };
                freeqdsk = pfinal.callPackage ./freeqdsk.nix { };
                indica = pfinal.callPackage ./indica.nix { };
                inference-tools = pfinal.callPackage ./inference-tools.nix { };
                midas-fusion = pfinal.callPackage ./midas-fusion.nix { };
                pyswarms = pfinal.callPackage ./pyswarms.nix { };
                scikit-optimize = pfinal.callPackage ./skopt.nix { };
                tokamesh = pfinal.callPackage ./tokamesh.nix { };
              })
            ];
        }
      );
      packages.${system} = {
        inherit (pkgs.python3Packages)
          dime-sampler
          fortranformat
          freeqdsk
          indica
          inference-tools
          midas-fusion
          pyswarms
          scikit-optimize
          tokamesh
          ;
      };
    };
}
