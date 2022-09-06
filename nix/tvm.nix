{ callPackage, stdenv, fetchFromGitHub, cmake, llvm }:
let
  tvm-source = callPackage ./tvm-source.nix { };
in
stdenv.mkDerivation rec {
  pname = "tvm";
  version = "0.7.0";

  src = tvm-source;

  nativeBuildInputs = [ cmake llvm ];

  preConfigure = ''
    cp cmake/config.cmake config.cmake
    substituteInPlace config.cmake --replace "USE_LLVM OFF" "USE_LLVM ${llvm.dev}/bin/llvm-config"
  '';

  # TVM CMake build uses some sources in the project's ./src/target/opt/
  # directory which errneously gets mangled by the eager `fixCmakeFiles`
  # function in Nix's CMake setup-hook.sh to ./src/target/var/empty/,
  # which then breaks the build. Toggling this flag instructs Nix to
  # not mangle the legitimate use of the opt/ folder.
  dontFixCmake = true;
  doCheck = false;
}
