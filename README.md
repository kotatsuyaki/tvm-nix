`tvm-nix` is a [Nix Flakes](https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-flake.html) repository that packages the [tvm](https://tvm.apache.org/) shared library and its Python package, for usage on NixOS.

# Flake Outputs

- `tvm`
- `tvm-python`
- A devShell for `nix develop` usage


# Usage

With an installation of Nix with the `flakes` and the `nix-command` experimental features enabled,

```sh
nix develop .#
```

to obtain a development shell with Python3.8 and TVM.


# Caveats

- TVM version:

  Currently this repository contains only TVM 0.7, since its author develops software against this version.

- Python version:

  This flake targets Python 3.8 because TVM [does not support Python 3.9+](https://github.com/apache/tvm/issues/8577).
  The official Nix binary cache does not contain Python 3.8 anymore, so it takes a long time to build dependencies such as scipy.


# TODO's

- Conditionally build against CUDA
- Build more versions of TVM
