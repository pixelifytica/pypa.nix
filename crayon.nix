{
  buildPythonPackage,
  setuptools,
  setuptools-scm,
  wheel,
  numpy,
  scipy,
  netcdf4,
  shapely,
  freeqdsk,
  scikit-image,
  cython,
}:

buildPythonPackage {
  pname = "crayon";
  version = "0.1dev";
  pyproject = true;
  src = builtins.fetchGit {
    url = "git@git.ccfe.ac.uk:sfreethy/ray_tracing.git";
    ref = "master";
    rev = "5efb2b7910e4413a28791c1c7936c59bfdc3b7a6";
  };
  build-system = [
    setuptools
    setuptools-scm
    wheel
  ];
  dependencies = [
    numpy
    scipy
    netcdf4
    shapely
    freeqdsk
    scikit-image
    cython
  ];
}
