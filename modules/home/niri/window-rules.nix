{ lib, config, pkgs, inputs, vars, ... }:
{
programs.niri.settings.window-rules = [
  # Все окна открываются максимизированными
  {
    open-maximized = true;
    draw-border-with-background = false;
  }

  # Steam уведомления
  {
    matches = [
      { app-id = "steam"; title = "^notificationtoasts_\\\\d+_desktop$"; }
    ];
    open-floating = true;
    open-focused = false;
    default-floating-position = { x = 10; y = 10; relative-to = "bottom-right"; };
  }

  # blobdrop всегда плавающее
  {
    matches = [ { app-id = "blobdrop"; } ];
    open-floating = true;
  }

  # tenki фиксированный размер
  {
    matches = [ { app-id = "tenki"; } ];
    open-floating = true;
    min-width = 391; max-width = 391;
    min-height = 155; max-height = 155;
  }

  # Активные окна с красной тенью
  {
    matches = [ { is-active = true; } ];
    shadow = {
      enable = true;
      color = "#d7666766";  # #d76667 + alpha 0.4
    };
  }

  # AIMP/TrayControl панель без бордера и тени
  {
    matches = [
      { title = "TrayControl"; app-id = "AIMP"; }
      { title = "TrayControl"; app-id = "Aimp"; }
    ];
    open-floating = true;
    border = { enable = false; };
    shadow = { enable = false; };
    default-floating-position = { x = 0; y = 0; relative-to = "bottom"; };
    min-width = 1910; max-width = 1910;
    min-height = 54;   max-height = 54;
  }

  # Firefox PiP (картинка‑в‑картинке)
  {
    matches = [ { title = "^Картинка в картинке$"; } { title = "^Picture-in-Picture$"; }];
    open-focused = false;
    open-floating = true;
    default-floating-position = { x = 20; y = 20; relative-to = "bottom-right"; };
  }

  # KeePassXC — блокировка демонстрации экрана
  {
    matches = [ { app-id = "^org\\.keepassxc\\.KeePassXC$"; } ];
    block-out-from = "screen-capture";
  }
];
}
