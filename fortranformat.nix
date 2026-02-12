{
  buildPythonPackage,
  fetchFromGitHub,
  poetry-core,
  ...
}:
buildPythonPackage rec {
  pname = "fortranformat";
  version = "2.0.3";
  pyproject = true;
  src = fetchFromGitHub {
    owner = "brendanarnold";
    repo = "py-fortranformat";
    rev = "v${version}";
    hash = "sha256-JtJZzMd4LqzVGx1k1wMDAiJ8RFiGl4JKDf4bJY68lEw=";
  };
  build-system = [ poetry-core ];
  dependencies = [ ];
}
