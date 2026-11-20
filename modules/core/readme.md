# Core modules

Always-imported base system configuration (`modules/default.nix` imports
`./core`). These modules consume `vars.host`, `vars.user` and `vars.system`
rather than per-user program lists.

## Groups

- **Nix**: `nix.nix`, `nixpkgs.nix`, `nix-init.nix`, `nix-ld.nix`,
  `variables.nix` — Lix/Nix settings, experimental features, nixpkgs config,
  session variables and nix-ld.
- **Locale and time**: `locale.nix`, `time.nix`, `tty.nix`, `man.nix`,
  `etc.nix` — Russian locale, Moscow timezone, console and `/etc` entries.
- **Network**: `network/default.nix`, `network/dispatchers.nix` —
  NetworkManager, DNS/resolved, hosts overrides, dispatcher hooks. This is also
  where the host's `wifi` setting is used.
- **Security**: `security/default.nix`, `pam.nix`, `polkit.nix`, `rtkit.nix`,
  `sops.nix`, `sudo.nix`, `sudo-rs.nix`, `wrappers.nix` — sudo/rtkit, polkit,
  PAM and sops-nix integration for encrypted secrets.
- **XDG**: `xdg/default.nix`, `autostart.nix`, `mime.nix`, `portals.nix`,
  `terminal-exec.nix`, `userDirs.nix` — XDG user dirs, MIME defaults, portals
  and terminal execution helpers.
- **Other**: `ssh.nix`, `systemd.nix`, `ksv-cachyos-settings.nix` — SSH daemon,
  systemd tweaks and the CachyOS settings module.

See [hosts](../../hosts/readme.md) for the `meta.nix` options that drive these modules.
