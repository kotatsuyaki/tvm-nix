{ callPackage, python38 }:
let
  tvm = callPackage ./tvm.nix { };
  tvm-source = callPackage ./tvm-source.nix { };
in
python38.pkgs.buildPythonPackage rec {
  pname = "tvm";
  version = "0.7.0";
  src = "${tvm-source}/python";

  # Make `import tvm` work
  pythonPath = [ "${tvm}/lib" ];

  # Enable setup.py to see tvm library
  # `pythonPath` does not work at build time
  preBuild = ''
    export TVM_LIBRARY_PATH=${tvm}/lib
  '';

  # Disable the tests
  # The tests caused "Permission denied: '/homeless-shelter'" and I did not try to fix
  doCheck = false;
  # At least make sure that `import tvm` works
  pythonImportsCheck = [ "tvm" ];

  propagatedBuildInputs = with python38.pkgs; [
    numpy
    decorator
    attrs
    psutil
    typed-ast
    (scipy.overrideAttrs (old: {
      doCheck = false;
    }))
    pytest
  ];
}
