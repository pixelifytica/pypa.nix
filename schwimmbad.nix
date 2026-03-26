{
  buildPythonPackage,
  fetchPypi,
  hatchling,
  hatch-vcs,
  dill,
  multiprocess,
}:

buildPythonPackage rec {
  pname = "schwimmbad";
  version = "0.4.2";
  pyproject = true;
  src = fetchPypi {
    inherit pname version;
    hash = "sha256-7+ZQUa53rp9sOOz5eqT0eANZupdCyt3X3yCDxXUOTKk=";
  };
  build-system = [
    hatchling
    hatch-vcs
  ];
  dependencies = [
    dill
    multiprocess
  ];
}
