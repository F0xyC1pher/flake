# dispatchers.nix
{pkgs, ...}: let
	updatePhoneIpScript =
		pkgs.writeShellApplication {
			name = "update-phone-ip";

			runtimeInputs = with pkgs; [
				iproute2
				gawk
				coreutils
				systemd
			];

			text = ''
				interface="''${1:-}"
				action="''${2:-}"

				# Early return if the action is not 'up' or interface is missing
				if [ "$action" != "up" ] || [ -z "$interface" ]; then
				  exit 0
				fi

				gateway=""
				for attempt in $(seq 1 10); do
				  gateway=$(ip route show dev "$interface" | awk '/default via/ {print $3; exit}')

				  if [ -n "$gateway" ]; then
				    break
				  fi

				  echo "Attempt $attempt: Waiting for default gateway on $interface..."
				  sleep 0.5
				done

				if [ -z "$gateway" ]; then
				  echo "Error: Failed to resolve default gateway for $interface" >&2
				  exit 1
				fi

				# Ensure state directory exists and atomic update of phone hosts entry
				mkdir -p /run/xray
				echo "$gateway phone.internal" > /run/xray/hosts

				# Update DNS standard nameserver configuration safely
				if awk '/nameserver/ && $2 != "127.0.0.1" { found=1 } END { exit !found }' /etc/resolv.conf; then
				  echo "Updating local DNS configuration..."
				  systemctl restart xray.service || true
				fi
			'';
		};
in {
	networking.networkmanager.dispatcherScripts = [
		{
			type = "basic";
			source = "${updatePhoneIpScript}/bin/update-phone-ip";
		}
	];
}
