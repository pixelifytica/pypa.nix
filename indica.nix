{
  buildPythonPackage,
  fetchFromGitHub,
  poetry-core,
  pandas,
  netcdf4,
  numpy,
  scipy,
  xarray,
  matplotlib,
  pyyaml,
  periodictable,
  freeqdsk,
  ...
}:
buildPythonPackage rec {
  pname = "indica";
  version = "0.1.22";
  pyproject = true;
  src = fetchFromGitHub {
    owner = "indica-mcf";
    repo = "indica";
    rev = "v${version}";
    hash = "sha256-v48DlhDf1OslIKdvoqu5XzFT65MpMowMtI+TbeLyxSE=";
  };
  build-system = [
    poetry-core
  ];
  dependencies = [
    pandas
    netcdf4
    numpy
    scipy
    xarray
    matplotlib
    pyyaml
    periodictable
    freeqdsk
  ];
  doChecks = false;
  dontCheckRuntimeDeps = true;
}
