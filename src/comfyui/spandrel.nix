{
  fetchFromGitHub,
  python313Packages,
  lib,
  version,
  hash,
}:

let
  src = fetchFromGitHub {
    owner = "chaiNNer-org";
    repo = "spandrel";
    rev = "v${version}";
    hash = hash;
  };
in
python313Packages.buildPythonPackage {
  pname = "spandrel";
  version = version;
  src = src;

  pyproject = true;
  build-system = with python313Packages; [
    setuptools
  ];
}
