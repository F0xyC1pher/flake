# Theme Engine

The theme engine uses a modified **Base16** structure to generate consistent color schemes, active UI elements, and automatic contrast variations across the entire system.

## Base Color Palette (`base`)

The 16 base slots define the structural colors for user interfaces, terminal palettes, and text hierarchy.

### Backgrounds & Text Hierarchy (`00` – `07`)

- `base.00`: Primary background (applications, terminal background).
- `base.01`: Alternate / darker background (status bars, panels, sidebars).
- `base.02`: Selection background (selected lines, cursor line, active item highlights).
- `base.03`: Muted text / comments (low contrast text).
- `base.04`: Secondary UI elements / borders / inactive indicators.
- `base.05`: Main foreground text.
- `base.06`: Secondary / bright text.
- `base.07`: Maximum brightness text / headings.

### Accent Slots (`08` – `0F`)

- `base.08`: Red (errors, deletion, critical alerts).
- `base.09`: Orange (warnings, constants, integers).
- `base.0A`: Yellow (classes, search highlights, warnings).
- `base.0B`: Green (strings, success indicators, additions).
- `base.0C`: Cyan (regex, escape characters, support functions).
- `base.0D`: Blue (functions, primary methods, headings).
- `base.0E`: Purple (keywords, storage types, control flow).
- `base.0F`: Magenta (deprecated items, secondary accents).

## Dynamic Accents (`accent`)

The theme engine automatically processes base accent colors into runtime variations with calculated foreground text contrast and brightness levels.

### Property Syntax

```nix
vars.theme.style.accent.<role>.<level>.<color_name>
```

### Parameters

- `<role>`:
  - `bg`: Accent background color value.
  - `fg`: Automatically calculated contrasting text color (`luminance`-matched for readability).
- `<level>`:
  - `dimmed`: Muted/desaturated variant for subtle highlights or inactive states.
  - `normal`: Standard accent shade defined by the active color palette.
  - `bright`: High-intensity variant for focus states, alerts, or active borders.
- `<color_name>`:
  - `red`, `orange`, `yellow`, `green`, `cyan`, `blue`, `purple`, `magenta`

### Example Usage Inside a Module (`vars`)

```nix
active_border = vars.theme.style.accent.bg.bright.purple;
text_on_active = vars.theme.style.accent.fg.bright.purple;
```
