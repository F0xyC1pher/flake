{...}: {
  systemd = {
    services.NetworkManager-wait-online.enable = false;
    settings = {
      Manager = {
        # DefaultCPUAccounting = "no";
        # DefaultMemoryAccounting = "no";
        # DefaultTasksAccounting = "no";
        # DefaultBlockIOAccounting = "no";
        # DefaultIPAccounting = "no";
      };
    };
  };
}
