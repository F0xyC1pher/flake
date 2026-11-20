# Users

`users/<name>/default.nix` is a plain attribute set (not a NixOS module) describing
one person. A host selects a profile with `host.user` in its `meta.nix`.

## Profiles in this flake

| Profile | Used by | Theme | Shell | Highlights |
| --- | --- | --- | --- | --- |
| `f` | `p` | `the-me` (accent `normal`/`purple`) | zsh | Full desktop + gaming stack, ~30 programs, ~25 services |
| `cicada` | `terminal` | `cicada` | fish | Laptop profile, opacity 0.78, blur enabled |
| `alice` | `wonderland` | `the-me` | fish | Minimal **template** profile for new users |

## Profile fields

```nix
{...}: {
  theme = {
    name = "the-me";                  # palette in themes/ :String
    accentLevel = "normal";           # dimmed | normal | bright
    accentColor = "purple";           # red | orange | yellow | green | cyan | blue | purple | magenta
    dark = true;                      # optional override of detected polarity
    opacity = 1;                      # 0..1
    liquid-glass.enable = false;
    gaps = {"in" = 5; "out" = 5;};
    struts = {top = 0; bottom = 0; left = 10; right = 10;};
    border = {size = 2; radius = 0;}; # `width` also accepted by defaults
    font = {name = "Cascadia Code"; size = 12;};
    cursor = {name = "Posy_Cursor_Black"; size = 24;};
    blur = {enable = false; xray.enable = false; settings = {passes = 2; offset = 2; noise = 0.05; saturation = 1.0;};};
    shadows = {enable = false; neon = false;};
  };

  app = {
    terminal = "kitty";
    launcher = "rofi";                # rofi | fuzzel
    file-manager = {tui = "yazi"; gui = null;};
    browser = {gui = "firefox"; tui = "lyx";};
    text-editor = {gui = "zeditor"; tui = "micro";};
  };

  user = {
    fullName = "F0xy_C1pher";
    gitName = "F0xy_C1pher";
    mail = "ageev-eldar@mail.ru";
    gitToken = "";                    # do not commit real tokens
    password = "<sha512 hash>";       # hashedPassword for users.users.<name>
    shell = "zsh";                    # fish | zsh | bash (attribute in pkgs)
  };

  system = {
    modKey = "Super";                 # Super | Mod4
    desktopShell = "custom";          # custom | dms | noctalia
  };

  programs = ["niri" "waybar" "yazi" ...];
  services = ["pipewire" "tuigreet" ...];
  packages = ["base" "jdk" "wine" ...];
}
```

## How a profile becomes `vars`

`lib/builder/vars.nix` fuses the host metadata and the profile:

- `vars.user` — `name` comes from `host.user`; `fullName`, `gitName`, `mail`,
  `password` (also accepts `userPassword`), `shell` (defaults to `fish`) come from
  `user`. Missing fields fall back to the username or empty strings.
- `vars.app` — the profile's `app` block, or a default set
  (kitty / rofi / yazi / firefox / micro).
- `vars.theme` — resolved palette plus the profile's visual settings, with
  defaults for gaps, struts, border, font, blur, shadows and cursor.
- `vars.hasProgram` / `vars.hasService` / `vars.hasPackage` — helpers used by
  `system-imports.nix` and modules to enable input modules or optional config.

`programs`, `services` and `packages` are lists of **module names**; resolution is
described in [modules/readme.md](../modules/readme.md).

## Adding a user

1. Copy `users/alice` to `users/<new-name>`.
2. Set identity, shell and theme (the palette name must exist in `themes/`).
3. Pick programs, services and packages from the available module names.
4. Point a host's `host.user` in `hosts/<host>/meta.nix` at the new profile.

Keep secrets out of tracked profiles — see the [Secrets](../readme.md#secrets)
section of the root readme.
