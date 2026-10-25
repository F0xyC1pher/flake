{vars, ...}: {
  hjem.users.${vars.user.name}.xdg.config.files = {
    "hypr/06-outputs.lua".text = ''
      hl.monitor({
        output = "${vars.host.hardware.video.output.name}",
        mode = "${vars.host.hardware.video.output.resolution}@${toString vars.host.hardware.video.output.framerate}",
        position = "0x0",
        scale = "1",
        cm = "edid",
      })
    '';
  };
}
