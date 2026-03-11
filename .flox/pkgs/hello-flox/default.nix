# hello-flox: uses the same build logic but with Flox catalog nixpkgs.
# Dependencies come from the catalog, keeping your environment consistent.
{ callPackage }:
callPackage ../../../pkgs/hello.nix { }
