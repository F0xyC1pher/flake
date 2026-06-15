# ── Nixcord (Vesktop / Discord) — custom CSS theme ────────────────────────────
# Replaces stylix.targets.nixcord. Injects role-driven CSS into Discord's
# client via nixcord's quickCSS mechanism.
{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {vars, ...}: let
			t = vars.theme.style;
			c = vars.theme.colors.accent;
		in {
			programs.nixcord = {
				config = {
					useQuickCss = true;
					themeLinks = []; # no upstream theme — full custom CSS below
				};
				quickCss = ''
					/* ── FoxyChipher Discord theme — role-driven, square mode ─────── */

					:root {
					  --bg-deep:       ${t.ui.deep};
					  --bg-main:       ${t.ui.main};
					  --bg-surface:    ${t.ui.surface};
					  --bg-overlay:    ${t.ui.overlay};
					  --bg-selection:  ${t.ui.selection};
					  --bg-highlight:  ${t.ui.highlight};
					  --fg-main:       ${t.text.main};
					  --fg-heading:    ${t.text.heading};
					  --fg-faint:      ${t.text.faint};
					  --accent:        ${t.accent};
					  --accent-fg:     ${t.text.onAccent};
					  --border-active: ${t.ui.border.active};
					  --border-inact:  ${t.ui.border.inactive};
					  --error:         ${t.text.syntax.error};
					  --warning:       ${t.text.syntax.warning};
					  --success:       ${t.text.syntax.success};
					  --info:          ${t.text.syntax.info};

					  /* Discord internal vars override */
					  --background-primary:         var(--bg-main)    !important;
					  --background-secondary:       var(--bg-surface) !important;
					  --background-secondary-alt:   var(--bg-deep)    !important;
					  --background-tertiary:        var(--bg-overlay) !important;
					  --background-floating:        var(--bg-surface) !important;
					  --background-mobile-primary:  var(--bg-main)    !important;
					  --background-mobile-secondary:var(--bg-surface) !important;
					  --background-modifier-hover:  var(--bg-overlay) !important;
					  --background-modifier-active: var(--bg-selection) !important;
					  --background-modifier-selected: var(--bg-selection) !important;
					  --background-modifier-accent: var(--accent)     !important;
					  --channeltextarea-background:  var(--bg-overlay) !important;
					  --modal-background:           var(--bg-main)    !important;

					  --text-normal:    var(--fg-main)     !important;
					  --text-muted:     var(--fg-faint)    !important;
					  --text-link:      var(--info)        !important;
					  --header-primary: var(--fg-heading)  !important;
					  --header-secondary:var(--fg-main)    !important;

					  --brand-experiment:        var(--accent) !important;
					  --brand-experiment-100:    var(--accent) !important;
					  --brand-experiment-500:    var(--accent) !important;

					  --interactive-normal:  var(--fg-main)    !important;
					  --interactive-hover:   var(--fg-heading) !important;
					  --interactive-active:  var(--accent)     !important;
					  --interactive-muted:   var(--fg-faint)   !important;

					  --status-positive-text:  var(--success) !important;
					  --status-warning-text:   var(--warning) !important;
					  --status-danger-text:    var(--error)   !important;

					  --scrollbar-thin-thumb:   var(--bg-selection) !important;
					  --scrollbar-auto-thumb:   var(--bg-selection) !important;
					  --scrollbar-auto-track:   var(--bg-main)      !important;

					  --deprecated-card-bg:     var(--bg-surface)  !important;
					  --deprecated-store-bg:    var(--bg-main)     !important;

					  --elevation-high: 0 0 0 1px var(--border-inact) !important;
					  --elevation-low:  0 0 0 1px var(--border-inact) !important;
					}

					/* ── Square mode ─────────────────────────────────────────────── */
					* { border-radius: 0 !important; }

					/* ── Sidebar ─────────────────────────────────────────────────── */
					nav[aria-label="Servers sidebar"] {
					  background-color: var(--bg-deep) !important;
					}
					.scroller__5e6e5,
					.sidebar_ded4b5 {
					  background-color: var(--bg-surface) !important;
					}

					/* ── Message area ────────────────────────────────────────────── */
					.message__76e32:hover {
					  background-color: var(--bg-surface) !important;
					}
					.mentioned__6b727 {
					  background-color: color-mix(in srgb, var(--accent) 10%, transparent) !important;
					  border-left: 2px solid var(--accent) !important;
					}

					/* ── Input ───────────────────────────────────────────────────── */
					.textArea__55573 {
					  background-color: var(--bg-overlay) !important;
					  border: 1px solid var(--border-inact) !important;
					}
					.textArea__55573:focus-within {
					  border-color: var(--accent) !important;
					}

					/* ── Buttons ─────────────────────────────────────────────────── */
					.button__4fa5b[class*="colorBrand"] {
					  background-color: var(--accent) !important;
					  color:            var(--accent-fg) !important;
					}
					.button__4fa5b[class*="colorRed"] {
					  background-color: var(--error) !important;
					}

					/* ── Status dots ─────────────────────────────────────────────── */
					rect[fill="${c."9"}"] { fill: "${c."9"}"  !important; }
					rect[fill="${c."6"}"] { fill: "${c."6"}" !important; }
					rect[fill="${c."0"}"] { fill: "${c."0"}"    !important; }
					rect[fill="${t.text.faint}"] { fill: "${t.text.faint}" !important; }
				'';
			};
		};
	};
}
