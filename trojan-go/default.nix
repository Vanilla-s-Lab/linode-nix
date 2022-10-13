{ callPackage, buildGoModule, runCommand, v2ray-geoip, v2ray-domain-list-community, ... }:
let generated = callPackage ../_sources/generated.nix { }; in
buildGoModule rec {
  pname = generated."trojan-go".pname;
  version = generated."trojan-go".version;

  src = generated."trojan-go".src;
  patches = [ ./remove-download.patch ];

  vendorSha256 = "sha256-c6H/8/dmCWasFKVR15U/kty4AzQAqmiL/VLKrPtH+s4=";

  locationAssetDir = runCommand "build_asset_dir" { } ''
    mkdir -p $out/
    cd $_

    ln -s ${v2ray-geoip}/share/v2ray/geoip.dat .
    ln -s ${v2ray-domain-list-community}/share/v2ray/geosite.dat .
  '';

  # https://github.com/p4gefau1t/trojan-go/blob/master/common/geodata/decode_test.go
  TROJAN_GO_LOCATION_ASSET = locationAssetDir;
  # https://github.com/p4gefau1t/trojan-go/blob/master/.github/workflows/test.yml
  SHADOWSOCKS_SF_CAPACITY = "-1";
}
