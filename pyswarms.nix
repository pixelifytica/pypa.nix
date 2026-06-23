{
  buildPythonPackage,
  fetchPypi,
  pythonAtLeast,
  scipy,
  numpy,
  matplotlib,
  attrs,
  tqdm,
  pyyaml,
  future,
  ...
}:
buildPythonPackage rec {
  pname = "pyswarms";
  version = "1.3.0";
  format = "wheel";
  disabled = pythonAtLeast "3.13";
  src = fetchPypi {
    inherit pname version format;
    hash = "sha256-ilHlX7wmsKZTiROg8kOcSBs4kXh7fqmMsswGP4NN0VQ=";
  };
  dependencies = [
    scipy
    numpy
    matplotlib
    attrs
    tqdm
    pyyaml
    future
  ];
}
