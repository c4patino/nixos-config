{
  pkgs ?
    import <nixpkgs> {
      config = {
        allowUnfree = true;
        cudaSupport = true;
      };
    },
}:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    dotnetPackages.Nuget
  ];

  buildInputs = with pkgs; [
    (with dotnetCorePackages;
      combinePackages [
        sdk_9_0_1xx
        sdk_8_0_3xx
      ])
    dotnet-ef
    mono5
  ];

  shell = pkgs.zsh;

  shellHook = ''
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$NIX_LD_LIBRARY_PATH;
  '';
}
