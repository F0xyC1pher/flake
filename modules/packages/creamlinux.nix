{pkgs, ...}: let
	creamlinux =
		import (pkgs.fetchFromGitHub {
				owner = "Novattz";
				repo = "creamlinux-installer";
				rev = "main"; # replace with a commit hash to pin the version
				hash = "sha256-sV23mp0XnJHf4oSqqvFLFfvSkssHzxafqYMNw3HGEdg="; # paste the value returned by the error your rebuild will output
			}) {inherit pkgs;};
in {
	environment.systemPackages = [creamlinux];
}
