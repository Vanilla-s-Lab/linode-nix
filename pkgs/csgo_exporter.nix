{ generated, buildGoModule, ... }:
with generated."csgo_exporter";
buildGoModule {
  inherit pname version src;
  vendorHash = "sha256-UHPDQ4GYyAAhnaiA2Zqczq9xXCX2twiVbcn409sExrg=";
}

