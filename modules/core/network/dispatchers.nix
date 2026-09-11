# dispatchers.nix
{pkgs, ...}: {
	networking.networkmanager.dispatcherScripts = [
		{
			source =
				pkgs.writeShellScript "update-phone-ip" ''
					IFACE=$1
					ACTION=$2

					if [ "$ACTION" = "up" ]; then
					  GW=""
					  for i in $(seq 1 10); do
					    GW=$(${pkgs.iproute2}/bin/ip route show dev "$IFACE" | ${pkgs.gawk}/bin/awk '/default via/ {print $3}' | ${pkgs.coreutils}/bin/head -n1)
					    if [ -n "$GW" ]; then
					      break
					    fi
					    ${pkgs.coreutils}/bin/sleep 0.5
					  done

					  if [ -n "$GW" ]; then
					    # Записываем телефонный IP в hosts
					    ${pkgs.coreutils}/bin/mkdir -p /run/sing-box
					    echo "$GW phone.internal" > /run/sing-box/hosts

					    # Устанавливаем DNS на телефоне (если ещё не стоит)
					    if ${pkgs.gawk}/bin/gawk '/nameserver/ { if ($2 != "127.0.0.1:6450") { print "127.0.0.1 6450" > "/etc/resolv.conf"; exit 0 } }' /etc/resolv.conf; then
					      ${pkgs.systemd}/bin/systemctl restart sing-box.service || true
					    fi
					  fi
					fi
				'';
		}
	];
}
