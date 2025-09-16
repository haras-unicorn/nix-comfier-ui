{ pkgs, ... }:

{
  integrate.package.package = pkgs.callPackage ./package.nix { };
}
