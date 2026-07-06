{
  den.schema.host = {
    host,
    lib,
    ...
  }: let
    inherit (lib) mkDefault mkOption types;
  in {
    config = {
      isLaptop = mkDefault false;
      keyboardLayout = mkDefault "br";
      keyboardLayourVariant = mkDefault "";
      displays = mkDefault {};
      terminal = mkDefault "kitty";
      shell = mkDefault "fish";
      gitSigningKey = mkDefault null;
    };

    options = {
      isLaptop = mkOption {
        default = false;
        type = types.bool;
      };
      keyboardLayout = mkOption {
        default = "br";
        type = types.str;
      };
      keyboardLayoutVariant = mkOption {
        default = "";
        type = types.str;
      };
      displays = mkOption {
        default = {};
        type = types.lazyAttrsOf (types.submodule ({
          name,
          config,
          ...
        }: {
          options = {
            name = mkOption {
              default = name;
              readOnly = true;
            };
            primary = mkOption {
              default = false;
              type = types.bool;
            };
            refresh = mkOption {
              default = 60;
              type = types.float;
            };
            width = mkOption {type = types.int;};
            height = mkOption {type = types.int;};
            x = mkOption {
              default = 0;
              type = types.int;
            };
            y = mkOption {
              default = 0;
              type = types.int;
            };
          };
        }));
      };
      terminal = mkOption {
        default = "kitty";
        type = types.enum ["kitty" "ghostty"];
      };
      shell = mkOption {
        default = "fish";
        type = types.str;
      };
      gitSigningKey = mkOption {
        default = null;
        type = types.nullOr types.str;
      };
    };
  };
}
