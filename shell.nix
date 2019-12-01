{ nixpkgs ? import <nixpkgs> {}, compiler ? "default", doBenchmark ? false }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, ansi-wl-pprint, array, base, bytestring
      , containers, filepath, fingertree, groups, hashable, JuicyPixels
      , MemoTrie, psqueues, stdenv, trifecta, unordered-containers
      , vector
      }:
      mkDerivation {
        pname = "advent";
        version = "0.1.0.0";
        src = ./.;
        isLibrary = true;
        isExecutable = true;
        libraryHaskellDepends = [
          ansi-wl-pprint array base bytestring containers filepath fingertree
          groups hashable JuicyPixels MemoTrie psqueues trifecta
          unordered-containers vector
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
