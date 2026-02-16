{
  stdenv,
  python3,
  vtk,
  vtkWithQt6,
  libsForQt5,
  qt6Packages,
  useQt6 ? false,
  ...
}:
let
  pythonWithCalcam = (
    (python3.override {
      packageOverrides = (
        pfinal: pprev: {
          triangle = pfinal.callPackage ./triangle.nix { };
          calcam = pfinal.callPackage ./calcam-lib.nix { inherit useQt6; };
        }
      );
    }).withPackages
      (ps: [ ps.calcam ])
  );
in
stdenv.mkDerivation {
  inherit (python3.pkgs.calcam) pname version;
  src = pythonWithCalcam.out;
  buildInputs = [
    pythonWithCalcam.pkgs.calcam
    (if useQt6 then qt6Packages else libsForQt5).qtbase
    (if useQt6 then qt6Packages else libsForQt5).qtwayland
  ]
  ++ (if useQt6 then [ vtkWithQt6 ] else [ vtk ]);
  nativeBuildInputs = [ (if useQt6 then qt6Packages else libsForQt5).wrapQtAppsHook ];
  installPhase = ''
    mkdir -p $out/
    cp -R * $out/
    for file in $out/bin/*; do wrapProgram "$file" --prefix QT_QPA_PLATFORM : "xcb"; done
  '';
}
