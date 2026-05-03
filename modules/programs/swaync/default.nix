# ── SwayNC — notification center ─────────────────────────────────────────────
{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {
			pkgs,
			vars,
			...
		}: {
			services.swaync = {
				enable = true;
				package = pkgs.swaynotificationcenter;

				settings = {
					positionX = "right";
					positionY = "top";
					layer = "overlay";
					control-center-layer = "top";
					layer-shell = true;
					cssPriority = "application";
					control-center-margin-top = 0;
					control-center-margin-bottom = 0;
					control-center-margin-right = 0;
					control-center-margin-left = 0;
					notification-2fa-action = true;
					notification-inline-replies = false;
					notification-icon-size = 48;
					notification-body-image-height = 100;
					notification-body-image-width = 200;
					timeout = 5;
					timeout-low = 2;
					timeout-critical = 0;
					fit-to-screen = true;
					control-center-width = 350;
					notification-window-width = 400;
					keyboard-shortcuts = true;
					image-visibility = "when-available";
					transition-time = 100;
					hide-on-clear = false;
					hide-on-action = true;
					script-fail-notify = true;

					widgets = ["title" "dnd" "notifications" "mpris"];

					widget-config = {
						title = {
							text = "Notifications";
							clear-all-button = true;
							button-text = "󰎟 Clear All";
						};
						dnd = {text = "Do Not Disturb";};
						mpris = {
							image-size = 56;
							image-radius = 0;
						};
					};
				};

				style = ''
					/* ── Base ─────────────────────────────────────────────────────────── */
					* {
					  border-radius: 0;
					  font-family:   "${vars.fontName}", monospace;
					  font-size:     13px;
					  color:         ${vars.style.theme.text.main};
					  transition:    none;
					}

					.notification-row { outline: none; }
					.notification-row:focus,
					.notification-row:hover {
					  background: ${vars.style.theme.ui.surface};
					}

					.notification {
					  background: ${vars.style.theme.ui.main};
					  border:     1px solid ${vars.style.theme.ui.overlay};
					  padding:    12px;
					  margin:     4px 8px;
					}

					.close-button {
					  background: transparent;
					  color:      ${vars.style.theme.accent};
					  border:     none;
					  box-shadow: none;
					  padding:    4px;
					}
					.close-button:hover { background: ${vars.style.theme.ui.surface}; }

					.notification-default-action,
					.notification-action {
					  background: ${vars.style.theme.ui.surface};
					  border:     1px solid ${vars.style.theme.ui.overlay};
					  color:      ${vars.style.theme.text.main};
					  padding:    4px 12px;
					}
					.notification-default-action:hover,
					.notification-action:hover {
					  background: ${vars.style.theme.ui.overlay};
					}

					/* ── Urgency levels ────────────────────────────────────────────── */
					.low      { border-left: 3px solid ${vars.style.theme.text.syntax.success}; }
					.normal   { border-left: 3px solid ${vars.style.colors.accent.orange};       }
					.critical {
					  border-left: 3px solid ${vars.style.theme.accent};
					  animation:   shake 0.35s ease;
					}

					/* ── Control center ────────────────────────────────────────────── */
					.control-center {
					  background: ${vars.style.theme.ui.main};
					  border:     1px solid ${vars.style.theme.ui.border.inactive};
					}

					.widget-title {
					  background:  ${vars.style.theme.ui.surface};
					  color:       ${vars.style.theme.text.heading};
					  font-size:   15px;
					  font-weight: bold;
					  padding:     8px 12px;
					}
					.widget-title > button {
					  font-size:  12px;
					  color:      ${vars.style.theme.text.faint};
					  background: transparent;
					  border:     none;
					}
					.widget-title > button:hover {
					  color:      ${vars.style.theme.accent};
					  background: transparent;
					}

					.widget-dnd {
					  background: ${vars.style.theme.ui.surface};
					  padding:    4px 12px;
					  border-top: 1px solid ${vars.style.theme.ui.overlay};
					}
					.widget-dnd > switch { border-radius: 0; }
					.widget-dnd > switch:checked { background: ${vars.style.colors.accent.orange}; }

					.widget-mpris {
					  background: ${vars.style.theme.ui.surface};
					  padding:    8px;
					  border-top: 1px solid ${vars.style.theme.ui.overlay};
					}

					scrollbar        { background: ${vars.style.theme.ui.surface}; }
					scrollbar slider {
					  background:    ${vars.style.theme.ui.selection};
					  border-radius: 0;
					}

					@keyframes shake {
					  0%   { margin-left:  0;   }
					  25%  { margin-left:  5px; }
					  50%  { margin-left: -5px; }
					  75%  { margin-left:  5px; }
					  100% { margin-left:  0;   }
					}
				'';
			};
		};
	};
}
