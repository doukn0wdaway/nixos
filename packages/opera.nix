{
  pkgs,
  oldPkgs,
}:
oldPkgs.opera.overrideAttrs (old: rec {
  pname = "opera";
  version = "120.0.5543.201";
  mirror = "https://get.geo.opera.com/pub/opera/desktop";

  src = pkgs.fetchurl {
    url = "${mirror}/${version}/linux/${pname}-stable_${version}_amd64.deb";
    hash = "sha256-BGY/iDJrzZgf0i/tbWeSe7d9ebepHBARi5qTXG1f9rg=";
  };

  nativeBuildInputs = (old.nativeBuildInputs or []) ++ [pkgs.makeWrapper];

  postFixup =
    (old.postFixup or "")
    + ''
      RUNTIME_LIBS="${pkgs.lib.makeLibraryPath [
        pkgs.ffmpeg-full
        pkgs.vivaldi-ffmpeg-codecs
        pkgs.libglvnd
        pkgs.egl-wayland
        pkgs.libva
        pkgs.wayland
        pkgs.xorg.libX11
        pkgs.xorg.libXext
      ]}"

      wrapProgram "$out/bin/opera" \
        --set NIXOS_OZONE_WL 1 \
        --set GTK_USE_PORTAL 1 \
        --add-flags "--ozone-platform=wayland" \
        --prefix LD_LIBRARY_PATH : "$RUNTIME_LIBS:/run/opengl-driver/lib:/run/opengl-driver-32/lib"
    '';
})
