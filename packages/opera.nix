{
  pkgs,
  oldPkgs,
}:
oldPkgs.opera.overrideAttrs (old: rec {
  pname = "opera";
  version = "120.0.5543.128";
  mirror = "https://get.geo.opera.com/pub/opera/desktop";

  src = pkgs.fetchurl {
    url = "${mirror}/${version}/linux/${pname}-stable_${version}_amd64.deb";
    hash = "sha256-AxLIp8nmi9yqMsGkAseFkWMVbJ1s7+ntN8463D5jPrk=";
  };
})
