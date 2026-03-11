# hello-flake: consumes the flake output directly.
# The package and ALL of its dependencies come from the flake's nixpkgs,
# not from the Flox catalog.
{ stdenvNoCC }:
let
  flake = builtins.getFlake (builtins.toString ../../..);
in
flake.packages.${stdenvNoCC.hostPlatform.system}.default
