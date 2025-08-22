{
  pkgs,
  nixOld,
}: {
  opera = pkgs.callPackage ./opera.nix {
    oldPkgs = nixOld."23_11";
    pkgs = pkgs;
  };
}
