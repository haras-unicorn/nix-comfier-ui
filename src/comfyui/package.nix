{
  fetchFromGitHub,
  python313Packages,
  lib,
  callPackage,
}:

let
  version = "0.3.59";

  embedded-docs = callPackage ./embedded-docs.nix {
    version = "0.2.6";
    hash = "sha256-Cpw0Q0GMuBhUX2THY9Ezw1LmvlHo+RQL0Q24yWvTfQ4=";
  };

  workflow-templates = callPackage ./workflow-templates.nix {
    version = "0.1.81";
    hash = "sha256-uE84DUho3cjdhV7DvrwYb8Kmtf/5sJ2ueKjGD+aAnA8=";
  };

  frontend = callPackage ./frontend.nix {
    version = "1.26.13";
    hash = "sha256-ocvO7woRyVkm40PNHIFJVQ13WtNfQfQAtYhY3nelSl4=";
    lockHash = "sha256-fmm6O+HeVE12X9u1fC3M2+w3uK4GR+qIzaT5y61mXEs=";
  };

  frontend-package = callPackage ./frontend-package.nix {
    version = "1.26.13";
    hash = "sha256-ocvO7woRyVkm40PNHIFJVQ13WtNfQfQAtYhY3nelSl4=";

    comfyui-frontend = frontend;
  };

  spandrel = callPackage ./spandrel.nix {
    version = "0.4.1";
    hash = "sha256-saRSosJ/pXmhLX5VqK3IBwT1yo14kD4nwNw0bCT2o5w=";
  };

  otherDependencies = with python313Packages; [
    torch
    torchsde
    torchvision
    torchaudio
    numpy
    einops
    transformers
    tokenizers
    sentencepiece
    safetensors
    aiohttp
    yarl
    pyyaml
    pillow
    scipy
    tqdm
    psutil
    alembic
    sqlalchemy
    av
    kornia
    spandrel
    soundfile
    pydantic
    pydantic-settings
  ];

  src = fetchFromGitHub {
    owner = "comfyanonymous";
    repo = "ComfyUI";
    rev = "v${version}";
    hash = "sha256-ySh1nDMYPtV3OclODEPlq09VXEVO4DxDhRpKg6OMkkY=";
  };
in
python313Packages.buildPythonPackage {
  pname = "comfyui";
  version = version;

  src = src;

  postPatch = ''
    cat >> pyproject.toml <<'EOF'
    [tool.setuptools.packages.find]
    include = [
      "comfy*",
      "comfy_api*",
      "comfy_config",
      "comfy_execution",
      "middleware",
      "api_server",
      "alembic_db",
      "app",
    ]
    exclude = [
      "models",
      "custom_nodes",
      "output",
      "input",
      "script_examples",
    ]
    EOF
  '';

  pyproject = true;

  dependencies = [
    embedded-docs
    workflow-templates
    frontend-package
  ]
  ++ otherDependencies;

  meta = {
    license = lib.licenses.gpl3;
  };
}
