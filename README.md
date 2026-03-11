# Flox NEF + Flake Example

This repo demonstrates two patterns for packaging a flake package as a
Flox [NEF](https://flox.dev/docs/concepts/nix-expression-builds/) (Nix Expression Framework) build.

## Pattern 1: Consume the flake output directly

**`.flox/pkgs/hello-flake`** calls `builtins.getFlake` and pulls the
package directly from the flake.

```nix
{ stdenvNoCC }:
let
  flake = builtins.getFlake (builtins.toString ../../..);
in
flake.packages.${stdenvNoCC.hostPlatform.system}.default
```

This is the simplest approach — you get exactly what the flake produces. The
caveat is that the package and all of its dependencies come from the flake's
`nixpkgs` input rather than the Flox catalog.

## Pattern 2: `callPackage` the derivation from the NEF

**`.flox/pkgs/hello-flox`** uses `callPackage` to call the shared
derivation at `pkgs/hello.nix`, with dependencies provided by the Flox catalog.

```nix
{ callPackage }:
callPackage ../../../pkgs/hello.nix { }
```

The shared derivation at **`pkgs/hello.nix`** is a standard
`callPackage`-compatible expression:

```nix
{ hello }:
hello
```

The flake also uses it (`pkgs.callPackage ./pkgs/hello.nix { }`), so build
logic lives in one place. The difference is that the NEF gets its dependencies
from the Flox catalog while the flake gets them from its own `nixpkgs` input.

## Usage

```bash
# Build using the flake output
flox build hello-flake

# Build using Flox catalog nixpkgs
flox build hello-flox
```
