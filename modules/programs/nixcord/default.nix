{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			programs.nixcord = {
				enable = true;
				vesktop.enable = false;
				# equibop.enable = true;
				discord = {
					enable = true;
					# equicord.enable = true;
					vencord.enable = false;
					openASAR.enable = false;
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
					};
				};
			};
		};
	};
}
