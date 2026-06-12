{
	inputs,
	vars,
	...
}: {
	imports = [
		./theme.nix
	];
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			programs.nixcord = {
				enable = true;
				vesktop.enable = false;
				equibop.enable = false;
				discord = {
					enable = true;
					equicord.enable = true;
					vencord.enable = false;
					openASAR.enable = true;
					autoscroll.enable = false;
				};
				config = {
					transparent = true;
					frameless = true;
					plugins = {
						blurNsfw.enable = true;
						clearUrls.enable = true;
						iRememberYou.enable = true;
						pinDms.enable = true;
						saveFavoriteGifs.enable = true;
						betterGifPicker.enable = true;
						betterSettings.enable = true;
						betterSettings.eagerLoad = true;
						betterUploadButton.enable = true;
						biggerStreamPreview.enable = true;
						fakeNitro.enable = true;
						fakeNitro.enableEmojiBypass = true;
						fakeNitro.enableStickerBypass = true;
						fakeNitro.enableStreamQualityBypass = true;
						volumeBooster.enable = true;
						waitForSlot.enable = true;
						webScreenShareFixes.enable = true;
						questify = {
							newExcludedQuestAlertVolume = 1;
							newQuestAlertVolume = 1;
							questButtonBadgeColor = 1;
							questButtonBadgeCount = 1;
							questCompletedAlertVolume = 1;
							questFetchInterval = 1;
						};
					};
				};
			};
		};
	};
}
