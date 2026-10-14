{
  inputs,
  vars,
  ...
}: {
  home-manager = {
    extraSpecialArgs = {inherit inputs vars;};
    users.${vars.user.name} = {...}: let
      t = vars.theme;
      bgRgb = t.hexToRgbString t.style.ui.bg;
      opacity = toString t.opacity;
      bgColor = "rgba(${bgRgb}, ${opacity})";
    in {
      programs.firefox = {
        profiles.${vars.user.fullName} = {
          userChrome = ''
            /* Тотальный сброс всего */
            * {
              background-color: transparent !important;
              background-image: none !important;
              box-shadow: none !important;
              border: none !important;
              border-radius: 0px !important;
            }

            /* Прозрачное окно контента */
            browser[type="content"] {
              background: ${bgColor} !important;
            }

            /* Прозрачная панель навигации */
            #nav-bar,
            #PersonalToolbar {
              background: ${bgColor} !important;
              padding: 4px 0 !important;
            }

            /* Всплывающие окна (меню, панели, подсказки) с блюром */
            menupopup,
            panel,
            .panel-arrowcontent,
            tooltip,
            .tooltip,
            #ContentSelectDropdown {
              background-color: ${bgColor} !important;
              backdrop-filter: blur(20px) saturate(180%) !important;
              border: 1px solid ${bgColor} !important;
            }

            menuitem[_focused="true"],
            menu[_focused="true"],
            menuitem:hover,
            menu:hover {
              background-color: rgba(${bgRgb}, 0.4) !important;
            }

            /* Прозрачный Sidebery */
            #sidebar-box,
            #sidebar,
            .sidebar-panel,
            #sidebar-box iframe {
              background: transparent !important;
              background-color: transparent !important;
            }

            /* Разделитель между контентом и боковой панелью цвета фона */
            #sidebar-splitter {
              background-color: ${bgColor} !important;
              width: 2px !important;
              margin: 0 !important;
              padding: 0 !important;
            }

            /* Текст, иконки, скрытие дефолтных элементов */
            .urlbar-input,
            .urlbar-input::placeholder,
            menuitem,
            menu,
            .toolbarbutton-text,
            .tab-text,
            #PersonalToolbar .bookmark-item {
              color: ${t.style.text.main} !important;
              fill: ${t.style.text.main} !important;
            }

            /* Скрытие заголовка тулбара */
            #TabsToolbar {
              visibility: collapse !important;
            }
            #sidebar-header {
              display: none !important;
            }

            /* Адресная строка */
            #urlbarView,
            .urlbarView {
              background-color: ${bgColor} !important;
              border-color: ${bgColor} !important;
            }

            .urlbarView-row {
              color: ${t.style.text.main} !important;
            }

            .urlbarView-row:hover {
              background-color: rgba(${bgRgb}, 0.4) !important;
            }

            .urlbarView-title strong {
              color: ${t.style.text.heading} !important;
            }

            .urlbar-input {
              color: ${t.style.text.main} !important;
            }

            /* Скрытие индикатора WebRTC */
            #webrtcIndicator {
              display: none !important;
            }
          '';
        };
      };
    };
  };
}
