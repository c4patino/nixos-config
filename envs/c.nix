{ pkgs ? import <nixpkgs> { 
    config = {
        allowUnfree = true;
        cudaSupport = true;
    };
}}: pkgs.mkShell {
    name = "c-dev";

    nativeBuildInputs = with pkgs; [
        libgcc
        gdb
    ];

    shell = pkgs.zsh;

    shellHook = ''
        export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$NIX_LD_LIBRARY_PATH;
    '';
}
