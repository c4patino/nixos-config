{ pkgs ? import <nixpkgs> { 
    config = {
        allowUnfree = true;
        cudaSupport = true;
    };
}}: pkgs.mkShell {
    name = "python311-dev";

    nativeBuildInputs = with pkgs; [
        poetry

        python311Full
        python311Packages.virtualenv

        # Won't actually use the matplotlib installed here, but needed to set up environment
        python311Packages.matplotlib
    ];

    shell = pkgs.zsh;

    shellHook = ''
        export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${pkgs.libGL}/lib
        export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${pkgs.glib.out}/lib
        export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/run/opengl-driver/lib
        export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$NIX_LD_LIBRARY_PATH
    '';
}
