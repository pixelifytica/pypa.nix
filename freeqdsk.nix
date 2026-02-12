{
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  setuptools-scm,
  toml,
  numpy,
  fortranformat,
  ...
}:
buildPythonPackage rec {
  pname = "freeqdsk";
  version = "0.5.2";
  pyproject = true;
  src = fetchFromGitHub {
    owner = "freegs-plasma";
    repo = "FreeQDSK";
    rev = "v${version}";
    hash = "sha256-E+bif5DALBRLSE9tLcy3AsQyWsdt0mzcYIwp0jE8/ck=";
  };
  build-system = [
    setuptools
    setuptools-scm
    toml
  ];
  dependencies = [
    numpy
    fortranformat
  ];
}
