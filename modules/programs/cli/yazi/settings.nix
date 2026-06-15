{
  inputs,
  vars,
  ...
}: {
  home-manager = {
    extraSpecialArgs = {inherit inputs vars;};
    users.${vars.user.name} = {config, ...}: {
      programs.yazi = {
        settings = {
          opener = {
            video = [
              {
                run = "mpv %s";
                block = true;
                desc = "Play in mpv";
              }
            ];
            image = [
              {
                run = "mcat -I %s";
                block = true;
                desc = "View Image (mcat)";
              }
            ];
          };
          open = {
            prepend_rules = [
              {
                mime = "video/*";
                use = "video";
              }
              {
                mime = "image/*";
                use = "image";
              }
            ];
          };
          mgr = {
            ratio = [1 4 3];
            sort_by = "natural";
            sort_sensitive = true;
            sort_reverse = false;
            sort_dir_first = true;
            linemode = "none";
            show_hidden = true;
            show_symlink = true;
            tab_size = 1;
          };

          preview = {
            max_width = 1200;
            max_height = 900;
            image_quality = 90;
            cache_dir = "${config.xdg.cacheHome}/yazi";
          };

          tasks = {
            micro_workers = 5;
            macro_workers = 10;
            bizarre_retry = 5;
          };

          plugin = {
            prepend_fetchers = [
              {
                id = "mime";
                group = "mime";
                url = "local://*";
                run = "mime-ext.local";
                prio = "high";
              }
              {
                id = "mime";
                group = "mime";
                url = "remote://*";
                run = "mime-ext.remote";
                prio = "high";
              }
            ];
          };
        };
      };
    };
  };
}
