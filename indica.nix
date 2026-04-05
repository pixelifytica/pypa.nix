{
  buildPythonPackage,
  fetchFromGitHub,
  poetry-core,
  corner,
  pandas,
  hydra-core,
  prov,
  netcdf4,
  numpy,
  mpmath,
  scipy,
  xarray,
  matplotlib,
  sal,
  emcee,
  dime-sampler,
  flatdict,
  bottleneck,
  tqdm,
  scikit-learn,
  scikit-optimize,
  pyyaml,
  pint,
  gitpython,
  periodictable,
  freeqdsk,
  click,
  coverage,
  hypothesis,
  mypy,
  pytest,
  pytest-cov,
  pytest-xdist,
  types-setuptools,
  ...
}:
buildPythonPackage rec {
  pname = "indica";
  version = "0.1.24";
  pyproject = true;
  src = fetchFromGitHub {
    owner = "indica-mcf";
    repo = "indica";
    rev = "v${version}";
    hash = "sha256-3JUFRPojYpdjqBqyXk/3Z8RuFvUAdTFAYcOjNjL14nQ=";
  };
  build-system = [
    poetry-core
  ];
  dependencies = [
    corner
    pandas
    hydra-core
    prov
    netcdf4
    numpy
    mpmath
    scipy
    xarray
    matplotlib
    sal
    emcee
    dime-sampler
    flatdict
    bottleneck
    tqdm
    scikit-learn
    scikit-optimize
    pyyaml
    pint
    gitpython
    periodictable
    freeqdsk
  ];
  nativeCheckInputs = [
    click
    corner
    coverage
    hypothesis
    mypy
    pytest
    pytest-cov
    pytest-xdist
    types-setuptools
  ];
  doChecks = true;
  dontCheckRuntimeDeps = true;
  patches = [ ./indica.patch ];
}
