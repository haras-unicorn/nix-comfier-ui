{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    perch.url = "github:altibiz/perch/refs/tags/2.2.1";
    perch.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { perch, ... }@inputs:
    perch.lib.flake.make {
      inherit inputs;
      root = ./.;
      prefix = "src";
    };
}
