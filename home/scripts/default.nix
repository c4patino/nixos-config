{pkgs, ...}: {
  home.packages = [
    (import ./get-music-cover.nix {inherit pkgs;})
    (import ./scratchpad.nix {inherit pkgs;})
    (import ./format-drive.nix {inherit pkgs;})
    (import ./nr.nix {inherit pkgs;})
  ];
}
