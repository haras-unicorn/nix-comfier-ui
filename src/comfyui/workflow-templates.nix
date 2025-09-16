{
  fetchFromGitHub,
  python313Packages,
  lib,
  version,
  hash,
}:

let
  src = fetchFromGitHub {
    owner = "Comfy-Org";
    repo = "workflow_templates";
    rev = "v${version}";
    hash = hash;
  };
in
python313Packages.buildPythonPackage {
  pname = "comfyui-workflow-templates";
  version = version;

  src = src;

  pyproject = true;
  build-system = with python313Packages; [
    setuptools
  ];

  meta = {
    license = lib.licenses.gpl3;
  };
}
