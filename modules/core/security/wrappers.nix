{pkgs, ...}: {
	# suid/capabilities wrappers for apps that need elevated privileges.
	# Add new entries here when a package needs a capability wrapper.
	# security.wrappers.nekobox = {
	# 	owner = "root";
	# 	group = "root";
	# 	capabilities = "cap_net_admin,cap_net_bind_service=+ep";
	# 	source = "${pkgs.nekobox}/bin/nekobox";
	# };
}
