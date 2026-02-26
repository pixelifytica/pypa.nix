{
  buildPythonPackage,
  fetchPypi,
  setuptools,
  joblib,
  pyaml,
  numpy,
  scipy,
  scikit-learn,
  packaging,
  ...
}:

buildPythonPackage rec {
  pname = "scikit-optimize";
  version = "0.10.2";
  pyproject = true;
  src = fetchPypi {
    inherit version;
    pname = "scikit_optimize";
    hash = "sha256-AKPZG/kBXikrbnqu/n5suV6NJc4Zra/SzYiEnhoLDaA=";
  };
  build-system = [ setuptools ];
  dependencies = [
    joblib
    pyaml
    numpy
    scipy
    scikit-learn
    packaging
  ];
}
