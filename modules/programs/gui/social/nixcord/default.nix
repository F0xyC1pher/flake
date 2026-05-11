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
				# equibop.enable = true;
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
						BlurNSFW.enable = true;
						ClearURLs.enable = true;
						IRememberYou.enable = true;
						PinDMs.enable = true;
						SaveFavoriteGIFs.enable = true;
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
							newExcludedQuestAlertVolume = 1.0;
							newQuestAlertVolume = 1.0;
							questButtonBadgeColor = 1.0;
							questButtonBadgeCount = 1.0;
							questCompletedAlertVolume = 1.0;
							questFetchInterval = 1.0;
						};
					};
				};
			};
		};
	};
}
