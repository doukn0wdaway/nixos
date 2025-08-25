{pkgs}:
pkgs.symlinkJoin {
  name = "freecad";
  paths = [pkgs.freecad];
  buildInputs = [pkgs.makeWrapper];
  postBuild = ''
    RUNTIME_LIBS="${pkgs.lib.makeLibraryPath [
      pkgs.libglvnd
      pkgs.egl-wayland
      pkgs.wayland
      pkgs.xorg.libX11
      pkgs.xorg.libXext
      pkgs.xorg.libXrender
      pkgs.xorg.libXfixes
      pkgs.xorg.libXcursor
      pkgs.xorg.libXi
      pkgs.xorg.libXrandr
      pkgs.xorg.libXxf86vm
    ]}"

    for bin in $out/bin/freecad $out/bin/freecadcmd; do
      wrapProgram "$bin" \
        --set QT_QPA_PLATFORM xcb \
        --set QT_OPENGL desktop \
        --set-default LIBGL_ALWAYS_SOFTWARE 0 \
        --set-default LIBGL_DRIVERS_PATH /run/opengl-driver/lib/dri \
        --prefix LD_LIBRARY_PATH : "$RUNTIME_LIBS:/run/opengl-driver/lib:/run/opengl-driver-32/lib"
    done
  '';
}
