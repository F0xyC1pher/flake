## Documentation

- [Hosts Architecture](./hosts/readme.md) - Host metadata, hardware configurations, and system entrypoints.
- [Users System](./users/readme.md) - User profile declarations, theme picking, and enabled software suites.
- [Modules](./modules/readme.md) - Directory layout for system and user configurations:
  - [Core](./modules/core/readme.md) - Essential system-level configurations and Nix parameters.
  - [Hardware](./modules/hardware/readme.md) - GPU drivers, CPU tweaks, and bootloader definitions.
  - [Packages](./modules/packages/readme.md) - Package group collections and application bundles.
  - [Programs](./modules/programs/readme.md) - Standalone program definitions and custom settings.
  - [Services](./modules/services/readme.md) - Systemd service integrations.
- [Themes](./themes/readme.md) - Base16 extensions into Base56.
- [Core Library (`lib/`)](./lib/readme.md) - Color palette math, module resolvers, and global `vars` generator.
