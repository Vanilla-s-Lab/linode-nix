{ pkgs, config, ... }:
{
  environment.systemPackages = [
    # https://github.com/Mic92/sops-nix
    pkgs.ssh-to-pgp
  ];

  # https://my.norton.com/extspa/passwordmanager?path=pwd-gen
  sops.secrets."shadowsocks/password".sopsFile = ./shadowsocks.yaml;
  sops.templates."shadowsocks".content = builtins.toJSON {
    password = config.sops.placeholder."shadowsocks/password";
  };
}
