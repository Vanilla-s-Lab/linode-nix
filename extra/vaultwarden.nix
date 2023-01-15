{ ... }:
{
  services.vaultwarden.enable = true;
  services.vaultwarden.config = {
    DOMAIN = "https://vaultwarden.vergedx.me";
    SIGNUPS_ALLOWED = false;
  };

  services.nginx.virtualHosts = {
    "vaultwarden.vergedx.me" = {
      addSSL = true;
      enableACME = true;

      locations."/" = {
        proxyPass = "http://127.0.0.1:8000";
      };
    };
  };
}
