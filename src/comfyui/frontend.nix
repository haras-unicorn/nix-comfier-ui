{
  stdenv,
  fetchFromGitHub,
  version,
  hash,
  lockHash,
  nodejs_20,
  util-linux,
  pnpm,
}:

let
  src = fetchFromGitHub {
    owner = "Comfy-Org";
    repo = "ComfyUI_frontend";
    rev = "v${version}";
    hash = hash;
  };
in
stdenv.mkDerivation (final: {
  inherit src;
  pname = "comfyui-frontend";
  version = "${version}";

  nativeBuildInputs = [
    nodejs_20
    util-linux
    pnpm.configHook
  ];

  pnpmDeps = pnpm.fetchDeps {
    inherit (final) pname version src;
    fetcherVersion = 2;
    hash = lockHash;
  };

  buildPhase = ''
    export NX_DAEMON=false
    export NX_TUI=false
    script -qfc "pnpm run build" /dev/null
  '';

  installPhase = ''
    mkdir --parents $out/share/comfyui
    cp --archive dist $out/share/comfyui/web
  '';
})
