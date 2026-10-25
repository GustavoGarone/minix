{
  den.aspects.services.zerotier = {
    nixos = {
      services.zerotierone = {
        enable = true;
        joinNetworks = [
          "1c33c1ced078f7d7"
        ];
      };
    };
  };
}
