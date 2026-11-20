# Squashed commit history

This repository keeps one commit per logical change. During the history
cleanup, short sequences of consecutive commits working on the same topic
were merged into a single commit. Each entry below lists the original
commits that were folded into it, so the development sequence is still
recoverable.

Original detailed history is preserved locally in branch `backup/pre-squash`
(tip `1b4340d`). It is deliberately not pushed.

79 groups squashed; 525 commits before, 410 after.

## Groups

### `08f612c` Add Hyprland with UWSM and switch to Black Posy cursors

- `c5d169e` Add Hyprland with UWSM and csgo-vulkan-fix plugin
- `9528e7e` Switch to Black Posy cursor theme and pin Hyprland packages

### `f8e76da` Refine stylix font sizes and clean commented theme options

- `6519c3e` Parameterize stylix font sizes through vars.fontSize
- `4f8f1c8` Refine stylix font sizes and clean commented theme options

### `cb6585e` Add environment modules and configure zarumet MPD client

- `3324555` Import zarumet and mango home modules per user
- `44dc8b8` Add environment modules and configure zarumet MPD client

### `0b1bbac` Fold home defaults into modules/default.nix

- `ea0e119` Group modules into theming, hardware and xdg subdirectories
- `ddee8ca` Fold home defaults into modules/default.nix

### `b3a88a4` Split home config into niri, waybar and firefox modules

- `699083b` Fix home-manager settings placement in modules/default.nix
- `086bbcb` Split home config into niri, waybar and firefox modules

### `090427a` Install Firefox extensions declaratively and theme the profile

- `770ce87` Lock firefox-addons input for declarative extensions
- `3a809c7` Install Firefox extensions declaratively from firefox-addons
- `4a9b667` Rename Firefox profile to vars.userLongName and theme it with stylix

### `4f97658` Track generated hardware-configuration.nix again

- `4e5e776` Ignore generated hardware-configuration.nix
- `5b5bc64` Re-add generated hardware-configuration.nix

### `e4d66f7` Add and wire the custom AIMP package into the system

- `c11980c` Add AIMP package derivation from Yandex Disk archive
- `243ee5b` Wire AIMP into system packages with allowUnfree
- `3b7c50f` Move AIMP derivation into environment packages module
- `3d0c3e3` Fix AIMP runtime dependencies and comment out hosts override

### `ed443fd` Refresh flake.lock inputs and update AIMP and niri config

- `5e5ffd6` Switch AIMP to nightly version and fix library paths
- `7266d3f` Refresh flake.lock inputs and update AIMP and niri config

### `621b8cd` Enable stylix theming for micro

- `63d1f1e` Restructure user packages into micro and yazi modules
- `73a0e9d` Enable stylix theming for micro

### `8a3091c` Convert services into a services module directory

- `ed931ec` Add awww input and zarumet home module
- `d36e6b5` Extract user services into dedicated module files
- `183d102` Convert services into a services module directory

### `98f1acf` Configure stylix dark theme and tidy waybar formats

- `71faf10` Add waybar test configuration module
- `d76d9dd` Switch waybar config to settings and add fonts
- `e04673b` Configure stylix dark theme and tidy waybar formats

### `0c5b148` Refine waybar module configuration and stylesheet

- `3bbb16c` Redesign waybar top bar with a new module set
- `33bbf06` Refine waybar module configuration and stylesheet

### `68f19cc` Restructure flake into flake/ with split system and home modules

- `593074c` Restructure flake into flake/ with split system and home modules
- `09cf510` Use system hardware-configuration.nix path in new flake
- `d8683d7` Remove services import from new system module list

### `fe24009` Move flake tree back to repository root after restructure

- `a486a57` Consolidate config under flake/ and drop old root modules
- `8f920b0` Move flake tree from flake/ back to repository root
- `17397c4` Wire up awww and ayugram-desktop flake inputs
- `da526f6` Add missing semicolon in flake.nix input

### `cac0f00` Add hardware-configuration.nix path input to flake

- `fb13557` Add ayugram-desktop input to flake and lock file
- `f45b3fd` Add hardware-configuration.nix path input to flake

### `1d272db` Split hardware and NVIDIA config into dedicated modules

- `5737924` Move NVIDIA persistence service into system modules
- `51fc0d8` Split hardware and NVIDIA config into dedicated modules

### `c9d6332` Group user services under modules/system/services

- `89c42dd` Tune awww daemon and restore systemd services
- `8914dac` Group user services under modules/system/services

### `65282a2` Split yazi config into separate modules

- `4f03aa1` Modularize firefox config and add pipewire and vars modules
- `75ada50` Split yazi config into separate modules

### `507aa13` Enable stylix home module and update firefox userJS

- `ba77a83` Move firefox preferences into userJS and fix module imports
- `22728b4` Enable stylix home module and update firefox userJS

### `c57f06e` Set up custom package overlay and move derivations

- `ec2dadf` Add custom package overlay and remove redundant modules
- `a4b4e5f` Move custom packages to top-level packages/ directory
- `54086bc` Fix custom package overlay and remove vendored scripts

### `13518d6` Set up sops-nix with an encrypted GitHub SSH key

- `5ed02eb` Add sops-nix and encrypted GitHub SSH key setup
- `3999b79` Document sops age key recovery steps

### `939f098` Configure GitHub SSH agent and re-encrypt the sops secret

- `8a1c364` Set addKeysToAgent for github SSH and re-encrypt secret
- `135c0b6` Re-encrypt the github SSH key in secrets.yaml
- `33c767f` Set addKeysToAgent to yes for github SSH

### `61cb469` Configure rofi module with theme and Papirus icons

- `4d3f4c2` Update flake.lock and add rofi and xdg portal config
- `992dab8` Configure rofi module with theme and Papirus icons

### `1916bf3` Unify rofi, stylix and VSCodium colors through shared variables

- `d4d70bb` Wire rofi and stylix colors to shared variables
- `8c0e741` Restructure color palette variables in vars/colors.nix
- `ef74e3b` Update vscodium colors to new palette variable names

### `c24c474` Comment out nixos-conf-editor package entry

- `fc3ef6b` Add nixos-conf-editor input and reformat flake modules
- `f0674c8` Comment out nixos-conf-editor package entry

### `808434a` Enable xdg import and remove dead system module imports

- `173a0e9` Rewrite services module and remove X server setup
- `5e166b0` Enable xdg import and remove dead system module imports

### `a5062c4` Force fuzzel color overrides with lib.mkForce

- `5390f10` Refresh flake.lock and expand fuzzel configuration
- `30c33e1` Apply shared color variables to fuzzel and stylix
- `6f037ff` Force fuzzel color overrides with lib.mkForce

### `e4afea1` Simplify module arguments and rework VSCodium settings

- `0d66373` Enable VSCodium comment toggle in read-only buffers
- `ec26b09` Simplify module arguments and rework VSCodium settings

### `7d0388b` Wire nekobox and rofi-polkit agent inputs

- `296d0cd` Add nekobox packages, swap config and polkit agent rename
- `444d3a8` Wire nekobox and rofi-polkit agent inputs

### `bea225d` Expand sysctl tuning and split system services into modules

- `7e517bd` Add real-time audio and performance tuning
- `8fcae15` Expand sysctl tuning and split system services into modules

### `5ce55b3` Convert Waybar configuration from JSON to Nix modules

- `348bd79` Split waybar config into per-module files
- `a69f52d` Convert waybar module JSON to Nix syntax
- `402e525` Remove waybar config.json and add disk module

### `3d4d680` Adjust kitty border width and colors

- `627b48c` Add kitty terminal module
- `bd9c103` Adjust kitty border width and colors

### `fc5c0aa` Move services and systemd modules to top level

- `aef3d37` Add cliphist clipboard services
- `db96aae` Move services and systemd modules to top level

### `8fa8486` Fix arrpc service option and relocate custom systemd modules

- `5eaa09c` Add arrpc Discord RPC service
- `32c3aa5` Fix arrpc service option and relocate custom systemd modules

### `06ff4ac` Add custom kitty tab bar script and reshape theme config

- `68c3e1b` Tweak kitty borders and clean niri config cruft
- `a74594c` Add rmpc music client and rework kitty tab layout
- `3fdf00d` Add custom kitty tab bar script and reshape theme config

### `61ac509` Rename shell config files to default.nix

- `5996145` Add r2modman and switch shell to fish
- `739c01a` Rename shell config files to default.nix

### `8a02d6b` Add nekobox-git package and centralize packages module

- `1e7dc49` Update nekobox to 5.10.40 and refresh flake inputs
- `5d20145` Add nekobox-git package and centralize packages module

### `40e62f1` Build the initial theme engine with palette discovery

- `ef2bb09` Build initial theme engine with palette resolution
- `db275b1` Auto-discover themes and rename theme role files
- `a3c2a5e` Remove obsolete theme.nix after role file rename
- `a76bf7e` Complete theme engine with cicada theme and docs

### `6087f4e` Drop manual throne package override

- `1e3d4d9` Refresh flake inputs and drop manual throne override
- `98e9e1c` Drop manual throne package override

### `e471181` Disable scheduler tweaks and scroll module, enable PCIe ASPM off

- `c615d07` Add tmux and scheduler services and refresh flake inputs
- `30a41c6` Disable scheduler tweaks and scroll module, enable PCIe ASPM off

### `13c1688` Restructure Firefox extension options and enable idle services

- `36db4cb` Refresh flake inputs and adjust Firefox addon config
- `42edea3` Restructure Firefox extension options and enable idle services

### `1ada78a` Move theme resolution into lib and restructure vars

- `9ad3fd9` Move theme resolver to lib/mkTheme.nix
- `0dd844b` Auto-derive match and onAccent theme colors
- `50b26a0` Restructure vars into user/app/theme groups

### `ecd2d61` Use explicit suffix for PipeWire audio format

- `adc3e11` Tune Bluetooth audio and refresh Firefox add-ons
- `61457c7` Use explicit suffix for PipeWire audio format

### `ba167ec` Reformat flake.nix and VSCodium config

- `43126f8` Gate parallels driver and reformat Firefox/Yazi configs
- `75504ed` Reformat flake.nix and VSCodium config

### `1134af7` Back up removed husi and nekobox derivations

- `e68ec57` Drop custom husi and nekobox packages and prune inputs
- `836bdea` Back up removed husi and nekobox derivations

### `98ffd5d` Rework Firefox userChrome and userJS preferences

- `2eb44e0` Rewrite Firefox userChrome as a transparent glass theme
- `261b01d` Raise Firefox audio rate and expand userJS prefs
- `dfc8709` Group Firefox prefs and block AI integrations
- `415220b` Clean up Firefox userChrome section comments

### `06548cb` Fix YouTube SVG buttons and drop firefox-color

- `49bddf1` Clean up Firefox userContent section comments
- `c06f3c1` Lock Firefox settings through policies
- `f62cd48` Fix stray character in Firefox userJS
- `8686475` Fix YouTube SVG buttons and drop firefox-color

### `a0b331e` Rework Freesmlauncher JDKs and nixcord options

- `f312092` Add Freesmlauncher overlay and enable nixcord
- `2511020` Disable Equibop in nixcord
- `5f2cfbd` Rework Freesmlauncher JDKs and nixcord options

### `f4eb9c6` Configure low-latency WirePlumber rules

- `bb5f1c9` Enable low-latency WirePlumber rules and darken Firefox UI
- `40e16dc` Fix WirePlumber matches and toggle MPD/Java options
- `a032c27` Fix audio.format variable in WirePlumber rule
- `c666b44` Fix ALSA node matching and period count in WirePlumber

### `21761a7` Fix WirePlumber audio format strings and split audio config

- `87d1ecc` Fix audio format strings in WirePlumber rules
- `022d510` Split audio configuration into input and output profiles

### `e5291b4` Clean up display manager comments

- `7f9022a` Move display manager modules into displayManager/
- `4078884` Clean up display manager comments

### `e55e220` Remove stale media import from programs/default.nix

- `7a56d47` Flatten media programs and add repository tree dump
- `ff0f59d` Remove stale media import from programs/default.nix

### `acae416` Refactor and rename module discovery helpers in lib

- `38abc1a` Refactor module discovery in lib/utils.nix
- `d860e70` Strip comments from lib/utils.nix
- `c00e48e` Rename lib/utils.nix to lib/mkModules.nix

### `e105fd7` Switch scx-loader to scx_bpfland and drop gamemode hooks

- `ee1c7d0` Add scx-loader service and tune boot parameters
- `b555370` Switch scx-loader to scx_bpfland and drop gamemode hooks

### `e237b2f` Enable Flatpak with Flathub and wire it into mkHost

- `6bf78e9` Enable Flatpak with Flathub remote and Sober
- `69769ce` Wire nix-flatpak into mkHost and fix Flatpak options
- `4b45dae` Move Flatpak config to home-manager and add curl packages

### `b2fdd5f` Remove archived flake and host module files

- `d79ef24` Rename WonderLand host and add downloader packages
- `b61581c` Remove archived flake and host module files

### `19f0d77` Set audio output rate to 48 kHz after trying higher rates

- `fe5e451` Raise audio output rate to 192 kHz
- `6db5ec2` Lower audio output rate to 96 kHz
- `64f2961` Lower audio output rate to 48 kHz

### `1fdc053` Disable ollama service

- `4e82b63` Add Ollama and TLP services and move swaylock
- `389df91` Disable ollama service

### `116c712` Add ShojiWM and Nix logo flake inputs

- `4a03ec7` Add fastfetch module with Nix snowflake logo
- `1a81e11` Add ShojiWM and Nix logo flake inputs

### `3fd0e33` Adopt niri-glass compositor and refine niri window rules

- `55b7d66` Wire niri-screenshare into xdg-desktop-portal
- `8f67791` Apply niri blur window rule to Discord
- `680ffec` Anchor niri window rule matches as exact regexes
- `8043dc5` Use niri-glass compositor and kitty-direct fastfetch logo

### `f1398d5` Add liquid-glass effects to niri window and layer rules

- `3a1409b` Update flake.lock (niri-glass, shorin-niri)
- `bb3b17f` Add liquid-glass effect to niri window rules
- `0792652` Extend liquid-glass effect to niri layer-shell rules
- `f5c0823` Tune niri layer liquid-glass vibrancy to 1

### `f0c999d` Tidy fastfetch module boxes and disk label

- `83bf73b` Add uwsm and ghostty modules with detailed fastfetch output
- `6ad3c60` Tidy fastfetch module boxes and disk label

### `5395fb8` Generate structured accent palettes from base16 colors

- `aedbf6d` Refactor accent selection and service module loading
- `d0545b4` Generate structured accent palettes from base16 colors
- `4f18499` Quantize accent mixing and expose opacity helpers

### `03d0c13` Darken theMe base background shades

- `c62fa88` Add gemini theme palette and role mapping
- `cba3b89` Darken theMe base background shades

### `4b0b53e` Restructure theme discovery and expand the palette library

- `5c2b511` Restructure boot modules and add shared theme role generator
- `33a1e01` Discover themes recursively and flatten theme files
- `2373c5c` Add experimental theme palettes and drop theme overrides
- `0a0e40f` Tune theMe foreground shades toward pink

### `77fa118` Restore transparent GTK styling and fix popovers

- `b99984b` Restore transparent GTK headerbars and toast styling
- `26f1ce5` Fix GTK indentation and restore popover overrides

### `202d5de` Rename displayManager service directory to display-manager

- `4554fe6` Rename lib modules to kebab-case filenames
- `9553a3e` Rename displayManager service directory to display-manager

### `4d677dd` Update flake imports after lib module renames

- `7bee95a` Add dconf program module
- `d4a7d35` Update flake imports after lib module renames

### `61d6c0d` Use theme background color for transparent Zed surfaces

- `5ac2723` Generate Zed theme from resolved theme colors
- `3fd86f4` Use theme background color for transparent Zed surfaces

### `aacc4b3` Add dms input and split Umbriel config into modules

- `b62cdc9` Add Noctalia input, module and Cachix substituter
- `ed09736` Add dms input and split Umbriel config into modules

### `30281cb` Move custom packages to modules/custom-packages

- `a085742` Split nixpkgs, session and Wine package modules
- `5dea4cf` Move custom packages to modules/custom-packages

### `419ef16` Remove unsupported noCoW option from swapfile module

- `f519a7d` Fix Bluetooth module import path
- `44f4d0f` Remove unsupported noCoW option from swapfile module

### `080322f` Fix Zed theme interpolation and switch user theme to the-me

- `a7696c5` Correct accent and palette colors in the-me theme
- `cf7bb03` Fix Zed theme name interpolation and dark check
- `7a9bd8a` Expand transparent surfaces in the Zed editor theme
- `5b233c6` Switch user theme to the-me and disable liquid-glass

### `6eff97c` Switch bootloader to Limine on host p

- `20b1960` Update boot UUID and remove swap device in host p
- `4d37c23` Switch bootloader to Limine on host p

### `c91445c` Use prebuilt luasteam for Balatro

- `f40e385` Build luasteam from source for Balatro
- `013ecff` Use prebuilt luasteam and robust Lovely extraction

### `88e3e2c` Add and wire Google Antigravity packages

- `7dbf830` Add google-antigravity system packages module
- `2188d39` Broaden module analyzer package reference patterns

### `4f508ff` Enable google-antigravity package for user f

- `ddc8ffa` Apply antigravity-nix overlay when antigravity is enabled
- `dd44f35` Enable google-antigravity package for user f

### `a2c9069` Set host p monitor to 1920x1080 at 60 Hz via host vars

- `c5aa560` Set host p monitor to 1920x1080 at 60Hz
- `1b0312f` Wrap host framerate with toString in display configs
