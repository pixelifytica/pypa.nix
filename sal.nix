{
  buildPythonPackage,
  fetchFromGitHub,
  poetry-core,
  flask,
  flask-restful,
  ldap3,
  numpy,
  requests,
}:
buildPythonPackage {
  pname = "sal";
  version = "1.2.5";
  pyproject = true;
  src = fetchFromGitHub {
    owner = "pixelifytica";
    repo = "simple-access-layer";
    rev = "7a5d43959cd28d668f92b702e4cd955e27d7b220";
    hash = "sha256-soZ1yDd3aVT7icXrifELJygPjNuzl0w26k/WOm5C1Gs=";
  };
  build-system = [ poetry-core ];
  dependencies = [
    flask
    flask-restful
    ldap3
    numpy
    requests
  ];
}
