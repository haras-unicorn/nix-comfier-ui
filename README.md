# Nix Comfier UI

This is a reboot of the [nix-comfyui](https://github.com/dyscorv/nix-comfyui)
flake.

## Get started

Add the following to `flake.nix` (this is just an example):

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/<nixpkgs-version>";

    nix-comfier-ui.url = "github:altibiz/perch/refs/tags/<nix-comfier-ui-version>";
    # don't pin the nixpkgs dependency unless you know what you are doing
    nix-comfier-ui.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nix-comfier-ui }: {
    nixosModules.default = { pkgs, ... }: {
      # use this to add overlay to nixpkgs that adds ComfyUI-related packages
      # cuda/rocm support is automatically applied
      imports = [ nix-comfier-ui.nixosModules.default ];

      config = {
        # this has the same effect as the import
        nixpkgs.overlays = [ nix-comfier-ui.overlays.default ];

        environment.systemPackages = with pkgs; [
          # use this to install without extensions
          comfyui

          # use this to install with extensions
          (comfyui.override {
            extensions = with pkgs.comfyuiExtensions; [
              city96-gguf
            ];
          })
        ];

        # if you want to pin nixpkgs for nix-comfier-ui use it like so
        environment.systemPackages = with nix-comfier-ui.packages.${pkgs.system}; [
          # use this to install without extensions
          comfyui

          # use this to install with extensions
          (comfyui.override {
            # don't forget to turn on cuda/rocm support (but not both!) for this scenario
            # since nix-comfier-ui isn't aware of pkgs now
            # cudaSupport = true;
            # rocmSupport = true;

            extensions = with nix-comfier-ui.packages.${pkgs.system}; [
              extension-city96-gguf
            ];
          })
        ];
      };
    };
  };
}
```

## Documentation

Documentation can be found on [GitHub Pages].

## Contributing

Please review [CONTRIBUTING.md](./CONTRIBUTING.md)

## License

This project is licensed under the [MIT License](./LICENSE.md).

[GitHub Pages]: https://haras-unicorn.github.io/nix-comfier-ui
