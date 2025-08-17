{
  services.tlp = {
    enable = true;
    settings = {
      TLP_DEFAULT_MODE = "BAT";
      TLP_PERSISTENT_DEFAULT = 1;
      START_CHARGE_THRESH_BAT0 = 40;
      # Doesn't seem to be working properly,
      # Battery stops charging at 89%
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };
}
