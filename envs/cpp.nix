{ pkgs ? import <nixpkgs> { 
    config = {
        allowUnfree = true;
        cudaSupport = true;
    };
}}: pkgs.mkShell {
    name = "cpp-dev";

    nativeBuildInputs = with pkgs; [
        clang-tools
        clang
        cmake 
        codespell
        conan
        cppcheck
        doxygen
        gtest
        lcov
        vcpkg
        vcpkg-tool
        gdb

        catch2_3
    ];

    shell = pkgs.zsh;

    shellHook = ''
        export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$NIX_LD_LIBRARY_PATH;
    '';
}
