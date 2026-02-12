{
  buildPythonPackage,
  fetchPypi,
  numpy,
  scipy,
  matplotlib,
  ...
}:
buildPythonPackage rec {
  pname = "inference-tools";
  version = "0.14.3";
  format = "wheel";
  src = fetchPypi {
    inherit version format;
    pname = "inference_tools";
    dist = "py3";
    python = "py3";
    hash = "sha256-8VKfPCABjcPleAekx/nP7/BNmyVyXUrIwpaEmvholsA=";
  };
  dependencies = [
    numpy
    scipy
    matplotlib
  ];
}
