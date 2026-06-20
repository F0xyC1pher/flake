{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: let
			t = vars.theme.style;
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
							background: rgba(36, 6, 6, 0.5) !important;
						}
						/* Прозрачная панель навигации */
						#nav-bar,
						#PersonalToolbar {
							background: rgba(36, 6, 6, 0.5) !important;
							padding: 4px 0 !important;
						}
						/* Всплывающие окна (меню, панели, подсказки) */
						menupopup,
						panel,
						.panel-arrowcontent,
						tooltip,
						.tooltip,
						#ContentSelectDropdown {
							background-color: rgba(36, 6, 6, 0.7) !important;
							border: 1px solid rgba(26, 26, 26, 0.5) !important;
						}
						menuitem[_focused="true"],
						menu[_focused="true"] {
							background-color: rgba(36, 6, 6, 0.5) !important;
						}
						/* Прозрачный Sideberry */
						#sidebar-box,
						#sidebar,
						.sidebar-panel,
						#sidebar-box iframe {
							background: transparent !important;
							background-color: transparent !important;
						}
						/* Разделитель между контентом и боковой панелью цвета фона*/
						#sidebar-splitter {
							background-color: rgba(36, 6, 6, 0.5) !important;
							width: 2px !important;
							border: none !important;
							margin: 0 !important;
							padding: 0 !important;
						}

						/* Текст, иконки, скрытие дефолтных элементов*/
						.urlbar-input,
						.urlbar-input::placeholder,
						menuitem,
						menu,
						.toolbarbutton-text,
						.tab-text,
						#PersonalToolbar .bookmark-item {
							color: #d6d6d6 !important;
							fill: #d6d6d6 !important;
						}
						/* Скрытие заголовка тулбара*/
						#TabsToolbar {
							visibility: collapse !important;
						}
						#sidebar-header {
							display: none !important;
						}
						/* Адресная строка */
						#urlbarView {
							background-color: rgba(36, 6, 6, 0.5) !important;
							border-color: rgba(26, 26, 26, 0.5) !important;
						}
						.urlbarView {
							background-color: rgba(36, 6, 6, 0.5) !important;
						}
						.urlbarView-row {
							color: #d6d6d6 !important;
						}
						.urlbarView-row:hover {
							background-color: rgba(36, 6, 6, 0.7) !important;
						}
						.urlbarView-title strong {
							color: #f6f6f6 !important;
						}
						.urlbar-input {
							color: #d6d6d6 !important;
						}

						/*Скрытие индикатора WebRTC*/
						#webrtcIndicator {
							display: none !important;
						}
					'';
				};
			};
		};
	};
}
