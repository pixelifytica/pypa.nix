{
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  numpy,
  scipy,
  inference-tools,
  tokamesh,
  pytest,
  ...
}:
buildPythonPackage rec {
  pname = "midas-fusion";
  version = "0.3.1";
  pyproject = true;
  src = fetchFromGitHub {
    owner = "C-bowman";
    repo = "midas";
    rev = version;
    hash = "sha256-AnHryOaUm6jPGZkpvTl+swnKAus2lFzwDbepLOluqTY=";
  };
  build-system = [ setuptools ];
  dependencies = [
    numpy
    scipy
    inference-tools
    tokamesh
  ];
  nativeCheckInputs = [ pytest ];
}
