{ nixpkgs ? import <nixpkgs> {}, compiler ? "default", doBenchmark ? false }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, base, bytestring, comonad, containers
      , contravariant, data-default, filepath, fingertree, ghc-prim
      , groups, hashable, lens, stdenv, transformers, trifecta
      , unordered-containers
      }:
      mkDerivation {
        pname = "advent";
        version = "0.1.0.0";
        src = ./.;
        isLibrary = true;
        isExecutable = true;
        libraryHaskellDepends = [
          base bytestring comonad containers contravariant data-default
          filepath fingertree ghc-prim groups hashable lens transformers
          trifecta unordered-containers
        ];
        executableHaskellDepends = [ base ];
        license = "unknown";
        hydraPlatforms = stdenv.lib.platforms.none;
      };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  variant = if doBenchmark then pkgs.haskell.lib.doBenchmark else pkgs.lib.id;

  drv = variant (haskellPackages.callPackage f {});

in

  if pkgs.lib.inNixShell then drv.env else drv
