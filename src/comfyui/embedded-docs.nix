{
  fetchFromGitHub,
  lib,
  python313Packages,
  version,
  hash,
}:

let
  versionToRev =
    version:
    let
      versionToRev = {
        "0.2.6" = "34d835df5490293cbce5ad4c9f42400c5777f6ea";
      };
    in
    if builtins.hasAttr version versionToRev then versionToRev.${version} else "v${version}";

  src = fetchFromGitHub {
    owner = "Comfy-Org";
    repo = "embedded-docs";
    rev = versionToRev version;
    hash = hash;
  };
in
python313Packages.buildPythonPackage {
  pname = "comfyui-embedded-docs";
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
