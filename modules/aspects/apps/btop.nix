{
  den.aspects.apps.btop = {
    homeManager = {pkgs, ...}: {
      programs.btop = {
        enable = true;
        package = pkgs.btop.override {rocmSupport = true;};
        settings = {
          vim_keys = true;
          proc_left = true;
        };
      };
    };
  };
}
