{
  buildPythonPackage,
  fetchPypi,
  scipy,
  numpy,
  matplotlib,
  attrs,
  tqdm,
  pyyaml,
  ...
}:
buildPythonPackage rec {
  pname = "pyswarms";
  version = "1.3.0";
  format = "wheel";
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
  ];
}
