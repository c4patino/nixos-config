{inputs, ...}: {
  systems = ["x86_64-linux" "aarch64-linux"];

  perSystem = {system, ...}: let
    pkgs = import inputs.nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
    cudaPkgs = import inputs.nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        cudaSupport = true;
      };
    };
  in {
    devShells = {
      c-dev = import ./c.nix {inherit pkgs;};
      cpp-dev = import ./cpp.nix {inherit pkgs;};
      csharp-dev = import ./csharp.nix {inherit pkgs;};
      go-dev = import ./go.nix {inherit pkgs;};
      java-dev = import ./java.nix {inherit pkgs;};
      js-dev = import ./js.nix {inherit pkgs;};
      lua-dev = import ./lua.nix {inherit pkgs;};
      nix-dev = import ./nix.nix {inherit pkgs;};
      python311-dev = import ./python311.nix {inherit pkgs;};
      python312-dev = import ./python312.nix {inherit pkgs;};
      racket-dev = import ./racket.nix {inherit pkgs;};
      rust-dev = import ./rust.nix {inherit pkgs;};
      zig-dev = import ./zig.nix {inherit pkgs;};

      rust-cuda-dev = import ./rust.nix {pkgs = cudaPkgs;};
      python311-cuda-dev = import ./python311.nix {pkgs = cudaPkgs;};
      python312-cuda-dev = import ./python312.nix {pkgs = cudaPkgs;};
    };
  };
}
