# xray.nix
{pkgs, ...}: let
	tunAddress = "172.19.0.1/30";
	socksProxyAddress = "phone.internal";
	socksProxyPort = 10808;
	dnsPort = 53;
	xrayRunDir = "/run/xray";

	# Create a wrapper package that intercepts '-test' calls during derivation builds
	xraySandboxSafe =
		pkgs.writeShellScriptBin "xray" ''
			if [ "$1" = "-test" ]; then
			  config_file=""
			  shift
			  while [ $# -gt 0 ]; do
			    case "$1" in
			      -config)
			        config_file="$2"
			        shift 2
			        ;;
			      *)
			        shift
			        ;;
			    esac
			  done

			  if [ -n "$config_file" ] && [ -f "$config_file" ]; then
			    sanitized_config=$(mktemp --suffix=.json)
			    trap 'rm -f "$sanitized_config"' EXIT

			    # Replace "tun" with a valid, unprivileged "dokodemo-door" stub for build-time verification
			    ${pkgs.jq}/bin/jq '
			      .inbounds |= map(
			        if .protocol == "tun" then
			          {
			            tag: .tag,
			            protocol: "dokodemo-door",
			            listen: "127.0.0.1",
			            port: 12345,
			            settings: { address: "127.0.0.1", port: 12345, network: "tcp,udp" }
			          }
			        else
			          .
			        end
			      )
			    ' "$config_file" > "$sanitized_config"

			    exec ${pkgs.xray}/bin/xray -format json -test -config "$sanitized_config"
			  fi
			fi

			exec ${pkgs.xray}/bin/xray "$@"
		'';
in {
	services.xray = {
		enable = true;
		package = xraySandboxSafe;

		settings = {
			log.loglevel = "warning";

			inbounds = [
				{
					tag = "tun-in";
					protocol = "tun";
					settings = {
						name = "xray0";
						address = [tunAddress];
						stack = "system";
						mtu = 1500;
						autoSystemRoutingTable = [
							"0.0.0.0/0"
							"::/0"
						];
					};
				}
			];

			outbounds = [
				{
					tag = "phone-proxy";
					protocol = "socks";
					settings.servers = [
						{
							address = socksProxyAddress;
							port = socksProxyPort;
						}
					];
				}
				{
					tag = "dns-out";
					protocol = "dns";
					settings = {
						network = "tcp,udp";
						address = "1.1.1.1";
						port = dnsPort;
					};
				}
			];

			routing = {
				domainStrategy = "AsIs";
				rules = [
					{
						type = "field";
						inboundTag = ["tun-in"];
						port = toString dnsPort;
						outboundTag = "dns-out";
					}
				];
				final = "phone-proxy";
			};
		};
	};

	systemd.services.xray = {
		path = [pkgs.iproute2];

		serviceConfig = {
			DeviceAllow = ["/dev/net/tun rwm"];
			PrivateDevices = false;
			AmbientCapabilities = [
				"CAP_NET_ADMIN"
				"CAP_NET_BIND_SERVICE"
			];
			CapabilityBoundingSet = [
				"CAP_NET_ADMIN"
				"CAP_NET_BIND_SERVICE"
			];

			ExecStartPre = [
				"+${pkgs.coreutils}/bin/mkdir -p ${xrayRunDir}"
				"+${pkgs.coreutils}/bin/touch ${xrayRunDir}/hosts"
			];

			ProtectSystem = "full";
			ProtectHome = true;
			NoNewPrivileges = true;
		};
	};
}
