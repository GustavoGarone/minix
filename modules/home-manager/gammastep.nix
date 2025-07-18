{lib, ...}: {
  services.gammastep = {
    enable = true;
    provider = "manual";
    tray = true;
    latitude = -23.00;
    longitude = -46.00;
    settings = {
      general.temp-night = lib.mkForce 3000;
    };
  };
}
