{
  fetchFromGitHub,
  python313Packages,
  lib,
  comfyui-frontend,
  version,
  hash,
}:

let
  src = fetchFromGitHub {
    owner = "Comfy-Org";
    repo = "ComfyUI_frontend";
    rev = "v${version}";
    hash = hash;
  };
in
python313Packages.buildPythonPackage {
  pname = "comfyui-frontend-package";
  version = version;
  src = "${src}/comfyui_frontend_package";

  pyproject = true;
  build-system = with python313Packages; [
    setuptools
  ];

  postPatch = ''
    cp -r ${comfyui-frontend}/share/comfyui/web ./comfyui_frontend_package/static
  '';

  meta = {
    license = lib.licenses.gpl3;
  };
}
