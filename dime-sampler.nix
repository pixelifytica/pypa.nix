{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  wheel,
  numpy,
  scipy,
  emcee,
  ...
}:

buildPythonPackage rec {
  pname = "dime-sampler";
  version = "1.0.0";
  pyproject = true;
  src = fetchPypi {
    inherit version;
    pname = "dime_sampler";
    hash = "sha256-FgykbJMw73mIEG5kToTZyqC6Kx+dUPm8vlCyl6+VTh0=";
  };
  build-system = [
    setuptools
    wheel
  ];
  dependencies = [
    numpy
    scipy
    emcee
  ];
}
