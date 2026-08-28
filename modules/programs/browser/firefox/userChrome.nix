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
							background: argb(${vars.theme.hexToRgbString vars.theme.style.ui.bg}, ${toString vars.theme.opacity}) !important;
						}
						/* Прозрачная панель навигации */
						#nav-bar,
						#PersonalToolbar {
							background: argb(${vars.theme.hexToRgbString vars.theme.style.ui.bg}, ${toString vars.theme.opacity}) !important;
							padding: 4px 0 !important;
						}
						/* Всплывающие окна (меню, панели, подсказки) */
						menupopup,
						panel,
						.panel-arrowcontent,
						tooltip,
						.tooltip,
						#ContentSelectDropdown {
							background-color: argb(${vars.theme.hexToRgbString vars.theme.style.ui.bg}, ${toString vars.theme.opacity}) !important;
							border: 1px solid argb(${vars.theme.hexToRgbString vars.theme.style.ui.bg}, ${toString vars.theme.opacity}) !important;
						}
						menuitem[_focused="true"],
						menu[_focused="true"] {
							background-color: argb(${vars.theme.hexToRgbString vars.theme.style.ui.bg}, ${toString vars.theme.opacity}) !important;
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
							background-color: argb(${vars.theme.hexToRgbString vars.theme.style.ui.bg}, ${toString vars.theme.opacity}) !important;
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
							color: ${vars.theme.style.text.main} !important;
							fill: ${vars.theme.style.text.main} !important;
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
							background-color: argb(${vars.theme.hexToRgbString vars.theme.style.ui.bg}, ${toString vars.theme.opacity}) !important;
							border-color: argb(${vars.theme.hexToRgbString vars.theme.style.ui.bg}, ${toString vars.theme.opacity}) !important;
						}
						.urlbarView {
							background-color: argb(${vars.theme.hexToRgbString vars.theme.style.ui.bg}, ${toString vars.theme.opacity}) !important;
						}
						.urlbarView-row {
							color: ${vars.theme.style.text.main} !important;
						}
						.urlbarView-row:hover {
							background-color: argb(${vars.theme.hexToRgbString vars.theme.style.ui.bg}, ${toString vars.theme.opacity}) !important;
						}
						.urlbarView-title strong {
							color: ${vars.theme.style.text.heading} !important;
						}
						.urlbar-input {
							color: ${vars.theme.style.text.main} !important;
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
