{ lib, ... }:
{
  # https://dn42.dev/howto/Bird2
  services.bird2.enable = true;
  # services.bird2.checkConfig = false;

  # https://bgp42.strexp.net/asinfo/4242421317

  services.bird2.config = ''
    ################################################
    #               Variable header                #
    ################################################

    define OWNAS = 4242421317;
    define OWNIP = 172.22.130.97;
    define OWNIPv6 = fd13:f622:f715::1;
    define OWNNET = 172.22.130.96/27;
    define OWNNETv6 = fd13:f622:f715::/48;
    define OWNNETSET = [172.22.130.96/27+];
    define OWNNETSETv6 = [fd13:f622:f715::/48+];

    ################################################
    #                 Header end                   #
    ################################################

  '' + ''

    # https://github.com/czerwonk/bird_exporter
    timeformat protocol     iso long;

    router id OWNIP;

    protocol device {
        scan time 10;
    }

    protocol kernel {
        scan time 20;

        ipv6 {
            import none;
            export filter {
                if source = RTS_STATIC then reject;
                krt_prefsrc = OWNIPv6;
                accept;
            };
        };
    };

    protocol kernel {
        scan time 20;

        ipv4 {
            import none;
            export filter {
                if source = RTS_STATIC then reject;
                krt_prefsrc = OWNIP;
                accept;
            };
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
            export all;
        };

        ipv6 {
            import all;
            export all;
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
