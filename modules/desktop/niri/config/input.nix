{
  inputs,
  vars,
  ...
}:
{
  home-manager = {
    extraSpecialArgs = { inherit inputs vars; };
    users.${vars.user.name} =
      { ... }:
      {
        xdg.configFile."niri/input.kdl".text = ''
          				// syntax: kdl
          				input {
          				    keyboard {
          				        xkb {
          				            layout "us,ru"
          				            options "grp:lalt_lshift_toggle"
          				        }
          				        repeat-delay 250
          				        repeat-rate 35
          				        track-layout "global"
          				    }
          					trackpoint {
          						// off
          						// natural-scroll
          						// accel-speed 0.2
          						// accel-profile "flat"
          						// scroll-method "on-button-down"
          						// scroll-button 273
          						// scroll-button-lock
          						// left-handed
          						// middle-emulation
          					}
          					touchpad {
          						// off
          						tap
          						// dwt
          						dwtp
          						drag true
          						drag-lock
          						natural-scroll
          						// accel-speed 0.2
          						// accel-profile "flat"
          						// scroll-factor 1.0
          						// scroll-factor vertical=1.0 horizontal=-2.0
          						// scroll-method "two-finger"
          						// scroll-button 273
          						// scroll-button-lock
          						tap-button-map "left-middle-right"
          						// click-method "clickfinger"
          						click-method "button-areas"
          						// left-handed
          						// disabled-on-external-mouse
          						// middle-emulation
          					}
          				    mouse {
          				        // off
          				        // accel-speed 0.2
          				        accel-profile "flat"
          				        scroll-factor vertical=1.3 horizontal=1.3
          				        // scroll-factor vertical=1.0 horizontal=-2.0
          				    }
          				    // Uncomment this to make the mouse warp to the center of newly focused windows.
          				    //warp-mouse-to-focus
          				    // disable-power-key-handling

          				    // Focus windows and outputs automatically when moving the mouse into them.
          				    // Setting max-scroll-amount="0%" makes it work only on windows already fully on screen.
          				    // focus-follows-mouse max-scroll-amount="0%"
          				    focus-follows-mouse
          				    workspace-auto-back-and-forth
          				}
          			'';
      };
  };
}
