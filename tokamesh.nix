{
  buildPythonPackage,
  fetchFromGitHub,
  pythonOlder,
  setuptools,
  setuptools-scm,
  wheel,
  numpy,
  scipy,
  matplotlib,
  ...
}:
buildPythonPackage rec {
  disabled = pythonOlder "3.9";
  pname = "tokamesh";
  version = "0.5.4";
  pyproject = true;
  src = fetchFromGitHub {
    owner = "C-bowman";
    repo = pname;
    rev = version;
    hash = "sha256-F5I5t+fEsXml9EWRR+LXAEfvNciIbr7qHjxW/tqKmVs=";
  };
  build-system = [
    setuptools
    setuptools-scm
    wheel
  ];
  dependencies = [
    numpy
    scipy
    matplotlib
  ];
  postPatch = ''
    substituteInPlace pyproject.toml --replace-fail "setuptools_scm[toml] >= 6.2" "setuptools_scm[toml] >= 7.0"
    substituteInPlace pyproject.toml --replace-fail \"setuptools_scm_git_archive\", ""
  '';
}
