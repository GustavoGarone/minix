{
  den.aspects.services.auto-cpufreq = {
    nixos = {
      services.auto-cpufreq = {
        enable = true;
        settings = {
          battery = {
            governor = "powersave";
            turbo = "never";
          };
          charger = {
            gorvernor = "performance";
            turbo = "auto";
          };
        };
      };
    };
  };
}
