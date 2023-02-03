{ lib, ... }:
{
  # https://dn42.dev/howto/Bird2
  services.bird2.enable = true;
  services.bird2.checkConfig = false;

  # /etc/bird/bird2.conf
  services.bird2.config = ''
    define OWNAS = 4242421317;
    define OWNIP = 172.22.130.97;
    define OWNIPv6 = fd13:f622:f715::1;
    define OWNNET = 172.22.130.96/27;
    define OWNNETv6 = fd13:f622:f715::/48;
    define OWNNETSET = [172.22.130.96/27+];
    define OWNNETSETv6 = [fd13:f622:f715::/48+];

  '' + ''

    router id OWNIP;

    protocol device {
        scan time 10;
    }

    protocol kernel {
        scan time 20;

        ipv6 {
            import none;
            export all;
        };
    };

    protocol kernel {
        scan time 20;

        ipv4 {
            import none;
            export all;
        };
    }

    protocol static {
        route OWNNET reject;

        ipv4 {
            import all;
            export none;
        };
    }

    protocol static {
        route OWNNETv6 reject;

        ipv6 {
            import all;
            export none;
        };
    }

    template bgp dnpeers {
        local as OWNAS;
        path metric 1;

        ipv4 {
            # https://miaotony.xyz/2021/03/25/Server_DN42/
            extended next hop on;

            import all;
            export none;
        };

        ipv6 {
            import all;
            export none;
        };
    }

  '' + ''

    protocol bgp dn42_4242422688_v6 from dnpeers {
        neighbor fe80::2688 % 'wg' as 4242422688;
        direct;
    }
  '';

  # https://en.wikipedia.org/wiki/Border_Gateway_Protocol
  networking.firewall.allowedTCPPorts = lib.singleton 179;
}
