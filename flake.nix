{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, ... } @ inputs:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        tvm = pkgs.callPackage ./nix/tvm.nix { };
        tvm-python = pkgs.callPackage ./nix/tvm-python.nix { };
        python = pkgs.python38.withPackages (python-pkgs: with python-pkgs; [
          tvm-python
          numpy
        ]);

        deps = [ tvm python ];
        native-deps = with pkgs; [ ];
        dev-deps = with pkgs; [ rnix-lsp clang ];
      in
      {
        packages = { inherit tvm tvm-python; };
        devShell = pkgs.stdenvNoCC.mkDerivation {
          name = "shell";
          nativeBuildInputs = deps ++ native-deps ++ dev-deps;
        };
      });
}
